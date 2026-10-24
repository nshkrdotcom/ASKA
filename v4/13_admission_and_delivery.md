# ASKA v4 — Admission, transport, and protected delivery

[Start](01_architecture_and_reading_map.md) · [Previous](12_cross_domain_security_and_information_release.md) · [Next](14_governance_updates_and_recovery.md)

**Requirements:** R01, R04, R05, R06, R07, R08, R12, R13, R19, R20, R23.

The source and receiver authorize their own sides of a transfer. Identity discovery, authority installation, forwarding, transport acceptance, object publication, and application effect each have a separate decision point. Completing one stage grants no implicit permission for the next.

## Identity and first contact

Realm identifiers bind canonical root-key material under a selected identity scheme. Service records bind a realm, service role, gate identity, key generation, and validity. Locators and paths provide separate discovery hints. A self-consistent key hash proves no relationship to a name the user intended; first contact requires an accepted introduction, configured anchor, or certification relationship.

Public encounter services use the dedicated receive resources specified in [11](11_purpose_networks_and_gateways.md), with bounded parser state and operation/concurrency caps. Existing relationships have separately reserved control service. Retry cookies can limit spoofed-source allocation but do not defeat reachable attackers. The ingress receiver silently drops unknown data-session identifiers without creating state or initiating admission. Those drops still consume bounded framing and lookup work; their load must not consume resources reserved for established traffic.

Attestation can report gate measurements and configuration under an accepted root. The receiver separately appraises what those measurements mean and which update authorities it trusts. Attestation neither authorizes arbitrary methods nor proves the measured implementation correct. [RATS architecture](https://www.rfc-editor.org/rfc/rfc9334.html).

## Bilateral contract installation

```text
DISCOVERED -> AUTHENTICATED_CONTROL -> OFFERED
  -> LOCALLY_ACCEPTED -> CONFIRMED -> INSTALLED -> ACTIVE
```

The source offers requested contexts, object methods, category mappings, physical path class, resource limits, and lifetime. The receiver returns the accepted intersection and a fresh challenge. The source confirms the exact canonical contract. Each side's authorized local installer verifies its own policy and fresh installation context. The receiver acknowledges readiness before the source enables emission.

The contract binds both realm/gate identities, fresh challenges, direction, source/destination generations, method/schema map, category/release map, crypto suite, maximum lengths, replay window, allocation/key-use limits, local leases, resource budgets, and required transport/physical profile. Meaning-changing map updates require a fresh contract. Receiver narrowing can take effect immediately through the delivery commit order.

A source credential may propose a contract but cannot install or broaden receiver policy. Replayed installation messages cannot renew a lease or reactivate a retired generation. Each installer checks freshness against its current protected boot/installation context. If it loses that context, it closes the uncertain sessions.

The protocol designer must choose an established authenticated key exchange whose guarantees fit the carrier and threat model. An intermediate implementation can use mutually authenticated TLS 1.3 over a reliable ordered control channel, with transcript-bound exporters and separate derivation labels for directional data keys. This does not make IP/TCP a native requirement. A new native binding needs canonical encodings, downgrade resistance, test vectors, and independent cryptographic review. [TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html).

Long-lived identities and confidential data require cryptographic migration planning. The cryptographic study must evaluate reviewed post-quantum key-establishment and signature profiles, including [ML-KEM](https://csrc.nist.gov/pubs/fips/203/final) and [ML-DSA](https://csrc.nist.gov/pubs/fips/204/final), with their current errata, implementation, and protocol assumptions. Neither a primitive nor a “quantum-resistant” label establishes a secure composed handshake. Local installers must authorize suite changes as contract changes and enforce downgrade protection. A suite change cannot silently reactivate retired keys. Quantum communication or entanglement is not a prerequisite for native networking.

## Data contract and encoding obligations

The architecture selects record semantics. The implementation study must still choose production field widths and cryptographic bindings. Every authenticated record resolves these meanings, either explicitly or through immutable installed state:

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

The encoding must be canonical, bounded, overflow-safe, and unambiguous about authenticated fields. The receiver denies processing for unknown critical fields or unsupported protection profiles. Remote identifiers remain data until the receiver resolves them through protected maps. Payloads cannot import native reference tags directly.

The key schedule must assign disjoint key/nonce spaces to the two directions. The protected source allocator burns sequence values even on cancellation. Changed plaintext never reuses a nonce under a key; retransmission repeats identical protected bytes. Key-use limits cover processed blocks and verification attempts, not merely sequence-field capacity. If the allocator cannot establish counter continuity, it retires the key/session. [AEAD interface and nonce requirements](https://www.rfc-editor.org/rfc/rfc5116.html).

## Receive and publication order

1. The receiver performs bounded framing and session lookup without admitting new state. It rejects lengths and sequence values outside installed limits, applies a read-only consumed-window precheck, and reserves a bounded verification/quarantine slot.
2. The authentication engine authenticates/decrypts into transport quarantine that workloads and untrusted DMA cannot access. Failed authentication must change neither replay state nor authenticated-sender authority.
3. The receiver serializes a second freshness check with sequence consumption. It consumes authenticated records even when later method, policy, resource, or destination checks deny delivery. Concurrent duplicates cannot both win.
4. The receiver resolves mappings and performs preliminary delivery checks. It assembles multi-record objects only in bounded protected staging, with immutable identity, offsets, total length, and commitment. It denies an object on overlap, inconsistent commitment, or resource exhaustion under a declared retry rule.
5. At publication, the receiver serializes its commit with current receiver-policy updates and destination generation changes. It rechecks permission, lifetime, category/release, complete-object integrity, and allowance, then reserves all fallible destination resources before charging delivery and assigning restrictions.
6. The receiver publishes only after that commit succeeds. Then a separately confined application parser may read the delivered object. Holding authenticated data in quarantine does not establish the safety of image/PDF/text parsing.

For atomic object publication, no partial assembly reaches the destination. A streaming method can authorize chunk-level effects explicitly, with its own partial-failure semantics. Application effect commit and durable storage still follow [07](07_persistence_and_effects.md).

## Release and transport are separate commits

A transport session can carry an output only after source-side flow and effect checks establish that output's authority. Where the flow policy requires release, the authenticated contract binds its release reference and immutable representation. Session authentication establishes neither that an attachment is harmless nor that its sender may disclose arbitrary plaintext.

Release-use consumption, transport sequence consumption, object publication, and application effects are distinct events. A source can spend a one-use release and then crash before emission; it must not recover by silently reopening that allowance. Exact retransmissions need an explicitly bounded retry rule and receiver operation deduplication. Neither replay protection nor a signature prevents a compromised semantic release authority from approving forbidden information. [12](12_cross_domain_security_and_information_release.md) specifies the surviving controls and residual dependency.

## Replay, denial, and recovery

The consumed window has a negotiated finite size. Authenticated forward sequences within the installed allocation limit can advance it regardless of gap; local aborts and wire loss must not trigger automatic retirement based on a small numerical jump. Advancing can age delayed traffic out. Narrow contracts limit the effect of an admitted malicious key holder, not its ability to abuse its own valid scope.

Resource accounting counts verification cost, consumed authenticated records, successful delivery, and application effects separately. Before authentication, a visible session identifier provides a lookup hint without reliable attribution. Forged packets naming a victim session cannot spend authenticated sender credit, change its policy, or trigger permanent key retirement. Temporary queue/service limits still need refill/fairness rules and measurements under targeted floods.

If transport quarantine is full, the receiver drops the record before verification. If it consumes an authenticated record and then denies delivery, the sender must use a new sequence for the retry. Application operation identity supports deduplication independently of transport sequence. Receipts distinguish transport acceptance, object publication, durable commit, and uncertain physical effect.

A replacement data contract may reuse a live authenticated control channel with fresh challenges, identifiers, and keys. Repeat attestation when local evidence policy requires it. The recovery controller bounds its request rate and concurrency so recovery cannot monopolize service reserved for unaffected sessions. If it loses replay state, it retires the session; it cannot reopen old traffic.

## Link interruption and session recovery

A guard distinguishes a paused physical path from a retired data contract. On detecting link loss, it blocks new emission on that path and discards incomplete link frames. Its path contract bounds detection and enforcement delay where such a bound is claimed. It preserves already consumed sequences and release uses. It also preserves complete authenticated records that remain valid under their original bindings; a flap cannot reopen freshness or refund uncertain emission.

The guard may resume under the same contract only while protected keys, nonce allocation, replay state, endpoint generations, policy mappings, leases, and required path bindings remain valid. Before emission, the guard rechecks current permission and physical egress. Retransmission uses identical protected bytes under the existing retry envelope, or fresh sequences for newly protected records. It never encrypts changed plaintext with an old nonce. Link interruption does not pause elapsed-time expiry.

If the guard cannot establish key custody, nonce allocation, or replay-state continuity, it retires the affected data contract. Endpoint replacement, changed mappings, or lost physical-path evidence require fresh installation or path authorization as applicable. Re-attest when the accepted evidence policy or a changed enforcement configuration requires it. A live authenticated control channel can install fresh data keys and challenges under the existing bounded recovery rules; a carrier flap alone does not mandate a full handshake and attestation.

A declaration of continuity needs protected reset/event semantics and recoverable state, not a link-up indication or a workload assertion. An in-line interceptor lacking keys remains subject to authentication and replay checks, but can observe traffic or deny service within the carrier threat model. Tests of link-state events cannot exclude an undetected passive tap. Deployments requiring retirement after specified physical events can impose that stricter policy and must account for induced recovery load.

## Expiry and physical forwarding

Local policy updates and elapsed-time leases bound current authority. For local duration `L`, maximum fractional clock slowdown `d < 1`, and enforcement delay `e`, continuous progress gives a real-time bound `L/(1-d) + e`. Reset or clock uncertainty invalidates the lease. A remote revocation notice has no instantaneous effect during a partition.

The forwarding gate verifies the chosen path/circuit authorization against actual ingress and selected physical egress before transmission. Whether it authenticates a complete record, a bounded authorization header, or independent chunks must match the claimed property. If the contract requires payload validity before a crossing, the forwarding guard must establish it there. Endpoint authentication afterward cannot satisfy that order. The first prototype should buffer complete bounded records to make this ordering observable.

**Open research:** a compact native encoding and reviewed key schedule; flow-controlled segmentation and retry; independent gate protocol integration; deployment cryptographic limits; and service guarantees under admitted floods. A model can establish ordering within its bounds, not interoperable or line-rate operation by itself.
