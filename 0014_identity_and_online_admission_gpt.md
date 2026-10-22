# ASKA — Identity and online admission

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0013_memory_ownership_and_lifecycle_gpt.md) · [Next](0015_transport_and_protected_transit_gpt.md)

Machines use untrusted infrastructure to discover services, then establish authenticated channels and negotiate authority limits. Each realm chooses its own trust anchors and policy. Directories, certificate issuers, and transit providers cannot override both endpoints' decisions.

## Identities and discovery

A realm identifier is the hash of a canonical realm root public key. A service identity binds a realm, service name, authorized gate identity, key, and validity interval in a signed record. An endpoint locator remains separate and can change without changing that identity.

Directories return signed service records, locator hints, and path candidates. The caller verifies the requested identity against its configured trust relationship. An authentic but unexpected key is not accepted merely because its hash is self-consistent. Name-to-root binding requires prior configuration, a reviewed introduction, or a locally accepted certification chain.

Each relying party chooses which issuers and delegation depths to accept. Federation and cross-signing can reduce enrollment work without requiring a universal root. First contact still depends on an accepted trust relationship.

Discovery exposes metadata even when identities use public keys and remain separate from locators. Private discovery or address-hiding relays need their own cost and observer models.

## Bounded public entry

The data plane silently drops unknown sessions. A separate rendezvous/admission service handles first contact with its own address, queues, and budget. It reveals only the configured discovery information.

Before allocating handshake state, the admission edge can issue a short-lived address-bound retry cookie. It limits reflection and spoofed-source state allocation; a reachable attacker can still obtain cookies. Public-key operations, attestation appraisal, and delegation-chain evaluation have independent concurrency caps. Established traffic receives reserved service so admission floods cannot monopolize the gate.

## Establish an authenticated control channel

The reference design uses mutually authenticated TLS 1.3 terminated inside the protected admission services. Use a reviewed TLS implementation with supported cryptographic suites and its existing key exchange. The admission services decide application authority separately from channel authentication. [TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html).

Attestation, when required, is exchanged over that channel and bound to a fresh challenge and its channel context. It covers the gate identity, enforcement configuration, firmware measurement, and available protection profile. The relying party evaluates that evidence against its local allowlist and update policy before deciding whether to grant permission. [RATS architecture](https://www.rfc-editor.org/rfc/rfc9334.html).

## Admission transaction

The transaction below specifies message meanings. Implementations must still define and review their encoding; this draft supplies no interoperable TLS extension.

| Message | Required contents and action |
|---|---|
| `OFFER` | Fresh sender challenge; requested source contexts, destination operations, category mapping, message limits, budgets, lifetime, and transport profile |
| `ACCEPT` | Receiver challenge; accepted intersection; destination generations; receiver policy revision; maximum outstanding work; explicit rejection of unsupported protection |
| `CONFIRM` | Sender's acceptance of the exact canonical contract and both challenges |
| `INSTALL_ACK` | Receiver's protected installation identifier and contract hash; confirms local receive readiness |
| `ACTIVATE` | Sender enables data emission only after verifying the acknowledgment |

Every message includes the transaction identifier and canonical contract hash after those exist. TLS authenticates the peer service; a local installer separately checks that the peer/service role may propose the relevant contract. Only a receiver-authorized local installer can activate or expand receiving policy.

Partial installation can expire without activation. Repeated transaction messages are idempotent within a bounded transaction table. A reused transaction identifier with different content is rejected. A receiver can prepare and receive acknowledgment traffic without granting a source general policy-installation authority.

## Session contract

The installed immutable contract contains:

```text
protocol profile and cryptographic suite
sender/receiver realm and gate identities
source-context and destination-object generations
operation, category, and release-service mappings
receiver grant identifier and policy revision
maximum record size, replay-window size, and sequence allocation limit
queue, byte, record, and rate limits
local lease durations and reset rules
transport profile and path authority requirements
both fresh challenges and contract hash
```

Mappings cannot silently change under a live session. A semantic change installs a new contract. Receiver narrowing or withdrawal may take effect immediately in current local delivery policy; expansion beyond the admitted contract requires new admission.

Use a 128-bit fresh session identifier per direction. Derive directional data secrets through the TLS exporter with an ASKA-specific label and the contract hash as context. A pinned key schedule then derives the data key and nonce prefix under separate labels. Opposite directions and renewed sessions never share nonce spaces. Exporter and derivation encodings require test vectors before implementation approval.

Protected services and engines retain session keys, including in protected DRAM where the host cannot read them. A protected mailbox can install derived data secrets into a packet engine.

## Rotation and withdrawal

For rotation, install a fresh contract, identifier, and keys alongside the old session. New output switches to the new session after its installation acknowledgment. Old output drains within a bounded overlap and deadline. Replay state and budgets remain independent, while any shared tenant allowance is accounted at a common protected parent.

A replacement data session can use an existing authenticated control TLS channel while its peer identity and authorization remain valid. Run a fresh admission transaction with new challenges, session identifiers, and derived keys. Repeat attestation only when local policy requires it because evidence expired, measurements changed, or recovery makes prior evidence unreliable. Loss of the control channel requires a new authenticated channel.

Recovery requests have per-peer and aggregate rate/concurrency limits and cannot consume capacity reserved for healthy established sessions. A pre-authentication failure counter or a visible session identifier cannot by itself trigger permanent session retirement. Measurements must separate data-session replacement from a new TLS handshake and fresh attestation.

Withdrawal stops new emission locally at the serialized transmit decision. At the receiver it stops delivery at the current-policy commit point. Remote notices are authenticated but can be delayed or dropped, so short local leases bound stale authority during partitions.

A lease uses a protected elapsed-time source. Clock reset or uncertainty retires the session. Replaying an old admission transcript cannot restart the lease: installation requires a current boot challenge and a fresh transaction bound to the active control channel. Loss of counter or replay state requires fresh admission and fresh keys.

With lease duration `L`, maximum clock slowdown fraction `d < 1`, and maximum enforcement delay `e`, expiry occurs within `L / (1-d) + e` real-time units after activation. This calculated bound assumes continuous clock progress and has not been measured on hardware.

## Compromise boundaries

A stolen source credential can exploit scopes the receiver already accepts until withdrawal or expiry. It cannot expand receiver policy. A compromised directory can suppress or redirect discovery but cannot forge the expected service identity. A compromised accepted release service can disclose within its release powers; admission cannot repair its semantics.

Local administration must separately authorize root-key restoration, trusted-firmware changes, and category-map replacement. Recovery must preserve the protected transport requirements; a failed session cannot silently fall back to host-owned plaintext transport.
