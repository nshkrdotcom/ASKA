# ASKA v5 — Accord Suite: objects, encodings, and cryptographic bindings

## 1. Protocol identity

The protocol family is the **ASKA Accord Suite**. Its named functional modules are **PACT** (Protocol for Authority, Consent, and Transactions), **CLAIM**, **CONTRACT**, **GRANT**, **RECEIPT**, **IDENT**, **RELATE**, **LEGAL**, **CIVIC**, **PROFILE**, and **WITNESS**. A module name identifies semantics, not a mandatory isolated daemon or a physical network interface. Each protocol message begins with a domain-separated type/version tag and critical-extension policy.

## 2. Semantic layers

| Layer | Input | Output | Independent authoritative role |
|---|---|---|---|
| Evidence | issuer attestation, relationship, court act, observations | `CLAIM` | qualified issuer + evidence verifier |
| Decision | claim graph, profile, negative rules, recipient policy | `CONTRACT` | evaluator + profile-required parties |
| Installation | admitted contract + current object/realm state | `GRANT` | protected local installer / effect owner |
| Performance | grant + concrete immutable inputs and live counter | result + `RECEIPT` | source/target enforcers and witness |

Every object is bound to a `type`, `schema_revision`, `operation_id` (when applicable), `issuer_key_id`, `proof_alg`, `critical_extensions`, and encoded, signed integrity envelope. Numeric size caps are profile choices; fields below define semantics, not frozen wire offsets.

## 3. Common types

- `PrincipalRef`: realm-scoped or pairwise identity reference; global stable user ID is **not required**.
- `ObjectRef`: owner-qualified object ID plus generation/version and type.
- `PlaneId`: `sanctum | polis | agora | wilder | steles` (last for witness operations only).
- `ProfileRef`: profile ID + immutable digest + validity epoch.
- `TimeBound`: monotonic lease where local safety depends on time, plus trusted wall-clock bounds where policy requires them.
- `Budget`: tuple of bytes, calls, records, CPU/fuel, duration, rate, monetary value or custom bounded units; any absent dimension is explicitly unlimited **only if policy permits**.
- `ConstraintSet`: permitted output, confidentiality categories, integrity endorsements, prohibited transformations and retention/notification obligations.
- `Commitment`: digest to an immutable canonical representation plus a declared hash and domain separator.

## 4. CLAIM

A `CLAIM` MUST encode `claim_id`, `issuer`, `subject`, `claim_kind`, `predicate`, `issued_at`, `validity`, `scope`, `supporting_evidence` or protected digest, `revocation_ref`, `selective_disclosure_policy`, `profile_context`, and verifiable signature. Evidence is never directly an effect capability. An assertion from a cloud provider cannot overwrite a court's issuer qualification, and a court certificate cannot become a machine decryption key.

### Example (illustrative YAML semantics)

```yaml
kind: aska.accord.claim
revision: 1
claim_id: clm:household:7F3
issuer: household:key:signerA
subject: person:pseudonym2
claim_kind: delegation
predicate:
  role: emergency_caregiver
  permitted_actions: [view_medication_list, receive_alert]
scope: sanctum:household-84
validity: {not_before: 2026-10-01T00:00:00Z, not_after: 2027-01-01T00:00:00Z}
revocation_ref: status:household:7F3
critical_extensions: []
signature: "<issuer signature over canonical object>"
```

## 5. CONTRACT

`CONTRACT` binds all admitted terms **including negative constraints**: `operation_id`, proposal digest, initiating principal, actual source owner and object versions, exact verbs, plane, receiving principals, purpose, evidence DAG commitment, governance profile digest, policy decisions and dissent state, approved output description, confidentiality release rule, resource/expiry budgets, independent approvers, obligations, notice/challenge route, audit confidentiality class and final disposition. A signed rejected decision is a useful contract outcome; contract creation does not imply success.

```yaml
kind: aska.accord.contract
revision: 1
operation_id: op:0f53
plane: agora
method: invoice_settle
source: {owner: business:21, object: invoice:882, generation: 9}
recipient: merchant:bank-account-alias-7
purpose: purchase_order:154
value: {currency: USD, amount_minor: 12500}
profile: {id: org.procurement, digest: sha256:...}
evidence_commitments: [sha256:...]
constraints:
  transformations: [normalize_invoice_fields]
  onward_use: settlement_receipt_only
  egress: agora:payments
budgets: {max_invocations: 1, max_bytes: 16384, deadline: 2026-10-30T00:00:00Z}
approvals: [authorized_signer:finance-role]
obligations: [durable_receipt, steles_commitment]
decision: allow_with_obligations
```

The above amount illustrates a price value, not a recommended limit. Ellipses show where a real profile needs canonical byte strings; the example is **not a test vector or valid signed packet**.

## 6. GRANT

A machine `GRANT` MUST include `contract_digest`, `grant_id`, `installer`, `executor_cell_id` and generation, exact object and generation, method, recipient, plane interface, output/release reference, use counter/budget, validity, revocation epoch and required receipt channel. Its bytes need not leave the local protection boundary. A grant MUST NOT carry global authority by referring to a “root” issuer alone. A source session's transport grant is not a disclosure grant.

## 7. RECEIPT

Every `RECEIPT` MUST identify an operation and its lifecycle event: `proposed`, `rejected`, `approved`, `installed`, `started`, `prepared`, `durably_committed`, `transmitted`, `received`, `published`, `irreversible`, `aborted`, `revoked`, `unavailable`, or `uncertain`. These are distinct, and profile-specific phases may add more. Receipts bind relevant effect-owner identifiers, redacted summaries, applicable confidentiality class, occurrence/sequence evidence, signature, and optional Steles commitment pointer. A receipt claiming that an irreversible action occurred MUST cite the corresponding owner proof, not simply an AI narration.

## 8. Message and signing model

1. **Canonical form:** choose a reviewed deterministic encoding; CBOR and COSE are candidate references ([RFC 8949](https://www.rfc-editor.org/rfc/rfc8949), [RFC 9052](https://www.rfc-editor.org/rfc/rfc9052)). Encode all field types and integer widths canonically; reject duplicate/ambiguous keys. A signature MUST commit to type/version, profile, plane, operation, issuer role, expiry and all critical fields.
2. **Transcript binding:** calculate `T = H("ASKA-ACCORD-PACT-v5" || canonical_messages || supported_suites || profile_hashes || nonce_challenges)`. Unparsed negotiation text MUST NOT be interpreted as a signature authorization.
3. **Domain separation:** claim, contract, grant, receipt, proof, and witness signatures MUST have distinct signing contexts so a valid byte string of one type cannot be replayed as another.
4. **Algorithm agility:** suite IDs are pinned for each contract; unsupported critical cryptographic suites are rejected, not silently downgraded.
5. **Post-quantum readiness:** evaluate NIST FIPS 203/204/205 mechanisms with hybrid deployment policy; neither QKD nor quantum memory is a prerequisite.
6. **Protection of metadata:** public packet headers SHOULD avoid stable identity, court matter IDs, personal categories or complete policy graphs. Bind private detail through transcript digest and protected local state.

## 9. Data-plane minimal record

```text
[frame/version] [plane-local routing label] [session handle]
[epoch + anti-replay sequence] [length/padding class]
[authenticated encrypted record + tag]
Protected local session record:
  contract digest, object binding, recipient policy,
  path admissibility, interface, keys, counters, lease.
```

The control/data split is normative; this ASCII drawing is **not** a registered packet format. Protected receive logic authenticates before it publishes, consumes authenticated replay windows under bounded budgets, validates current recipient authorization, and places output directly into the named protected destination. See [20](20_admission_transport_and_protected_delivery.md).

## 10. Profiles, critical extensions and interop

Profiles MUST declare supported module revisions, maximum proof and transcript complexity, signing suites, status/revocation freshness, plane and path assurance, notice obligations, failure behavior, and support for partial offline operations. A peer cannot conclude that another endpoint implements the full architecture merely from understanding PACT messages. `profile_mismatch` and `cannot_enforce_obligation` are first-class rejection codes, not reasons to choose a silent weaker option.
