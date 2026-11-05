# ASKA v6 — Steles, witness receipts and notice

Steles provides scoped evidence that specified events or commitments were recorded. It does not observe all machine behavior, determine whether every asserted fact is true, or replace independent security watchers. A witness can preserve a source owner's signed receipt, expose equivocation relative to known checkpoints and support later review. Its evidence is only as strong as the event source, custody, clock, signature and publication assumptions that the selected profile declares.

Witnessing serves several distinct purposes: retaining evidence of a person's approval, proving that a machine installed a grant, recording local effect finality, preserving a legal-process step, documenting a notice attempt, or committing to a software artifact. These events must not be collapsed into an undifferentiated “transaction succeeded” entry. The receipt schema is owned by [Claim, contract, grant and receipt schemas](32_claim_contract_grant_receipt_schemas.md).

## 47.1 Evidence classes and event identity

A witness envelope includes witness identity and epoch, event class, source receipt digest, relevant owner and object references, sequence, previous commitment, policy profile, time interval and time-source class, retention class and signature. Payloads can be encrypted or separately retained. An event's protected context must remain accessible only to qualified recipients; public verification of a commitment need not reveal its contents.

**R-47-01 — Scoped witnessed statements.** Every Steles record MUST identify what is witnessed, who asserted it, the relevant finality point or procedural event, and the limits of witness observation. Witnessing a request, approval or submission MUST NOT be reported as evidence that a grant was installed, a receiver displayed data or an external outcome occurred.

An owner can issue a receipt stating that it accepted a sealed output at its ingress boundary. A witness can record that receipt. Neither event proves that a human read the content. Similarly, a signed notice submission is evidence of submission under its delivery contract; it may not establish recipient receipt, comprehension or legally sufficient service. The interpretation remains profile-specific.

## 47.2 Append-only evidence and equivocation

Records can be hash-linked or organized in an authenticated structure. A checkpoint identifies a committed history extent, sequence and epoch. Independent recipients can retain and compare checkpoints to detect conflicting histories. A chain proves only a relation among the records and checkpoints actually available to the verifier. An isolated witness can present one internally consistent fork to one reader and another to someone else unless the deployment's comparison and publication mechanisms expose the discrepancy.

**R-47-02 — Verifiable continuity with declared limits.** A witness MUST support verification of history continuity relative to retained checkpoints and MUST distinguish missing evidence, a known gap, a conflicting branch and verified continuity. It MUST NOT claim complete non-equivocation or absence of events merely because its current local chain validates.

[RFC 9162](https://www.rfc-editor.org/rfc/rfc9162) provides a useful comparison through append-only transparency logs and consistency evidence. Its certificate-transparency setting does not establish the truth of arbitrary ASKA events or guarantee availability. ASKA must separately specify checkpoint distribution, reader independence and response to detected forks.

A record sequence must not be reset under an old identity after reboot. If storage loss requires a new epoch, the transition explicitly records the last retained checkpoint, lost range or unknown interval, recovery authority and new key binding. A witness cannot repair an unknown history by inventing empty records. Cryptographic verification of a new epoch is distinct from proving continuity across the lost interval.

## 47.3 Privacy and selective evidence disclosure

Receipts can contain sensitive facts even without payloads: a relationship, a clinic visit, a disputed order, an employment event, a purchase or a pattern of activity. Hashing a small predictable message may allow an attacker to guess it. Publishing a global sequence of user events can create correlation independent of content encryption. Witness profiles therefore need disclosure tiers and metadata minimization.

**R-47-03 — Witness privacy.** Receipt contents, event classes, identifiers, timing and linkage MUST retain their applicable confidentiality and release restrictions. Commitments over guessable data MUST use a profile-defined hiding or selective-disclosure method where required; a bare digest MUST NOT be claimed to hide low-entropy facts.

A public checkpoint may commit to a batch while detailed records remain encrypted for the subject and qualified reviewers. A reviewer may receive a proof of inclusion or an event-specific receipt without access to every neighboring event. Retention and deletion policies must distinguish the public commitment, private payload and identifying linkage. Keeping an irreversible public commitment may be incompatible with later promises to erase all evidence of an event; that tradeoff must be admitted in advance.

Witness access does not grant investigative powers. A party entitled to verify a payment receipt may not inspect the payer's full transaction history. A security analyst entitled to detect gaps may not receive raw user interactions. Additional disclosure requires a separately applicable basis and source release decision.

## 47.4 Notice as a tracked obligation

A notice obligation identifies its subject, triggering event, permitted content, recipient-resolution method, delivery channels, deadline, delay or sealing conditions, retry policy, acknowledgment requirement and accountable owner. The obligation can remain outstanding after the initiating contract closes. It must survive process failure and ownership transfer according to its durability contract.

Notice status uses descriptive events such as required, prepared, submitted, acknowledged, deferred, sealed, failed or overdue. These are notice classifications, not replacements for the canonical effect states. Each concrete submission or acknowledgment has its own scoped effect and receipt. A deadline depends on the declared clock and uncertainty interval; the system must not claim precise timeliness from an unqualified or rolled-back clock.

**R-47-04 — Durable notice accountability.** Required notice MUST be represented as a persistent obligation with an owner, deadline, delivery contract and explicit failure or delay status. Submission, receipt acknowledgment and satisfaction of a profile's notice condition MUST remain distinguishable.

A lawful delay or sealed process may restrict immediate disclosure. Its qualifying authority, scope, duration and review or expiry conditions must be explicit. The system should queue the eventual notice and expose overdue status to authorized oversight. It must not transform a temporary sealing condition into indefinite silence through a lost timer or vanished task.

**R-47-05 — Bounded deferred notice.** Deferral or sealing MUST have an admitted basis, scope, expiry or review condition and accountable owner. Removal of that condition MUST trigger the required delivery workflow, while unrelated protected information remains restricted.

## 47.5 Failure behavior and witness independence

Witness failure affects different operations differently. A low-impact local action may proceed with a bounded local receipt queue if the admitted profile allows it. A consequence whose admission requires a durable independent witness may have to pause when that witness is unavailable. The choice must be explicit before the failure, including queue bounds, loss behavior and availability costs.

| Failure | Required interpretation and response |
|---|---|
| Witness partition | Remote witnessing unavailable; bounded local evidence only if admitted |
| Storage exhaustion | Declared block, shedding or emergency retention behavior; no silent loss claim |
| Source key compromise | Event authenticity after the relevant compromise boundary is uncertain; historical validity evaluated separately |
| Witness key compromise | Quarantine or rotate under qualified recovery; preserve the compromised epoch's evidence status |
| Sequence gap or rollback | Report missing range or continuity failure; do not interpret it as inactivity |
| Conflicting checkpoints | Preserve both branches and invoke the admitted review or containment path |
| Uncertain clock | Record an interval and time-source quality; do not invent ordering beyond supported evidence |

**R-47-06 — Failures remain visible.** A witness implementation MUST expose queue loss, storage exhaustion, sequence gaps, key transitions, forks and timing uncertainty under the declared privacy policy. A required witness failure MUST cause the specified admission or continuity response rather than an unmarked reduction in assurance.

Steles and WM-L or WM-M have different roles. A witness may hold commitments from observers, but it is not a substitute for independent observation of the protected interface. Independence requires distinct control and failure assumptions, not merely a second software process or a different service name.

## 47.6 Operational example and acceptance

A professional custodian releases a narrowly admitted extract. The source owner records the exact output digest and release basis. The receiver records its acceptance. Steles separately witnesses both receipts without treating them as one universal success. A notice obligation is created for the affected person, but delivery is deferred under a qualified time-limited sealing condition. When the condition expires, a notice service resolves the permitted recipient channel, submits the notice and tracks acknowledgment. If the recipient is offline, the record says submitted or pending under the delivery contract, not “person informed.”

**R-47-07 — Independent witness admission.** The choice, replacement and authority of a witness MUST be admitted independently of the party whose behavior it is intended to evidence wherever the profile claims such independence. A participant MUST NOT satisfy an independent-witness requirement by appointing an equivalent root under its own control without disclosure and renewed admission.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-47-01 | Witness a request before installation; queries cannot present it as an installed grant or completed external effect. |
| T-47-02 | Present two valid but inconsistent checkpoint histories; the verifier reports equivocation relative to the retained evidence. |
| T-47-03 | Attempt dictionary recovery of a predictable protected receipt from public material; the admitted hiding mechanism prevents the claimed disclosure within its threat model. |
| T-47-04 | Lose a notice worker after submission; recovery preserves the obligation and distinguishes acknowledgment from submission. |
| T-47-05 | Let a sealing condition expire while its original task is absent; the accountable notice workflow resumes or reports an explicit failure. |
| T-47-06 | Exhaust witness storage and roll back a counter; the deployment reports loss or blocks as specified, without declaring a complete clean history. |
| T-47-07 | Replace an independent witness with a service controlled by the event source; the old independence claim is rejected or explicitly downgraded. |
