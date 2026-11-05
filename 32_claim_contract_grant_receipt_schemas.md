# ASKA v6 — CLAIM, CONTRACT, GRANT and RECEIPT schemas

**Status:** proposed normative schema contract. Examples are semantic illustrations, not registered wire formats, signed packets or cryptographic test vectors.

## 1. Type discipline and common envelope

This chapter owns the canonical Accord object fields. A protocol profile selects one registered wire revision and publishes its complete schema, bounds and encoding rules. Implementations must distinguish absence, an explicit null value and an empty collection. They cannot infer policy from an omitted field or from a field name supplied by untrusted content.

**R-32-01 — Bind the complete typed envelope.** Every Accord object MUST carry `schema_version`, `type`, `id`, `issuer`, `audience`, `realm_id`, `object_ref`, `subject_ref`, `operation`, `constraints`, `policy_epoch`, `issued_at`, `expires_at`, `nonce`, `evidence_refs`, `body`, `critical_fields` and `signature`; every signed object MUST integrity-bind all authority-relevant content under a type-specific signing context. Where a type has no single object, subject or operation, the schema MUST require an explicit null and define its meaning.

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

## 2. Encoding and cryptographic binding

**R-32-02 — Reject ambiguous or incomplete signed meaning.** A verifier MUST reject duplicate keys, unknown critical fields, unsupported suites, noncanonical encodings under its selected profile, invalid text encodings, out-of-range integers and inconsistent redundant bindings. All authority-relevant fields MUST be integrity protected; unprotected header hints MUST NOT select a more privileged interpretation.

The reference encoding candidate is deterministic CBOR using RFC 8949 section 4.2.1, supplemented by an ASKA schema that disallows indefinite forms, floats for money and counters, alternative encodings of the same identifier, and unregistered semantic tags. Textual aliases are display values; stable identifiers use an exact byte representation. Currency amounts use integer minor units and a currency/scale identifier. Time carries an interval and source classification where uncertainty matters. The profile specifies length and nesting limits before allocation.

A COSE profile may use COSE_Sign1 or a registered multisignature structure, with the Accord type and schema context bound through the signed payload or protected external context. Merely calling an object COSE does not make its payload deterministic or its issuer qualified. A signature context must distinguish claims, contracts, grants, receipts, approvals, releases and witness checkpoints. The exact framing must be length-delimited; concatenated strings with ambiguous boundaries are invalid. Signature input excludes the signature byte value itself. Algorithm and key selection, type context, payload and protected external context must be authenticated as prescribed by the selected suite; serialization wrappers cannot introduce unsigned authority semantics.

## 3. CLAIM: attributed evidence

**R-32-03 — Keep claims evidentiary.** CLAIM bodies MUST contain `claim_kind`, `predicate`, `scope`, `validity`, `revocation_ref`, `issuer_qualification`, `supporting_evidence`, `disclosure_policy` and `profile_context`. Validation MUST establish only the attributed predicate and its qualified scope, never resource authority absent a separately admitted contract.

Registered claim kinds include `FACT`, `ROLE`, `DELEGATION`, `DUTY`, `PROHIBITION`, `CONSENT`, `ORDER`, `CAPACITY`, `ATTESTATION` and `REVOKE`. Each kind has distinct issuer and applicability rules. An attestation predicate names measurements and appraisal policy. An order predicate names the instrument and its procedural scope. A consent predicate identifies the information shown, purpose, recipient, duration and approval evidence; it cannot label a compelled action voluntary. Relationship or capacity assertions include activation and contestation evidence where relevant.

A claim reference can point to sealed evidence. Its verifier receives only a permitted presentation, with the proof scheme, holder binding, audience and challenge declared. Fetching a reference is a separately bounded operation; a malicious URL cannot force an evaluator to access private endpoints. Repeated status checks must account for privacy and availability of the status service.

## 4. CONTRACT: admitted terms and obligations

**R-32-04 — Preserve all contract constraints.** CONTRACT bodies MUST bind `proposal_digest`, `participants`, `source_bindings`, `recipient_bindings`, `authority_basis`, `profile_refs`, `evidence_graph_digest`, `decision`, `dissent`, `output_contract`, `release_refs`, `budgets`, `approvals`, `obligations`, `notice_contract`, `challenge_route`, `audit_class`, `finality_points` and `admission_record`. Installation MUST fail if a required constraint lacks an enforceable interpretation.

`authority_basis` is a typed list rather than one boolean: consent, legal duty, contractual obligation, institutional instruction, emergency exception or a registered profile basis may coexist for different parts of a transaction. `decision` uses the evaluation dispositions in [Accord authorization](31_accord_system_and_machine_authorization.md). `dissent` records an attributed objection and any recognized stay without equating disagreement with automatic invalidity. `admission_record` binds the PACT transcript and the responsible admission authority. Before admission, a CONTRACT-shaped candidate uses explicitly defined pending or null values for unavailable decision and admission fields and empty approval collections where appropriate. Such a candidate carries no installation authority; every mandatory predicate and constraint must be resolved before a positive grant can be compiled. An admitted revision is immutable, while a counteroffer creates a new revision and digest.

Each obligation identifies its subject, required action, trigger, deadline, permitted evidence, responsible enforcer and failure behavior. Preservation, disclosure and notice are separate obligations. A condition requiring future notice cannot be represented as a promise by an entity that has no delivery capability or retained address. A rejected or unavailable decision may be retained as a signed decision object, but it is never a basis for a positive grant.

## 5. GRANT: installed local authority

**R-32-05 — Make grants local, attenuated and live.** GRANT bodies MUST bind `contract_digest`, `grant_id`, `grant_epoch`, `installer`, `executor_ref`, `object_bindings`, `method`, `parameter_bounds`, `recipient_binding`, `plane_interface`, `release_binding`, `budget_parent`, `reservation_ref`, `use_state_ref`, `lease`, `revocation_refs`, `receipt_policy` and `installation_evidence`. The installed scope MUST be a subset of the admitted contract and all parent delegations.

A grant may be represented by an unforgeable local handle rather than portable signed bytes. Exporting a representation is not importing authority: the destination validates it as evidence and makes its own installation decision. `executor_ref` identifies the cell and epoch or the protected service allowed to invoke the method. Object selectors are resolved to admissible generations or a precisely bounded dynamic selector controlled by the owner. A broad text prefix such as “all relevant files” is not a resolved selector.

Budget consumption is held in protected state. Copying a handle does not duplicate credit. Sibling grants reference a shared budget owner or obtain disjoint escrowed credits before disconnection. The final owner serializes consumption with its finality point where implementable. Merely signing an integer balance is insufficient to prevent double use.

## 6. RECEIPT: qualified outcome evidence

**R-32-06 — Scope receipts to an owner and finality point.** RECEIPT bodies MUST contain `effect_id`, `idempotency_key`, `grant_ref`, `object_ref`, `source_binding`, `destination_binding`, `event_kind`, `effect_state`, `finality_point`, `outcome`, `owner_epoch`, `effect_counter`, `evidence_refs`, `uncertainty_reason`, `witness_commitment` and `predecessor_receipt_refs`. An outcome MUST NOT claim another owner's finality without attributable evidence from that owner.

`effect_state` is one of PROPOSED, PREPARED, COMMITTED, RECONCILED, DENIED, ABORTED or UNCERTAIN. `event_kind` describes the observed phase, such as requested, approved, installed, source released, receiver published, notice attempted or correction recorded. These descriptive events do not create a second effect-state machine. A receipt for approval proves no execution. A source-release receipt proves no remote acceptance. COMMITTED means the named finality point was crossed under its declared durability or physical contract.

Once a particular finality is established as COMMITTED, it is not changed to UNCERTAIN because a later downstream outcome is unknown. A separate downstream effect carries that uncertainty. Reconciliation appends evidence or correction referencing the original receipt; it never rewrites history. An ABORTED receipt is valid only when no final effect escaped. If a device may have acted before a crash, the service must use UNCERTAIN until reconciliation can establish the relevant outcome.

## 7. Release and label bindings

**R-32-07 — Encode independent confidentiality and integrity.** Labels MUST encode confidentiality `C=(realm, compartments, recipients, purpose, retention)` and integrity `I=(source class, transformations, evidence confidence)` under declared partial orders. A release binding MUST identify source labels and versions, authorized transform and revision, exact output commitment or checked output relation, resulting labels, destination, observation profile, leakage statement and aggregate-use allowance.

No universal numeric trust score orders those labels. A transformation may validate an image's dimensions while leaving its depicted event unverified. A recipient may accept low-integrity data while lacking permission to receive its confidentiality class. Encryption preserves the plaintext's restrictions; a permitted encryption key is not a release grant. For opaque transfers, the contract explicitly records what semantic properties cannot be checked.

## 8. Resource and privacy rules

**R-32-08 — Resolve every required budget dimension.** Method schemas MUST name all required dimensions, including applicable calls, bytes, records, memory, fuel, duration, rate and value. Admission MUST reject unresolved or omitted dimensions. An explicit unbounded dimension is permitted only when the governing profile specifically authorizes it and states the resulting risk; it is never inferred from null or omission.

**R-32-09 — Minimize linkable protocol metadata.** Public envelopes and error responses MUST expose only the identifiers and predicates needed by their audience. Sensitive identity, relationship, legal-matter and source-selector information MUST be placed behind access-controlled references or protected representations. Commitments to predictable values MUST use a construction that addresses dictionary guessing and audience correlation.

**R-32-10 — Pin revisions and fail explicit incompatibility.** Negotiation MUST pin schema revisions, suites, profiles, critical extensions and their digests. An incompatible peer MUST receive a bounded `profile_mismatch` or `cannot_enforce_obligation` result. A weaker alternative requires a separately authorized contract; historical receipt verification MUST NOT silently enable obsolete credentials for new effects.

## 9. Illustrative operation and schema tests

A payment contract might bind an invoice generation, one supplier account, an integer amount, a finance approver, a one-use budget, a deadline and a bank-submission finality. Its grant would additionally bind the executing cell, local payment owner epoch and protected allowance. The resulting receipt would identify submission COMMITTED while a separate settlement receipt remains UNCERTAIN. Names such as `invoice-7` in this explanation are placeholders; production identities use the declared opaque types.

| Oracle | Required observation |
|---|---|
| T-32-01 | Alter audience, type or object generation without resigning; signature or semantic validation fails before installation. |
| T-32-02 | Submit duplicate-map keys, alternative integer encodings, unknown critical fields and contradictory redundant bindings; all are rejected before allocating unbounded state. |
| T-32-03 | Present a qualified role claim with no contract; no protected method becomes callable. |
| T-32-04 | Remove a negative restriction or notice obligation during grant compilation; non-expansion checking rejects installation. |
| T-32-05 | Copy a one-use handle to two cells; at most one local finality consumes the shared protected allowance. |
| T-32-06 | Lose a remote acknowledgement after local submission; retain the committed local receipt and create only a separately scoped uncertain remote outcome. |
| T-32-07 | Request a public label for encrypted secret-derived data without release authority; the label transition is denied. |
| T-32-08 | Omit a required byte or invocation ceiling; admission fails rather than supplying infinity. |
| T-32-09 | Compare public receipts for predictable private predicates; the stated commitment/privacy mechanism must prevent the specific declared guessing/linking attack. |
| T-32-10 | Negotiate an unknown critical extension or outdated suite; no silent downgrade or active grant results. |

## 10. Standards comparison and limits

[RFC 8949](https://www.rfc-editor.org/rfc/rfc8949), section 4.2, defines deterministic CBOR choices; [RFC 9052](https://www.rfc-editor.org/rfc/rfc9052), sections 3–4, defines COSE headers and signature structures. Neither specifies ASKA's application schema or issuer qualification. [W3C Verifiable Credentials Data Model 2.0](https://www.w3.org/TR/vc-data-model-2.0/) provides an interoperable evidence model with issuer, holder and verifier roles. Credential verification must remain distinct from ASKA resource admission. All byte-level vectors, limits and implementation claims require separate conformance evidence.
