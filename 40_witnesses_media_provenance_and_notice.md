# ASKA v6 — Witnessing, notice and media provenance

Steles provides scoped evidence that specified events or commitments were recorded. It does not observe all machine behavior, determine whether every asserted fact is true, or replace independent security watchers. A witness can preserve a source owner's signed receipt, expose equivocation relative to known checkpoints and support later review. Its evidence is only as strong as the event source, custody, clock, signature and publication assumptions that the selected profile declares.

Witnessing serves several distinct purposes: retaining evidence of a person's approval, proving that a machine installed a grant, recording local effect finality, preserving a legal-process step, documenting a notice attempt, or committing to a software artifact. These events must not be collapsed into an undifferentiated “transaction succeeded” entry. The receipt schema is owned by [Claim, contract, grant and receipt schemas](28_authority_schemas_and_pact_protocol.md).

## Evidence classes and event identity

A witness envelope includes witness identity and epoch, event class, source receipt digest, relevant owner and object references, sequence, previous commitment, policy profile, time interval and time-source class, retention class and signature. Payloads can be encrypted or separately retained. An event's protected context must remain accessible only to qualified recipients; public verification of a commitment need not reveal its contents.

**R-40-01 — Scoped witnessed statements.** Every Steles record MUST identify what is witnessed, who asserted it, the relevant finality point or procedural event, and the limits of witness observation. Witnessing a request, approval or submission MUST NOT be reported as evidence that a grant was installed, a receiver displayed data or an external outcome occurred.

An owner can issue a receipt stating that it accepted a sealed output at its ingress boundary. A witness can record that receipt. Neither event proves that a human read the content. Similarly, a signed notice submission is evidence of submission under its delivery contract; it may not establish recipient receipt, comprehension or legally sufficient service. The interpretation remains profile-specific.

## Append-only evidence and equivocation

Records can be hash-linked or organized in an authenticated structure. A checkpoint identifies a committed history extent, sequence and epoch. Independent recipients can retain and compare checkpoints to detect conflicting histories. A chain proves only a relation among the records and checkpoints actually available to the verifier. An isolated witness can present one internally consistent fork to one reader and another to someone else unless the deployment's comparison and publication mechanisms expose the discrepancy.

**R-40-02 — Verifiable continuity with declared limits.** A witness MUST support verification of history continuity relative to retained checkpoints and MUST distinguish missing evidence, a known gap, a conflicting branch and verified continuity. It MUST NOT claim complete non-equivocation or absence of events merely because its current local chain validates.

[RFC 9162](https://www.rfc-editor.org/rfc/rfc9162) provides a useful comparison through append-only transparency logs and consistency evidence. Its certificate-transparency setting does not establish the truth of arbitrary ASKA events or guarantee availability. ASKA must separately specify checkpoint distribution, reader independence and response to detected forks.

A record sequence must not be reset under an old identity after reboot. If storage loss requires a new epoch, the transition explicitly records the last retained checkpoint, lost range or unknown interval, recovery authority and new key binding. A witness cannot repair an unknown history by inventing empty records. Cryptographic verification of a new epoch is distinct from proving continuity across the lost interval.

## Privacy and selective evidence disclosure

Receipts can contain sensitive facts even without payloads: a relationship, a clinic visit, a disputed order, an employment event, a purchase or a pattern of activity. Hashing a small predictable message may allow an attacker to guess it. Publishing a global sequence of user events can create correlation independent of content encryption. Witness profiles therefore need disclosure tiers and metadata minimization.

**R-40-03 — Witness privacy.** Receipt contents, event classes, identifiers, timing and linkage MUST retain their applicable confidentiality and release restrictions. Commitments over guessable data MUST use a profile-defined hiding or selective-disclosure method where required; a bare digest MUST NOT be claimed to hide low-entropy facts.

A public checkpoint may commit to a batch while detailed records remain encrypted for the subject and qualified reviewers. A reviewer may receive a proof of inclusion or an event-specific receipt without access to every neighboring event. Retention and deletion policies must distinguish the public commitment, private payload and identifying linkage. Keeping an irreversible public commitment may be incompatible with later promises to erase all evidence of an event; that tradeoff must be admitted in advance.

Witness access does not grant investigative powers. A party entitled to verify a payment receipt may not inspect the payer's full transaction history. A security analyst entitled to detect gaps may not receive raw user interactions. Additional disclosure requires a separately applicable basis and source release decision.

## Notice as a tracked obligation

A notice obligation identifies its subject, triggering event, permitted content, recipient-resolution method, delivery channels, deadline, delay or sealing conditions, retry policy, acknowledgment requirement and accountable owner. The obligation can remain outstanding after the initiating contract closes. It must survive process failure and ownership transfer according to its durability contract.

Notice status uses descriptive events such as required, prepared, submitted, acknowledged, deferred, sealed, failed or overdue. These are notice classifications, not replacements for the canonical effect states. Each concrete submission or acknowledgment has its own scoped effect and receipt. A deadline depends on the declared clock and uncertainty interval; the system must not claim precise timeliness from an unqualified or rolled-back clock.

**R-40-04 — Durable notice accountability.** Required notice MUST be represented as a persistent obligation with an owner, deadline, delivery contract and explicit failure or delay status. Submission, receipt acknowledgment and satisfaction of a profile's notice condition MUST remain distinguishable.

A lawful delay or sealed process may restrict immediate disclosure. Its qualifying authority, scope, duration and review or expiry conditions must be explicit. The system should queue the eventual notice and expose overdue status to authorized oversight. It must not transform a temporary sealing condition into indefinite silence through a lost timer or vanished task.

**R-40-05 — Bounded deferred notice.** Deferral or sealing MUST have an admitted basis, scope, expiry or review condition and accountable owner. Removal of that condition MUST trigger the required delivery workflow, while unrelated protected information remains restricted.

## Failure behavior and witness independence

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

**R-40-06 — Failures remain visible.** A witness implementation MUST expose queue loss, storage exhaustion, sequence gaps, key transitions, forks and timing uncertainty under the declared privacy policy. A required witness failure MUST cause the specified admission or continuity response rather than an unmarked reduction in assurance.

Steles and WM-L or WM-M have different roles. A witness may hold commitments from observers, but it is not a substitute for independent observation of the protected interface. Independence requires distinct control and failure assumptions, not merely a second software process or a different service name.

## Operational example and acceptance

A professional custodian releases a narrowly admitted extract. The source owner records the exact output digest and release basis. The receiver records its acceptance. Steles separately witnesses both receipts without treating them as one universal success. A notice obligation is created for the affected person, but delivery is deferred under a qualified time-limited sealing condition. When the condition expires, a notice service resolves the permitted recipient channel, submits the notice and tracks acknowledgment. If the recipient is offline, the record says submitted or pending under the delivery contract, not “person informed.”

**R-40-07 — Independent witness admission.** The choice, replacement and authority of a witness MUST be admitted independently of the party whose behavior it is intended to evidence wherever the profile claims such independence. A participant MUST NOT satisfy an independent-witness requirement by appointing an equivalent root under its own control without disclosure and renewed admission.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-40-01 | Witness a request before installation; queries cannot present it as an installed grant or completed external effect. |
| T-40-02 | Present two valid but inconsistent checkpoint histories; the verifier reports equivocation relative to the retained evidence. |
| T-40-03 | Attempt dictionary recovery of a predictable protected receipt from public material; the admitted hiding mechanism prevents the claimed disclosure within its threat model. |
| T-40-04 | Lose a notice worker after submission; recovery preserves the obligation and distinguishes acknowledgment from submission. |
| T-40-05 | Let a sealing condition expire while its original task is absent; the accountable notice workflow resumes or reports an explicit failure. |
| T-40-06 | Exhaust witness storage and roll back a counter; the deployment reports loss or blocks as specified, without declaring a complete clean history. |
| T-40-07 | Replace an independent witness with a service controlled by the event source; the old independence claim is rejected or explicitly downgraded. |

## None

Media evidence combines several claims that must be assessed separately: who controlled a capture device, what bytes it produced, which transformations followed, how the artifact was held, and whether the depicted event corresponds to the physical world. Cryptographic provenance can authenticate signed statements and bind them to an artifact. It cannot, by itself, establish that a camera faced the claimed scene, that a sensor was calibrated, that a person consented to recording, or that an institution's interpretation is correct.

ASKA supports ordinary signed media, derived-artifact provenance, sensor-rich capture and experimental physical evidence media. These are distinct profiles with different costs and assumptions. None is a universal prerequisite for communication. A deployment may accept conventional photographs or documents while labeling their provenance limits. A research mechanism must not be marketed as irrefutable evidence merely because its internal algorithm is proprietary or difficult to inspect.

### Capture and transformation records

A capture record identifies the artifact digest, media type, capture device and key epoch, sensor configuration, firmware or processing version, time interval and time-source quality, calibration references, environmental claims, processing steps, relevant consent or other authority references, and custody events. Each field distinguishes directly measured values, externally asserted facts and derived estimates. Optional location and identity metadata require particular care because they can expose bystanders or sensitive relationships.

**R-40-08 — Typed provenance claims.** A media record MUST distinguish artifact integrity, signer identity, capture assertions, calibration, transformations, custody and claims about the depicted world. Verification MUST report which claims were checked and MUST NOT promote a valid signature into a general truth judgment.

A transformation record identifies the parent artifact, transformation identity and version, parameters, responsible owner, source authorization, resulting digest and residual disclosures. Cropping, color correction, format conversion, compression, blurring, synthetic augmentation and summarization can preserve different aspects of an original. The provenance graph must say what changed rather than use a single “authentic” flag.

The [C2PA Technical Specification 2.3](https://spec.c2pa.org/specifications/specifications/2.3/specs/C2PA_Specification.html) provides mechanisms for signed provenance assertions and asset bindings. Its scope and validation model do not make a value judgment about every asserted fact. An ASKA adapter can preserve such records while applying its own source-release, receiver-acceptance and disclosure policies.

### Capture authority and privacy-preserving derivatives

Capture is itself an observation operation. Ownership of a camera does not settle whether it may record every person, room, conversation or screen visible to it. A profile must define the applicable basis, scope, retention and export rules. Voluntary opt-in can be required for a particular service or feature, while another context may use a separately applicable basis. The machine must identify the actual basis instead of claiming consent that was never obtained.

**R-40-09 — Authorized capture and transformation.** Recording, privacy transformation and publication MUST have separately applicable authority where their scopes differ. A privacy feature presented as voluntary MUST require the relevant opt-in, and the resulting artifact MUST retain provenance linking the authorized transformation to the protected source without unnecessarily exposing that source.

Privacy blurring should be treated as a controlled derivation, not proof of anonymity. Face obscuration can leave voice, gait, clothing, tattoos, location, timing, social context and other linkage signals. A transformation may preserve a journalist's evidentiary purpose while reducing one identifying channel, but its residual leakage must be stated and tested against the intended audience. A reversible privacy transform must identify who can recover the concealed material and under what key custody; an irreversible transform must state which information it actually destroys. The original remains protected under its own policy; a link to it must not become a public retrieval capability.

A reviewer might receive an encrypted original under a specific matter while the public receives only a redacted derivative and a proof that a qualified transformer produced it. The two recipients do not share authority. The public artifact's provenance should not expose the subject's hidden identity or the original's private storage locator. If the transformation is later challenged, review follows an admitted process rather than automatic public unmasking.

### Verification, storage and fallback

Verification returns a structured result: matched or unmatched artifact binding, validated or unvalidated signatures, capture and calibration evidence, transformation chain, custody gaps, known compromises and explicit uncertainty. A mismatch need not mean fraud; it can result from legitimate transformation, damaged media or unavailable evidence. A valid chain need not mean the subject consented or the content is accurate. The receiving institution determines what evidentiary weight its qualified procedure assigns.

**R-40-10 — Qualified verification results.** Verifiers MUST preserve negative, incomplete and uncertain outcomes and identify the evidence supporting each conclusion. They MUST NOT replace missing calibration, custody or capture evidence with an unqualified authenticity score.

Encrypted storage and the persistent object service can protect artifact bytes and access histories under their respective assumptions. Binding a media record to encrypted storage custody or risk-rating service evidence does not strengthen the underlying physical claim beyond the evidence actually provided. A trust service can report a device's status, but cannot prove that a particular scene was unstaged. A storage owner can attest that bytes were preserved, but cannot prove the camera originally captured them honestly.

Fallback to conventional cryptographic provenance must be explicit. If a specialized sensor or physical verifier is unavailable, a contract can permit a weaker evidence class, or the receiver can reject the artifact. It must not report a conventional signature as successful completion of a physical challenge that never occurred.

**R-40-11 — Explicit evidence downgrade.** Storage, transport and verification adapters MUST retain the provenance class and unresolved limitations. Fallback from physical or sensor-rich evidence to conventional signatures MUST require an admitted compatible policy or a newly accepted weaker contract.

### Cryptographic privacy and operational example

A zero-knowledge proof may demonstrate that an admitted verification computation accepted a committed record. It does not prove the honesty of the original sensor or eliminate leakage through public inputs. Multiparty computation may distribute a verification task under a defined collusion model. Differential privacy may protect aggregate analytics about a collection; it is not a replacement for protecting an individual original. Trusted execution can restrict some software attackers while retaining hardware and side-channel assumptions. Each mechanism must be evaluated for its actual role.

**R-40-12 — Evidence privacy composition.** Privacy mechanisms used with media MUST state what information they hide, from whom, under which composition and trust assumptions, and what remains public. Proof validity MUST NOT be treated as authority to disclose the underlying artifact or as proof that its physical premises were true.

Consider a field scientist documenting an instrument reading. The capture device signs an image and calibrated sensor record with a time interval. A reviewer checks device status, calibration and custody. A privacy transformer removes bystanders' identifying regions under an admitted rule and produces a derivative with a linked transformation record. The public receives the derivative and selected provenance; qualified reviewers retain a path to inspect the original. If a proposed microstructure is issued, its enrollment binds the specific receipt, and later verification reports its measured match and tolerance. No stage claims that the signature alone proves the scientific conclusion.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-40-08 | Verify a signed staged or synthetic scene; the result confirms only supported provenance claims and does not certify world truth. |
| T-40-09 | Produce a blurred derivative; source retrieval remains restricted and tests evaluate remaining voice, gait, context and linkage disclosures. |
| T-40-10 | Remove calibration or custody evidence while keeping a valid signature; verification remains explicitly incomplete. |
| T-40-11 | Disable the specialized verifier; conventional fallback cannot inherit the unavailable physical-evidence assurance label. |
| T-40-12 | Present a valid proof of a verification computation; the prover still cannot export the protected original without release authority. |
