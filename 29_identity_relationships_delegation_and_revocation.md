# ASKA v6 — Identity, relationships, delegation and revocation

ASKA represents identity as evidence relevant to a context, not as a universal identifier that automatically connects a person's household, employment, medical care, civic activity and commerce. A principal may have several keys and several identifiers; a key may act for a person, organization, device, service or narrowly defined role. The machine must determine what an identifier denotes, who controls its current authentication material, which relationship is asserted and what authority follows under an applicable profile. Those questions have different evidence and failure modes.

Authentication establishes a claim about control of an authenticator. It does not by itself establish informed consent, professional qualification, capacity, legal jurisdiction or ownership of every object associated with a name. The [Accord system](27_accord_system_and_machine_authorization.md) evaluates those predicates separately. A credential issuer supplies qualified evidence only within the predicates for which the accepting owner trusts it.

## Contextual identity and correlation

A contextual subject reference contains a realm and a locally meaningful subject identifier, with an optional binding to other identities supported by an authorized claim. Pairwise identifiers can limit direct correlation between relationships. They do not hide correlation arising from repeated public keys, contact endpoints, unique attributes, timing, network paths or document contents. A profile must therefore state both its identifier design and its remaining correlation channels.

**R-29-01 — Contextual identity.** Identity resolution MUST remain scoped to an admitted purpose and relationship. Cross-context linkage MUST require an explicit authorized binding or independently applicable basis; a shared name, device, household, employer or issuer MUST NOT silently merge subjects or their permissions.

An application must not use “same human” as a convenience permission join. A hospital account may be linkable to a billing record for an admitted reimbursement operation while the same subject's civic participation remains outside that link. Deletion of an application alias does not guarantee deletion of externally retained records, and a stable audit reference may remain necessary under a separately justified retention obligation. Those distinctions must be shown to the subject when they affect a decision.

The [W3C DID Core privacy considerations](https://www.w3.org/TR/did-core/) discuss correlation risks even when pairwise identifiers are used. The [W3C Verifiable Credentials Data Model 2.0](https://www.w3.org/TR/vc-data-model-2.0/) supplies a vocabulary for issuers, holders, verifiers and credential subjects. Neither document establishes the authority consequences of an ASKA identity binding.

## Relationship records

A relationship record, represented as a typed CLAIM, names its participants, roles, scope, evidence issuer, commencement, expiry, activation conditions, termination conditions and delegation limits. A relationship may be reciprocal without granting symmetric rights. A physician's duty to protect a patient's information does not give the patient access to the physician's unrelated records. An employer's responsibility for a managed device does not confer authority over an employee's private realm.

| Relationship | Example qualifying evidence | Bounds that must remain explicit |
|---|---|---|
| Professional and client | Current qualification, engagement and task | Matter, confidentiality, conflict, retention and nondelegable responsibilities |
| Guardian and dependent | Applicable appointment or recognized relationship | Protected interests, age or capacity conditions, review and limits on disclosure |
| Caregiver and person receiving care | Voluntary delegation or another applicable basis | Observations, permitted intervention, schedule, escalation and expiry |
| Fiduciary and beneficiary | Appointment and asset scope | Purpose, accounting, conflict rules and prohibited self-dealing |
| Employee and institution | Role appointment and current employment status | Institutional resources, duties, separation of roles and personal privacy |
| Representative and principal | Mandate or power supported by the selected profile | Matter, duration, substitution, budget and acts excluded from delegation |
| Successor or estate representative | Trigger evidence and qualified appointment | Assets, timing, disputes, retained obligations and unavailable keys |

**R-29-02 — Relationship qualification.** A relationship claim MUST name the rights and duties it can support, its activation and termination predicates, and the evidence accepted for those predicates. Mere relationship existence MUST NOT confer unrestricted access, and inferred intimacy, dependency or vulnerability MUST NOT create a machine grant.

Relationship records need not be globally published. A verifier can receive only the predicates needed for a transaction, such as whether a representative is currently qualified for one specified matter. The proof must not be reused as a broader relationship disclosure without a new basis.

## Delegation as attenuation

A delegation grants a subordinate the ability to request or exercise a subset of an already authorized operation. It cannot create rights that the delegator lacks. For grant lineage \(g_0,g_1,\ldots,g_n\), the exercisable authority at the leaf is constrained by every applicable ancestor, source policy, destination policy and contextual restriction. A larger set of credentials is not a larger permission set when one credential introduces a prohibition or duty.

Authority attenuation includes operation set, object set, recipient, purpose, region, validity interval, amount, use count, confidentiality, integrity requirements, effect ceiling and redelegation depth. Obligations are carried forward where applicable; they are not discarded because a child token has fewer fields. Some duties are explicitly nondelegable. A professional can delegate preparation while retaining required personal judgment, verification or signature responsibility.

**R-29-03 — Attenuating delegation.** Every delegated grant MUST be no broader than its admitted ancestors, preserve applicable obligations and prohibitions, and respect nondelegable acts. A child MUST reference its lineage and generation. Omitting a constraint MUST NOT convert a constrained ancestor into an unrestricted child.

Budget attenuation requires more than assigning a ceiling independently to each child. If two children each receive authority to spend 60 units from a parent budget of 100, a shared owner must prevent their aggregate committed consumption from exceeding 100. A split can instead reserve disjoint child allocations. The profile must choose its accounting model and define reservation expiry, failed attempts, refunds and compensation. A refund does not automatically restore grant authority unless the budget owner admits that restoration.

**R-29-04 — Lineage budget conservation.** Sibling grants MUST share a conserved parent budget or receive disjoint reserved allocations. Finality-sensitive consumption MUST be checked by the budget owner; renewal, suspension, retry, reboot or alias creation MUST NOT multiply the available authority.

## Authentication, capacity and trusted presence

Authenticator enrollment, replacement, loss and recovery are lifecycle events with their own risks. A recovery key or trustee threshold may restore control of a specific identity credential while leaving unrelated grants revoked. Key rotation must preserve an auditable transition without forcing a permanent public identifier across contexts. A stolen old key must not remain valid merely because its signature can still be mathematically verified.

Biometric recognition is evidence with error rates, presentation attacks and privacy consequences. It cannot establish all aspects of a person's intention or capacity. [NIST SP 800-63B-4, section 3.2.3](https://pages.nist.gov/800-63-4/sp800-63b.html) treats biometrics within bounded authentication arrangements and includes alternatives; that guidance is not a legal capacity test. ASKA profiles must accommodate accessibility and recovery without assigning a universal physiological identity root.

**R-29-05 — Qualified activation and recovery.** Capacity-dependent authority, trusted local presence and identity recovery MUST use the specific evidence and procedure admitted for that predicate. Behavioral prediction, a biometric match or an AI confidence score MUST NOT independently activate guardianship, succession, professional qualification or unrestricted recovery rights.

A capacity-triggered arrangement should identify who may assess the trigger, how conflicts are handled, how the subject can contest it, what temporary action is permitted and when reassessment is required. An inaccessible assessment service does not authorize the system to guess. Emergency action may proceed under a separate bounded basis, with its own receipt and review obligations.

## Revocation and continuing obligations

Revocation can terminate a credential's accepted status, withdraw a delegation, suspend a relationship or invalidate an installed grant. These events are related but not interchangeable. Revoking an authentication key does not erase historical evidence signed while the key was valid. Terminating a role does not remove a records custodian's retention duty. Ending consent can block future voluntary processing while leaving independently applicable duties to be evaluated separately.

A revocation record names its issuer, target, scope, reason class, effective condition, status version and permitted disclosure. The enforcing owner maintains monotonic generations or another declared antirollback mechanism. A refresh from an older cache cannot downgrade known revocation. Offline validation must disclose the age and reliability of status evidence and the maximum interval in which authority can remain usable without contact.

**R-29-06 — Revocation without historical erasure.** Enforcers MUST reject stale or revoked authority at future finality according to the admitted freshness policy, while preserving the distinction between valid historical acts, continuing obligations and new authority. Revocation MUST NOT be represented as undoing an irreversible disclosure or physical consequence.

A terminated caregiver session can still have an in-flight sensor sample. The owner must drain or reject the sample according to its declared finality boundary and stop new collection at the required point. Already delivered observations cannot be made unknown to the recipient. The system can demand deletion where authorized and record attestations, but cannot claim that a remote human forgot information.

## Operational example and acceptance

A person delegates medication reminders to a family member and payment preparation to a financial representative. The caregiver receives schedules and acknowledgment status, not transaction histories. The financial representative prepares an invoice within a budget but cannot access clinical notes or finalize an act reserved for the principal. During a temporary incapacity, a qualified activation claim enables the prearranged care scope. It does not merge the two relationships. When capacity is restored, the activation expires, installed grants are revoked and outstanding duties are reconciled.

**R-29-07 — Relationship privacy and review.** Relationship evidence, linkage proofs and revocation explanations MUST be disclosed only at the granularity authorized for the recipient. The subject and qualified reviewers MUST have a profile-defined path to inspect and challenge consequential bindings without receiving unrelated protected evidence.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-29-01 | Present two aliases with a shared contact address; no cross-realm permission join occurs without an admitted linking basis. |
| T-29-02 | Present a valid caregiver relationship without a matching operation scope; unrelated records remain inaccessible. |
| T-29-03 | Delegate a grant while dropping its recipient restriction or a nondelegable signature duty; admission rejects the child. |
| T-29-04 | Race sibling spending requests across a reboot; aggregate committed consumption never exceeds the conserved allocation. |
| T-29-05 | Supply only a biometric or behavioral capacity score; the protected relationship cannot activate. |
| T-29-06 | Replay a previously valid credential after known revocation; new execution fails while historical verification remains separately available. |
| T-29-07 | Request a qualification proof for one matter; the response does not expose the subject's unrelated relationships or private revocation details. |

These tests specify acceptance behavior. Their satisfaction requires implementation evidence for the selected identity, status, clock, persistence and guard mechanisms; the availability of a credential format alone is insufficient.
