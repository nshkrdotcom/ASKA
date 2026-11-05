# ASKA v6 — Civic services, elections and public accountability

Civic systems must combine reliable service delivery, bounded institutional authority, individual rights and inspectable public decisions. ASKA supports eligibility checks, benefits, permits, taxation, public notices, infrastructure operations and election workflows through explicit contracts and consequence owners. Civic participation does not require a universal identity graph, and an institution's legitimate service role does not grant it general access to a person's private realm.

Public accountability and personal privacy are complementary requirements with different objects. Rules, decision criteria, procurement commitments and aggregate service outcomes can be made inspectable while individual applications, ballots, medical facts and protected third-party information remain restricted. A dashboard that exposes all raw records is not a prerequisite for accountable government. An opaque score that decides eligibility without a review path is not an adequate substitute for a qualified procedure.

## 50.1 Civic service contracts

A civic service contract identifies the service, qualified institution, eligibility predicates, accepted evidence, requested outcome, required contribution or payment, decision deadline, notice, appeal route, retention and data-sharing terms. It distinguishes proving an eligibility attribute from disclosing every record from which that attribute could be inferred. A source owner can supply a scoped qualification statement if the recipient accepts that issuer for the relevant predicate.

**R-50-01 — Bounded civic qualification.** Civic admission MUST use explicitly applicable eligibility rules and qualified evidence for the requested service. It MUST minimize unrelated identity linkage and MUST NOT treat a general reputation score, activity history or AI prediction as an unchallengeable source of eligibility authority.

AI may help explain forms, identify missing documents, flag inconsistent evidence or simulate policy outcomes. A consequential determination must still identify the governing rule and accountable decision maker. If a model assists triage, the profile should examine disparate error costs, feedback loops and access to correction. An anomalous submission may deserve review; it does not automatically justify exclusion from a service or removal of rights.

A service should expose a meaningful status: submitted, evidence incomplete, under qualified review, decision issued, payment pending, fulfilled or contested. Concrete actions use canonical effect states and scoped receipts. A locally committed application submission is not a guarantee of eligibility or final benefit payment.

## 50.2 Election purpose and threat model

Election systems require an election-specific profile. Eligibility, uniqueness of participation, ballot secrecy, accessibility, availability, integrity, auditability and resistance to coercion can pull in different directions. A cryptographic receipt that helps one voter prove how they voted may undermine secrecy or enable vote buying. A permanent artifact that joins a voter identifier to a vote choice is incompatible with a profile requiring that association to remain unavailable.

**R-50-02 — Eligibility and ballot separation.** A secrecy-preserving election profile MUST separate eligibility and participation controls from ballot-choice records. It MUST NOT create a voter-linkable identity-to-choice mapping through identifiers, receipts, microstructures, logs, timestamps or correlated metadata merely to simplify auditing.

The architecture may support qualified eligibility credentials, separate ballot authorization and independently administered election services. The specific protocol must explain how duplicate participation is prevented without making choices linkable, which parties could collude to break that separation, and how revocation, replacement ballots or disputed eligibility are handled. The architecture does not select one universal election protocol or claim remote voting is coercion-resistant by default.

The [U.S. Election Assistance Commission's VVSG 2.0](https://www.eac.gov/sites/default/files/TestingCertification/Voluntary_Voting_System_Guidelines_Version_2_0.pdf), including its software-independence and ballot-secrecy requirements, is a concrete technical comparison. It is not an ASKA certification, a rule for every jurisdiction or proof that any proposed physical voting artifact is suitable.

## 50.3 Distinct election evidence

A voter needs confidence that the intended selection was captured. The election needs evidence that cast ballots were recorded and the recorded set was tallied correctly. These are different claims, often described as cast as intended, recorded as cast and tallied as recorded. A protocol that supplies one does not automatically supply the others. Accessibility mechanisms, ballot design, trusted display, paper handling and cryptographic verification all have separate failure modes.

**R-50-03 — Separate verifiability claims.** An election realization MUST state how it supports intention capture, ballot recording and tally verification, which participants can verify each claim, and what evidence remains if software is defective. It MUST NOT collapse those claims into a single ledger-integrity assertion.

A tamper-evident log can retain incorrect input faithfully. A scanner can misinterpret a marked ballot while its software signs the result. A voter may be unable to inspect a machine-generated record without an accessible independent presentation. The profile must describe audit and recount evidence that remains meaningful under the stated compromised-component assumptions. An auditable paper record, an end-to-end verifiable protocol or a qualified combination needs its own detailed conformance argument.

Physical microstructures may be explored as custody, commitment or audit artifacts, but the research must preserve secrecy. An artifact issued to a voter must not reveal a transferable proof of their choice under a receipt-free profile. A publicly checkable inclusion proof must not accidentally include an identity binding or a linkable high-resolution timestamp. A physical artifact's resistance to cloning says nothing by itself about election correctness or freedom from coercion.

**R-50-04 — Coercion and receipt analysis.** Election receipts, proofs and physical artifacts MUST be assessed for transferable choice evidence, coercion, vote buying and metadata linkage under an explicit adversary model. A valid signature, difficult-to-copy artifact or public tally proof MUST NOT be claimed to establish coercion resistance.

## 50.4 Availability, inclusion and dispute handling

Election availability requires planning for failed devices, partitions, inaccessible authentication, disputed records and people unable to use the primary interface. Alternative procedures must preserve eligibility and duplicate controls without requiring every voter to possess one device, biometric or online account. A fallback should have its own chain of custody, reconciliation and audit rules; it must not silently degrade to unrecorded manual authority.

**R-50-05 — Inclusive continuity.** Civic and election services MUST define accessible and failure-tolerant procedures for unavailable credentials, equipment or connectivity, with bounded provisional treatment, reconciliation and qualified review. A failed digital path MUST NOT by itself be interpreted as ineligibility.

Dispute procedures should preserve evidence without exposing a secret ballot or unrelated personal records. A contested participation record and a contested tally have different evidence needs. Reviewers must be qualified for the matter and independent where the profile requires it. A recount must not become a pretext to reconstruct voter-choice associations. Correcting a public result requires an attributable decision and a new record, not silent replacement of the original announced result.

Clock and network assumptions are particularly important near deadlines. A device with an uncertain clock should report an interval and its time-source class. The profile must define which submission boundary determines timeliness and how qualified evidence resolves uncertainty. A user interface must not assure a voter that a ballot was accepted merely because the local device displayed success.

## 50.5 Public decisions, simulation and oversight

Civic policy simulation can help people examine tradeoffs, compare proposed rules and submit feedback. Such tools should expose assumptions, input limitations, model versions and uncertainty. Citizen feedback is evidence of views expressed through the admitted process, not necessarily a representative population estimate. A model must not automatically settle a contested policy conflict or convert inferred preferences into a binding vote.

**R-50-06 — Accountable public computation.** Public policy analysis and AI-supported decision tools MUST distinguish simulation, measurement, consultation and binding institutional decisions. Binding rules and consequential outputs MUST have qualified adoption, provenance, review and correction procedures independent of the model's confidence.

Independent oversight may examine service failure rates, procurement, access patterns or procedural compliance. Privacy-preserving aggregate statistics can support this work, but the query system must account for repeated releases and small populations. An agency cannot use the label “analytics” to bypass the source owners' release restrictions. Where individual inspection is necessary, it needs its own admitted basis and protected review channel.

**R-50-07 — Public accountability with protected records.** Civic systems MUST publish or disclose the decision and audit evidence required by their accountability profile while protecting individual records and secret ballots. Public reporting MUST identify material gaps, corrections and uncertainty rather than use privacy as a blanket justification for unreviewable institutional conduct.

## 50.6 Public emergency alerts and bounded local delivery

A public alert is a civic operation with its own issuer qualification and lifecycle. Its record binds an alert identity, issuing role, affected locality or audience, event class, precise content or content commitment, issue time, validity interval, revision, superseded or canceled alert references, admitted delivery channels and evidence quality. A citizen's emergency report can enter a bounded review workflow without being treated as an authenticated institutional broadcast. Unverified payloads remain low-integrity data and cannot acquire authoritative presentation or actuator privileges merely by using urgent language.

**R-50-08 — Qualified civic-alert lifecycle.** Civic alert owners MUST verify the issuer's authority for the alert's locality and event scope, enforce expiry and authenticated update or cancellation references, and prevent stale revisions from reviving a superseded alert. Unverified reports MUST remain explicitly unverified. A deployment claiming local emergency continuity MUST reserve the declared Polis admission, queue, processing and delivery resources against Wilder overload and test that claim under its stated surviving-resource assumptions.

An update can narrow the affected area or change instructions; a cancellation terminates the alert's current applicability but does not erase evidence that earlier versions were issued or delivered. Receivers validate the relationship between revisions and retain enough state to reject delayed superseded or expired copies. Clock uncertainty must follow the profile's declared validity rule. A display should distinguish an unverified report, an active qualified alert, a superseded message and a cancellation. Its delivery receipt identifies the local publication or channel submission actually established, not proof that every affected person saw or understood it.

Reserved local service is a concrete capacity claim. The profile names protected buffers, admission work, processing budget, power and the admitted local link, and measures the retained service under an open-network flood. If remote delivery shares a saturated radio, regional carrier or failed power facility, external delivery remains unavailable or uncertain even while the local alert service works. Neither the label Polis nor an emergency declaration creates a missing independent route. Alert updates, retries and cancellations remain within bounded service and disclosure budgets.

## 50.7 Operational examples and acceptance

For a benefit application, a person provides scoped eligibility evidence and a payment destination. The service records a local submission, performs qualified review and issues a reasoned decision. A model can explain missing evidence but cannot deny eligibility based on an undisclosed behavioral score. The person can challenge an incorrect binding without granting the reviewer access to unrelated private records. Payment instruction, bank acceptance and settlement remain separate outcomes.

For an election, an eligibility service verifies participation rights without receiving ballot choices. Ballot casting, recording, tallying and audit are separately controlled according to the election protocol. Logs minimize correlation, and any physical audit artifact is evaluated for identity linkage and transferable choice evidence. A failed voting device invokes an admitted accessible continuity procedure. An independent audit checks the declared evidence; it does not infer correctness from the mere presence of signatures or a blockchain-style history.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-50-01 | Submit an application with qualifying evidence but a low AI reputation score; the model cannot independently remove eligibility or bypass qualified review. |
| T-50-02 | Attempt to join enrollment logs, ballot records and artifact identifiers; the profile's stated secrecy assumptions survive or the realization fails qualification. |
| T-50-03 | Corrupt one of intention capture, recording or tallying while leaving the others intact; the corresponding independent evidence detects the defined failure. |
| T-50-04 | Give a coercer voter receipts and physical artifacts; evaluate whether they can establish choice under the claimed receipt-resistance model. |
| T-50-05 | Remove network access or the primary authenticator; the admitted fallback preserves participation review and duplicate controls without falsely declaring ineligibility. |
| T-50-06 | Change a simulation assumption or model output; no binding rule changes until the qualified adoption procedure completes. |
| T-50-07 | Request public audit evidence; the system supplies the required decision and integrity records without exposing protected identities or ballot choices. |
| T-50-08 | Deliver an unverified report, wrong-locality alert, expired revision, authenticated update and cancellation, then replay the old version during a Wilder flood. Receivers must preserve verification status and revision/expiry rules; the valid local alert must meet the declared reserved-service bound when its stated resources survive, while an unavailable shared uplink is reported separately. |

These oracles define work required for qualification. No election security, accessibility or legal compliance result is established merely by adopting the general ASKA architecture.
