# ASKA v6 — Legal process, rights and emergencies

**Status:** proposed architectural requirements. Acceptance oracles specify evidence to obtain; no ASKA implementation or validation result is asserted.

ASKA must support legitimate lawful compulsion, accountable public duties and urgent protection while preserving limits on authority and honest statements of technical ability. It must not treat every requested disclosure as voluntary consent, nor make consent a universal veto over independently applicable duties. Equally, a signed demand is not a universal key. Qualification, applicability, scope, contested predicates, operative stays, custody and actual machine capability remain separate checks.

This chapter specifies architectural procedures. Profiles must be qualified for their intended institutional setting; the architecture does not determine the law of every jurisdiction or replace qualified interpretation. The machine can enforce a bounded admitted decision and preserve evidence of its basis. It cannot guarantee that every institution is honest, every order is correct or every affected person has an effective remedy.

## 49.1 Request and applicability records

A legal-process request identifies issuing authority and role, qualifying evidence, matter reference, subjects and object scope, requested operations, relevant time range, asserted basis, applicability predicates, recipient, deadline, minimization terms, preservation conditions, contest route, notice or sealing conditions, expiry and signature. It distinguishes a request for information from an order to preserve, a demand to decrypt existing custody, and a request to create new surveillance or access capability.

**R-49-01 — Qualified and scoped legal requests.** Every compulsory operation MUST be admitted from a request with verified issuer qualification, applicability, object and operation scope, recipient, time bounds and relevant procedural conditions. A signature, title or network source alone MUST NOT authorize arbitrary access.

A custodian may accept a qualified applicability statement without receiving all confidential material from the issuing process. Such delegation of predicate verification must itself be admitted and bounded. A resource owner must know which predicate the statement supports and what remains unresolved. If the request cannot identify the intended data precisely, a search process requires its own bounded scope and observation authority; uncertainty does not justify unrestricted collection.

The evaluation can record descriptive procedural events such as issued, verified, contested, applicable, extracting, sealed, disclosed and notified. These are event kinds. Their concrete actions use the canonical PACT and effect states, so procedural vocabulary does not create a second incompatible finality model.

## 49.2 Distinct acts and independent boundaries

Preservation, discovery, extraction, review, disclosure and notification are different operations. A preservation order may require retention while prohibiting disclosure. A reviewer may inspect a limited extract to decide what can be released without gaining permission to export the full source. A recipient may accept a sealed package only into a restricted case realm. Each act has its own qualified owner, grant and receipt.

**R-49-02 — Separation of legal-process effects.** Preservation authority MUST NOT imply disclosure authority; review authority MUST NOT imply public release; and compelled source release MUST NOT bypass independent destination acceptance. Each materially distinct act MUST have an admitted scope and named finality boundary.

Extraction should operate over selected object generations or an explicitly bounded query. Redaction and minimization must preserve the exact transformation identity, input provenance and output commitment needed for review. If a query spans information about uninvolved people, the applicable profile must state how that information is excluded, sealed or separately reviewed. A tool's convenience cannot erase a third party's restrictions.

The source owner must distinguish information it holds, information another party holds, inaccessible ciphertext and nonexistent data. It may be able to produce a record without being able to reconstruct an expired key or an unrecorded event. A truthful inability response is part of compliance behavior, not evidence that the machine secretly possesses an override.

## 49.3 Contest, duties and limited exceptions

A contested request needs a defined effect on execution. Some profiles may require a stay pending review; others may permit specified actions to proceed while a dispute remains open. The machine must apply the declared rule and retain the fact that the action was contested. It must not invent a universal rule that every objection blocks all duties or that every institutional demand overrides all objections.

**R-49-03 — Explicit contest semantics.** A legal-process profile MUST define who may contest which predicates, the qualified review path, the effect of an operative stay, and the treatment of separable uncontested actions. An unresolved mandatory predicate MUST produce the specified suspension, escalation or unavailability result rather than undocumented precedence.

Nondelegable responsibilities require qualified human or institutional acts even when an agent prepares the evidence. A professional may have an independently applicable confidentiality duty or an affirmative duty to act; either must be represented explicitly. An employee cannot assume that an employer's instruction authorizes conduct beyond the employer's actual domain. The architecture carries these relationships without resolving every substantive legal dispute itself.

Exceptional access profiles distinguish no additional access, existing custody, voluntary threshold arrangements and mandated additional paths as described in [Governance profiles](35_governance_profiles_conflicts_and_institutions.md). The actual mechanism, eligible data, triggering authorities, collusion assumptions and review procedures must be disclosed in the assurance profile.

**R-49-04 — Honest custody and exceptional access.** A compulsory request MUST use only an actually implemented, admitted access or recovery path. The system MUST report unavailable information or keys honestly and MUST NOT manufacture an undeclared backdoor, broaden trustee scope or claim recovery from an unestablished physical mechanism.

## 49.4 Emergency action

Emergency response can include containing a compromised process, preserving evidence, entering a safe physical state, sustaining essential care or disclosing a limited fact to an appropriate recipient. These are separate effects. A standing containment grant may operate immediately under an admitted trigger, while a disclosure requires another qualifying basis. The speed requirement does not justify merging the two authorities.

An emergency contract identifies the protected interest, trigger evidence, responsible owner, target set, permitted operation templates, maximum duration, budget, renewal ceiling, minimum necessary disclosure, affected parties and after-action duties. A false alarm must have bounded consequences and a recovery path. A delayed or unavailable reviewer may change availability under the profile but must not cause unlimited renewal.

**R-49-05 — Bounded emergency authority.** Emergency grants MUST constrain trigger, target, effect, duration, renewal and disclosure, and MUST record the basis and outcome of each exercise. They MUST NOT create arbitrary code execution, new signers, global shutdown or general investigative authority as an implicit consequence of urgency.

The admitted protective templates are FREEZE_EGRESS, ISOLATE_CELL, REVOKE_SESSION, RATE_LIMIT, PRESERVE_EVIDENCE and ENTER_SAFE_STATE. Their implementation must account for physical safety and other affected interests. Freezing a hospital device's network path may have a different risk from freezing a document export. Priority must be governed by a declared safety and authority profile rather than a single severity score produced by SAI.

## 49.5 Notice, custody and institutional accountability

A record of process should identify the request, applicability evidence, approvals, extraction specification, produced output, delivery boundary, custody changes and notice status. Protected content need not be exposed in every audit record. Commitments and selective review can preserve accountability while limiting disclosure. Steles witnesses scoped receipts; it does not judge whether the underlying institutional decision was lawful.

**R-49-06 — Notice and review continuity.** Legal-process and emergency workflows MUST preserve their admitted notice, custody and review obligations across task closure, failure and institutional handoff. Delayed notice MUST have a qualifying basis and explicit expiry or review condition, with unresolved delivery reported honestly.

A sealing condition may limit who can see the request or notice obligation. Authorized oversight must still be able to inspect the status permitted by the profile. When the condition ends, the system needs an accountable owner to deliver notice; a terminated task must not make the obligation disappear. Notice submission, recipient acknowledgment and satisfaction of a legal condition remain distinct claims.

Institutional compromise is a residual risk. A malicious qualified signer may submit a formally valid but wrongful request. Colluding reviewers may approve it. A coercive physical operator may interfere with the endpoint. Architectural separation can constrain scope and preserve evidence, but cannot guarantee a remedy where the surrounding institutions are captured. Assurance must identify those assumptions candidly.

## 49.6 Operational example and acceptance

A records custodian receives a narrowly scoped demand to preserve and later disclose specified account records. Preservation is admitted first and prevents ordinary deletion of the identified objects. It does not permit the requesting party to read them. A separate applicability decision admits an extract, excludes unrelated records and binds the output to a qualified recipient. The receiver accepts the sealed package into a restricted matter realm. A contest concerning one category suspends that portion according to the operative rule; the others proceed only if independently separable. Notice remains deferred under a time-limited condition and is tracked to later delivery.

**R-49-07 — Explicit legitimacy and enforcement limits.** Legal-process assurance MUST distinguish verified procedure, technical enforcement, institutional judgment and residual abuse risks. A deployment MUST NOT describe architectural conformance as proof that every order, emergency declaration or disclosure is substantively legitimate.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-49-01 | Submit a valid signature from an issuer lacking qualification for the requested matter or scope; no compulsory grant is installed. |
| T-49-02 | Exercise a preservation-only grant; retention changes but the requesting party cannot read or export the preserved payload. |
| T-49-03 | Introduce an operative stay on one separable category; that category cannot cross finality while others follow their own admitted rule. |
| T-49-04 | Demand decryption without an available admitted key path; the system reports inability and does not create broader recovery authority. |
| T-49-05 | Trigger an emergency repeatedly near expiry; duration and renewal ceilings remain enforced and unrelated data stays protected. |
| T-49-06 | Close the extraction task before delayed notice becomes due; the obligation survives and has an accountable delivery outcome. |
| T-49-07 | Model a compromised qualified signer; the assurance record identifies the remaining institutional dependency rather than declaring the action legitimate by construction. |

The requirements here are ASKA design rules. Format and signature standards cited in the schema chapter can validate representations; they do not supply jurisdiction-specific authority or settle a disputed legal interpretation.
