# ASKA v4 — Traceability, decisions, and architectural evolution

[Start](01_architecture_and_reading_map.md) · [Previous](17_research_and_realizations.md) · [Next](19_sources_and_evidence.md)

**Requirements:** R01–R24; this document governs their maintenance.

The requirement register in [02](02_requirements_and_threat_model.md) takes precedence over a subsystem choice or an intermediate realization. Every change record must show whether the change preserves a requirement, implements it differently, leaves it unestablished, or violates it. Lower implementation cost does not establish equivalent security.

## Requirements-to-design matrix

ASKA has not validated the claims below as an integrated system. The evidence column names the artifacts and observations that a realization must produce. It reports no completed results.

| Requirement | Principal design | Responsible documents | Required evidence / regression |
|---|---|---|---|
| R01: explicit authority and mediation | Protected object/effect handles and unavoidable guards | 05, 08, 11–14 | Malicious caller, helper/fallback, raw DMA/transmit, and broker-path tests; crossing cases X01–X12 |
| R02: granular applications | Component graph, ephemeral workers, narrow state owners | 07, 09–10 | Useful application with narrow default grants and manageable developer effort |
| R03: physical compute ownership | P1 islands; P2/P3 where the threat requires them | 03–07, 10 | Resource/path inventory, malicious-engine containment, shared-fault analysis |
| R04: physical purpose networks | ATN/STN/encounter/observation separation and explicit DTGs | 04, 11, 13 | Physical topology and forbidden-crossing observations under controller compromise |
| R05: transformation continuity | Confinement and immutable metadata through compute, storage, AI, and transport | 06–10, 13 | Derived-code, logs, renderer, accelerator, index, and network-flow checks |
| R06: independent recipient effects | Method/parameter grants and current receiver checks | 07–09, 13 | Confused-deputy and cached-allow/withdrawal counterexamples |
| R07: lifetime correctness | Source bindings, revoke/drain, generations, sanitation | 05–07, 10, 13 | Late DMA/writeback, alias, service-worker/scanout retirement, reset, abort, and allocation-reuse models |
| R08: protected persistence | Owned versions, durable commits, receipts and uncertainty | 07, 14 | Fresh service-request cells, sealed proposal/commit separation, crash/restore/deduplication, and uncertain-device-effect traces |
| R09: AI without ambient authority | Trusted interaction, context ownership, isolated planning/building | 09–10, 14 | Full planner takeover, forged approval, private-context/artifact export tests |
| R10: scoped management | Separate allocator, policy, signer, updater, recovery, and observer roles | 10, 14 | One-role takeover cannot acquire another role or another realm's scope |
| R11: common-cause resistance | Dependency graph and independently rooted high-consequence domains | 03–04, 11, 14 | Actual custodians/build/reset/supply dependencies and minimal failure sets |
| R12: bounded resources and useful service | Admission budgets, local slots, reserved control, bounded recovery | 05–07, 11, 13–14, 16 | Overload, targeted-session floods, encounter FIFO/buffer/DMA segregation, downstream coupling, flap-recovery load, deadlock, and useful progress |
| R13: distinct security outcomes | Separate prevention, containment, abuse, propagation, and availability reports | 02, 15–16 | Deliberate in-cell compromise and malicious use of valid authority |
| R14: no silent target drift | Requirement/decision records and realization ledger | 03, 17–18 | Every change identifies impacted IDs and revised evidence |
| R15: native independence | Object/effect execution, own application/UI/network model | 01, 05, 09–11, 17 | Native workflow operates with compatibility and IP gateways disconnected |
| R16: attributable evidence | Source register and explicit claim status | 04, 16–19 | Reproducible artifacts; no reported run/proof without records |
| R17: native memory semantics | Checked region references and separate persistent allocator safety | 05–07, 10 | Bounds, retained references, service/presentation controller safety, in-lifetime temporal errors, and compiler refinement |
| R18: whole-application assurance | Document-review graph with compromised parser, planner, services, and insider | 09–10, 12, 15–17 | Every import/fallback/device path; compromised service worker and renderer; useful authorized release; malicious intermediaries |
| R19: no authority from membership | Independent operation checks on all fabrics and exposed endpoints | 02, 04, 11–13 | Authenticated malicious peer and rogue guarded connection gain no new rights |
| R20: no implicit export | Separate read, release, carriage, device, and receiving grants | 05, 07–10, 12 | Read-authorized insider cannot export through media, output devices, or encryption |
| R21: every modeled path | Path register spans digital, peripheral, management, and physical outputs | 04, 06–07, 12, 14 | Enumerated bypass tests and declared physical/human exclusions |
| R22: no unilateral forbidden flow | Scoped installers and independent cross-root prerequisites | 02, 11–12, 14 | Cable/route/peripheral edits and one-role takeover cannot mint permissions |
| R23: independently bound release | Immutable output binding, local current policy, durable use accounting | 06, 08, 12–13 | Substitution, destination change, replay, withdrawal, crash, and retry traces |
| R24: bounded intermediaries | Separate import/export workers and independently owned controls | 03, 09, 11–12 | Transformer/proposer takeover preserves declared independent ceilings |

[12](12_cross_domain_security_and_information_release.md) defines the crossing-specific acceptance cases X01–X12 and observation profiles O1–O3. They extend the original requirements while retaining physical ownership and purpose segregation. All twenty-four requirements remain obligations of the native target.

## Decision records

The project records major choices D01–D09 in [03](03_architectural_candidates_and_decisions.md). A replacement record contains the old/new choice, affected requirements, alternatives, assumptions, expected benefit, evidence, remaining counterexamples, and reopening criteria. It preserves the earlier record rather than erasing why a design changed.

Changing a requirement requires a separate architectural decision. That decision must name the original property it gives up, who accepts the departure, and what name the resulting architecture will use. Omitting a property from a realization's benchmark does not authorize its removal from the requirements.

## Recovery and correction of earlier ideas

This revision evaluates earlier proposals against the current requirements. Foundational discussion, speculative brainstorms, and measured external work have different status. The following departures explain the reconstructed target; they are not a claim that every earlier passage held one consistent position.

| Earlier idea or decision | Treatment here | Reason |
|---|---|---|
| Dedicated IES compute/memory/I/O and physical channel segregation | The target again requires these resources and paths under explicit physical profiles | Makes compromise consequence and shared failure paths architectural rather than optional |
| Out-of-band onboard AI, secure UI, and application API | The native operating environment separates intent, context, and effect authority | Assistance and application construction belong to the system model; model reasoning cannot enforce permission |
| ATN/STN/DTG roles | Each role uses a physical purpose topology and narrow transaction gateways | Trust-purpose separation is broader than encrypting one unified network |
| Central Hub, AI-adjusted trust, and inherited zonal control | Scoped local roles replace central control; recommendations cannot broaden rights | Central orchestration or a score must not recreate universal administrative authority |
| v2/v3 source binding, lifetime, receiver independence, and protected placement | The target retains these rules and extends them to application services, AI artifacts, and durable effects | These mechanics support the target when their scope is explicit |
| v2 policy-before-replay update | The receiver consumes authenticated records, then independently commits delivery | Bounds repeated processing of authenticated denials while preserving current-policy checks before publication |
| v3 small-gap session retirement | The receiver allows in-range authenticated forward jumps instead of retiring on small gaps | Loss and locally burned sequences must not force avoidable admission churn |
| Fixed RV64/CHERI target and chiplet layout | Competing execution/substrate candidates reopen both choices | Mechanisms must follow the restored requirements; an existing ISA can still win on evidence |
| Compatibility IES and IP overlay | Isolated interoperability/research realizations only | Legacy compatibility cannot define native construction or physical guarantees |
| Persistent worker heaps as a convenience | Disposable workers plus explicit persistent owners | Prevents hidden cross-request references while preserving real persistent state |
| Fixed many-level core hierarchy and projected density/latency | No fixed hierarchy or unsupported performance numbers | Physical/resource granularity must follow evidence and workload requirements |
| Quantum-entangled memory/OTP, speculative physical audit, and unrelated futuristic extensions | Not dependencies of the target | No demonstrated enforcement contract justifies placing them on the critical path |
| Blanket exploit/global-hack impossibility | Claims now state containment scope and correlated failures | Valid authority, shared defects, physical attacks, and service loss remain distinct risks |

The original material also included legacy integration and centralized management proposals. The redesign does not assume the earlier architecture consistently satisfied its own aims. It recovers the governing purpose and corrects tensions within those proposals.

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

“Established” always names its scope, such as one finite model or one board configuration. A component result cannot establish the entire target. When a negative test invalidates a guard, update every conformance entry that depends on it.

## Change review questions

Before accepting a revision, ask whether a previously separate resource is now shared; whether a new broker, update role, or AI context owner has acquired broad authority; whether a new fallback parses untrusted content outside confinement; whether a carrier experiment has been promoted to a physical-path claim; and whether convenient recovery resurrects stale rights.

Then replay the complete application stress cases and the relevant weakened variants. A change can simplify implementation or improve cost while preserving every requirement. If the change cannot preserve every requirement, its record must state the departure explicitly and update the architecture diagrams accordingly.
