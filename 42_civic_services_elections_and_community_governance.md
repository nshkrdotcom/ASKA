# ASKA v6 — Civic services, elections and community governance

Civic systems must combine reliable service delivery, bounded institutional authority, individual rights and inspectable public decisions. ASKA supports eligibility checks, benefits, permits, taxation, public notices, infrastructure operations and election workflows through explicit contracts and consequence owners. Civic participation does not require a universal identity graph, and an institution's legitimate service role does not grant it general access to a person's private realm.

Public accountability and personal privacy are complementary requirements with different objects. Rules, decision criteria, procurement commitments and aggregate service outcomes can be made inspectable while individual applications, ballots, medical facts and protected third-party information remain restricted. A dashboard that exposes all raw records is not a prerequisite for accountable government. An opaque score that decides eligibility without a review path is not an adequate substitute for a qualified procedure.

## Civic service contracts

A civic service contract identifies the service, qualified institution, eligibility predicates, accepted evidence, requested outcome, required contribution or payment, decision deadline, notice, appeal route, retention and data-sharing terms. It distinguishes proving an eligibility attribute from disclosing every record from which that attribute could be inferred. A source owner can supply a scoped qualification statement if the recipient accepts that issuer for the relevant predicate.

**R-42-01 — Bounded civic qualification.** Civic admission MUST use explicitly applicable eligibility rules and qualified evidence for the requested service. It MUST minimize unrelated identity linkage and MUST NOT treat a general reputation score, activity history or AI prediction as an unchallengeable source of eligibility authority.

AI may help explain forms, identify missing documents, flag inconsistent evidence or simulate policy outcomes. A consequential determination must still identify the governing rule and accountable decision maker. If a model assists triage, the profile should examine disparate error costs, feedback loops and access to correction. An anomalous submission may deserve review; it does not automatically justify exclusion from a service or removal of rights.

A service should expose a meaningful status: submitted, evidence incomplete, under qualified review, decision issued, payment pending, fulfilled or contested. Concrete actions use canonical effect states and scoped receipts. A locally committed application submission is not a guarantee of eligibility or final benefit payment.

## Election purpose and threat model

Election systems require an election-specific profile. Eligibility, uniqueness of participation, ballot secrecy, accessibility, availability, integrity, auditability and resistance to coercion can pull in different directions. A cryptographic receipt that helps one voter prove how they voted may undermine secrecy or enable vote buying. A permanent artifact that joins a voter identifier to a vote choice is incompatible with a profile requiring that association to remain unavailable.

**R-42-02 — Eligibility and ballot separation.** A secrecy-preserving election profile MUST separate eligibility and participation controls from ballot-choice records. It MUST NOT create a voter-linkable identity-to-choice mapping through identifiers, receipts, microstructures, logs, timestamps or correlated metadata merely to simplify auditing.

The architecture may support qualified eligibility credentials, separate ballot authorization and independently administered election services. The specific protocol must explain how duplicate participation is prevented without making choices linkable, which parties could collude to break that separation, and how revocation, replacement ballots or disputed eligibility are handled. The architecture does not select one universal election protocol or claim remote voting is coercion-resistant by default.

The [U.S. Election Assistance Commission's VVSG 2.0](https://www.eac.gov/sites/default/files/TestingCertification/Voluntary_Voting_System_Guidelines_Version_2_0.pdf), including its software-independence and ballot-secrecy requirements, is a concrete technical comparison. It is not an ASKA certification, a rule for every jurisdiction or proof that any proposed physical voting artifact is suitable.

## Distinct election evidence

A voter needs confidence that the intended selection was captured. The election needs evidence that cast ballots were recorded and the recorded set was tallied correctly. These are different claims, often described as cast as intended, recorded as cast and tallied as recorded. A protocol that supplies one does not automatically supply the others. Accessibility mechanisms, ballot design, trusted display, paper handling and cryptographic verification all have separate failure modes.

**R-42-03 — Separate verifiability claims.** An election realization MUST state how it supports intention capture, ballot recording and tally verification, which participants can verify each claim, and what evidence remains if software is defective. It MUST NOT collapse those claims into a single ledger-integrity assertion.

A tamper-evident log can retain incorrect input faithfully. A scanner can misinterpret a marked ballot while its software signs the result. A voter may be unable to inspect a machine-generated record without an accessible independent presentation. The profile must describe audit and recount evidence that remains meaningful under the stated compromised-component assumptions. An auditable paper record, an end-to-end verifiable protocol or a qualified combination needs its own detailed conformance argument.

Physical microstructures may be explored as custody, commitment or audit artifacts, but the research must preserve secrecy. An artifact issued to a voter must not reveal a transferable proof of their choice under a receipt-free profile. A publicly checkable inclusion proof must not accidentally include an identity binding or a linkable high-resolution timestamp. A physical artifact's resistance to cloning says nothing by itself about election correctness or freedom from coercion.

**R-42-04 — Coercion and receipt analysis.** Election receipts, proofs and physical artifacts MUST be assessed for transferable choice evidence, coercion, vote buying and metadata linkage under an explicit adversary model. A valid signature, difficult-to-copy artifact or public tally proof MUST NOT be claimed to establish coercion resistance.

## Availability, inclusion and dispute handling

Election availability requires planning for failed devices, partitions, inaccessible authentication, disputed records and people unable to use the primary interface. Alternative procedures must preserve eligibility and duplicate controls without requiring every voter to possess one device, biometric or online account. A fallback should have its own chain of custody, reconciliation and audit rules; it must not silently degrade to unrecorded manual authority.

**R-42-05 — Inclusive continuity.** Civic and election services MUST define accessible and failure-tolerant procedures for unavailable credentials, equipment or connectivity, with bounded provisional treatment, reconciliation and qualified review. A failed digital path MUST NOT by itself be interpreted as ineligibility.

Dispute procedures should preserve evidence without exposing a secret ballot or unrelated personal records. A contested participation record and a contested tally have different evidence needs. Reviewers must be qualified for the matter and independent where the profile requires it. A recount must not become a pretext to reconstruct voter-choice associations. Correcting a public result requires an attributable decision and a new record, not silent replacement of the original announced result.

Clock and network assumptions are particularly important near deadlines. A device with an uncertain clock should report an interval and its time-source class. The profile must define which submission boundary determines timeliness and how qualified evidence resolves uncertainty. A user interface must not assure a voter that a ballot was accepted merely because the local device displayed success.

## Public decisions, simulation and oversight

Civic policy simulation can help people examine tradeoffs, compare proposed rules and submit feedback. Such tools should expose assumptions, input limitations, model versions and uncertainty. Citizen feedback is evidence of views expressed through the admitted process, not necessarily a representative population estimate. A model must not automatically settle a contested policy conflict or convert inferred preferences into a binding vote.

**R-42-06 — Accountable public computation.** Public policy analysis and AI-supported decision tools MUST distinguish simulation, measurement, consultation and binding institutional decisions. Binding rules and consequential outputs MUST have qualified adoption, provenance, review and correction procedures independent of the model's confidence.

Independent oversight may examine service failure rates, procurement, access patterns or procedural compliance. Privacy-preserving aggregate statistics can support this work, but the query system must account for repeated releases and small populations. An agency cannot use the label “analytics” to bypass the source owners' release restrictions. Where individual inspection is necessary, it needs its own admitted basis and protected review channel.

**R-42-07 — Public accountability with protected records.** Civic systems MUST publish or disclose the decision and audit evidence required by their accountability profile while protecting individual records and secret ballots. Public reporting MUST identify material gaps, corrections and uncertainty rather than use privacy as a blanket justification for unreviewable institutional conduct.

## Public emergency alerts and bounded local delivery

A public alert is a civic operation with its own issuer qualification and lifecycle. Its record binds an alert identity, issuing role, affected locality or audience, event class, precise content or content commitment, issue time, validity interval, revision, superseded or canceled alert references, admitted delivery channels and evidence quality. A citizen's emergency report can enter a bounded review workflow without being treated as an authenticated institutional broadcast. Unverified payloads remain low-integrity data and cannot acquire authoritative presentation or actuator privileges merely by using urgent language.

**R-42-08 — Qualified civic-alert lifecycle.** Civic alert owners MUST verify the issuer's authority for the alert's locality and event scope, enforce expiry and authenticated update or cancellation references, and prevent stale revisions from reviving a superseded alert. Unverified reports MUST remain explicitly unverified. A deployment claiming local emergency continuity MUST reserve the declared Polis admission, queue, processing and delivery resources against Wilder overload and test that claim under its stated surviving-resource assumptions.

An update can narrow the affected area or change instructions; a cancellation terminates the alert's current applicability but does not erase evidence that earlier versions were issued or delivered. Receivers validate the relationship between revisions and retain enough state to reject delayed superseded or expired copies. Clock uncertainty must follow the profile's declared validity rule. A display should distinguish an unverified report, an active qualified alert, a superseded message and a cancellation. Its delivery receipt identifies the local publication or channel submission actually established, not proof that every affected person saw or understood it.

Reserved local service is a concrete capacity claim. The profile names protected buffers, admission work, processing budget, power and the admitted local link, and measures the retained service under an open-network flood. If remote delivery shares a saturated radio, regional carrier or failed power facility, external delivery remains unavailable or uncertain even while the local alert service works. Neither the label Polis nor an emergency declaration creates a missing independent route. Alert updates, retries and cancellations remain within bounded service and disclosure budgets.

## Operational examples and acceptance

For a benefit application, a person provides scoped eligibility evidence and a payment destination. The service records a local submission, performs qualified review and issues a reasoned decision. A model can explain missing evidence but cannot deny eligibility based on an undisclosed behavioral score. The person can challenge an incorrect binding without granting the reviewer access to unrelated private records. Payment instruction, bank acceptance and settlement remain separate outcomes.

For an election, an eligibility service verifies participation rights without receiving ballot choices. Ballot casting, recording, tallying and audit are separately controlled according to the election protocol. Logs minimize correlation, and any physical audit artifact is evaluated for identity linkage and transferable choice evidence. A failed voting device invokes an admitted accessible continuity procedure. An independent audit checks the declared evidence; it does not infer correctness from the mere presence of signatures or a blockchain-style history.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-42-01 | Submit an application with qualifying evidence but a low AI reputation score; the model cannot independently remove eligibility or bypass qualified review. |
| T-42-02 | Attempt to join enrollment logs, ballot records and artifact identifiers; the profile's stated secrecy assumptions survive or the realization fails qualification. |
| T-42-03 | Corrupt one of intention capture, recording or tallying while leaving the others intact; the corresponding independent evidence detects the defined failure. |
| T-42-04 | Give a coercer voter receipts and physical artifacts; evaluate whether they can establish choice under the claimed receipt-resistance model. |
| T-42-05 | Remove network access or the primary authenticator; the admitted fallback preserves participation review and duplicate controls without falsely declaring ineligibility. |
| T-42-06 | Change a simulation assumption or model output; no binding rule changes until the qualified adoption procedure completes. |
| T-42-07 | Request public audit evidence; the system supplies the required decision and integrity records without exposing protected identities or ballot choices. |
| T-42-08 | Deliver an unverified report, wrong-locality alert, expired revision, authenticated update and cancellation, then replay the old version during a Wilder flood. Receivers must preserve verification status and revision/expiry rules; the valid local alert must meet the declared reserved-service bound when its stated resources survive, while an unavailable shared uplink is reported separately. |

These oracles define work required for qualification. No election security, accessibility or legal compliance result is established merely by adopting the general ASKA architecture.

## None

A community deployment joins independently governed participants without creating a universal authority over their private realms. It may provide shared compute, connectivity, public information, mutual assistance, local services, dispute procedures and collective infrastructure. Membership defines a relationship with specified rights and duties. It does not make every member's data public or give a community administrator authority to operate all connected machines.

A realm has a bounded namespace, resource owners, policy roots, accepted profiles and interfaces to other realms. Different realms can cooperate through negotiated contracts while retaining different admission decisions. Federation requires interoperable evidence and consequences, not agreement on every institutional judgment. A community may decline a service contract without being entitled to inspect the prospective participant's unrelated private data.

### Community constitution and resource authority

A community profile specifies membership and representation, resource ownership, admission, charging or contribution rules, service commitments, amendment procedures, dispute routes, privacy, emergency powers, oversight and exit. Each clause must identify the institution or resource owner that can enforce it. A community vote about shared infrastructure does not automatically amend a person's private source policy or transfer custody of their keys.

**R-42-09 — Bounded community governance.** Community decisions MUST operate within explicitly admitted shared resources, relationships and amendment procedures. Membership, a majority vote or an administrator role MUST NOT create universal control of independent realms or override unrelated source owners.

Shared resources need concrete scheduling and accounting. Compute access can be allocated by quotas, reservations, priority classes or admitted contribution policies. A scheduler may know enough to enforce resource bounds without reading workloads. A service's financial or operational rules must not be confused with a universal reputation measure of its users. Scarcity decisions should identify their basis, qualified owner and review route where required.

A participant's decision to leave may terminate future service access while preserving obligations already incurred. Outstanding charges, shared-object ownership, retained public commitments and unresolved disputes require an explicit exit treatment. The system must not promise instantaneous deletion of records held by independent parties or retain unlimited access as a condition of portability.

### Federation and interoperability

Federated admission identifies each participating realm, accepted issuer classes, applicable profiles, source and destination policies, grant owners, permitted effects, budgets, status freshness and dispute handling. An interrealm gateway translates agreed formats and routes admitted exchanges. It does not become the owner of every endpoint or infer authority from network reachability.

**R-42-10 — Independent federation admission.** Each realm MUST independently admit its applicable source release, destination acceptance and resource effects. A federation agreement MUST NOT turn one realm's positive authorization, trust score or credential issuer into permission at every other realm.

A destination can accept a narrow qualification proof without importing the source institution's complete policy. If profile meanings are incompatible, the parties can negotiate a restricted intersection, use a qualified translation or decline the exchange. Silent weakening is not acceptable. A gateway that cannot enforce retention, revocation freshness or output restrictions must expose that limitation before the effect is admitted.

Availability also has independent boundaries. A regional outage need not stop local private computation if the local profile permits continued operation. However, an effect requiring fresh remote status may have to pause. Offline authority must be limited by a declared lease, budget and reconciliation rule. A community's desire for continuity cannot make revoked authority permanently valid.

### Disputes and qualified review

Disputes can concern facts, identity bindings, contract interpretation, governance procedure, service quality or resource accounting. The record should identify the disputed predicates, parties, requested remedy, evidence scope, reviewer qualification, deadlines, stays and appeal path. Reviewers need only the evidence appropriate to their role. Public interest in a dispute does not automatically authorize disclosure of every participant's personal records.

**R-42-11 — Scoped dispute procedure.** A dispute process MUST specify qualified reviewers, evidence access, contest and stay semantics, decision scope and correction or appeal routes. An unresolved predicate MUST not be replaced by an AI confidence score or an undocumented administrator override.

Independence is a factual architecture claim. Reviewers may share legal control, funding, identity infrastructure, software, hosting or physical facilities. Those dependencies matter when the profile claims resistance to collusion or common-cause failure. A threshold of signatures is useful only under the stated threshold and corruption model; it does not prove institutional independence by itself.

**R-42-12 — Explicit review independence.** Quorum and independent-review claims MUST identify control roots, shared dependencies, tolerated corruption and recovery rules. Multiple agents, accounts or keys under a disallowed common controller MUST NOT satisfy an independence requirement.

Review outcomes become attributable decisions with bounded effects. A reviewer may direct correction of a shared accounting record without receiving general authority to rewrite private histories. Compensation requires a new admitted effect. A corrected decision should link to the earlier record and explain the scope of correction; it should not silently erase evidence that an erroneous decision occurred.

### Public participation and AI-supported policy work

Communities can use AI to summarize proposals, translate materials, identify conflicting clauses, simulate resource allocations and organize feedback. These functions can improve participation if their sources, assumptions and limitations are visible. A summary should preserve material disagreement and uncertainty rather than present a synthetic consensus that no participant approved.

Participation analytics require their own privacy policy. Counts and trends may be released while individual submissions remain protected. Repeated queries, small communities and distinctive writing can make apparent aggregation identifying. A platform must not infer a member's private beliefs or relationships simply to improve its policy model. A member's explicit public statement is different from a model's speculative attribution.

Federated analytics or learning may distribute computation among realms. Keeping raw inputs local does not itself prevent leakage through updates, models, outputs or participation timing. Any multiparty or differential-privacy mechanism must identify its adversary, privacy unit, composition limits and failure behavior. A community service cannot claim collective privacy merely because it avoids one central database.

### Amendments, emergencies and exit

A profile amendment names the proposed change, qualified initiators, voting or approval procedure, affected contracts, activation time, compatibility treatment and review route. Existing grants must either remain valid under their pinned terms, narrow, expire or undergo renewed admission as specified. A routine software update cannot silently change the community constitution. Conversely, an authorized governance change still needs a technically safe deployment procedure.

**R-42-14 — Governed amendment and exit.** Community amendments MUST follow the admitted procedure and explicitly address active grants, retained evidence, portability and continuing obligations. Exit MUST retire future membership authority without silently transferring private keys or eliminating independently applicable duties.

Emergency authority is limited to admitted shared resources and protective templates. An infrastructure incident may justify RATE_LIMIT or ENTER_SAFE_STATE for a community service, but does not grant a council access to all private content. Duration, renewal, affected interests, notice and after-action review remain explicit. A repeated emergency declaration must not become a permanent route around ordinary amendments.

**R-42-15 — Bounded collective emergency response.** Community emergency powers MUST name targets, triggers, operations, duration, renewal ceilings, responsible owners and review duties. They MUST NOT confer general private-realm access or silently persist after their admitted conditions end.

### Operational example and acceptance

A community operates shared research compute and a local notice service. Members receive quotas under a published profile. Private workloads run under their own source restrictions, while the scheduler sees only the information required for allocation. Two laboratories negotiate an aggregate analysis; each independently admits its input and the resulting output policy. A dispute about accounting is reviewed by qualified people with access to the relevant receipts, not all workload contents. An AI simulates alternative quota policies and summarizes member feedback, but a change becomes binding only through the admitted amendment procedure.

During an upstream outage, the community continues admitted local work. Remote-dependent effects pause or use bounded offline leases according to their contracts. If an administrator leaves, their future grants are revoked and unresolved tasks are assigned to qualified successors. A departing member exports their admitted objects through an explicit portability workflow; protected coauthored data and public commitments follow their existing ownership and retention rules.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-42-09 | Approve a community motion concerning shared compute; private-realm keys and unrelated data remain outside its enforceable scope. |
| T-42-10 | Present one realm's valid grant at another realm lacking admission; no local effect occurs. |
| T-42-11 | Contest a billing predicate with no declared precedence rule; the dispute follows its stay and review procedure rather than an administrator shortcut. |
| T-42-12 | Place nominally independent reviewers under a common prohibited root; the quorum's claimed independence fails qualification. |
| T-42-13 | Change an AI policy recommendation; installed community authority remains unchanged until qualified adoption. |
| T-42-14 | Amend membership rules or process exit while contracts remain active; each grant and continuing obligation receives the declared treatment. |
| T-42-15 | Renew an emergency beyond its ceiling; further exercise is blocked or requires a new qualified basis, and private data remains protected. |

Community governance is therefore a composition of explicit authority and evidence boundaries. Its legitimacy and resilience depend on the actual institutions, control roots and remedies described in the profile; architectural terminology alone cannot supply them.
