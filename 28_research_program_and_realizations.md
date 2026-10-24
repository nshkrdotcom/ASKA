# ASKA v5 — Research program and staged realizations

## Essential Accord research track

The first implementation must include a finite-model **authority calculus**, signed object schemas and transcript commitments, a PACT interpreter, protected approval, and reproducible positive/negative transaction traces. The next work integrates independent execution and effect enforcers, a demonstrable 4+1 endpoint, Steles witness commitments, and a community network with distinct failure scenarios. An intermediate software simulation may test semantics but cannot claim native physical separation or high-assurance side-channel protections.

---

## Detailed technical contract

**Requirements:** R02–R04, R09–R12, R14–R18, R19–R24.

The research program must build and test a whole computing environment, including the mechanisms it still lacks. It promises no fabrication date and assumes no schedule for processor, optical, AI, or verification advances. Requirements govern the target. Each intermediate build must record what it establishes and what it leaves unresolved.

## Research tracks

| Track | Required advance | Decision evidence |
|---|---|---|
| Physical islands | Private compute/memory with guarded paths, safe reuse, and documented dependencies | Netlist/board path verification, malicious-engine containment, lifecycle cost |
| Execution architecture | Object/effect semantics with spatial/temporal safety and useful compute | ISA/compiler refinement and matched sequential/dataflow workload comparisons |
| Persistence | Granular owners, crash-defined commits, revocation and rollback protection | Crash/restore/device traces and durable-state evidence |
| Native applications | Contract composition and least-authority development as the default | Complete application graph, developer studies, malicious-parser containment |
| AI environment | Trusted intent, isolated context/planning/building, independent effects | Compromised-planner tests and useful tasks without broad grants |
| Purpose networks | Separate physical roles, independent gateways, admission and resources | Topology inventory, forbidden-port tests, gateway failure and bandwidth studies |
| Governance | Scoped installation, independent updates/recovery, common-cause analysis | Compromised-role tests and actual dependency cut sets |
| Frontier integration | Better density, memory proximity, energy, and communication | Reproducible component/process demonstrations and an ASKA-specific integration argument |

All tracks use the same reference application: admitted document import, isolated parsing, protected state, AI-assisted review, constrained display, and explicit export. A networking-only or processor-only result does not complete the project.

## Cross-domain research obligations

The test harness also attacks the common application with an authorized insider, an infected removable device, a rogue connection outside the guards, and compromised import/release components. Its export path must remain useful while enforcing [19](19_cross_domain_security_and_release.md). Compare the crossing contract with NCSC guidance and NIST AC-4; public program descriptions do not establish compliance with inaccessible requirements.

Phase A adds separate reachability and authority graphs plus release-use/crash interleavings. Phase B instruments removable-media and physical-port crossings and independently controls both domain boundaries. Phase C compares disclosure/metadata service guarantees, including bidirectional processor compromise. Phases D and E revisit physical taps, maintenance paths, human exposure, recovery, and actual custodians. No phase may claim that an air gap or authenticated fabric alone stops insider disclosure.

## Phase A: semantic and application reference

Write executable models for authority graphs, ownership, delivery, and persistence. Implement a reference interpreter for component contracts and an adversarial application harness. The interpreter and harness can run on conventional machines. Their memory and physical checks model assumptions; they do not measure P1/P2 isolation.

Select a minimal worker language/IR and define its memory, effect, and fault behavior. Exercise the UI/intent protocol with a hostile planner. Retain all counterexamples and negative controls. Complete Phase A only when the model distinguishes permitted work, denied effects, authorized abuse, and uncertain outcomes.

## Phase B: separated physical demonstrator

Use separate boards or FPGA partitions with dedicated local memories and instrumented links. Implement bounded guards and lifecycle controllers. Put policy/recovery on independently controlled equipment for the boundary under test. Build the complete application with at least one real physical purpose crossing.

An FPGA configuration authority can often rewrite every partition. The demonstrator must disclose that shared power. Separate boards with the same administrator and signing key are not automatically P2. The demonstrator must name what independence it actually achieves.

Complete Phase B only after a successful compromised-parser/planner campaign, observable safe reuse under delayed DMA, and successful authorized application work. If testing finds a physical bypass, revise the reported result until the implementation repairs it and the test confirms the repair.

## Phase C: competing engines and fabrics

Compare an existing capability core, a minimal new object instruction design, and a dataflow engine inside equivalent owned domains. Compare dedicated circuits, installed channels, and packet-carried grants on equivalent physical topology. Include setup/reconfiguration costs and fault behavior, not only steady-state throughput.

Evidence may justify changing the selected binary ISA or transport. That choice cannot silently change physical, authority, flow, or application requirements. A promising accelerator can join the heterogeneous fabric without becoming the sole implementation of trusted policy.

## Phase D: integrated substrate and toolchain

Investigate planar islands, chiplets, private memory tiers, 3D bonding, and optical links using component results from [11](11_physical_substrate_and_hardware.md). Build a compiler/checker chain and physical integration flow with explicit refinement boundaries. Evaluate fabrication testing, debug control, yield, repair, heat, power, and replacement.

Advances can make currently expensive isolation practical. They may also add shared management or thermal dependencies. Accept an integration gain only if it preserves the corresponding requirement; otherwise, label the build a weaker realization. Forecasts of transistor density do not eliminate memory-movement or cooling costs.

## Phase E: independent realms and long-lived operation

Operate independently administered deployments with different update/recovery roots and meaningful implementation diversity. Exercise partitions, root retirement, software evolution, data recovery, and common supply-chain failures. Require evidence that applications remain granular after years of feature growth and that the AI environment remains bounded through model and tool updates.

Complete Phase E only when a useful realization implements the whole-system contract under stated physical and observation profiles. It does not require proving invulnerability to all fabrication defects or physical attacks. Those residual assumptions remain part of the architecture's evidence record.

## Intermediate realization ledger

| Realization | Useful evidence | Target properties it cannot establish alone |
|---|---|---|
| Conventional-host reference interpreter | Contract behavior, UI workflows, model traces | Physical ownership, hostile-host plaintext exclusion, actual gate integrity |
| Confidential VM and DPU | Protected endpoint/key placement on a qualified platform | Granular native application defaults or independent sovereign management |
| Shared capability processor | Bounds, references, local compartments, compiler costs | Required cross-trust physical resource separation |
| IP/SCION overlay | Endpoint admission, authenticated carriage, selected path semantics | Disjoint purpose facilities or cable geography |
| Multi-board demonstrator | Specific physical edges, failure paths, separate authorities | Dense package cost, production silicon behavior, or universal independence |
| Integrated P1 islands | Native spatial resource organization on that apparatus | P2/P3 properties without additional roots and physical controls |

Each experiment records satisfied, assumed, unestablished, and violated requirements separately. A build that violates an essential requirement cannot qualify as a target implementation. It may still serve as research apparatus.

## Branches, dependencies, and stopping rules

If 3D integration progresses slowly, larger modules can preserve the target at greater cost. If optical I/O remains difficult, dedicated electrical links can support shorter distances. If new ISA/compiler work is too uncertain, an existing core can test the execution contract without making its conventions normative. If physical granularity remains expensive, measure the cost and investigate coarser owned domains explicitly; do not rename shared logical isolation as physical separation.

Stop a mechanism when it depends on an unmodeled bypass, cannot bound resource use, or requires a universally trusted broker. Reopen it when a concrete mechanism or corrected assumption addresses the failure. Continue frontier research only when it can plausibly meet a named requirement or measurably reduce cost. Novelty alone is insufficient.

Maintain a changing research backlog, stable requirements, and archived decision evidence. Use those records to distinguish the target requirements from prototype limitations throughout the research program.
