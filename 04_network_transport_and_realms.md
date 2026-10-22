# 04 — Network transport and independent realms

[Start](README.md) · [Previous](03_protected_handoff.md) · [Next: costs and limits](05_costs_limits_and_open_questions.md)

ASKA's network question is how to carry a protected operation across machines without confusing network reachability, source authentication, data restrictions, and receiver permission. The experimental record below specifies the fields and endpoint state for that study. Physical path enforcement needs a separate design.

Existing distributed-policy, labeled-network and protected-channel work is the starting point: [DStar](07_prior_art_and_sources.md#c05), [Fabric](07_prior_art_and_sources.md#c06), [Ryoan](07_prior_art_and_sources.md#ry), [historical MLS IPsec](07_prior_art_and_sources.md#mls), [RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [TLS 1.3](07_prior_art_and_sources.md#tls), [attested TLS](07_prior_art_and_sources.md#e08). The experimental format makes the required semantics explicit so they can also be tested over existing transports.

The record is an **experimental format for parser, handoff and state-machine studies**. It has no protocol registration, interoperable implementation or deployment cryptography review. Fixed field widths let the study examine costs and ambiguities while leaving the final wire design open.

## Independent admission before data transfer

A directional session from realm A to realm B requires A's outbound permission and B's independently installed acceptance. B decides which source gate, source context, destination object, operations, classifications, and release authorities it accepts. A decides whether B's enforcement and agreed policy mapping satisfy A's disclosure requirements.

Each party controls acceptance; no universal issuer can override both. Each must assess the other gate, its configuration and its update authority. Attestation can report measurements under a root; assessing the measured system remains a separate step.

Independent trust/delegation and bilateral scope have precedents in [DStar](07_prior_art_and_sources.md#c05), [WAVE](07_prior_art_and_sources.md#e02), [Macaroons](07_prior_art_and_sources.md#e01), [IKEv2](07_prior_art_and_sources.md#ike). [RFC 9334 / RATS](07_prior_art_and_sources.md#e03), [RATS interaction draft](07_prior_art_and_sources.md#e09), [SPDM](07_prior_art_and_sources.md#e04), [attested TLS](07_prior_art_and_sources.md#e08) distinguish evidence, appraisal, device identity and channel binding. These precedents cover independent administration and authorization without a universal issuer.

For the first experiment, admission is a trusted setup procedure that installs matching, bounded records and directional keys directly into protected endpoint state. Ordinary hosts never receive those keys. Online enrollment is outside the first experiment. An eventual deployment needs authenticated enrollment, negotiation, key establishment, rollback protection, and recovery; those are unfinished protocol work.

A session record contains at least:

- The peer gate identity, direction, fresh session identifier, and policy generation.
- The source-context and destination-object mappings, including object generations.
- The permitted operations and label interpretation accepted by both sides.
- The permitted release decisions or narrowly delegated release authority.
- The cryptographic key and nonce prefix, sequence/replay state, and usage limits.
- A local expiry deadline, resource allowances, and applicable transport restrictions.

A session-local code is a compact reference to this state. It is neither a globally meaningful security classification nor an independent credential. Mappings are immutable for a live session. A change that alters their meaning retires the session and installs a new one.

Compare protected local/global meanings in [DStar §4.2](07_prior_art_and_sources.md#c05) and SA replacement in [IKEv2 §§2.9.2,4](07_prior_art_and_sources.md#ike). ASKA fixes the source, object and IFC mappings under one generation. The comparison must account for differences between that rule and each source’s mappings.

## A fixed 64-byte header

All multi-byte integers below are unsigned and encoded in network byte order. The experimental version has no optional fields, padding, compression, or extensions. The header is followed by the encrypted payload and a 16-byte authentication tag.

| Byte offset | Width | Field | Experimental interpretation |
|---:|---:|---|---|
| 0 | 8 bits | `version` | Value 1 for this local experiment |
| 1 | 8 bits | `flags` | Zero; all other values rejected |
| 2 | 16 bits | `header_bytes` | Exactly 64 |
| 4 | 32 bits | `payload_bytes` | Plaintext/ciphertext payload length, 1–1024 bytes |
| 8 | 128 bits | `session_id` | Opaque identifier for one installed directional session |
| 24 | 64 bits | `policy_generation` | Must equal that session's installed generation |
| 32 | 64 bits | `sequence` | Gate-allocated record number; never reused under the key |
| 40 | 32 bits | `source_context` | Code resolved through the session's protected source map |
| 44 | 32 bits | `destination_object` | Code resolved through the receiver's protected object map |
| 48 | 16 bits | `operation` | Session-defined operation code |
| 50 | 16 bits | `label_code` | Restriction interpreted through the installed mapping |
| 52 | 32 bits | `policy_map` | Exact identifier of the immutable mapping in this session |
| 56 | 64 bits | `release_id` | Zero for no release; otherwise an installed, scoped decision |
| 64 | `8 × payload_bytes` bits | `ciphertext` | Protected payload |
| `64 + payload_bytes` | 128 bits | `authentication_tag` | Authenticates the header and ciphertext under the selected AEAD |

The header's widths sum to 512 bits. Total record length is `64 + payload_bytes + 16` bytes. The 1024-byte cap bounds buffering and parsing in the first experiment. The optimal packet size remains open.

The first eight bytes, shown at bit resolution, are:

```text
 bit  0               8              16                              32
      +---------------+---------------+-------------------------------+
      | version: 8    | flags: 8      | header_bytes: 16              |
      +---------------+---------------+-------------------------------+
      |                     payload_bytes: 32                         |
      +---------------------------------------------------------------+
```

The source gate derives the source context, label, mapping, and release reference from protected state. It checks the proposed destination and operation against its installed grant. The receiver repeats its own checks. Authentication of a field does not make an out-of-scope value acceptable.

The session authenticates a particular gate and its authorized assertions. Provenance comes from the protected source context and metadata. Authenticated encryption binds the payload bytes to the record without a separate payload hash. A separately reviewable release artifact may need its own payload commitment.

Binding selected metadata as authenticated associated data is established in [RFC5116 §§2.1–2.3](07_prior_art_and_sources.md#ae); [ESP §3.3.2](07_prior_art_and_sources.md#esp) authenticates its own specified record fields. [historical RFC2401 §8](07_prior_art_and_sources.md#mls) associates sensitivity with channels/data. The experiment chooses its own 64-byte layout, codes and 1024-byte cap.

## Authentication and nonce discipline

For this experiment, use the existing `AEAD_AES_256_GCM` construction with a 32-byte directional key, a 12-byte nonce, and the full 16-byte tag. The 64-byte header is associated data. The nonce is the session's protected 4-byte prefix followed by the header's 8-byte sequence value. The underlying primitive and the importance of nonce uniqueness are specified in [RFC 5116](https://www.rfc-editor.org/rfc/rfc5116.html).

Each installation uses a fresh key and session identifier; the key is exclusive to this encoding and direction. Only the protected sender allocates sequence values. Reset, loss of counter state, uncertain restoration, or an attempted wrap retires the session. Reinstalling an old key with sequence zero is forbidden. Migration or replication cannot copy this state into two concurrent senders without a new allocation scheme. Losing receiver replay state likewise retires its session rather than reopening acceptance of old records.

For reboot-safe nonce allocation compare [RFC5116 §3.1](07_prior_art_and_sources.md#ae) and [ESP §3.3.3](07_prior_art_and_sources.md#esp); for failover receive-state hazards compare [RFC6027 §§3.4–3.5 and RFC6311](07_prior_art_and_sources.md#ha). Mandatory retirement on uncertainty and burning even unused reserved sequence values are conservative ASKA choices. Other designs can recover or synchronize state; the first ASKA model omits those alternatives.

Laboratory runs cap a session at `2^20` emitted records to exercise retirement and renewal. This experimental limit exercises the lifecycle; it has not been derived as a cryptographic security bound. A deployment must set and justify limits on total authenticated blocks, failed verification attempts, key lifetime, and aggregate use across sessions. A 64-bit sequence field alone cannot justify using one key for `2^64` messages.

This symmetric construction supplies evidence to the receiving endpoint. Because that endpoint also holds the directional verification key, the record is not transferable proof against a dishonest receiver. Public attribution or third-party audit would need a different evidence design.

## Bounded parsing and delivery

The receiver first checks the outer record length and fixed grammar without allocating session state. It rejects unsupported version or flags, non-64 header size, payload outside 1–1024, arithmetic overflow, and any mismatch with `80 + payload_bytes`. Unknown session identifiers are rejected without creating a session or sending an enrollment response.

For a known session, authentication and policy evaluation occur in bounded resources. The receiver does not expose partially decrypted bytes. It rejects unknown field codes and inconsistent session mappings. A host-supplied source address is transport information, not the authoritative source identity.

Unknown-association rejection is established in [ESP §3.4.2](07_prior_art_and_sources.md#esp); bounded record processing in [TLS §5.1](07_prior_art_and_sources.md#tls); authenticated-decryption failure semantics in [RFC5116 §2.2](07_prior_art_and_sources.md#ae). Hardware quarantine must additionally prevent DMA and receiving compartments from reading unaccepted plaintext.

Use a 64-record replay window in the initial model: the highest accepted sequence and a bitmap track recent arrivals. Sequences below the retained window or already marked are rejected. Authentication must succeed before a packet can advance the window. Acceptance and replay-state update serialize with policy changes and destination publication, as described in [Document 03](03_protected_handoff.md).

The highest-sequence and bitmap mechanism appears in [ESP §3.4.3/Appendix A](07_prior_art_and_sources.md#esp) and [hardware replay-window implementations](07_prior_art_and_sources.md#arp). ASKA additionally delays advancement until receiver policy passes. [RFC4301 §5.2 step4](07_prior_art_and_sources.md#ip) places selector checks after ESP processing, which differs from the ASKA commit order.

This permits limited reordering. It cannot preserve delivery under arbitrary delay: a valid old record can fall outside the window. Retransmission may repeat the exact already-created ciphertext; it does not re-encrypt new data with the same nonce. A duplicate never produces a second mailbox delivery. Fresh application retries use new record numbers and separate application deduplication if needed.

The record carries no fragmentation fields. A transport binding must reject or bound outer reassembly before the protected parser. In a controlled 1500-byte IPv6/UDP path with no extension headers, the largest record occupies `40 + 8 + 64 + 1024 + 16 = 1152` bytes at the IP layer. The record fits under those assumptions. Reassembly and the remaining transport and deployment details still need specification.

## What “stateless transit” can mean

The endpoint record does not authorize transit switches. An intermediate switch lacks the endpoint key and cannot treat the visible `label_code` as authenticated authority merely by reading it.

A candidate protected fabric could instead use packet-carried forwarding permissions that each relevant gate can verify. The ordinary controller would select among permitted paths. A protected gate would check authorization against its actual ingress and proposed egress, current generation, and applicable resource class.

TVA develops receiver-authorized traffic capabilities; SANE uses capabilities enforced by switches within an enterprise protection architecture. SCION authenticates forwarding information with hop fields and MACs. Those mechanisms address overlapping questions and are comparison baselines for any ASKA-specific alternative. [TVA](https://users.cs.duke.edu/~xwy/publications/tva.pdf), [SANE](https://www.usenix.org/legacy/event/sec06/tech/full_papers/casado/casado_html/paper.html), [SCION header specification](https://docs.scion.org/en/latest/protocols/scion-header.html).

The feasible objective is **no per-application-flow table in each transit gate**. Transit still needs keys, epoch or policy state, port configuration, queues, and bounded resource accounting. The edges keep session, replay, and any exact per-session quota state.

For closer comparisons, see [ICING §§2–3,5](07_prior_art_and_sources.md#d01) and [OPT](07_prior_art_and_sources.md#d02), [EPIC](07_prior_art_and_sources.md#d03), [Platypus](07_prior_art_and_sources.md#d05), [SIBRA](07_prior_art_and_sources.md#d08). ICING directly targets verification without per-flow forwarding authority; keys/queues/control state still remain. [FAIR](07_prior_art_and_sources.md#d09) provides accountability after forwarding; it cannot prevent the first crossing. [FABRID](07_prior_art_and_sources.md#d04) concerns attested forwarding choices, while cable geography needs independent evidence.

| State location | State that remains | Consequence |
|---|---|---|
| Source edge | Ownership, labels, grants, keys, sequence, accounting | A protected handoff is stateful |
| Transit gate | Port/neighbor policy, keys, generations, class queues | Stateless-per-flow does not mean stateless |
| Receiver edge | Admission mappings, replay window, delivery state, accounting | Replays can be rejected at the receiver |
| Enrollment/recovery functions | Accreditation, installation, rotation, withdrawal | Removing a data-plane table does not remove control-plane work |

A transit gate with no per-flow history cannot remember every replay or enforce every individual flow's exact cumulative allowance. A token is copyable unless some state or physical assumption limits its reuse. Replayed valid traffic can consume transit capacity before an edge discards it. Class scheduling and policing may bound that damage, with corresponding state and sharing costs.

A forwarding design must specify key ownership, token issuance, path splicing defenses, direction, expiration, and the relationship between forwarding authority and the actual record. It must say whether a token authorizes only a resource class or also asserts protected payload provenance. Those claims require different bindings and potentially different authentication work.

For the first physical-gate study, a static protected port policy is sufficient to test whether a compromised controller can bypass an egress veto. It does not demonstrate scalable packet-carried authorization. The endpoint record experiment and port experiment test different properties.

Separate protected control has precedents in [BlueField restricted mode](07_prior_art_and_sources.md#bf), [Intel control-plane isolation](07_prior_art_and_sources.md#cpi), [Intel NIC control paths](07_prior_art_and_sources.md#cps). ICING trusts its local provider and uses a Linux-managed key slow path. The ASKA study must check whether a compromised route controller can reconfigure the physical datapath under its own trust model. Separately authorized installation, packet-carried authority, actual port binding and unavoidable egress are the requirements to compare. The [physical-forwarding research](08_defensive_structural_disclosure.md#physical-forwarding-research) needs a specified token and enforcement construction before an apparatus can be evaluated.

## Physical forwarding and cut-through behavior

A physical-path claim names the boundary at which transmission becomes irreversible. If a gate begins forwarding protected content before validating the evidence required for that crossing, discarding the tail cannot undo the prefix already sent.

A design may authenticate a bounded authorization header before forwarding, buffer the complete record, or use independently authenticated chunks. It must specify what the checked evidence establishes about the rest of the bytes. Payload authentication completed only at the final endpoint establishes no earlier claim that every forwarded payload was valid.

Compare [ICING Figs.3,7](07_prior_art_and_sources.md#d01) for packet-bound verification and [EPIC](07_prior_art_and_sources.md#d03) for per-packet path authentication. A logical verify-before-forward algorithm does not alone prove the needed protected buffering circuit. Evaluate header-only authorization, store-and-forward and authenticated chunks against their respective guarantees.

Likewise, proving that a port is permitted does not prove that a remote cable follows an asserted geographical path. Physical route claims require inventory, inspection, and a threat model for the intervening infrastructure. An overlay experiment cannot supply that evidence.

## Expiry, withdrawal, and partitions

`policy_generation` prevents acceptance under the wrong installed version, but it cannot measure elapsed time. During a network partition, the generation may never change.

The receiving gate therefore uses a protected local elapsed-time deadline. Let `L` be a lease duration measured locally, and let the clock's maximum fractional slowdown be `delta < 1`. If clock progress is continuous and the maximum enforcement delay is `epsilon`, acceptance stops no later than:

```text
L / (1 - delta) + epsilon
```

real seconds after activation. Reset or clock uncertainty invalidates the lease. Replaying an installation message cannot restart its lifetime; installation needs fresh protected authorization and anti-replay state. The receiver checks the deadline at delivery commit, so queued packets do not acquire indefinite validity.

Protected timed assertions that fail on clock discontinuity are already specified by [TPM2.0 §19.7.12, pp.128–130](07_prior_art_and_sources.md#tpm); [ICING §3.3](07_prior_art_and_sources.md#d01) includes expiring consent (not implemented in its prototype). The comparison still needs to cover replay of installation messages and lifetime enforcement at the receiver or forwarder. The bound above follows from the stated continuous-clock assumptions.

A local withdrawal takes effect at the receiver's serialized policy update. Remote withdrawal takes effect only when authenticated notice arrives or the applicable lease expires. Previously delivered information cannot be recalled. Preauthorized local safety functions may continue within a separately defined envelope, but a partition does not authorize new cross-realm rights.

## Privacy, enrollment, and interoperability

The visible header leaks length, session continuity, and session-local codes. Replacing names with identifiers reduces some disclosure but does not provide anonymity. Padding, rotation, and hiding policy metadata would add cost and need an observer model. Transit should receive only the information necessary for its decision; it does not need universal access to plaintext or civil identity.

A pre-enrolled protected ingress can silently reject unknown records. A public discovery or enrollment service has a different attack surface and its own resource budget. Silence does not prevent an upstream link from being flooded, and stateless forwarding does not inherently require every peer to be enrolled manually.

Existing transports should be reused where they preserve the contract. Terminating TLS, IPsec, or another secure channel inside a suitable protected boundary is an important comparison. Use the experimental record’s semantics to assess whether an existing transport suffices. A legacy gateway that decrypts or reclassifies data becomes an explicit trusted component. Unsupported protection must cause an explicit policy decision, never an automatic fallback to weaker semantics.

Protected endpoint comparisons should include [Ryoan](07_prior_art_and_sources.md#ry), [SENG](07_prior_art_and_sources.md#seng), [attested TLS](07_prior_art_and_sources.md#e08) as well as [RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [TLS 1.3](07_prior_art_and_sources.md#tls), [historical MLS IPsec](07_prior_art_and_sources.md#mls) protocol semantics. Device attachment and keys need [Composite Enclaves](07_prior_art_and_sources.md#a12), [TDX Connect](07_prior_art_and_sources.md#e05), [NVIDIA GPU threat model](07_prior_art_and_sources.md#e06) configuration-level review. A legacy reclassification/exporter path should also be compared with [DStar](07_prior_art_and_sources.md#c05), [CamFlow](07_prior_art_and_sources.md#c08), retaining their actual trusted components.
