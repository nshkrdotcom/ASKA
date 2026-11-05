# ASKA v6 — Packet records, delivery and egress

## A record is a bounded authority-bearing object

ASKA transport operates on bounded records whose protected fields bind payload, peer, object and effect context. A record is not accepted solely because its packet checksum or channel authenticator is valid. The receive guard (RG) authorizes protected publication; the egress guard (EG) authorizes a named emission boundary. Routing and encryption support those decisions but do not replace them.

A selected protocol manifest defines canonical encoding, field widths, length limits, algorithm suite, nonce construction, sequence allocation, replay horizon, queue capacities and exhaustion behavior. The following logical fields must be represented directly or by an unambiguous protected context:

| Field group | Required meaning |
|---|---|
| Protocol | Schema version, record type, critical fields and exact encoded length |
| Session | Peer roles, session identity, key epoch and endpoint binding |
| Object | Realm, owner, object identity, generation, class and payload commitment |
| Authority | Grant reference and epoch, policy context, operation and recipient |
| Delivery | Sequence, effect identifier, idempotency key and transfer mode |
| Limits | Payload size, batch context where applicable, lifetime and relevant budget |
| Protection | Authenticated encoding or authenticated associated data covering all decision-relevant fields |

A record can carry ciphertext, but the source release owner must establish the required binding to the permitted plaintext or transformation. A malicious worker must not be allowed to encrypt arbitrary confidential data to an unintended recipient and claim that the gateway sees only harmless opaque bytes.

**R-38-01 — Unambiguous protected records.** Every accepted record MUST bind all decision-relevant fields to one canonical protected representation and a finite protocol profile. Unknown critical fields, duplicate fields, inconsistent lengths, arithmetic overflow and ambiguous object or endpoint bindings MUST be rejected.

## Keys, nonces and sequence allocation

The cryptographic profile separates traffic keys by session, direction and purpose using a reviewed construction. If TLS exporters are used, the binding follows [the normal exporter contract in RFC 8446](https://www.rfc-editor.org/rfc/rfc8446.html), with the admitted application context. This is a candidate construction, not a mandatory universal wire suite. An implementation must not invent a custom cryptographic construction without its own review.

AEAD nonce discipline is distinct from replay protection. [RFC 5116, sections 3 and 3.2](https://www.rfc-editor.org/rfc/rfc5116.html) describes nonce-use and construction obligations. The selected profile must ensure uniqueness under a key, including across concurrent senders, crash recovery, canceled batches and key rotation. A record that was prepared but never emitted may still have consumed nonce material; cancellation does not authorize reuse with another plaintext.

**R-38-02 — Nonce and sequence continuity.** Traffic-key use MUST preserve the selected construction’s nonce requirements across all sender lifecycles. Sequence allocation MUST be protected against overlap, rollback and wrap, and allocated material MUST NOT be reused after an ambiguous or canceled operation.

Sequence blocks can be preallocated to reduce contention, but the allocator records their ownership and epoch. Unused values may be burned. Counter exhaustion closes or rekeys the context before wrap. A restored snapshot cannot restart a counter under an old key. Session identifiers and key epochs are not raw process IDs that may be recycled without regard to old traffic.

**R-38-03 — Cryptographic key-use ceilings.** Every traffic-key profile MUST define reviewed per-key ceilings for processed data blocks and verification attempts, as well as nonce and sequence limits. Protected accounting MUST reserve the applicable use before parallel engines begin work and MUST stop, rekey or retire the cryptographic context before any ceiling would be exceeded. A crash, canceled job or uncertain accounting state MUST NOT reset or refund potentially consumed cryptographic use.

[TLS 1.3 section 5.5](https://www.rfc-editor.org/rfc/rfc8446.html) addresses key-use limits; an ASKA native profile requires bounds reviewed for its own construction. The profile specifies the accounting unit, authenticated-data and payload contributions, maximum record length, applicable failed-verification count and safety margin. A large sequence field cannot substitute for those limits. The protected key owner aggregates actual use across all engines sharing the key, with overflow-safe counters and recovery continuity or mandatory retirement. Distinct keys may have distinct bounds; no universal numerical ceiling is selected here.

Verification-work accounting is separate from accepted replay state, authenticated-sender credit and application effect allowances. A failed verification counts against the cryptographic bound when the selected construction requires it, but cannot establish sender culpability or spend the named principal’s effect grant. Reaching a key-use ceiling stops further use of that key; it does not establish a permanent revocation of the peer’s identity or general rights. Bounded recovery may install fresh keys, while encounter admission and fair scheduling limit an attacker’s ability to force repeated recovery. Framing rejection before invoking the keyed engine is recorded separately from a verification attempt.

## Bounded ingress and quarantine

Ingress processing first performs safe bounded framing and resource admission. It then authenticates the record under the selected session, validates endpoint and object context, and checks current policy. Payload bytes remain in protected quarantine until final receive publication. Decryption into application-readable memory is already disclosure and therefore cannot be used as a preliminary validation step.

Queues have finite byte, descriptor and cryptographic-work budgets. The protocol declares whether authenticated work may wait and for how long. A strict candidate can reject when no protected slot is available; another may queue under a bounded lease. Neither allows an attacker to create an unbounded waiting room by naming valid-looking sessions. Authentication failures may consume an encounter-processing budget, but cannot spend the victim’s one-use authority or mutate its accepted replay state.

**R-38-04 — Protected bounded ingress.** Unaccepted plaintext MUST remain inaccessible to the destination application. Ingress work and waiting state MUST be bounded, and malformed or unauthenticated traffic MUST NOT consume another principal’s effect authority or alter its accepted replay state.

A preliminary replay check can reject an obvious duplicate before expensive work, but successful preliminary inspection does not reserve acceptance. Concurrent workers may race. The final protected transition must repeat freshness, sequence and policy checks against the current state.

## Accepted replay state and negative outcomes

The accepted replay window represents records whose authorized protected publication occurred. Its high-water value and bitmap or equivalent set change only with that publication. An authenticated record rejected for policy, label, destination, capacity or current grant failure does not advance the accepted window. In particular, a malicious policy-invalid record with a high sequence number must not suppress a valid lower sequence.

A separate bounded negative-result cache may remember rejected authenticated attempts. Its key binds the relevant session/key epoch, sequence, exact record commitment and policy/grant context. It cannot redefine accepted sequence history. Its entries expire or are re-evaluated according to a declared policy-change rule; a past denial is not an eternal right to prevent a newly authorized operation. Negative caching itself has bounded memory and cannot become an unbounded state-exhaustion service.

**R-38-05 — Publication-based replay acceptance.** Accepted replay state MUST change atomically only with authorized protected publication. Rejected records MAY enter a separate bounded negative-result cache, but MUST NOT shift the accepted window, suppress otherwise admissible lower sequences or consume accepted-publication quota. Unauthenticated records MUST NOT change either authenticated outcome history or accepted state.

The profile also defines the admissible forward horizon and treatment of gaps. A large forward jump is not permission to retire all intervening records. A resynchronization protocol, bounded gap rule or fresh session may be required. Records outside the admitted horizon are denied without changing accepted history. The selected window must support the declared concurrency and reordering envelope; an undersized window is an availability limitation, not a reason to relax authentication.

## Atomic receive publication

The local final transition performs the following conceptual operations under one serialized or recoverably equivalent decision:

1. Recheck current session, object generation, grant, negative restrictions, destination acceptance and sequence admissibility.
2. Confirm protected capacity and the exact quarantined payload commitment and label.
3. Publish the destination object, record the accepted sequence, debit the applicable grant budget and establish the local receipt.
4. Release transient resources according to their lifetime contract.

These steps describe required semantics, not a prescribed software implementation. Hardware transactions, a protected journal or a narrow commit controller may provide the transition. A design with publication in one uncontrolled process and replay/debit state in another must demonstrate equivalent crash consistency before claiming this property.

**R-38-06 — Atomic receive consequence.** Protected object publication, accepted replay update, applicable authority debit and label installation MUST be one atomic or recoverably equivalent local finality transition. A crash MUST NOT permit published data with reusable one-use authority or a consumed accepted sequence with no corresponding established publication.

The receipt reports protected publication, not application understanding or durable storage unless those are explicitly part of the receiving owner’s finality. If the application later rejects the object, that is a separate result. An established publication receipt remains committed even when subsequent workflow completion is unresolved.

## Egress, port binding and partial transmission

The EG binds an exact output object or sealed record to a recipient/session, actual egress port or protected tunnel context, current grant and finite budget. It checks policy at the finality point the profile promises. For a verified-before-first-byte profile, the complete bounded record is validated and buffered before emission begins. Checking only a header while streaming unverified payload would not satisfy that claim.

After the first irreversible byte crosses the named boundary, a later failure can produce partial emission. The receipt identifies the established prefix or the uncertainty in extent. The operation cannot be called aborted merely because the final byte or remote acknowledgement is missing. Streams use bounded chunks or a separately qualified contract with current checks and cumulative disclosure limits.

**R-38-07 — Actual-boundary egress authorization.** Egress MUST bind current release authority to the exact emitted representation and actual output context at its named finality point. Partial or ambiguous emission MUST preserve its scoped evidence; local cancellation MUST NOT be represented as undoing emitted bytes.

Transit path authentication, including an [EPIC-style mechanism](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) where selected, remains a separate protocol property. A packet may have a valid authenticated path and still lack permission to release its contents. Conversely, an authorized object may remain undelivered because no qualifying path is available.

## Batches, retry and recovery

A batch binds child count, aggregate byte limit, source-object versions, sequence allocation and expiration. Every child receives the required final checks. The source remains pinned until all child copies, cryptographic operations and retained-ciphertext uses have stopped. Canceling the batch cannot release memory while a delayed engine still reads it. Completion of some children does not imply completion of the remainder.

### Segmented-object assembly

**R-38-08 — Bounded atomic object assembly.** A segmented object MUST bind authenticated object and version identity, total encoded length, chunk index or offset, whole-object commitment, labels and publication mode. The RG MUST assemble it only in bounded protected staging, reject overlap, out-of-range extents, overflow and inconsistent bindings, and verify complete-object integrity before atomic application-visible publication. Partial assembly MUST NOT advance accepted replay state. Whole-object publication MUST atomically establish current authorization, destination generation, final label, allowance debit and replay state for its member records, unless an explicitly admitted chunk-effect contract defines separate authorized finality for each chunk.

The assembly manifest also binds the source and destination context, permitted chunk count and sizes, object generation, session/key epochs, grant and release references, and assembly lifetime. Exact duplicate chunks may be recognized without copying or recharging a published effect; differently encoded, overlapping or conflicting chunks are rejected under the declared retry rule. Protected provisional deduplication records describe assembly progress only. They cannot advance the accepted window, suppress an unrelated valid record, or turn a malicious high-sequence fragment into authority over lower sequences.

Before whole-object publication the RG checks that every required extent is present exactly once, the final length and commitment match, the member sequences remain fresh under the admitted finite horizon, and destination resources are reserved. It rechecks current policy, object generations, confidentiality and integrity restrictions, release authority, lifetime and budget in the same publication order. The selected horizon and staging capacity must support the admitted object size; a profile that cannot retain the needed member context must bound that size or refuse the object. Other accepted traffic aging a provisional member out requires a declared retry or rejection, not a silent weakening of freshness. No partial plaintext becomes readable by an application parser during this process.

On timeout, resource exhaustion or invalid assembly, staging is discarded only after engine references end and protected storage can be sanitized. Failure leaves accepted replay and application delivery allowances unchanged; actual cryptographic work remains accounted. A crash may resume provisional assembly only from protected, consistent bindings and current authorization. Otherwise it discards the assembly and follows session-continuity rules. Restoring partial chunks must not restore expired policy, spent rights or retired keys.

An admitted streaming method can intentionally expose chunks as separate effects. Its contract identifies the label, recipient, allowance, sequence and finality of each published chunk, and the consequences of a missing suffix. A completed first chunk remains committed even if a later chunk fails. Such a method cannot represent the partial stream as an atomically published whole object.

A retry uses the stable effect and idempotency context appropriate to the owner. It must not turn a lost receipt into a fresh unintended effect. A restart either restores accepted replay and effect evidence consistently or closes the old session and admits a fresh one while preserving unresolved outcomes. Changing keys prevents old ciphertext from becoming valid; it does not by itself resolve whether an old physical or remote effect occurred.

**R-38-09 — Safe record recovery.** Batch cancellation and restart MUST preserve source lifetime, consumed nonce/sequence material and established effect evidence. Retries MUST follow the owner’s deduplication or reconciliation contract and MUST NOT infer nonexecution from a missing receipt.

## Performance model and acceptance obligations

Capacity parameters are selected by workload and threat analysis. A laboratory study may compare 1 KiB records, fixed slot arrays, bounded replay windows and preallocated sequence blocks, but none is an architectural constant. The study must include denial paths, concurrency, maximum encoded lengths, timeouts and rekey behavior, not only a successful steady-state stream.

For payload size `B`, fixed protected header size `H` and `n` hop fields of size `h`, useful-byte efficiency before other framing is `B / (B + H + n·h)`. A source-stabilizing copy requires at least one additional read and one additional write of the copied bytes, so it adds `2B` of memory traffic under that simple accounting model. A raw 100 Gb/s stream corresponds arithmetically to 12.5 GB/s before overhead; 400 Gb/s corresponds to 50 GB/s. These are dimensional calculations, not ASKA measurements. Encryption, integrity, quarantine and copying can require several memory passes, and the actual controller, cache and engine behavior determines the measured cost.

**R-38-10 — End-to-end record qualification.** A transport profile MUST publish its finite capacities, failure behavior and measured or explicitly modeled costs under an exact configuration. It MUST include authorization, copying, cryptography, queueing and lifecycle overhead and MUST distinguish raw link rate from useful authorized delivery.

Acceptance specifications are:

- **T-38-01:** Fuzz lengths, duplicate fields, critical-field handling and object/endpoint encodings. No ambiguous record may reach protected publication or egress.
- **T-38-02:** Race sequence allocators, cancel encryption jobs and restore an old sender snapshot. No nonce or sequence may be reused contrary to the selected key profile; exhaustion must close or rekey.
- **T-38-03:** Configure deliberately small test ceilings and race multiple encryption and verification engines, including failed checks and a crash after reservation. No engine may start work that would cross a processed-block or verification-attempt ceiling, and restart must not refund uncertain use. Reaching the ceiling must stop or rekey cryptographic use without changing accepted replay state or spending the peer’s application authority.
- **T-38-04:** Exhaust unauthenticated traffic and fail authentication after decryption work. Application memory must contain no unaccepted plaintext, queues must remain bounded and victim authority must remain unchanged.
- **T-38-05:** Submit an authenticated policy-invalid high sequence followed by a valid lower one, plus unauthenticated high sequences and a gap beyond the forward horizon. The accepted window must remain unchanged by each rejection, and the valid lower record must remain admissible.
- **T-38-06:** Race two valid copies of one record with revocation and inject crashes at publication. At most one authorized publication may occur, with matching label, debit and replay evidence after recovery.
- **T-38-07:** Change the actual output port or sealed payload after approval and fail a transmission after its first byte. Unauthorized changes must emit nothing; an established partial emission must not be reported as an abort.
- **T-38-08:** Deliver an object out of order, then inject an overlap, an out-of-range chunk, inconsistent total commitment and an authenticated invalid high-sequence fragment. Partial bytes must remain inaccessible and accepted replay state must remain unchanged. Race final assembly with policy withdrawal, destination-generation replacement and a crash; publication must be all-or-nothing with matching labels, debit and member replay evidence. Under a separately admitted chunk-effect contract, any published prefix must instead retain its explicit partial-effect receipts.
- **T-38-09:** Cancel a batch while a delayed child reads source memory, then restart and retry after losing a receipt. Source reuse must wait for closure, and retries must preserve established or uncertain outcomes without blind duplication.
- **T-38-10:** Run the selected load and failure workload with all guards enabled. Report useful delivery, latency distribution, queue limits, memory traffic and rejected load; raw line rate alone cannot satisfy qualification.
