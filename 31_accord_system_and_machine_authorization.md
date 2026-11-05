# ASKA v6 — Accord system and machine authorization

## 1. Position in the physical machine

Accord connects human and institutional authority to the resources and consequence boundaries of ASKA. It describes why an operation may be admitted, what must remain forbidden, who may receive its result, and what evidence must survive execution. The physical machine remains the enforcement foundation: an IES owns its execution and writable memory; a cell receives bounded views and handles; a persistent object owner or effect owner checks the operation where its consequence becomes final. An Accord document cannot replace those boundaries.

The suite comprises CLAIM, CONTRACT, GRANT and RECEIPT, with PACT for negotiation and admission. IDENT, RELATE, PROFILE, LEGAL, CIVIC and WITNESS supply typed evidence and procedures. These names denote semantics. They do not require a separate daemon per module, a worldwide contract service, or one administrator able to install rights everywhere. A deployment MAY combine implementation functions only when its assurance statement records the resulting shared failure domain.

**R-31-01 — Separate evidence, decision, authority and outcome.** Implementations MUST preserve the chain CLAIM → CONTRACT → GRANT → RECEIPT. Parsing, signing, witnessing or accepting a CLAIM MUST NOT itself change executable authority. A contract is an admitted decision only after its admission prerequisites hold; a grant is usable only after the responsible local installer accepts it.

The distinction survives apparent convenience. A professional credential may qualify someone to request a medical operation. It does not name the patient's object, supply consent or other applicable basis, reserve storage, or authorize a recipient. A security finding may justify considering a port freeze. It is neither a freeze command nor permission to export the affected person's memory. A payment receipt can establish a named bank's reported disposition without proving that purchased goods arrived.

[The confused-deputy problem](https://doi.org/10.1145/54289.871709) motivates keeping a coordinator's own power distinct from a caller's grant. [Saltzer and Schroeder](https://web.mit.edu/Saltzer/www/publications/protection/) already prescribe economical, completely mediated mechanisms; [Clark and Wilson](https://doi.org/10.1109/SP.1987.10001) show why commercial integrity requires more than confidentiality. The evaluator and grant compiler are trusted interpreters of these obligations and must be included in the failure analysis.

## 2. Independent roles and their interfaces

| Role | Input and output | Authority boundary |
|---|---|---|
| Proposer | Intent and candidate action → bounded proposal | May request only; cannot install |
| Qualified issuer | Evidence and mandate → scoped claim | Qualification is evaluated for this claim kind |
| Evaluator | Claims, profiles, restrictions → decision and reason graph | Does not own every affected resource |
| Approver | Canonical terms → digest-bound approval or refusal | Signs under an actual role and basis |
| Installer | Admitted contract and live local state → attenuated grant | Controls only delegated tables and resources |
| Source owner and exporter | Admitted source view → exact authorized representation | Reading does not imply release |
| Recipient owner | Independently accepted operation → publication or effect | Foreign grants are evidence until locally admitted |
| Witness | Authorized commitments → checkpoint and qualified audit evidence | Does not decide permission or inspect all plaintext |

**R-31-02 — Preserve independent consequence checks.** Every participating owner MUST check its own current operation, object generation, grant epoch, restrictions and budget at its named finality point. Source release, transport, receive publication and downstream business effects MUST remain separately authorized. A successful upstream check MUST NOT stand in for a downstream one.

The evaluator's output is therefore a request to several local protection boundaries, not a universal capability. A receiver can reject a valid source disclosure because it lacks storage, rejects the schema, has revoked the session, or cannot satisfy retention obligations. Conversely, receiver willingness cannot remove a source confidentiality label. An operation spanning realms can leave source release committed while remote publication remains uncertain. The [effect contract](17_transactions_effects_and_reconciliation.md) defines how those separate outcomes are recorded.

## 3. Action-specific evaluation

An action is a tuple of actor, operation, object selectors and generations, stable input commitments, recipients, purpose, plane, context, time bounds, resource budget and proposed output. Evidence is evaluated against that tuple. A decision about one invoice does not authorize all future invoices; a retention duty does not authorize arbitrary searches of retained records.

Let Γ contain pinned profiles, verified claims, relationship proofs, current revocation evidence, resource state, time bounds, source restrictions and recipient policy. The evaluator derives one of `ALLOW`, `ALLOW_WITH_OBLIGATIONS`, `DENY`, `SUSPEND`, `ESCALATE` or `UNAVAILABLE`. These are evaluation dispositions, separate from the PACT lifecycle and effect states. Every decision includes reason codes, a decision-time basis, profile digests, missing prerequisites and the responsible review path where applicable.

**R-31-03 — Expose unresolved authority.** An evaluator MUST use an explicit pending, escalation or unavailable disposition when applicable evidence is contradictory, required interpretation is absent, or execution is technically inaccessible. It MUST NOT invent a total ranking of governments, employers, families and individuals or convert compelled conduct into voluntary consent.

Evaluation first validates encoding and issuer purpose, then determines applicable profiles, currentness, delegation and exclusions. It evaluates negative restrictions independently, computes effect and disclosure obligations, and requests the approvals actually required by the applicable procedure. The installer then checks whether every machine obligation can be enforced. `ALLOW_WITH_OBLIGATIONS` is not permission to omit an obligation because the implementation lacks the necessary gate. Such an implementation returns `cannot_enforce_obligation`.

## 4. Confinement and controlled release

Confidentiality and integrity are separate from societal purposes. Sanctum, Polis, Agora and Wilder are relationship contexts, not an ordered trust lattice. A business record can be more restricted than a civic publication; a public notice can be authentic yet false. The [information-flow contract](07_information_flow_and_release.md) defines conservative propagation, explicit realm mappings and release obligations.

**R-31-04 — Keep source restrictions independent of destination choice.** Computation, encryption, logging, indexing, AI inference and representation changes MUST retain applicable source restrictions unless an authorized release process approves a specified transformation and output. Destination acceptance MUST NOT serve as declassification or semantic endorsement.

An approved report must identify the source versions, transformation revision, output commitment, recipient and residual observations. A digest comparison prevents substitution after approval; it cannot establish that the report is safe when the semantic approver is compromised. Repeated query values, error behavior, timing and output size can disclose information even when each field matches its schema. A grant compiler must preserve aggregate limits and observation assumptions instead of treating a schema as a complete confidentiality proof.

## 5. Standing authority and protective operation

Routine work and urgent protection need not invoke a person for every call. A standing contract can authorize reading a named collection, creating drafts in a named workspace, or applying a bounded protective template. Its authority must already exist before the event triggers execution. The event supplies a predicate value; it does not create a new signer or widen the target set.

**R-31-05 — Bound preauthorized protective effects.** Protective execution MUST use an installed standing grant naming an allowed template, exact target set, trigger evidence class, owner, priority, duration and renewal ceiling, resource budget, affected interests and receipt obligations. An anomaly score MUST NOT create arbitrary code execution, global shutdown, root replacement or forensic disclosure authority.

The canonical templates are `FREEZE_EGRESS`, `ISOLATE_CELL`, `REVOKE_SESSION`, `RATE_LIMIT`, `PRESERVE_EVIDENCE` and `ENTER_SAFE_STATE`. Their detailed safety behavior belongs to [protective response](26_protective_response_and_containment.md). Containment and disclosure are separate effects: isolating a workload does not authorize sending its secrets to an analyst. A false alarm can still produce harmful in-scope denial of service, so duration, renewal and appeal are meaningful constraints, not optional annotations.

## 6. Bounded admission and accountable failure

**R-31-06 — Bound evaluation and installation work.** Admission MUST impose finite limits on message size, evidence depth, proof work, negotiation rounds, pending state and reserved resources. A denial or timeout MUST release only reservations known to remain unconsumed and MUST disclose no more decision detail than the caller is entitled to receive.

Attackers can submit validly signed but irrelevant claims, cyclic relationship graphs, expensive proofs and repeated status probes. They can also exploit distinctions in errors to discover private relationships. The admission frontier therefore uses bounded parsing and protected quotas before expensive interpretation. A permitted issuer's availability failure does not imply revocation, validity or permission to bypass currentness checks. Offline use requires an explicit lease and a declared staleness risk.

**R-31-07 — Make authority provenance inspectable without universal exposure.** Each admitted contract MUST retain a reconstructible, access-controlled reason graph identifying relevant evidence, exclusions, decisions, approver roles and installed scope. Auditors MUST receive only the views their own contracts permit; administrative inspection MUST NOT imply access to every participant's identity or data.

## 7. Trusted evaluator and grant compiler

The evaluator and compiler belong to the transitive trusted computing base for any grant they cause to be installed. A mathematically correct attenuation check against a **wrongly admitted contract** does not repair a semantic error: a compiler can install a narrow grant for a contract whose object scope or consenting party was misread. Signing the result only authenticates that mistake.

Admission uses a versioned, finite grammar for evidence and contract predicates. An implementation profile supplies positive upper bounds for `B_input` (encoded bytes), `N_claim` (claims), `N_edge` (relationship edges), `D_proof` (dependency depth), `W_eval` (evaluation work), `Q_pending` (outstanding decisions), and `B_grants` (installed entries). Parsing, graph expansion and profile selection reject exhaustion before an unbounded step or allocation; cyclic dependencies terminate without grant creation. The exact values are deployment parameters and are not supplied by this architecture. Critical fields and operations admit one canonical interpretation; unknown values deny installation.

The compiler emits a canonical contract digest, immutable provenance identifiers and candidate owner-specific rights. At the protected owner, a small **grant verifier** validates type, object generation, operation set, restrictions, recipient, duration and non-additive budgets against the admitted contract and local standing ceilings. The verifier operates on canonical fields rather than compiler-provided descriptions and rejects any unsupported obligation. This second check limits compiler mistakes; it cannot prove an institution's authority or a person's comprehension. The profile therefore declares the semantic evaluator, approved policy grammar, qualified issuers and any trusted human judgment as distinct failure assumptions.

For each deployable profile, the assurance dossier measures the **transitive** trusted base: executable size and update roots of parser, evaluator, policy/role interpreter, compiler, grant verifier, local installer, recovery logic and privileged dependencies; the mutable state and privilege edges for each; worst-case admission memory and work; and the number of shared installation/reset paths. A complexity ceiling is set before qualification and justified against a simpler guarded alternative. A candidate that exceeds its ceiling is rejected or assigned a weaker assurance claim, not silently exempted because its functions reside in different processes.

**R-31-08 — Independently check canonical grant bounds at the owner.** The local owner MUST reject any candidate grant whose canonical fields exceed the admitted contract, active exclusions, object generation, installer ceiling or enforceable obligations. Compiler output, provenance signatures and evaluator success MUST NOT bypass this check.

**R-31-09 — Publish and enforce a transitive TCB budget.** A qualified implementation MUST pin finite admission limits and a profile-specific trusted-component budget, including evaluation grammar, dependency roots and privileged state. Exceeding a limit MUST block promotion or installation without widening authority.

## 8. Operational example and acceptance obligations

A supplier delivers an invoice into Wilder. A disposable parser produces a candidate amount and account identifier. Agora separately retrieves the purchase order and checks the supplier relationship. A user companion proposes settlement, but an approved account directory supplies the recipient binding. Keystone shows the amount, currency, account, fees, permitted source fields and actual authority basis. The local payment owner installs a one-use grant, charges its protected allowance with submission finality, and records a receipt. A lost bank response leaves bank settlement uncertain while the local submission receipt remains committed. Reconciliation queries the named bank operation before any retry.

The following are specified tests, not reported execution results.

| Oracle | Required observation |
|---|---|
| T-31-01 | Feed a valid claim directly to every installation interface; no grant-table change occurs without an admitted contract and authorized installer. |
| T-31-02 | Accept source release but revoke the destination before publication; destination publication is denied and the source receipt remains unchanged. |
| T-31-03 | Present conflicting qualified instruments with no precedence procedure; obtain SUSPEND or ESCALATE with no executable grant. |
| T-31-04 | Approve reception of a secret-derived summary without source release; egress remains denied even if the recipient labels it public. |
| T-31-05 | Supply an authentic false alarm outside a standing template's target or lifetime; no protective effect occurs outside the installed scope. |
| T-31-06 | Submit a cyclic, oversized evidence graph; work and retained state stay within declared bounds and protected useful service continues. |
| T-31-07 | Give an auditor receipt access without relationship access; it verifies the scoped outcome without obtaining the complete proof graph. |
| T-31-08 | Corrupt compiler output to add a different recipient, expired generation, wider budget or missing obligation; owner verification rejects every overbroad grant while admitting an unchanged control. |
| T-31-09 | Submit validly signed but oversized and cyclic graphs, then alter the privileged dependency inventory; bounded rejection occurs and the qualification dossier fails until the added root and costs are evaluated. |

## 9. Standards comparison and limits

[Macaroons](https://research.google/pubs/macaroons-cookies-with-contextual-caveats-for-decentralized-authorization-in-the-cloud/) already support attenuation through contextual caveats; the distinct ASKA question is whether a local owner can enforce each admitted consequence. The [W3C ODRL Information Model 2.2](https://www.w3.org/TR/odrl-model/) distinguishes permissions, prohibitions, duties and constraints. It is a useful vocabulary comparison, not an ASKA enforcement implementation or a determination of applicable law. [OAuth Rich Authorization Requests, RFC 9396](https://www.rfc-editor.org/rfc/rfc9396) provides a comparison for structured action details. Accord additionally requires independently installed resource authority and explicit consequence finality. Neither source establishes whole-system physical confinement.
