# ASKA v6 — Authority schemas and PACT state machines

## Type discipline and common envelope

This chapter owns the canonical Accord object fields. A protocol profile selects one registered wire revision and publishes its complete schema, bounds and encoding rules. Implementations must distinguish absence, an explicit null value and an empty collection. They cannot infer policy from an omitted field or from a field name supplied by untrusted content.

**R-28-01 — Bind the complete typed envelope.** Every Accord object MUST carry `schema_version`, `type`, `id`, `issuer`, `audience`, `realm_id`, `object_ref`, `subject_ref`, `operation`, `constraints`, `policy_epoch`, `issued_at`, `expires_at`, `nonce`, `evidence_refs`, `body`, `critical_fields` and `signature`; every signed object MUST integrity-bind all authority-relevant content under a type-specific signing context. Where a type has no single object, subject or operation, the schema MUST require an explicit null and define its meaning.

| Common field group | Required interpretation |
|---|---|
| `schema_version`, `type` | Exact registered semantics; no inference from display text |
| `id`, `nonce` | Opaque identifiers with declared uniqueness scope and replay behavior |
| `issuer`, `audience`, `realm_id` | Scoped principal/key reference, intended verifiers and governing realm |
| `object_ref` | `(realm_id, owner_id, object_id, generation)` plus registered object type where required |
| `subject_ref` | Scoped person, institution, device or cell principal; a cell also binds `cell_epoch` |
| `operation`, `constraints` | Registered method and typed parameter/flow limits |
| `policy_epoch`, time bounds | Pinned policy context and explicitly qualified clock or lease semantics |
| `evidence_refs` | Typed digest references with access policy and retrieval bounds |
| `body`, `critical_fields` | Type-specific data and fields whose semantics the verifier must understand |
| `signature` | Algorithm-suite identifier, key reference and signature bytes; no authority implied by key possession alone |

Identifiers are never raw addresses. A profile declares widths, overflow behavior and rollback protection for object generations, grant epochs, boot epochs, observer epochs and counters. An implementation must retire an identity namespace before wrap could make an old handle live again.

## Encoding and cryptographic binding

**R-28-02 — Reject ambiguous or incomplete signed meaning.** A verifier MUST reject duplicate keys, unknown critical fields, unsupported suites, noncanonical encodings under its selected profile, invalid text encodings, out-of-range integers and inconsistent redundant bindings. All authority-relevant fields MUST be integrity protected; unprotected header hints MUST NOT select a more privileged interpretation.

The reference encoding candidate is deterministic CBOR using RFC 8949 section 4.2.1, supplemented by an ASKA schema that disallows indefinite forms, floats for money and counters, alternative encodings of the same identifier, and unregistered semantic tags. Textual aliases are display values; stable identifiers use an exact byte representation. Currency amounts use integer minor units and a currency/scale identifier. Time carries an interval and source classification where uncertainty matters. The profile specifies length and nesting limits before allocation.

A COSE profile may use COSE_Sign1 or a registered multisignature structure, with the Accord type and schema context bound through the signed payload or protected external context. Merely calling an object COSE does not make its payload deterministic or its issuer qualified. A signature context must distinguish claims, contracts, grants, receipts, approvals, releases and witness checkpoints. The exact framing must be length-delimited; concatenated strings with ambiguous boundaries are invalid. Signature input excludes the signature byte value itself. Algorithm and key selection, type context, payload and protected external context must be authenticated as prescribed by the selected suite; serialization wrappers cannot introduce unsigned authority semantics.

## CLAIM: attributed evidence

**R-28-03 — Keep claims evidentiary.** CLAIM bodies MUST contain `claim_kind`, `predicate`, `scope`, `validity`, `revocation_ref`, `issuer_qualification`, `supporting_evidence`, `disclosure_policy` and `profile_context`. Validation MUST establish only the attributed predicate and its qualified scope, never resource authority absent a separately admitted contract.

Registered claim kinds include `FACT`, `ROLE`, `DELEGATION`, `DUTY`, `PROHIBITION`, `CONSENT`, `ORDER`, `CAPACITY`, `ATTESTATION` and `REVOKE`. Each kind has distinct issuer and applicability rules. An attestation predicate names measurements and appraisal policy. An order predicate names the instrument and its procedural scope. A consent predicate identifies the information shown, purpose, recipient, duration and approval evidence; it cannot label a compelled action voluntary. Relationship or capacity assertions include activation and contestation evidence where relevant.

A claim reference can point to sealed evidence. Its verifier receives only a permitted presentation, with the proof scheme, holder binding, audience and challenge declared. Fetching a reference is a separately bounded operation; a malicious URL cannot force an evaluator to access private endpoints. Repeated status checks must account for privacy and availability of the status service.

## CONTRACT: admitted terms and obligations

**R-28-04 — Preserve all contract constraints.** CONTRACT bodies MUST bind `proposal_digest`, `participants`, `source_bindings`, `recipient_bindings`, `authority_basis`, `profile_refs`, `evidence_graph_digest`, `decision`, `dissent`, `output_contract`, `release_refs`, `budgets`, `approvals`, `obligations`, `notice_contract`, `challenge_route`, `audit_class`, `finality_points` and `admission_record`. Installation MUST fail if a required constraint lacks an enforceable interpretation.

`authority_basis` is a typed list rather than one boolean: consent, legal duty, contractual obligation, institutional instruction, emergency exception or a registered profile basis may coexist for different parts of a transaction. `decision` uses the evaluation dispositions in [Accord authorization](27_accord_system_and_machine_authorization.md). `dissent` records an attributed objection and any recognized stay without equating disagreement with automatic invalidity. `admission_record` binds the PACT transcript and the responsible admission authority. Before admission, a CONTRACT-shaped candidate uses explicitly defined pending or null values for unavailable decision and admission fields and empty approval collections where appropriate. Such a candidate carries no installation authority; every mandatory predicate and constraint must be resolved before a positive grant can be compiled. An admitted revision is immutable, while a counteroffer creates a new revision and digest.

Each obligation identifies its subject, required action, trigger, deadline, permitted evidence, responsible enforcer and failure behavior. Preservation, disclosure and notice are separate obligations. A condition requiring future notice cannot be represented as a promise by an entity that has no delivery capability or retained address. A rejected or unavailable decision may be retained as a signed decision object, but it is never a basis for a positive grant.

## GRANT: installed local authority

**R-28-05 — Make grants local, attenuated and live.** GRANT bodies MUST bind `contract_digest`, `grant_id`, `grant_epoch`, `installer`, `executor_ref`, `object_bindings`, `method`, `parameter_bounds`, `recipient_binding`, `plane_interface`, `release_binding`, `budget_parent`, `reservation_ref`, `use_state_ref`, `lease`, `revocation_refs`, `receipt_policy` and `installation_evidence`. The installed scope MUST be a subset of the admitted contract and all parent delegations.

A grant may be represented by an unforgeable local handle rather than portable signed bytes. Exporting a representation is not importing authority: the destination validates it as evidence and makes its own installation decision. `executor_ref` identifies the cell and epoch or the protected service allowed to invoke the method. Object selectors are resolved to admissible generations or a precisely bounded dynamic selector controlled by the owner. A broad text prefix such as “all relevant files” is not a resolved selector.

Budget consumption is held in protected state. Copying a handle does not duplicate credit. Sibling grants reference a shared budget owner or obtain disjoint escrowed credits before disconnection. The final owner serializes consumption with its finality point where implementable. Merely signing an integer balance is insufficient to prevent double use.

## RECEIPT: qualified outcome evidence

**R-28-06 — Scope receipts to an owner and finality point.** RECEIPT bodies MUST contain `effect_id`, `idempotency_key`, `grant_ref`, `object_ref`, `source_binding`, `destination_binding`, `event_kind`, `effect_state`, `finality_point`, `outcome`, `owner_epoch`, `effect_counter`, `evidence_refs`, `uncertainty_reason`, `witness_commitment` and `predecessor_receipt_refs`. An outcome MUST NOT claim another owner's finality without attributable evidence from that owner.

`effect_state` is one of PROPOSED, PREPARED, COMMITTED, RECONCILED, DENIED, ABORTED or UNCERTAIN. `event_kind` describes the observed phase, such as requested, approved, installed, source released, receiver published, notice attempted or correction recorded. These descriptive events do not create a second effect-state machine. A receipt for approval proves no execution. A source-release receipt proves no remote acceptance. COMMITTED means the named finality point was crossed under its declared durability or physical contract.

Once a particular finality is established as COMMITTED, it is not changed to UNCERTAIN because a later downstream outcome is unknown. A separate downstream effect carries that uncertainty. Reconciliation appends evidence or correction referencing the original receipt; it never rewrites history. An ABORTED receipt is valid only when no final effect escaped. If a device may have acted before a crash, the service must use UNCERTAIN until reconciliation can establish the relevant outcome.

## Release and label bindings

**R-28-07 — Encode independent confidentiality and integrity.** Labels MUST encode confidentiality `C=(realm, compartments, recipients, purpose, retention)` and integrity `I=(source class, transformations, evidence confidence)` under declared partial orders. A release binding MUST identify source labels and versions, authorized transform and revision, exact output commitment or checked output relation, resulting labels, destination, observation profile, leakage statement and aggregate-use allowance.

No universal numeric trust score orders those labels. A transformation may validate an image's dimensions while leaving its depicted event unverified. A recipient may accept low-integrity data while lacking permission to receive its confidentiality class. Encryption preserves the plaintext's restrictions; a permitted encryption key is not a release grant. For opaque transfers, the contract explicitly records what semantic properties cannot be checked.

## Resource and privacy rules

**R-28-08 — Resolve every required budget dimension.** Method schemas MUST name all required dimensions, including applicable calls, bytes, records, memory, fuel, duration, rate and value. Admission MUST reject unresolved or omitted dimensions. An explicit unbounded dimension is permitted only when the governing profile specifically authorizes it and states the resulting risk; it is never inferred from null or omission.

**R-28-09 — Minimize linkable protocol metadata.** Public envelopes and error responses MUST expose only the identifiers and predicates needed by their audience. Sensitive identity, relationship, legal-matter and source-selector information MUST be placed behind access-controlled references or protected representations. Commitments to predictable values MUST use a construction that addresses dictionary guessing and audience correlation.

**R-28-10 — Pin revisions and fail explicit incompatibility.** Negotiation MUST pin schema revisions, suites, profiles, critical extensions and their digests. An incompatible peer MUST receive a bounded `profile_mismatch` or `cannot_enforce_obligation` result. A weaker alternative requires a separately authorized contract; historical receipt verification MUST NOT silently enable obsolete credentials for new effects.

## Illustrative operation and schema tests

A payment contract might bind an invoice generation, one supplier account, an integer amount, a finance approver, a one-use budget, a deadline and a bank-submission finality. Its grant would additionally bind the executing cell, local payment owner epoch and protected allowance. The resulting receipt would identify submission COMMITTED while a separate settlement receipt remains UNCERTAIN. Names such as `invoice-7` in this explanation are placeholders; production identities use the declared opaque types.

| Oracle | Required observation |
|---|---|
| T-28-01 | Alter audience, type or object generation without resigning; signature or semantic validation fails before installation. |
| T-28-02 | Submit duplicate-map keys, alternative integer encodings, unknown critical fields and contradictory redundant bindings; all are rejected before allocating unbounded state. |
| T-28-03 | Present a qualified role claim with no contract; no protected method becomes callable. |
| T-28-04 | Remove a negative restriction or notice obligation during grant compilation; non-expansion checking rejects installation. |
| T-28-05 | Copy a one-use handle to two cells; at most one local finality consumes the shared protected allowance. |
| T-28-06 | Lose a remote acknowledgement after local submission; retain the committed local receipt and create only a separately scoped uncertain remote outcome. |
| T-28-07 | Request a public label for encrypted secret-derived data without release authority; the label transition is denied. |
| T-28-08 | Omit a required byte or invocation ceiling; admission fails rather than supplying infinity. |
| T-28-09 | Compare public receipts for predictable private predicates; the stated commitment/privacy mechanism must prevent the specific declared guessing/linking attack. |
| T-28-10 | Negotiate an unknown critical extension or outdated suite; no silent downgrade or active grant results. |

## Standards comparison and limits

[RFC 8949](https://www.rfc-editor.org/rfc/rfc8949), section 4.2, defines deterministic CBOR choices; [RFC 9052](https://www.rfc-editor.org/rfc/rfc9052), sections 3–4, defines COSE headers and signature structures. Neither specifies ASKA's application schema or issuer qualification. [W3C Verifiable Credentials Data Model 2.0](https://www.w3.org/TR/vc-data-model-2.0/) provides an interoperable evidence model with issuer, holder and verifier roles. Credential verification must remain distinct from ASKA resource admission. All byte-level vectors, limits and implementation claims require separate conformance evidence.

## None

PACT is the protocol by which parties negotiate bounded terms, present qualifying evidence, obtain local admission decisions, install grants and reconcile consequences. It is not a consensus protocol that makes every participant share one legal judgment. A clinician, a patient, a records custodian and a public authority can participate in one exchange while retaining different obligations, evidence visibility and machine owners. A contract becomes executable only at those owners whose admission rules it satisfies. Agreement between people and installation in machines are separate events.

The object vocabulary is defined in [Claim, contract, grant and receipt schemas](28_authority_schemas_and_pact_protocol.md); the authority calculus is defined in [Authority calculus and nonexpansion](06_authority_calculus_and_nonexpansion.md). PACT carries references to those objects without enlarging them. It supports interactive negotiation, scheduled transactions and preauthorized protective action. A standing response grant can remain valid without a new negotiation on every alarm, but its trigger, targets, budget and expiry remain enforceable.

### Participants and transcript identity

A session identifies a proposer, the relevant source owners, destination owners, qualifying authorities, approvers and optional witnesses. One principal may hold several roles only when the selected profile permits that combination. The transcript records which role supported each signature. Receiving a message does not assign a role to its sender, and possession of a network identity does not qualify a signer to approve a disclosure or operate a resource.

The session identifier binds a realm, session generation, participant references and protocol version. Every message carries its type, sequence or causal predecessor, sender role, recipient, contract digest, challenge binding, expiry and authenticated origin. A recipient maintains a replay window and a durable terminal marker when subsequent reactivation would be dangerous. A message from a previous boot, grant epoch or abandoned counteroffer cannot silently revive authority.

**R-28-11 — Transcript binding.** A PACT implementation MUST bind every approval, admission and installation to the exact contract revision, participant roles, selected profiles, audience and freshness challenge. A changed recipient, object generation, operation, budget or release transformation MUST invalidate affected approvals and require a new decision.

The transcript need not expose every underlying claim to every party. A custodian can return a signed applicability result or a narrowly scoped credential presentation while retaining confidential evidence. Such a result must identify what was checked, by whom, under which profile and with what expiry. A bare assertion that a hidden policy was satisfied is usable only if the admitting owner explicitly accepts that attester for that predicate.

### Canonical contract states

The states below describe the contract's protocol lifecycle. They do not describe whether an external payment settled or a physical actuator moved.

| State | Meaning and permitted continuation |
|---|---|
| DRAFT | Local candidate terms; no recipient commitment. It may become OFFERED or be discarded. |
| OFFERED | A bounded proposal has been delivered. It may be COUNTERED, AGREED, DENIED or CONTESTED. |
| COUNTERED | A new revision proposes changed terms. Earlier signatures are retained as history, not reused for the new revision. |
| AGREED | Required parties accepted the same revision. Agreement alone installs no rights. |
| ADMITTED | Identified local owners accepted the evidence and terms for installation. Admission has a finite validity window. |
| ACTIVE | Applicable grants are installed at the named local owners. This says nothing about completion at an unlisted owner. |
| SUSPENDED | Future exercise is temporarily blocked under a specified condition. Resumption requires fresh admission where relevant facts changed. |
| REVOKED | Identified grants or terms have been withdrawn for future exercise. Past irreversible consequences remain recorded. |
| EXPIRED | A validity boundary passed. Extension requires new qualifying terms, not a reset clock. |
| CLOSED | No further exercise is permitted; obligations such as retention or notice may continue separately. |
| DENIED | The attempted agreement or admission failed with a scoped reason. |
| CONTESTED | A declared dispute or review path is active; its effect on exercise is determined by the applicable stay rule. |

**R-28-12 — State separation.** Implementations MUST distinguish agreement, local admission, local installation and effect finality. ACTIVE MUST enumerate the owners and grant references to which it applies; it MUST NOT imply that all remote parties installed grants or that any requested real-world outcome occurred.

DENIED and CONTESTED are branches, not an authorization shortcut. A contest may suspend execution where a profile requires a stay, or proceed in parallel with an independently applicable duty where a valid profile allows that treatment. The machine must record the governing rule. Neither a universal “appeal always blocks” rule nor a universal “orders always win” rule is adequate.

### Exchange and admission

The logical exchange contains proposal, challenge, evidence, offer or counteroffer, approval, local admission, installation and receipt messages. A profile can combine transport messages, but cannot remove the distinct checks they represent. Challenges state the missing predicates and acceptable evidence types rather than requesting every available identity attribute. Negotiation has limits on rounds, evidence volume, computation, elapsed time and outstanding sessions. An adversary cannot force unlimited proof search by repeatedly offering slightly different credentials.

Before admission, an owner resolves the selected profile versions, evaluates qualifying evidence, checks explicit prohibitions and obligations, determines whether each requested resource is within its jurisdiction, and computes an attenuated grant. Admission records assumptions that must be rechecked at finality: revocation status, object generation, capacity activation, destination acceptance, remaining budget and required current presence. A long negotiation does not freeze those facts.

**R-28-13 — Bounded and fresh admission.** Every admission MUST have finite evidence, computation and validity bounds. The consequence owner MUST recheck the predicates designated as finality-sensitive immediately before effect finality, using the permitted freshness policy. A timeout or unavailable status service MUST produce the declared unavailable, denied or suspended result rather than implicit permission.

An admission decision may reserve resources. A reservation is not a commitment to perform the effect and needs its own expiry and release rule. Reservation failure must not leak protected data through elaborate error distinctions. Local denial may return a coarse public reason while an authorized reviewer receives a more detailed private explanation.

### Installation and effect execution

Installation creates a GRANT at a specific enforcing owner and returns evidence that this owner accepted that grant generation. A signed admission message sent to a machine is not proof of installation. The local guard verifies the request, checks compatible schema and policy versions, commits the installation under its durability contract and returns a receipt. Restart recovery must distinguish an installation known to be durable from one whose acknowledgment was merely in flight.

**R-28-14 — Installation receipt.** A machine MUST expose authority only after the applicable local grant installation succeeds. Its receipt MUST identify the enforcing owner, grant and policy epochs, admitted bounds and durability class. Lost installation acknowledgments MUST be resolved by authenticated status or idempotent installation, never by assuming a second independent grant is harmless.

Effects then use the common states PROPOSED, PREPARED, COMMITTED and RECONCILED, with DENIED, ABORTED and UNCERTAIN as defined in [Transactions, effects and reconciliation](17_transactions_effects_and_reconciliation.md). The effect owner checks and consumes one-use authority at its named local finality point where the realization can make those operations atomic. A transaction spanning owners requires explicit coordination semantics. PACT does not manufacture a globally atomic physical action.

**R-28-15 — Scoped finality and retry.** Retries MUST retain the same effect identity and idempotency binding when they seek the same consequence. COMMITTED MUST name the established finality point and MUST NOT revert to UNCERTAIN for that same established event. An unresolved downstream outcome MUST be represented separately; an attempted effect whose finality cannot be established MUST remain UNCERTAIN until reconciliation supplies evidence.

ABORTED is valid only if no final effect escaped. Compensation is a new authorized effect: reversing a debit, sending a correction or returning a shipment does not erase the first event. Reconciliation adds evidence and links corrective actions without rewriting history.

### Revocation, partition and bounded standing action

A revocation identifies its authority, target generation, scope, effective condition and propagation requirements. Each owner reports its observed revocation epoch and the effects that may have crossed finality before enforcement. During partition, a grant may continue only under an explicit offline lease and residual-risk policy. Otherwise unavailable status blocks further exercise. A network-wide statement that revocation was instantaneous is invalid unless the profile proves the relevant bounded propagation and clock assumptions.

**R-28-16 — Revocation enforcement.** An owner MUST prevent new finality under a grant once applicable revocation is effective locally, drain in-flight activity according to its effect semantics, and preserve receipts for consequences already committed. Offline use MUST be limited by an explicitly admitted lease, budget and reconciliation rule; absence of a revocation message MUST NOT mean permanent validity.

A standing protective contract follows the same discipline. FREEZE_EGRESS or ISOLATE_CELL may execute under an installed grant when an authorized trigger is met. The message cannot substitute arbitrary code, new signers, a broader target set or an indefinite duration. Suspension and resumption must not replenish an exhausted response budget unless an authorized renewal explicitly does so.

### Operational example and acceptance

A laboratory and an external analyst agree to release one aggregate result. The laboratory's source owner admits the specified aggregation and output commitment. The analyst's receiver independently accepts the format, provenance and local retention terms. The two installation receipts identify distinct grants. The computation can complete while receiver publication remains blocked by a local policy update; source authorization does not force acceptance. If a transfer acknowledgment is lost, the sender queries the existing effect identity. It does not create another release grant or claim the receiver displayed the result.

**R-28-17 — Recoverable and private protocol history.** PACT MUST preserve enough authenticated state to reject stale branches and reconcile uncertain actions, while exposing transcripts and explanations only to authorized recipients. Diagnostic access MUST NOT confer the underlying data access or release authority.

The following tests are conformance obligations, not reports of an implemented system.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-28-11 | Change only the destination or contract revision after approval; installation rejects the stale signature. |
| T-28-12 | Install at one of two owners; ACTIVE identifies that owner and the other remains unable to execute. |
| T-28-13 | Exhaust negotiation rounds or expire status during preparation; no finality occurs through the unavailable predicate. |
| T-28-14 | Crash between durable installation and acknowledgment; recovery returns the same grant identity and does not double its budget. |
| T-28-15 | Lose a remote acknowledgment after local submission commits; the local committed receipt persists and remote outcome stays separately unresolved. |
| T-28-16 | Revoke during a queued operation and partition another owner; outcomes respect each finality boundary and the admitted offline ceiling. |
| T-28-17 | Give a reviewer transcript access alone; protected payload retrieval and new effect execution still fail. |

PACT's exchanges are ASKA design requirements. Standard authorization formats can carry interoperable details, but do not establish these state transitions or atomicity. [RFC 9396, sections 2 and 11](https://www.rfc-editor.org/rfc/rfc9396) provides a useful comparison for structured authorization requests; its scope is OAuth authorization detail, not the physical consequence model specified here.
