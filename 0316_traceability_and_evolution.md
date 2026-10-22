# ASKA v4 — Traceability, decisions, and architectural evolution

[Start](0300_architecture_and_reading_map.md) · [Previous](0315_research_and_realizations.md) · [Next](0317_sources_and_evidence.md)

**Requirements:** R01–R24; this document governs their maintenance.

The requirement register in [0301](0301_requirements_and_threat_model.md) takes precedence over a subsystem choice or an intermediate realization. A future change must show whether it preserves a requirement, implements it differently, leaves it unestablished, or violates it. “More practical” is a cost observation, not evidence of equivalent security.

## Requirements-to-design matrix

All target claims below remain unvalidated as an integrated system. The evidence column names what must be produced, not a result already obtained.

| Requirement | Principal design | Responsible documents | Required evidence / regression |
|---|---|---|---|
| R01: explicit authority and mediation | Protected object/effect handles and unavoidable guards | 0304, 0307, 0310–0312, 0318 | Malicious caller, helper/fallback, raw DMA/transmit, and broker-path tests; crossing cases X01–X12 |
| R02: granular applications | Component graph, ephemeral workers, narrow state owners | 0308–0309 | Useful application with narrow default grants and manageable developer effort |
| R03: physical compute ownership | P1 islands; P2/P3 where the threat requires them | 0302–0305 | Resource/path inventory, malicious-engine containment, shared-fault analysis |
| R04: physical purpose networks | ATN/STN/encounter/observation separation and explicit DTGs | 0303, 0310–0311 | Physical topology and forbidden-crossing observations under controller compromise |
| R05: transformation continuity | Confinement and immutable metadata through compute, storage, AI, and transport | 0305–0309, 0311 | Derived-code, logs, renderer, accelerator, index, and network-flow checks |
| R06: independent recipient effects | Method/parameter grants and current receiver checks | 0306–0308, 0311 | Confused-deputy and cached-allow/withdrawal counterexamples |
| R07: lifetime correctness | Source bindings, revoke/drain, generations, sanitation | 0304–0306, 0311 | Late DMA/writeback, alias, reset, abort, and allocation-reuse models |
| R08: protected persistence | Owned versions, durable commits, receipts and uncertainty | 0306, 0312 | Crash/restore/deduplication and uncertain-device-effect traces |
| R09: AI without ambient authority | Trusted interaction, context ownership, isolated planning/building | 0308–0309, 0312 | Full planner takeover, forged approval, private-context/artifact export tests |
| R10: scoped management | Separate allocator, policy, signer, updater, recovery, and observer roles | 0309, 0312 | One-role takeover cannot acquire another role or another realm's scope |
| R11: common-cause resistance | Dependency graph and independently rooted high-consequence domains | 0302–0303, 0310, 0312 | Actual custodians/build/reset/supply dependencies and minimal failure sets |
| R12: bounded resources and useful service | Admission budgets, local slots, reserved control, bounded recovery | 0304–0306, 0310–0312, 0314 | Overload, deadlock, targeted-session flood, and useful-progress measurements |
| R13: distinct security outcomes | Separate prevention, containment, abuse, propagation, and availability reports | 0301, 0313–0314 | Deliberate in-cell compromise and malicious use of valid authority |
| R14: no silent target drift | Requirement/decision records and realization ledger | 0302, 0315–0316 | Every change identifies impacted IDs and revised evidence |
| R15: native independence | Object/effect execution, own application/UI/network model | 0300, 0304, 0308–0310, 0315 | Native workflow operates with compatibility and IP gateways disconnected |
| R16: attributable evidence | Source register and explicit claim status | 0303, 0314–0317 | Reproducible artifacts; no reported run/proof without records |
| R17: native memory semantics | Checked region references and separate persistent allocator safety | 0304–0305 | Bounds, retained references, in-lifetime temporal errors, and compiler refinement |
| R18: whole-application assurance | Document-review graph with compromised parser, planner, services, and insider | 0308–0309, 0313–0315, 0318 | Every import/fallback/device path; useful authorized release; malicious intermediaries |
| R19: no authority from membership | Independent operation checks on all fabrics and exposed endpoints | 0301, 0303, 0310–0311, 0318 | Authenticated malicious peer and rogue guarded connection gain no new rights |
| R20: no implicit export | Separate read, release, carriage, device, and receiving grants | 0304, 0306–0309, 0318 | Read-authorized insider cannot export through media, output devices, or encryption |
| R21: every modeled path | Path register spans digital, peripheral, management, and physical outputs | 0303, 0305–0306, 0312, 0318 | Enumerated bypass tests and declared physical/human exclusions |
| R22: no unilateral forbidden flow | Scoped installers and independent cross-root prerequisites | 0301, 0310, 0312, 0318 | Cable/route/peripheral edits and one-role takeover cannot mint permissions |
| R23: independently bound release | Immutable output binding, local current policy, durable use accounting | 0305, 0307, 0311, 0318 | Substitution, destination change, replay, withdrawal, crash, and retry traces |
| R24: bounded intermediaries | Separate import/export workers and independently owned controls | 0302, 0308, 0310, 0318 | Transformer/proposer takeover preserves declared independent ceilings |

The crossing-specific acceptance cases X01–X12 and observation profiles O1–O3 are defined in [0318](0318_cross_domain_security_and_information_release.md). They extend the original requirements rather than superseding physical ownership or purpose segregation. All twenty-four requirements remain obligations of the native target.

## Decision records

Major choices D01–D09 are recorded in [0302](0302_architectural_candidates_and_decisions.md). A replacement record contains the old/new choice, affected requirements, alternatives, assumptions, expected benefit, evidence, remaining counterexamples, and reopening criteria. It preserves the earlier record rather than erasing why a design changed.

A requirement change is a separate architectural action. It must explain which original property is relinquished, who accepts that departure, and how the resulting architecture is named. A realization cannot approve that change by simply omitting the property from a benchmark.

## Recovery and correction of earlier ideas

The earlier material is used critically. Foundational discussion, speculative brainstorms, and measured external work have different status. The following departures explain the reconstructed target; they are not a claim that every earlier passage held one consistent position.

| Earlier idea or decision | Treatment here | Reason |
|---|---|---|
| Dedicated IES compute/memory/I/O and physical channel segregation | Restored as target requirements with explicit physical profiles | Makes compromise consequence and shared failure paths architectural rather than optional |
| Out-of-band onboard AI, secure UI, and application API | Restored as the native operating environment with separate intent/context/effect authority | Assistance and application construction belong to the system model; model reasoning cannot be trusted to enforce permission |
| ATN/STN/DTG roles | Restored with per-purpose physical topology and narrow transaction gateways | Trust-purpose separation is broader than encrypting one unified network |
| Central Hub, AI-adjusted trust, and inherited zonal control | Split into scoped local roles; recommendations cannot broaden rights | Central orchestration or a score must not recreate universal administrative authority |
| v2/v3 source binding, lifetime, receiver independence, and protected placement | Retained and extended to application services, AI artifacts, and durable effects | These mechanics support the target when their scope is explicit |
| v2 policy-before-replay update | Replaced by authenticated consumption followed by independent delivery commit | Bounds repeated processing of authenticated denials while preserving current-policy checks before publication |
| v3 small-gap session retirement | Excluded; in-range authenticated forward jumps are allowed | Loss and locally burned sequences must not force avoidable admission churn |
| Fixed RV64/CHERI target and chiplet layout | Reopened through competing execution/substrate candidates | Mechanisms must follow the restored requirements; an existing ISA can still win on evidence |
| Compatibility IES and IP overlay | Isolated interoperability/research realizations only | Native construction and physical guarantees cannot be defined by legacy compatibility |
| Persistent worker heaps as a convenience | Disposable workers plus explicit persistent owners | Prevents hidden cross-request references while preserving real persistent state |
| Fixed many-level core hierarchy and projected density/latency | No fixed hierarchy or unsupported performance numbers | Physical/resource granularity must follow evidence and workload requirements |
| Quantum-entangled memory/OTP, speculative physical audit, and unrelated futuristic extensions | Not dependencies of the target | No demonstrated enforcement contract justifies placing them on the critical path |
| Blanket exploit/global-hack impossibility | Replaced by scoped containment and correlated-failure claims | Valid authority, shared defects, physical attacks, and service loss remain distinct risks |

The original material also included legacy integration and centralized management proposals. The redesign does not treat a uniformly uncompromising earlier architecture as a historical fact. It recovers the governing purpose and corrects tensions within those proposals.

For source provenance, the historical repository at commit `23203ca5db55089bbda6e30b7ab943f37f438355` preserves [v1's detailed overview](https://github.com/nshkrdotcom/ASKA/blob/23203ca5db55089bbda6e30b7ab943f37f438355/v1/DOC.md), [v1's application discussion](https://github.com/nshkrdotcom/ASKA/blob/23203ca5db55089bbda6e30b7ab943f37f438355/v1/8.md), [v2's handoff contract](https://github.com/nshkrdotcom/ASKA/blob/23203ca5db55089bbda6e30b7ab943f37f438355/v2/03_protected_handoff.md), and [v3's reading map](https://github.com/nshkrdotcom/ASKA/blob/23203ca5db55089bbda6e30b7ab943f37f438355/0010_architecture_and_reading_map_gpt.md). These establish what the project proposed, not external proof that it worked.

## Realization conformance record

Each implementation or experiment publishes:

```text
artifact identity and revision
requirement IDs: established / assumed / unestablished / violated
decision records implemented and deviations
physical profile and actual dependency graph
observer model and residual trusted components
model/proof/test/measurement evidence
useful work completed; denial and uncertainty behavior
```

“Established” always names its scope, such as one finite model or one board configuration. It never means the entire target follows from a component result. A negative test that invalidates a guard updates every dependent conformance entry.

## Change review questions

Before accepting a revision, ask whether a previously separate resource is now shared; whether a new broker, update role, or AI context owner has acquired broad authority; whether a new fallback parses untrusted content outside confinement; whether a carrier experiment has been promoted to a physical-path claim; and whether convenient recovery resurrects stale rights.

Then replay the complete application stress cases and the relevant weakened variants. A change can simplify implementation or improve cost while preserving every requirement. If it cannot, the departure must remain visible rather than disappearing into a new architecture diagram.
