# ASKA v4 — Admission, transport, and protected delivery

[Start](01_architecture_and_reading_map.md) · [Previous](12_cross_domain_security_and_information_release.md) · [Next](14_governance_updates_and_recovery.md)

**Requirements:** R01, R04, R05, R06, R07, R08, R12, R13, R19, R20, R23.

Communication requires independent source and receiver decisions. Identity discovery, authority installation, forwarding, transport acceptance, object publication, and application effect are separate stages. Completing an earlier stage does not implicitly authorize a later one.

## Identity and first contact

Realm identifiers bind canonical root-key material under a selected identity scheme. Service records bind a realm, service role, gate identity, key generation, and validity. Locators and paths provide separate discovery hints. A self-consistent key hash proves no relationship to a name the user intended; first contact requires an accepted introduction, configured anchor, or certification relationship.

Public encounter services have isolated parsers, bounded state, operation/concurrency caps, and reserved service for existing relationships. Retry cookies can limit spoofed-source allocation but do not defeat reachable attackers. Unknown data-session identifiers are silently dropped without creating state or initiating admission.

Attestation can report gate measurements and configuration under an accepted root. The receiver separately appraises what those measurements mean and which update authorities it trusts. Attestation neither authorizes arbitrary methods nor proves the measured implementation correct. [RATS architecture](https://www.rfc-editor.org/rfc/rfc9334.html).

## Bilateral contract installation

```text
DISCOVERED -> AUTHENTICATED_CONTROL -> OFFERED
  -> LOCALLY_ACCEPTED -> CONFIRMED -> INSTALLED -> ACTIVE
```

The source offers requested contexts, object methods, category mappings, physical path class, resource limits, and lifetime. The receiver returns the accepted intersection and a fresh challenge. The source confirms the exact canonical contract. Each side's authorized local installer verifies its own policy and fresh installation context. The receiver acknowledges readiness before source emission activates.

The contract binds both realm/gate identities, fresh challenges, direction, source/destination generations, method/schema map, category/release map, crypto suite, maximum lengths, replay window, allocation/key-use limits, local leases, resource budgets, and required transport/physical profile. Meaning-changing map updates require a fresh contract. Receiver narrowing can take effect immediately through the delivery commit order.

A source credential may propose a contract but cannot install or broaden receiver policy. Replayed installation messages cannot renew a lease or reactivate a retired generation. Installation freshness includes current protected boot/installation context; losing it closes uncertain sessions.

Use an established authenticated key-exchange protocol whose guarantees fit the carrier and threat model. An intermediate implementation can use mutually authenticated TLS 1.3 over a reliable ordered control channel, with transcript-bound exporters and separate derivation labels for directional data keys. This does not make IP/TCP a native requirement. A new native binding needs canonical encodings, downgrade resistance, test vectors, and independent cryptographic review. [TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html).

Long-lived identities and confidential data require cryptographic migration planning. Evaluate reviewed post-quantum key-establishment and signature profiles, including [ML-KEM](https://csrc.nist.gov/pubs/fips/203/final) and [ML-DSA](https://csrc.nist.gov/pubs/fips/204/final), with their current errata, implementation, and protocol assumptions. Neither a primitive nor a “quantum-resistant” label establishes a secure composed handshake. Suite changes are locally authorized contract changes with downgrade protection; they cannot silently reactivate retired keys. Quantum communication or entanglement is not a prerequisite for native networking.

## Data contract and encoding obligations

The record semantics are selected; production field widths and cryptographic binding remain an implementation study. Every authenticated record resolves these meanings, either explicitly or through immutable installed state:

```text
protocol/profile; directional session and key generation
transport sequence; source domain generation
destination object generation; method and schema
category map; release reference if any
application operation identity
payload length and stable payload bytes
for segmented objects: object/version identity, total length,
chunk offset/index, total commitment, and publication mode
```

The encoding must be canonical, bounded, overflow-safe, and unambiguous about authenticated fields. Unknown critical fields and unsupported protection profiles deny processing. Remote identifiers remain data until the receiver resolves them through protected maps. Payloads cannot import native reference tags directly.

Directional key/nonce spaces are disjoint. The protected source allocator burns sequence values even on cancellation. Changed plaintext never reuses a nonce under a key; retransmission repeats identical protected bytes. Key-use limits cover processed blocks and verification attempts, not merely sequence-field capacity. Counter uncertainty retires the key/session. [AEAD interface and nonce requirements](https://www.rfc-editor.org/rfc/rfc5116.html).

## Receive and publication order

1. Perform bounded framing and session lookup without admitting new state. Reject lengths and sequence values outside the installed limits. Apply a read-only consumed-window precheck and reserve a bounded verification/quarantine slot.
2. Authenticate/decrypt into transport quarantine inaccessible to workloads and untrusted DMA. Invalid authentication changes no replay or authenticated-sender authority.
3. Serialize a second freshness check and sequence consumption. Consume authenticated records even when later method, policy, resource, or destination checks deny delivery. Concurrent duplicates cannot both win.
4. Resolve mappings and perform preliminary delivery checks. Assemble multi-record objects only in bounded protected staging, with immutable identity, offsets, total length, and commitment. Overlap, inconsistent commitment, or resource exhaustion denies the object under a declared retry rule.
5. At publication, serialize with current receiver-policy updates and destination generation changes. Recheck permission, lifetime, category/release, complete-object integrity, and allowance. Reserve all fallible destination resources before charging delivery and assigning restrictions.
6. Publish only after that commit succeeds. Then a separately confined application parser may read the delivered object. Holding authenticated data in quarantine does not establish the safety of image/PDF/text parsing.

For atomic object publication, no partial assembly reaches the destination. A streaming method can authorize chunk-level effects explicitly, with its own partial-failure semantics. Application effect commit and durable storage still follow [07](07_persistence_and_effects.md).

## Release and transport are separate commits

A transport session can carry an output only after source-side flow and effect checks establish that output's authority. The authenticated contract binds its release reference and immutable representation where release is required. Session authentication does not assert that an attachment is harmless or that its sender is permitted to disclose arbitrary plaintext.

Release-use consumption, transport sequence consumption, object publication, and application effects are distinct events. A source can spend a one-use release and then crash before emission; it must not recover by silently reopening that allowance. Exact retransmissions need an explicitly bounded retry rule and receiver operation deduplication. Neither replay protection nor a signature prevents a compromised semantic release authority from approving forbidden information. The surviving controls and residual dependency are specified in [12](12_cross_domain_security_and_information_release.md).

## Replay, denial, and recovery

The consumed window has a negotiated finite size. Authenticated forward sequences within the installed allocation limit can advance it regardless of gap; local aborts and wire loss must not trigger automatic retirement based on a small numerical jump. Advancing can age delayed traffic out. Narrow contracts limit the effect of an admitted malicious key holder, not its ability to abuse its own valid scope.

Verification cost, consumed authenticated records, successful delivery, and application effect budgets are counted separately. Before authentication, a visible session identifier provides a lookup hint without reliable attribution. Forged packets naming a victim session cannot spend authenticated sender credit, change its policy, or trigger permanent key retirement. Temporary queue/service limits still need refill/fairness rules and measurements under targeted floods.

If transport quarantine is full, drop before verification. If an authenticated record is consumed and then denied, retry uses a new sequence. Application operation identity supports deduplication independently of transport sequence. Receipts distinguish transport acceptance, object publication, durable commit, and uncertain physical effect.

A replacement data contract may reuse a live authenticated control channel with fresh challenges, identifiers, and keys. Repeat attestation when local evidence policy requires it. Recovery work is rate/concurrency bounded and cannot monopolize service reserved for unaffected sessions. Loss of replay state retires its session rather than reopening old traffic.

## Expiry and physical forwarding

Local policy updates and elapsed-time leases bound current authority. For local duration `L`, maximum fractional clock slowdown `d < 1`, and enforcement delay `e`, continuous progress gives a real-time bound `L/(1-d) + e`. Reset or clock uncertainty invalidates the lease. A remote revocation notice has no instantaneous effect during a partition.

The forwarding gate verifies the chosen path/circuit authorization against actual ingress and selected physical egress before transmission. Whether it authenticates a complete record, a bounded authorization header, or independent chunks must match the claimed property. If payload validity is required before a crossing, endpoint-only authentication afterward is insufficient. The first prototype should buffer complete bounded records to make this ordering observable.

**Open research:** a compact native encoding and reviewed key schedule; flow-controlled segmentation and retry; independent gate protocol integration; deployment cryptographic limits; and service guarantees under admitted floods. A model can establish ordering within its bounds, not interoperable or line-rate operation by itself.
