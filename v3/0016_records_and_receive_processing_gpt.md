# ASKA — Records and receive processing

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0015_transport_and_protected_transit_gpt.md) · [Next](0017_chiplets_and_hardware_integration_gpt.md)

Each endpoint record authenticates an immutable payload together with its protected source, destination object, operation, label interpretation, and session sequence. The receiver consumes authenticated sequences even when it denies delivery. A consumed denial cannot later become a delivery.

## Experimental endpoint header

All integers are unsigned and in network byte order. One carrier datagram contains exactly one endpoint record, optionally preceded by the native envelope. The endpoint header has no optional extensions in this profile.

| Offset | Bytes | Field and rule |
|---:|---:|---|
| 0 | 1 | Version: 3 |
| 1 | 1 | Flags: zero |
| 2 | 2 | Header length: 64 |
| 4 | 4 | Payload length: 1–1024 |
| 8 | 16 | Directional session identifier |
| 24 | 8 | Immutable contract generation |
| 32 | 8 | Sequence |
| 40 | 4 | Source context code |
| 44 | 4 | Destination object code |
| 48 | 2 | Operation code |
| 50 | 2 | Label code |
| 52 | 4 | Immutable mapping identifier |
| 56 | 8 | Release reference, zero when unused |
| 64 | `P` | Ciphertext |
| `64 + P` | 16 | Authentication tag |

Total endpoint-record length is `80 + P`. The header codes select protected session mappings and have meaning only within that session. A session names one source generation, destination object generation, and narrow operation family in the lab profile. Other fields remain explicit for validation and future comparison.

The engine reads identity and label from protected state. Incoming payload bytes carry no usable capability tags. After delivery, the assigned compartment may deserialize objects, but gains no ambient authority to install them.

## Cryptography and sending

The experimental suite is AES-256-GCM with a 32-byte directional key, a 12-byte nonce, and a full 16-byte tag. The header is associated data. The nonce is a protected 4-byte per-key prefix followed by the 8-byte sequence. Nonce uniqueness is required by the construction. [RFC 5116](https://www.rfc-editor.org/rfc/rfc5116.html).

Sequence values start at zero, increase under one protected allocator, and are burned once allocated, including on abort. New payload bytes never reuse an old sequence under that key. Retransmission repeats identical authenticated bytes. Counter uncertainty, wrap, or replay-state loss retires the session. Renewal installs fresh derived keys and identifiers.

The lab rotates after at most `2^20` allocated records or lease expiry. That limit exercises rotation in the lab. Deployment limits need a cryptographic review of total processed blocks, verification failures, key lifetime, and aggregate use.

Sender queues are FIFO by sequence for first emission. Each narrow session has at most 32 local record slots, counted from sequence allocation through terminal cleanup, including any bounded retransmission retention. A slot is released after local engine access ends; it is not held until receiver acknowledgment. [0013](0013_memory_ownership_and_lifecycle_gpt.md) defines parent-allocation and child-record lifetime. The limit bounds sender resources; loss and cancellation can still leave large numerical distances between received sequences.

## Receive pipeline

```text
bounded parse -> known-session lookup -> replay precheck
  -> protected slot reservation -> AEAD verification
  -> serialized sequence consumption
  -> current policy and destination checks
  -> serialized delivery commit -> protected publication
```

1. Check lengths, constants, overflow, supported carrier, and complete datagram framing. Reject unknown sessions without allocating new session state or responding.
2. Check the session's consumed replay window read-only. Drop marked or too-old sequences before cryptographic work. This precheck alone changes no authority.
3. Reserve a bounded quarantine slot and verification budget. Decrypt only into memory inaccessible to the host, receiving workload, and untrusted DMA.
4. Authenticate the complete header and ciphertext. Failure wipes or invalidates quarantine and updates only bounded abuse accounting. It cannot modify replay or delivery state.
5. Under the session arbiter, recheck freshness and consume the sequence. A duplicate that raced authentication loses here. Any authenticated sequence within the installed allocation limit may advance the window, regardless of its forward distance.
6. Evaluate current receiver policy, mappings, label/release rules, lease, destination generation, mailbox space, and delivery budget. A denial remains consumed and produces no publication.
7. Reserve destination ownership, then enter a delivery commit serialized with receiver-policy updates. Recheck the policy version, current permission, lease, destination generation, and allowance inside that commit; a preliminary allow from step 6 grants no right to publish. If the version changed, evaluate current policy again. Debit delivery allowance, attach the restriction, and enable mailbox visibility only when every check passes. Publication is last. A denial releases unused reservations and leaves the sequence consumed.

An authenticated malformed code is still consumed, then denied. An authenticated record arriving after expiry is consumed if the session remains in its bounded retiring state; it is never delivered. Once retired state is discarded, its unknown identifier is dropped.

## Replay-window contract

Maintain a 256-position consumed bitmap, highest consumed sequence, and an initially empty state. Mark both delivered records and authenticated denials. Before authentication, reject sequences outside the installed allocation limit; the lab permits values `0` through `2^20 - 1`. Within that range, a forward sequence is eligible regardless of distance. It advances the window only after authentication and the serialized freshness recheck.

There is no separate forward-gap retirement rule. Loss, cancellation, and burned-but-unemitted sequences can produce large valid jumps without requiring session replacement. A forged high sequence cannot move the window, spend authenticated sender allowance, or retire the session. A valid high sequence can age delayed records out of the window; a malicious key holder can exploit that authority within this narrow session. The receiver does not promise delivery under arbitrary reordering.

An accepted in-window number marks one bit. An authenticated forward number within the installed allocation limit shifts the window and marks itself. A record older than the window cannot be recovered through retransmission. Retry uses a new sequence and, where necessary, a stable application operation identifier.

Consuming authenticated denials prevents the same eligible ciphertext from repeatedly requiring verification after its first serialized consumption. Simultaneous duplicates can still consume a bounded number of crypto slots before that commit. A session-key holder can also generate arbitrarily many fresh valid records until its budget or lease stops it. Admission and scheduler limits remain necessary.

Window advancement by valid denied records can age out delayed valid traffic. Narrow sessions and independent replay spaces limit collateral damage; they do not remove this tradeoff. The receiver bounds repeated-rejection work and provides at-most-once delivery, while allowing sufficiently delayed records to become ineligible. Replay mechanisms have established precedent in [ESP](https://www.rfc-editor.org/rfc/rfc4303.html); the denial-consumption and forward-acceptance rules here define the endpoint contract.

## Resource accounting and backpressure

Count verification work, authenticated record consumption, and successful delivery separately. Before tag verification, a supplied session ID is only an untrusted lookup hint. Forged traffic naming it must not spend authenticated sender credit, advance replay state, or permanently disable the named session.

Charge actual pre-authentication work to bounded ingress queues and verification service. Scheduler buckets may limit work associated with a claimed session, but they are temporary service limits, not proof of sender abuse. Specify refill, fair sharing, and reserved service for established traffic; measure targeted-session floods and collateral loss. Invalid records must not trigger automatic re-admission or key rotation. Verification capacity remains finite, so a sustained upstream flood can still deny service.

Denials consume verification resources without consuming an application's successful-delivery allowance. Refund unused reservations; do not refund completed cryptographic work.

If quarantine is full, drop before authentication and rely on sender retry. After authentication and sequence consumption, mailbox-full is a terminal denial for that sequence. The receiver may send a rate-limited protected status message, but absence of a status implies no delivery guarantee. The sender retries with a new sequence; applications requiring deduplication retain the same operation identifier.

The first profile has no authenticated waiting queue after consumption. That avoids retaining records indefinitely while policy changes. Later queuing requires explicit ownership, lease, capacity, and retry semantics.

## Crash and application effects

Reset closes the data path, discards unpublished quarantine, and retires sessions before fresh installation. Transport consumption does not make physical or application effects exactly once across crashes. Payments, database mutations, and actuator commands need durable deduplication and their own effect protocols.

For mailbox publication, the arbiter reserves all fallible resources before updating successful-delivery counters and making the object visible. If a fault occurs after reservation but before publication, recovery conservatively treats the sequence and spent work as consumed. It never publishes unclassified or uncharged bytes to complete a partial operation.

## Transport bounds

The overlay binding forbids IPv6 fragmentation and extension headers in the initial controlled experiment. A maximum record plus IPv6/UDP occupies `40 + 8 + 1104 = 1152` IP bytes. Native envelopes add `128 + 96h` bytes. A path unable to carry the configured maximum denies admission or negotiates a smaller payload in a separate pinned profile; it does not silently fragment.

Before testing interoperability, validate this experimental encoding with parser and key-schedule vectors, malformed inputs, and concurrent receive traces.
