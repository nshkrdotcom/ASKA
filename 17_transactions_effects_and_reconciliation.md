# ASKA v6 — Transactions, effects and reconciliation

## Finality belongs to a named boundary

ASKA treats computation, object publication, durable mutation, rendering, emission and actuation as effects with different finality points. A transaction protocol must identify which point it controls. A committed local command is not proof that a remote bank settled a payment, that a printer produced a page or that a valve reached its requested position. Conversely, uncertainty about a physical outcome does not erase an already established local emission receipt.

The canonical states are `PROPOSED → PREPARED → COMMITTED → RECONCILED`. `DENIED` records failure before admission or finality. `ABORTED` is permitted only when no final effect escaped. `UNCERTAIN` records an attempt for which the owner cannot establish whether the named finality point was crossed. These meanings follow [the unified execution contract](05_unified_execution_data_and_effect_contract.md); subsystem-specific states refine them without redefining them.

**R-17-01 — Explicit finality scope.** Every effect protocol MUST name its owner, finality point, observable outcome and irreversible boundary. It MUST distinguish local acceptance, emission, remote acceptance, durability and physical completion whenever these are separate events.

An effect identifier is stable across the retries that the protocol treats as one intended operation. Its idempotency key is bound to the exact permitted operation, principal and relevant object version. Reusing an identifier for different payloads is rejected. A receipt contains the effect and grant references, source/destination binding, object generation, owner epoch, effect counter, finality point, outcome, evidence references and any uncertainty reason. It reports what the owner can establish, not what the caller hoped would happen.

## Preparation and the final authorization check

Preparation can parse input, verify proofs, reserve capacity and calculate a candidate result. It does not grant an indefinite right to commit. The effect owner checks current grant state, negative restrictions, destination acceptance, object generation, context, freshness and remaining budget at the final boundary. An early authorization check can speed later work, but it cannot replace a check whose inputs may have changed.

For one-use authority, the owner consumes the right atomically with the local final effect when that is implementable. Deduplication state must have the same lifetime and durability as the effect it protects. A queue entry in one volatile process cannot establish exactly-once durable mutation in another. Where atomicity cannot be implemented across the real boundary, the protocol explicitly represents uncertainty and reconciliation.

**R-17-02 — Atomic local authority consumption.** The owner MUST bind final authorization, applicable one-use consumption, deduplication and its locally controlled final effect in one atomic or recoverably equivalent transition. If that guarantee is unavailable, the interface MUST expose the weaker semantics and a reconciliation path.

A prepared effect can expire or become invalid after a revocation, changed object version or exhausted budget. The owner then denies commitment and releases reservations that are safe to release. It does not silently substitute a different effect. A transformed document release, for example, remains bound to the exact output bytes or a precisely specified bounded transform, not to “some output of the approved program.”

## Crash windows and durable evidence

The design enumerates crash windows before preparation, after preparation, before finality, after finality and before receipt delivery. Each window has a recovery rule. If the owner can establish that no effect escaped, it may report an abort. If durable evidence establishes commitment, it reports that commitment even when the caller did not receive the original receipt. If neither conclusion is supported, it reports uncertainty and prevents a blind duplicate effect.

**R-17-03 — Truthful crash recovery.** Crash recovery MUST preserve established finality and MUST use `UNCERTAIN` when an attempted effect may have crossed its boundary without trustworthy outcome evidence. An established `COMMITTED` receipt MUST NOT be downgraded to `UNCERTAIN` for the same finality point merely because a separate downstream outcome is unresolved.

The receipt channel is itself fallible. A sender can lose a receipt after the receiver committed. Querying by the stable effect identifier should return the established result when the owner retains the required record. If retention has expired, the protocol must say what is still knowable and whether a retry is safe. A “not found” response is not proof of nonexecution when the system may have discarded the record or changed owners.

## Multi-owner workflows

A workflow can involve several independent owners: a PO commits a reservation, an EG emits a request, a remote EO accepts it, and a physical device acts. There is no assumed universal transaction manager able to roll all of those effects back. The workflow describes dependencies and compensation separately. Compensation is another authorized effect with its own risk, not a time machine that removes the first action from history.

A two-phase protocol is useful only under declared participant, recovery and availability assumptions. Prepared participants can remain blocked when a coordinator fails. A quorum or witness can establish a particular agreement or log property, but cannot prove an unobserved physical outcome. A partitioned realm retains its local authority boundaries rather than accepting a remote coordinator as an emergency universal administrator.

**R-17-04 — Bounded distributed workflow semantics.** A multi-owner workflow MUST specify each owner’s finality, failure and recovery obligations, including blocked preparation and compensation. It MUST NOT claim generic exactly-once remote or physical execution or atomic rollback across independently controlled effects.

Promises are represented as admitted obligations, installed grants where applicable and subsequent evidence. An agreement that a service will act is not evidence that its machine authority has been installed. An installed grant is not evidence that the service performed the operation. This distinction connects transaction execution to the CLAIM, CONTRACT, GRANT and RECEIPT chain without allowing a signed promise to bypass a guard.

## Independently observed reconciliation

A Promise Keeper-style reconciliation service compares promised, authorized and observed outcomes under an explicit contract. It may observe a command receipt, independent sensor evidence, a destination acknowledgement or a witness commitment. It records agreement, mismatch or unresolved evidence. It does not manufacture a successful outcome when an observation is missing, and it cannot reprogram the effect owner unless a separate installed grant authorizes a bounded response.

The service declares its observation interface, independence relative to the relevant attacker, freshness, sampling and dependencies. A sensor reading supplied by the same compromised actuator controller is not independent evidence against that controller. A second observer on the same controllable power rail may fail with its subject. Independence therefore refers to a named threat and cut set, not merely a second process or separate log file.

**R-17-05 — Evidence-preserving reconciliation.** Reconciliation MUST append observations and corrections without rewriting original receipts. It MUST identify evidence provenance, coverage, conflicts and unresolved gaps, and MUST distinguish independent observations from self-reports by the component being assessed.

A reconciler may recommend a refund, repeat operation, safe-state transition or investigation. Each recommendation remains a proposal. Protective responses can execute automatically under installed standing grants with target, duration and budget ceilings. A failed physical outcome does not authorize arbitrary code execution, new signers or access to unrelated private data.

## Operational examples

For a print job, the renderer produces a sealed page image under a release grant. The print EO records commitment when the authorized bytes cross its defined device boundary. A paper sensor may later establish that a sheet moved, while a human check may be needed to establish legibility. If the sensor is missing, the emission receipt remains committed and physical printing remains unresolved. Reprinting can cause duplicate disclosure and therefore requires the retry policy to be applied explicitly.

For an actuator, the EO may support a sequence-numbered command that the device deduplicates durably. That mechanism can prevent duplicate command acceptance within its assumptions. It still does not prove that the actuator moved correctly. If a power failure occurs after movement but before device-side evidence becomes durable, the controller must query independent state or enter a safe reconciliation path rather than asserting an abort.

For a persistent append, a PO can often make the value, debit and deduplication entry durable together. That local guarantee is stronger than an ordinary remote request but narrower than complete real-world agreement. A network failure after the append leaves a committed local version and an undelivered receipt, not a nonexistent append.

**R-17-06 — Safe retry and correction.** Every effect interface MUST declare whether retries use durable deduplication, mathematical or physical idempotence, a prepare/commit protocol, or independent reconciliation. Corrections and compensations MUST receive their own authority, identifiers and receipts.

Acceptance specifications are:

- **T-17-01:** Trace a workflow with local queueing, network emission and physical completion. Receipts must name the separate boundaries and must not conflate their outcomes.
- **T-17-02:** Race two requests against one remaining use while crashing the owner at its final transition. At most one local effect may commit, and recovered consumption and deduplication must match it.
- **T-17-03:** Lose a receipt after established local emission and withhold the remote response. The local receipt must remain committed; the remote outcome must be separately unresolved. A crash before finality evidence must instead retain justified uncertainty.
- **T-17-04:** Partition a prepared multi-owner workflow and fail its coordinator. The exposed states must match the declared blocking and recovery rules; fabricated global rollback fails.
- **T-17-05:** Feed conflicting sensor and device self-reports to the reconciler. It must retain both provenance chains and the conflict without overwriting the original outcome.
- **T-17-06:** Retry an ambiguous physical command and request compensation. The system must apply the declared safe retry method, and any compensation must require its own current grant and receipt.
