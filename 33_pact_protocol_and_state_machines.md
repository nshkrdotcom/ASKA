# ASKA v6 — PACT protocol and state machines

**Status:** proposed architectural requirements. Acceptance oracles specify evidence to obtain; no ASKA implementation or validation result is asserted.

PACT is the protocol by which parties negotiate bounded terms, present qualifying evidence, obtain local admission decisions, install grants and reconcile consequences. It is not a consensus protocol that makes every participant share one legal judgment. A clinician, a patient, a records custodian and a public authority can participate in one exchange while retaining different obligations, evidence visibility and machine owners. A contract becomes executable only at those owners whose admission rules it satisfies. Agreement between people and installation in machines are separate events.

The object vocabulary is defined in [Claim, contract, grant and receipt schemas](32_claim_contract_grant_receipt_schemas.md); the authority calculus is defined in [Authority calculus and nonexpansion](06_authority_calculus_and_nonexpansion.md). PACT carries references to those objects without enlarging them. It supports interactive negotiation, scheduled transactions and preauthorized protective action. A standing response grant can remain valid without a new negotiation on every alarm, but its trigger, targets, budget and expiry remain enforceable.

## 33.1 Participants and transcript identity

A session identifies a proposer, the relevant source owners, destination owners, qualifying authorities, approvers and optional witnesses. One principal may hold several roles only when the selected profile permits that combination. The transcript records which role supported each signature. Receiving a message does not assign a role to its sender, and possession of a network identity does not qualify a signer to approve a disclosure or operate a resource.

The session identifier binds a realm, session generation, participant references and protocol version. Every message carries its type, sequence or causal predecessor, sender role, recipient, contract digest, challenge binding, expiry and authenticated origin. A recipient maintains a replay window and a durable terminal marker when subsequent reactivation would be dangerous. A message from a previous boot, grant epoch or abandoned counteroffer cannot silently revive authority.

**R-33-01 — Transcript binding.** A PACT implementation MUST bind every approval, admission and installation to the exact contract revision, participant roles, selected profiles, audience and freshness challenge. A changed recipient, object generation, operation, budget or release transformation MUST invalidate affected approvals and require a new decision.

The transcript need not expose every underlying claim to every party. A custodian can return a signed applicability result or a narrowly scoped credential presentation while retaining confidential evidence. Such a result must identify what was checked, by whom, under which profile and with what expiry. A bare assertion that a hidden policy was satisfied is usable only if the admitting owner explicitly accepts that attester for that predicate.

## 33.2 Canonical contract states

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

**R-33-02 — State separation.** Implementations MUST distinguish agreement, local admission, local installation and effect finality. ACTIVE MUST enumerate the owners and grant references to which it applies; it MUST NOT imply that all remote parties installed grants or that any requested real-world outcome occurred.

DENIED and CONTESTED are branches, not an authorization shortcut. A contest may suspend execution where a profile requires a stay, or proceed in parallel with an independently applicable duty where a valid profile allows that treatment. The machine must record the governing rule. Neither a universal “appeal always blocks” rule nor a universal “orders always win” rule is adequate.

## 33.3 Exchange and admission

The logical exchange contains proposal, challenge, evidence, offer or counteroffer, approval, local admission, installation and receipt messages. A profile can combine transport messages, but cannot remove the distinct checks they represent. Challenges state the missing predicates and acceptable evidence types rather than requesting every available identity attribute. Negotiation has limits on rounds, evidence volume, computation, elapsed time and outstanding sessions. An adversary cannot force unlimited proof search by repeatedly offering slightly different credentials.

Before admission, an owner resolves the selected profile versions, evaluates qualifying evidence, checks explicit prohibitions and obligations, determines whether each requested resource is within its jurisdiction, and computes an attenuated grant. Admission records assumptions that must be rechecked at finality: revocation status, object generation, capacity activation, destination acceptance, remaining budget and required current presence. A long negotiation does not freeze those facts.

**R-33-03 — Bounded and fresh admission.** Every admission MUST have finite evidence, computation and validity bounds. The consequence owner MUST recheck the predicates designated as finality-sensitive immediately before effect finality, using the permitted freshness policy. A timeout or unavailable status service MUST produce the declared unavailable, denied or suspended result rather than implicit permission.

An admission decision may reserve resources. A reservation is not a commitment to perform the effect and needs its own expiry and release rule. Reservation failure must not leak protected data through elaborate error distinctions. Local denial may return a coarse public reason while an authorized reviewer receives a more detailed private explanation.

## 33.4 Installation and effect execution

Installation creates a GRANT at a specific enforcing owner and returns evidence that this owner accepted that grant generation. A signed admission message sent to a machine is not proof of installation. The local guard verifies the request, checks compatible schema and policy versions, commits the installation under its durability contract and returns a receipt. Restart recovery must distinguish an installation known to be durable from one whose acknowledgment was merely in flight.

**R-33-04 — Installation receipt.** A machine MUST expose authority only after the applicable local grant installation succeeds. Its receipt MUST identify the enforcing owner, grant and policy epochs, admitted bounds and durability class. Lost installation acknowledgments MUST be resolved by authenticated status or idempotent installation, never by assuming a second independent grant is harmless.

Effects then use the common states PROPOSED, PREPARED, COMMITTED and RECONCILED, with DENIED, ABORTED and UNCERTAIN as defined in [Transactions, effects and reconciliation](17_transactions_effects_and_reconciliation.md). The effect owner checks and consumes one-use authority at its named local finality point where the realization can make those operations atomic. A transaction spanning owners requires explicit coordination semantics. PACT does not manufacture a globally atomic physical action.

**R-33-05 — Scoped finality and retry.** Retries MUST retain the same effect identity and idempotency binding when they seek the same consequence. COMMITTED MUST name the established finality point and MUST NOT revert to UNCERTAIN for that same established event. An unresolved downstream outcome MUST be represented separately; an attempted effect whose finality cannot be established MUST remain UNCERTAIN until reconciliation supplies evidence.

ABORTED is valid only if no final effect escaped. Compensation is a new authorized effect: reversing a debit, sending a correction or returning a shipment does not erase the first event. Reconciliation adds evidence and links corrective actions without rewriting history.

## 33.5 Revocation, partition and bounded standing action

A revocation identifies its authority, target generation, scope, effective condition and propagation requirements. Each owner reports its observed revocation epoch and the effects that may have crossed finality before enforcement. During partition, a grant may continue only under an explicit offline lease and residual-risk policy. Otherwise unavailable status blocks further exercise. A network-wide statement that revocation was instantaneous is invalid unless the profile proves the relevant bounded propagation and clock assumptions.

**R-33-06 — Revocation enforcement.** An owner MUST prevent new finality under a grant once applicable revocation is effective locally, drain in-flight activity according to its effect semantics, and preserve receipts for consequences already committed. Offline use MUST be limited by an explicitly admitted lease, budget and reconciliation rule; absence of a revocation message MUST NOT mean permanent validity.

A standing protective contract follows the same discipline. FREEZE_EGRESS or ISOLATE_CELL may execute under an installed grant when an authorized trigger is met. The message cannot substitute arbitrary code, new signers, a broader target set or an indefinite duration. Suspension and resumption must not replenish an exhausted response budget unless an authorized renewal explicitly does so.

## 33.6 Operational example and acceptance

A laboratory and an external analyst agree to release one aggregate result. The laboratory's source owner admits the specified aggregation and output commitment. The analyst's receiver independently accepts the format, provenance and local retention terms. The two installation receipts identify distinct grants. The computation can complete while receiver publication remains blocked by a local policy update; source authorization does not force acceptance. If a transfer acknowledgment is lost, the sender queries the existing effect identity. It does not create another release grant or claim the receiver displayed the result.

**R-33-07 — Recoverable and private protocol history.** PACT MUST preserve enough authenticated state to reject stale branches and reconcile uncertain actions, while exposing transcripts and explanations only to authorized recipients. Diagnostic access MUST NOT confer the underlying data access or release authority.

The following tests are conformance obligations, not reports of an implemented system.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-33-01 | Change only the destination or contract revision after approval; installation rejects the stale signature. |
| T-33-02 | Install at one of two owners; ACTIVE identifies that owner and the other remains unable to execute. |
| T-33-03 | Exhaust negotiation rounds or expire status during preparation; no finality occurs through the unavailable predicate. |
| T-33-04 | Crash between durable installation and acknowledgment; recovery returns the same grant identity and does not double its budget. |
| T-33-05 | Lose a remote acknowledgment after local submission commits; the local committed receipt persists and remote outcome stays separately unresolved. |
| T-33-06 | Revoke during a queued operation and partition another owner; outcomes respect each finality boundary and the admitted offline ceiling. |
| T-33-07 | Give a reviewer transcript access alone; protected payload retrieval and new effect execution still fail. |

PACT's exchanges are ASKA design requirements. Standard authorization formats can carry interoperable details, but do not establish these state transitions or atomicity. [RFC 9396, sections 2 and 11](https://www.rfc-editor.org/rfc/rfc9396) provides a useful comparison for structured authorization requests; its scope is OAuth authorization detail, not the physical consequence model specified here.
