# ASKA v6 — Protective response and containment

## Timely action with prior authority

ASKA distinguishes prevention at a mandatory boundary from detection and later containment. A memory guard denies an unauthorized transaction under its installed predicate. An LSM may subsequently recognize a pattern and propose a wider but bounded protective action. The latter cannot be credited with preventing a consequence that already crossed its finality point.

A security incident does not require a fresh interactive negotiation for every alarm. Accord can establish standing grants before operation, including grants that allow deterministic local responses without a human round trip. The grant fixes the permissible action, target lifetime, trigger, duration, budgets, priority and affected interests. The protected effect owner validates these terms at execution. Actions outside that scope need the appropriate new authority.

The stages are thus operationally useful: deliberate admission establishes the permitted response envelope; a local incident supplies evidence; a bounded owner transition enacts the admitted response; a receipt records its actual finality. [Chapter 05](05_unified_execution_data_and_effect_contract.md) owns the shared effect state model.

## Finite response templates

**R-23-01 — Closed action vocabulary.** Automatic protective response MUST use a registered finite template with a typed target and bounded parameters. The baseline templates are `FREEZE_EGRESS`, `ISOLATE_CELL`, `REVOKE_SESSION`, `RATE_LIMIT`, `PRESERVE_EVIDENCE` and `ENTER_SAFE_STATE`. A template MUST NOT contain arbitrary executable code, introduce a new signer, expand policy authority or conceal a general-purpose management operation.

| Template | Protected owner and admitted effect | Essential bound |
|---|---|---|
| `FREEZE_EGRESS` | EG blocks selected future releases | Exact source/generation, affected flows and duration; indispensable safety channel exceptions declared |
| `ISOLATE_CELL` | Relevant owners stop admitted interactions and retire the cell lifecycle | Exact cell epoch; drain, acknowledgement and sanitation ordering |
| `REVOKE_SESSION` | Session owner retires named grants and replay state | Session/grant epochs and handling of in-flight work |
| `RATE_LIMIT` | Queue/resource owner lowers a permitted rate | Minimum essential service, period, maximum impact and recovery condition |
| `PRESERVE_EVIDENCE` | PO/evidence owner retains an authorized evidence object | Collection scope, size, recipient and retention; no implicit plaintext access |
| `ENTER_SAFE_STATE` | Device-specific EO and independent safety logic perform a defined transition | Validated physical state, timing, interlocks and authorized recovery |

Narrowing authority can still cause harm. Freezing the output of a medical controller, isolating a protection relay or revoking the only available operator session may worsen the incident. The response model therefore evaluates operational consequence as well as permission set size. A “monotonic reduction” label alone is not a safety argument.

## Standing grants and owner admission

**R-23-02 — Complete standing grant.** Every automatic response grant MUST specify its issuer and installation authority, exact target and lifetime, eligible trigger evidence, allowed template/parameter bounds, time validity, maximum cumulative impact, renewal conditions, recipient interests, priority and receipt obligations. Missing scope MUST cause denial. The incident detector MUST NOT mint, extend or renew the grant that authorizes its own proposal.

A trigger may be a protected guard counter, a watcher-reported loss condition, a supported SAI hypothesis, or a specified combination. Its admissibility is part of the grant. A raw model confidence value is not a universal trigger. Where a single watcher can trigger a short freeze, the grant deliberately gives that watcher a bounded denial-of-service influence and must budget it accordingly.

**R-23-03 — Revalidate at the consequence boundary.** The protected owner MUST validate source authority, target identity/generation, installed grant and epoch, receiver conditions, trigger freshness, resource budget and current policy before making a protective effect final. A valid signature, incident severity, risk-rating service score or MSM instruction MUST NOT bypass that decision. Competing proposals MUST be resolved by an explicit admitted priority policy.

The owner returns a reasoned denial when the target was reallocated, the evidence is too old, the action exceeds its quota or the safety condition conflicts. A rejected response does not become an unreported success. SAI can propose a different admitted response or request independent review; it cannot rewrite the rejection or downgrade the priority of an emergency stop to make its recommendation fit.

`EO-T` is limited to the trusted-service protective owners specified in [chapter 04](04_reference_machine_and_reachability.md). It cannot disable Keystone approval or emergency stop, rewrite Steles history, or use trusted-service status to shut down unrelated purposes. Cross-realm containment is subject to each receiving realm’s own authority.

## Lifecycle races and finality

**R-23-04 — Ordered containment and reuse.** A response affecting cells, memory, devices or sessions MUST obey their canonical revoke, drain, invalidate, acknowledge and sanitation rules before reuse. The target generation MUST remain bound through queued proposals and delayed completions. A response intended for a retired cell MUST NOT apply to a new occupant of the same physical resource.

Consider a malicious driver whose late DMA completion remains in a device queue. Merely stopping its CPU does not retire that transaction. DG and the ownership controller must reject the old device/cell epoch, drain or cancel accepted work under the relevant contract, and establish the reuse barrier before the bank can serve another cell. The observer’s claim that the cell looks quiet is not the required acknowledgement.

The shared effect states are `PROPOSED`, `PREPARED`, `COMMITTED` and `RECONCILED`, with `DENIED`, `ABORTED` and `UNCERTAIN` where their conditions apply. `ABORTED` is valid only when no final effect escaped. A crash after an attempt can leave the effect `UNCERTAIN` when finality cannot be established. Once a receipt establishes `COMMITTED` at a particular finality point, later lack of evidence does not reverse it to uncertainty at that same point.

Physical outcomes often need separate records. A committed command-acceptance receipt is compatible with an unknown actuator position. Reconciliation can add later evidence or an authorized compensating effect; it cannot claim to rewind motion, communication or another irreversible consequence. [Chapter 17](17_transactions_effects_and_reconciliation.md) defines that distinction for the entire machine.

## Safety-critical response

**R-23-05 — Device-specific safety authority.** An effect that can influence a physical process MUST be admitted by its device-specific safety contract and protected owner. Automatic security actions MUST preserve designated emergency controls and validated safe-operation requirements. `ENTER_SAFE_STATE` MUST identify an actual assessed transition; “stop everything,” “power off” or “disconnect” MUST NOT be assumed safe without that assessment.

A safe state can require continued computation, controlled deceleration, maintained cooling, delivery of an alarm or access by an authorized operator. Independent safety logic may override a proposed network freeze within its explicitly admitted role. The conflict and resulting owner decision are recorded so that security monitoring does not silently rewrite the hazard analysis.

[NIST SP 800-82 Revision 3, September 2023, §§2.3.7 and 4.2.2](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r3.pdf) discusses safety systems and the interaction between cyber and physical risks. It does not certify any particular ASKA response. NIST’s [publication record](https://csrc.nist.gov/pubs/sp/800/82/r3/final) also identifies Revision 4 as an initial public draft as of the research date; Revision 3 is the final technical reference used here.

Emergency authority is installed authority with explicit conditions. An incident may satisfy those conditions without further interaction, but it does not grant the observer a universal exception. A legal emergency request likewise needs the applicable institutional and technical admission described in [chapter 41](41_legal_process_rights_and_emergencies.md). It cannot conjure a missing key or create an unimplemented device function.

## False-alarm denial of service and recovery

**R-23-06 — Cumulative intervention budget.** Protective owners MUST enforce deduplication, rate limits, cumulative duration and scope quotas for response proposals. Repeated individually valid responses MUST NOT evade an aggregate impact limit by changing incident identifiers. Renewal, escalation and restoration of ordinary operation MUST follow separately specified conditions that the triggering observer cannot unilaterally broaden.

The budget accounts for the complete effect: a sequence of one-minute freezes can be an hour of denial. It should distinguish genuinely independent targets from aliases of the same resource and reserve required safety operations. Queueing and cryptographic verification also consume capacity, so the proposal interface has its own bounded parser and admission budget.

A protective action is not automatically reversible just because its template name suggests containment. Revocation can cause a remote application to time out; isolation can interrupt a persistent transaction; evidence preservation can increase privacy exposure. Restoring a local configuration does not undo those outcomes. Recovery uses current authorization and fresh generations, with the lost or uncertain external effects retained for reconciliation.

**R-23-07 — Truthful response receipt.** Every admitted response attempt MUST produce or recover an owner-bound disposition identifying the effect, idempotency key, grant, target generation, finality point, outcome and evidence. Rejection, unavailable evidence and physical uncertainty MUST remain explicit. A response service MUST NOT report success from proposal delivery, and a retry MUST respect the recorded finality and deduplication state.

## Conformance campaign

| Test | Stimulus | Required oracle |
|---|---|---|
| T-23-01 | Submit an unknown template, embedded script or arbitrary target selector | Closed parser rejects it without invoking a generic management path |
| T-23-02 | Trigger an alarm with expired, missing, self-renewed or overbroad standing grant | No unauthorized effect; valid bounded trigger works without new interactive negotiation |
| T-23-03 | Submit a signed severe incident with wrong epoch, stale evidence or conflicting safety priority | Owner enforces the complete predicate and records the actual disposition |
| T-23-04 | Race isolate/revoke against DMA completion, writeback, message publication and bank reuse | Old generation cannot affect the new owner; barriers and acknowledgements precede reuse |
| T-23-05 | Request shutdown or egress freeze during a simulated hazardous process | Assessed safety contract prevails; emergency control remains reachable |
| T-23-06 | Repeatedly request short freezes with fresh incident identifiers | Aggregate quota and deduplication prevent unbounded denial while preserving essential operations |
| T-23-07 | Crash before/after owner commit and lose a downstream physical acknowledgement | Receipts distinguish denial, no-escape abort, uncertain finality and committed local acceptance; retries do not invent exactly-once behavior |

These tests must measure both blocked attacks and successful useful work. A system that prevents every operation by remaining permanently isolated does not satisfy the intended availability and operational contract.
