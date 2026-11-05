# ASKA v6 — Family, care, professional and personal authority

Relationships make computing useful. A person may ask a family member to help with bills, authorize a caregiver to receive alerts, retain a professional, appoint a representative or plan for incapacity and succession. These relationships involve different rights, duties and protected interests. ASKA must represent them without making the relationship holder the universal owner of another person's data or decisions.

A shared household is not a single security principal. A dependent person has interests distinct from a guardian's convenience. A professional may owe duties to a client that neither party can freely delegate. An institution may own equipment while personal information on that equipment remains protected under an applicable profile. The machine needs explicit evidence of relationship scope and activation, as defined in [Identity and relationships](34_identity_relationships_delegation_and_revocation.md).

## 51.1 Personal delegation and household boundaries

A personal delegation identifies the principal, representative, permitted operations, objects, recipients, budget, duration, conditions and stopping procedure. It should support narrow assistance: reviewing selected invoices, preparing a form, receiving a safety alert or maintaining a shared calendar. A person should not have to disclose their complete archive to obtain one useful service.

**R-51-01 — Relationship-specific scope.** Family, household and personal relationships MUST confer only the operations admitted for their explicit scope. Shared residence, device ownership, kinship or knowledge of an authenticator MUST NOT create general access to another person's private realm.

Shared objects require explicit ownership and participation rules. A household calendar can expose availability without exposing medical appointment details. A joint account may allow specified transactions while preserving separate private correspondence. When participants disagree, the object owner and applicable relationship profile determine which changes can occur; the system must not resolve the dispute by choosing the person with the most device access.

A person's delegation can be prospective and conditional. It can authorize a trusted relative to act only during travel, after a qualified incapacity determination or when an alert remains unanswered for a defined interval. The trigger must be the one actually admitted. Failure to answer a message is not automatically proof of incapacity or permission to inspect every sensor.

## 51.2 Care, capacity and dependent interests

Care workflows can combine reminders, observations, escalation, professional contact and emergency action. Each step should disclose the minimum information needed by its recipient. A family caregiver may receive that an agreed check-in failed while a clinician receives a qualified clinical record under a different contract. A general alert service need not receive the full health history.

**R-51-02 — Qualified care activation.** Capacity-dependent or protective authority MUST identify its trigger evidence, qualified assessor or procedure, protected interests, duration, reassessment and contest route. AI inference, age estimation, unusual behavior or a biometric match MUST NOT independently activate broad guardianship or care access.

Profiles for guardianship and dependent care must account for applicable rights, developmental or capacity changes, confidentiality needs and conflicts of interest. They cannot assume that a guardian's preferences always exhaust the dependent person's interests. A professional or independent reviewer may have a qualified role when the relationship is contested or when disclosure to a particular caregiver could create risk. The architecture should support those distinctions without inventing a universal rule for every jurisdiction.

**R-51-03 — Protected-person privacy.** Care and guardianship grants MUST preserve the protected person's applicable confidentiality and participation rights, including limits on caregiver access and review where required. A grant to protect welfare MUST NOT become general behavioral surveillance or unrestricted control of unrelated resources.

Continuous monitoring can be helpful but intrusive. The observation contract should state sensors, sampling, inference, recipients, retention, alert thresholds and false-alarm response. A device that shares only an alert still may reveal a pattern of life through timing. Analytics must include these metadata channels, and revocation must stop future observation or export at the specified boundary.

## 51.3 Professional duties and conflicts

Professional work often combines client instructions, qualification requirements, confidentiality, record retention, competence duties and institutional constraints. The client can authorize preparation or disclosure within their authority, but cannot necessarily waive every professional obligation. A professional's credential likewise does not grant access to every client record held by another owner.

**R-51-04 — Duties survive delegation.** Professional and fiduciary workflows MUST preserve applicable confidentiality, conflict, retention and nondelegable duties through all delegated tasks. An agent or subordinate MAY prepare work only within admitted scope and MUST NOT impersonate the qualified owner's required judgment or signature.

The contract should distinguish preparation, review, advice, filing, treatment authorization and payment. A billing office may receive the minimum data necessary for its function while clinical interpretation remains in a separate realm. A professional engaged for one matter must not use that access to pursue an unrelated commercial interest. Conflicts should produce the profile-defined review or restriction rather than be hidden behind a generic consent checkbox.

A model-generated professional draft can be useful if its provenance, limitations and required review remain visible. A confident answer is not evidence of qualification. The responsible owner must be able to inspect the source and reasoning artifacts appropriate to the task without expanding their rights over unrelated data. Passing the output through a licensed person's account does not establish that the required review actually occurred.

## 51.4 Succession, recovery and continuity

Planning for incapacity, death or device loss requires explicit custody and activation arrangements. A person may establish trustee-held recovery for selected objects, a delayed release to named beneficiaries, a representative's access to specified accounts or a professional's continued retention obligations. Each arrangement names trigger evidence, qualified authorities, dispute handling, scope and limits.

**R-51-05 — Planned and bounded succession.** Succession and recovery MUST use an admitted existing custody path with qualified trigger evidence and object-specific scope. They MUST NOT presume that a relationship, death record or court document can reconstruct unknown keys, reveal all private data or cancel surviving obligations.

Threshold custody requires real independence and a defined collusion model. Several nominal trustees using one account or administrator do not provide the claimed separation. A beneficiary's access to one asset does not imply access to private communications involving third parties. An estate representative may need an accounting record without the deceased person's entire personal archive. Unavailable information must remain honestly unavailable rather than prompting a hidden universal recovery mechanism.

Continuity also covers ordinary service failure. If a caregiver's device fails, an alternative authorized recipient may receive a bounded alert under a prearranged contract. A failed primary channel does not authorize broadcasting sensitive information. The profile should define escalation order, retry ceilings, emergency conditions and when to report that the intended support was not delivered.

## 51.5 Revocation, emergency response and operational example

A person can revoke a voluntary delegation according to its applicable terms, while independently applicable duties are evaluated separately. Revocation prevents future exercise at the required boundary; it cannot make already disclosed information unknown. Continued retention may remain justified for a qualified professional record even after ordinary access or processing consent ends. The interface must explain this distinction without falsely claiming either that revocation does nothing or that it erases every trace.

**R-51-06 — Clear termination and continuing duties.** Relationship termination MUST withdraw future delegated authority as specified, drain in-flight activity and identify any independently applicable continuing duties. It MUST NOT silently retain broad access under the label of continuity or promise reversal of completed disclosures.

Emergency care may require a limited act under a separate profile. An emergency contact can receive an alert without gaining the person's financial records. ENTER_SAFE_STATE may protect a device without authorizing personal-data export. Every emergency use needs a bounded basis, affected interests, receipt and subsequent review or notice when required. Repeated alarms must not create indefinite surveillance by renewing themselves automatically.

Consider a person who asks a relative to help with daily medication reminders and a professional representative to prepare tax materials. The caregiver sees reminder schedules and specified acknowledgment signals. The representative sees selected financial records and can prepare a filing, but a reserved signature remains with the qualified person. During a temporary incapacity, a separately qualified activation permits bounded care coordination. It does not unlock the financial archive for the caregiver. Restoration of capacity ends the temporary grant, while relevant care records and professional retention duties remain governed by their own profiles.

**R-51-07 — Reviewable care and personal decisions.** Affected people and qualified reviewers MUST have a scoped path to inspect consequential relationship bindings, activation decisions and access history, correct errors and invoke applicable dispute procedures. Review MUST preserve third-party confidentiality and must not depend exclusively on a conversational model.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-51-01 | Authenticate a household member on a shared device; another person's private archive remains inaccessible without a scoped relationship grant. |
| T-51-02 | Trigger a behavioral anomaly score without the required capacity evidence; broad care or guardianship authority does not activate. |
| T-51-03 | Give a caregiver alert access; unrelated intimate records and raw monitoring streams remain unavailable. |
| T-51-04 | Delegate preparation of a professional act; the subordinate cannot satisfy a nondelegable review or signature requirement. |
| T-51-05 | Present valid succession evidence for one asset; unrelated keys and third-party correspondence remain protected or unavailable. |
| T-51-06 | Revoke a care delegation during a queued export; future finality is blocked as specified and prior disclosures remain honestly recorded. |
| T-51-07 | Contest a mistaken relationship binding through the deterministic review path; the dispute can be processed without exposing unrelated protected records. |

These requirements describe architectural profiles, not universal legal rules about family, capacity or professional practice. Qualification requires evidence for the selected institutional procedure as well as the enforcing machine boundaries.
