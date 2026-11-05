# ASKA v6 — Governance profiles, conflicts and institutions

**Status:** proposed architectural requirements. Acceptance oracles specify evidence to obtain; no ASKA implementation or validation result is asserted.

A governance profile makes a bounded institutional interpretation executable. It identifies the rules, authorities, procedures and evidence that a resource owner accepts for a class of operations. It cannot settle disputed law by declaring its own interpretation correct. Different institutions may apply different profiles to the same proposed exchange, and a source owner may be technically unable or institutionally unauthorized to fulfill a request that another participant considers valid. ASKA must expose that difference without inventing a universal administrator.

Profiles apply to people, organizations, services and resource owners through explicit applicability rules. They are not numerical trust ranks. A court, employer, credential issuer, professional body, family member and community council hold different kinds of authority. None thereby acquires another institution's keys or every person's private data. An AI may help identify relevant documents or simulate consequences, but its interpretation remains a proposal subject to the admitted qualification and review rules.

## 35.1 Profile contents and applicability

A profile manifest contains a stable profile identity, issuer qualification, version and digest, applicability conditions, accepted authority classes, evidence schemas, decision rules, prohibited acts, required approvals, privacy rules, notice procedures, emergency limits, dispute routes, retention rules, update procedure, expiry and compatible cryptographic and assurance suites. It states who can amend which provisions and which changes require affected-party participation or independent review.

**R-35-01 — Explicit profile applicability.** Admission MUST identify the exact profile versions used, the predicates making them applicable, and the authority that qualified their issuers. A profile name, institutional affiliation or signature alone MUST NOT establish applicability to every subject, object or operation.

Applicability can depend on location, relationship, resource ownership, service category, contract or legally relevant facts. These facts may be contested or privacy-sensitive. The profile must identify acceptable evidence and how uncertainty changes execution. A device's current network address is not automatically proof of residence or jurisdiction. A user interface must distinguish a verified predicate from an assumption whose failure could defeat the decision.

Profiles are objects subject to provenance and admission. A syntactically valid profile received over a trusted network does not install itself. A resource owner may accept a profile's vocabulary without accepting its issuer for a consequential legal predicate. Version selection must be pinned before approval so that a subsequently fetched document cannot silently change the meaning of an existing grant.

## 35.2 Conflict evaluation as a partial decision

A proposed operation is evaluated against positive authorization, applicable prohibitions, duties, source restrictions, destination acceptance, relationship limits and machine feasibility. A positive result requires all mandatory predicates to be resolved in the required direction. Some comparisons are intentionally undefined. An unresolved conflict should produce SUSPEND, ESCALATE or UNAVAILABLE under the selected rule rather than an invented precedence relationship.

The evaluator returns ALLOW, ALLOW_WITH_OBLIGATIONS, DENY, SUSPEND, ESCALATE or UNAVAILABLE, together with a scoped explanation and evidence references. These are evaluation results, distinct from PACT lifecycle states and effect finality states. ALLOW_WITH_OBLIGATIONS is executable only when the relevant obligations can be enforced or assigned to a qualified accountable owner as the profile requires. A logging promise is not adequate if the obligation actually requires suppression of the release.

**R-35-02 — No invented precedence.** Conflict evaluation MUST apply declared relations between rules and return a nonauthorizing unresolved result when a required relation is absent. It MUST NOT convert source policy, consent, lawful compulsion, professional duty or institutional status into an undocumented universal priority order.

This requirement permits legitimate compulsion where an applicable profile establishes it. It does not give consent a universal veto over every duty or order. Conversely, a document labeled “legal order” does not automatically defeat all rights and constraints. Qualification, scope, applicability, contest procedures, stays and technical ability must still be checked. The architecture records the basis actually used rather than relabeling compelled action as voluntary agreement.

The [W3C ODRL Information Model 2.2](https://www.w3.org/TR/odrl-model/) distinguishes permissions, prohibitions and duties and provides profile mechanisms. It offers a useful descriptive comparison, but does not determine which institutions legitimately prevail in a concrete dispute. ASKA's evaluation and enforcement obligations remain independent design requirements.

## 35.3 Source and recipient independence

A source owner evaluates whether specified information may leave its protected context. A destination owner evaluates whether its own realm may receive, retain, execute, display or republish the material. Both decisions are necessary where the operation crosses their boundaries. A source's lawful release basis does not make the destination accept malware, incompatible retention duties or an unbounded tracking obligation. A destination's desire for information does not declassify the source.

**R-35-03 — Independent institutional boundaries.** Cross-institution operations MUST satisfy independently applicable source release and destination acceptance decisions. Joining profiles MUST preserve their applicable negative restrictions and duties; a permissive rule from one participant MUST NOT erase a restriction owned by another.

The same separation applies inside an institution. A payroll role can approve compensation while a clinical records role rejects unrelated diagnosis access. A supervisory title is not an ambient capability. If an institution chooses to concentrate several roles in one office, the resulting common failure domain must be explicit. Renaming one operator as several approvers does not create independence.

## 35.4 Exceptional access and emergency profiles

Exceptional access must declare its actual technical mechanism. It cannot be described solely by a policy aspiration such as “authorized parties can always recover.” Four useful profile categories distinguish materially different systems:

| Category | Technical meaning | Principal limitation |
|---|---|---|
| E0 | No additional recovery or disclosure capability beyond existing ordinary custody | A valid request may be technically unavailable. |
| E1 | A custodian discloses information or keys it already lawfully and technically holds | Custodian compromise or misuse remains a risk. |
| E2 | Voluntarily established trustee or threshold recovery for specified objects | Trustees, trigger evidence and collusion assumptions must be assessed. |
| E3 | An additional access path required by an applicable institutional arrangement | The path enlarges the attack and abuse surface and must be separately qualified. |

These categories describe architecture; they do not endorse an arrangement or settle its legality. No category permits the system to pretend it can recover an unknown secret. Threshold custody must identify who controls each share, where common infrastructure exists, which failures are tolerated and what audit evidence remains available.

**R-35-04 — Declared exceptional access.** A profile permitting exceptional access MUST identify the actual custody or recovery path, eligible objects, qualifying authorities, threshold and common-cause assumptions, trigger, limits and notice or review duties. An unavailable path MUST yield an honest inability result rather than undisclosed key escrow or fabricated recovery.

Emergency authority is similarly bounded. Immediate containment, temporary continuity of care and disclosure to an emergency recipient are distinct operations. A grant to enter a safe machine state does not automatically authorize medical disclosure. Limits include a target set, operation set, duration, renewal ceiling, budget, trigger evidence, responsible owner and reconciliation requirements. Emergency use must not silently become the ordinary policy after the trigger ends.

## 35.5 Profile evolution and accountability

Profile updates can fix errors, incorporate new institutional decisions or alter security assumptions. Each update has a provenance chain, change description, compatibility assessment and activation rule. An update affecting a contract's meaning must identify whether existing grants continue, narrow, suspend or require new admission. Cryptographic compatibility is insufficient if a rule newly permits a previously forbidden recipient or substitutes one authority for another.

**R-35-05 — Governed profile change.** Profile updates MUST follow the currently admitted amendment procedure and preserve explicit treatment of active grants, historical verification and affected rights. An AI-generated rule, a signed software package or a majority of unqualified operators MUST NOT bypass that procedure.

Profiles should separate governance assumptions from hardware and software assurance. A deployment can have strong guards but weak institutional review, or accountable institutions with a limited laboratory realization. A conformance manifest must report the relevant dimensions instead of presenting one “high trust” label. Reviewability includes a decision record, qualified appeal path, correction mechanism and notice where applicable. It does not require publishing protected evidence to everyone.

**R-35-06 — Accountable decisions.** Consequential institutional decisions MUST retain a bounded explanation identifying applicable rules, qualified decision makers, material assumptions and contest or correction routes. Review access MUST be separately authorized and MUST preserve protected third-party information.

## 35.6 Operational example and acceptance

A public agency requests a limited records extract from a professional custodian. The agency presents qualifying authority and scope. The custodian verifies applicability and any operative stay, identifies the exact objects and checks whether the extract is technically available. A protected third party's information requires redaction under the governing rule. The receiving agency separately admits the sealed extract and its retention obligation. If two applicable interpretations conflict without an admitted resolution rule, the disputed portion is escalated while any independently authorized separable portion can proceed under its own contract. This avoids making a broad conflict an excuse for either unlimited disclosure or undocumented suppression.

**R-35-07 — Honest limits of institutional enforcement.** A deployment MUST distinguish technical enforcement from the legitimacy, accuracy and independence of the institutions supplying its predicates. It MUST document failure modes involving compromised signers, colluding reviewers, unavailable remedies and physically coerced operators rather than claiming that profile execution eliminates them.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-35-01 | Present a correctly signed profile outside its subject or resource applicability; no grant is installed. |
| T-35-02 | Supply conflicting applicable rules with no declared precedence; execution remains blocked or escalated under the specified partial result. |
| T-35-03 | Approve source release while the receiver rejects retention terms; receiver publication does not occur. |
| T-35-04 | Request E2 recovery without the admitted threshold or trigger; the system reports insufficient authority and cannot synthesize the key. |
| T-35-05 | Push a signed update that changes an active contract's recipient set; existing authority does not expand silently. |
| T-35-06 | Give a reviewer access to a contested decision; explanations reveal the required predicates without unrelated private evidence. |
| T-35-07 | Remove a supposedly independent reviewer's separate control root; the deployment's assurance description changes and no independence claim survives unchanged. |
