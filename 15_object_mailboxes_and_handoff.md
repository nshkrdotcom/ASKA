# ASKA v6 — Object mailboxes and handoff

## Messages transfer objects under contracts

A mailbox is a bounded guarded interface between owners. It carries a record referring to an exact object version or carrying bounded bytes, together with the authority and lifecycle context needed by the receiving owner. It is not a shared writable heap. A mailbox guard (BG) enforces source binding, destination acceptance, capacity and publication rules even when both communicating workloads are compromised.

A mailbox descriptor identifies source and destination endpoints, mailbox identity and epoch, permitted record types, object-class constraints, labels, maximum payload and batch size, queue capacity, applicable grants, replay policy and finality points. Fields use the canonical encoding rules in [object schemas](32_claim_contract_grant_receipt_schemas.md). Unknown critical fields, duplicate encodings and ambiguous lengths are rejected before a payload is interpreted as an authorized object.

**R-15-01 — Bounded mailbox contract.** Every mailbox MUST have an installed descriptor binding its endpoints, epochs, object classes, authority limits and finite capacity. A mailbox record MUST NOT derive authority from an untrusted pointer, route identifier or caller-supplied owner name alone.

The interface distinguishes submission, protected receive publication and application use. A sender’s successful enqueue establishes only the named local enqueue event. Receiver publication establishes the receiver’s acceptance of a protected object. Neither establishes that an application understood the object, durably stored it or completed a physical task. These distinctions remain visible in receipts rather than being hidden behind one “success” bit.

Segmented delivery of one application object follows the authenticated identity, length, offset, commitment and bounded assembly contract in [Packet records, delivery and egress](45_packet_records_delivery_and_egress.md). Mailbox receipt of individual fragments does not establish atomic publication of that object.

## Copy, immutable loan and exclusive handoff

Copy creates a new object at the destination while the source retains its own version. The BG obtains a stable source binding through the MG, reserves destination capacity and copies the permitted bytes into quarantine. It cannot publish a partially copied object. If labels or permissions change before publication, the final check may reject the result even though the copy consumed resources.

An immutable loan permits the destination to read a specific version while the source or its owner retains the underlying allocation. All writers must be excluded for the loan lifetime. Reference counting alone is not evidence of immutability when a device or alternate mapping can still write. Loan expiration prevents future access; reclamation still waits for the necessary reader and transaction closure.

Exclusive handoff closes the old owner’s access and installs a new ownership generation after drain and sanitization obligations are satisfied. It must state whether bytes are preserved for the recipient or erased before reuse. A resource transfer and an information release are separate decisions: transferring a cleared bank does not disclose its former contents, while transferring a populated object requires authorization for those contents.

**R-15-02 — Explicit handoff semantics.** Each mailbox transfer MUST declare copy, immutable loan or exclusive handoff. The implementation MUST enforce the corresponding writer, lifetime and ownership rules, and MUST NOT substitute one mode for another without equivalent admitted authority and lifecycle behavior.

[OctopOS](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf) provides a concrete bounded-mailbox comparison with delegated exclusive access. ASKA uses its own effect and revocation contract, including the distinction between a protected local publication and a remote effect. [Elasticlave](https://www.usenix.org/system/files/sec22-yu-jason.pdf) likewise makes clear why transferring exclusive access need not transfer ownership. Neither comparison removes ASKA’s obligation to close device and cache paths during physical reassignment.

Object graphs need an explicit transfer discipline as well as ownership of their root. A candidate interface can require an acyclic tree with exclusive ownership, or encode a bounded graph with validated object identifiers, cycle handling and a defined cleanup algorithm. Linear ownership means that an ownership right cannot be duplicated; it does not by itself prove that a data structure is acyclic. The receiving contract limits nodes, edges, nesting, serialized extents and cleanup work, and rejects hidden raw pointers or aliases outside the admitted graph. Crash recovery must reclaim the complete transferred allocation without freeing a still-owned object or following attacker-selected addresses. These checks refine the bounded mailbox and handoff obligations even when both endpoints use memory-safe languages.

## Stable source and protected quarantine

Before reading mutable source memory, the BG binds owner, object generation, mapping and class. It stops relevant writers or obtains an immutable version, drains pending writes and holds the binding until copying finishes. Any temporary permission restoration occurs while the binding remains held. A payload digest can identify the copied bytes, but hashing an unstable source does not by itself guarantee that authorization and copied contents refer to the same object.

Quarantine is inaccessible to the destination application until validation and acceptance complete. The receive guard checks record integrity, destination identity, grant freshness, labels, capacity, sequence state and the exact publication policy. Decryption does not publish plaintext. A failed record is destroyed or retained only under an explicit diagnostic policy; it cannot remain in an application-readable “error buffer.”

**R-15-03 — Atomic protected publication.** A receive operation MUST keep unaccepted contents in protected quarantine and MUST publish only a complete, validated object. Object publication, accepted replay-state change, applicable quota debit and installed label MUST form one local atomic decision or an equivalent recoverable transaction.

An authenticated record that fails policy may enter a separate bounded negative-result or deduplication cache. It must not advance the accepted replay window or suppress valid lower sequence numbers. Unauthenticated traffic cannot alter accepted replay state. This is the same rule used for external records in [packet delivery](45_packet_records_delivery_and_egress.md), so an internal fast path cannot introduce a different replay meaning.

## Credits, batching and cancellation

Credits reserve a precise local resource: descriptor slots, quarantine bytes or receive-publication capacity. Their meaning is declared. Returning a descriptor credit does not prove that the recipient has released every referenced object. A malicious sender cannot increase capacity by replaying a credit return, and a malicious receiver cannot pin unbounded sender memory through a small retained handle.

Batches amortize validation and cryptographic setup but increase retained state and cancellation complexity. A batch descriptor binds its permitted child records, total byte ceiling, child count, source versions, sequence allocation and expiration. Every child remains subject to its final publication check. A rejected child does not retroactively authorize a different payload in the same slot.

**R-15-04 — Accounted batching and backpressure.** Mailbox credits and batches MUST have bounded, replay-safe accounting for bytes, descriptors and pinned objects. Cancellation MUST stop all remaining child operations before releasing shared source bindings or retained ciphertext state. Previously consumed sequence or nonce material MUST NOT be reused because a batch was canceled.

A candidate laboratory capacity profile may test 1 KiB small records, fixed descriptor arrays and a bounded bulk-batch path. Those values are test parameters, not universal architectural limits. Production widths and capacities must follow a selected workload and exhaustion analysis. The system must remain safe at the smallest and largest supported sizes, including zero-length payloads where permitted, maximum-length encodings and arithmetic overflow cases.

Cancellation distinguishes work not admitted, quarantined work, published work and unresolved outcome. A sender cannot erase a receiver’s already published object by locally freeing its descriptor. It may revoke future access where the receiving contract permits revocation, but completed disclosure remains a historical effect. A timeout is not evidence of either publication or nonpublication.

## Epochs, crashes and queue reuse

Queues bind cell, grant, mailbox and owner epochs. A new cell cannot inherit an old queue simply because the same physical ring buffer is reused. A queue reset closes producer and consumer access, drains or fences outstanding operations, clears retained plaintext and metadata, and installs fresh bindings. If a controller loses volatile replay state, it must either recover that state safely or establish fresh session keys and epochs that make old records unusable.

**R-15-05 — Fresh queue lifetime.** Queue reuse, controller restart and endpoint replacement MUST prevent old records, credits and references from becoming current authority. Recovery MUST preserve established publication outcomes and represent unresolved outcomes explicitly rather than manufacture an empty queue history.

A narrow lock discipline keeps lifecycle coordination tractable. The source binding is acquired before bounded copy-engine state; destination capacity is reserved without an unbounded wait while holding a global ownership lock. Publication may use a protected local journal or equivalent atomic hardware transition. The exact mechanism belongs to the implementation evidence, but the observable result must be one authorized object publication or no publication, with uncertainty preserved if the boundary cannot establish which occurred.

## Operational example and acceptance obligations

A Sanctum object owner releases a redacted document to an Agora analysis cell. The owner creates an immutable redacted version and installs an exact recipient and purpose grant. The BG copies that version into a quarantine object. Meanwhile, the analysis cell is replaced. Its new cell epoch does not match the destination binding, so the receive guard rejects publication and records the reason. The original confidential document never becomes a candidate payload, and neither the sender’s copy completion nor the old cell’s queue credit authorizes the replacement cell.

**R-15-06 — Scoped mailbox evidence.** Mailbox receipts MUST identify the exact source and destination binding, object generation, transfer mode and named finality point. They MUST distinguish copy completion, protected publication, application acceptance and unresolved outcome where those are separate events.

Acceptance specifications are:

- **T-15-01:** Submit forged owner fields, oversized batches and unknown critical record fields. Admission must reject them before object interpretation or capacity overcommit.
- **T-15-02:** Attempt a write through every known source alias during an immutable loan, and retain old access after exclusive handoff. No prohibited access may succeed under the declared scope.
- **T-15-03:** Race policy revocation and a policy-invalid high sequence with a valid lower sequence. No rejected record may publish or shift the accepted window; the valid lower record must remain admissible if its grant is current.
- **T-15-04:** Cancel a batch while one child and one retained ciphertext buffer are active. Source bindings must remain pinned until all operations stop, and no sequence or nonce may be reused.
- **T-15-05:** Reboot the BG and reuse its physical ring for a new cell. Replayed old records and credits must fail. A receipt for already established publication must remain `COMMITTED` at that finality point; only an attempt whose publication finality was never established may remain `UNCERTAIN` pending evidence and reconciliation.
- **T-15-06:** Interrupt each transfer between local copy completion and destination publication. The receipts must identify the established boundary and must never equate sender completion with recipient application success.
