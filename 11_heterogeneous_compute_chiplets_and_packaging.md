# ASKA v6 — Heterogeneous compute, chiplets and packaging

## Resource diversity within a common boundary

ASKA permits heterogeneous compute because workloads need different resources. A bounded parser, cryptographic transform, vector inference job and interactive application need not occupy identical processors. The common contract is physical ownership, explicit communication and guarded effects. A specialized core does not gain broader authority because its function is security related, and a large accelerator does not qualify as an isolated domain merely because its command queue is private.

The resource manifest records each compute element’s instruction or dataflow semantics, private state, local memory, external ports, reset and clock controls, interrupt sources, management firmware and sharing granularity. It also records the smallest unit that can be independently allocated, drained and sanitized. The granularity of marketing terms such as “core,” “tile,” “chiplet” and “partition” is not accepted as evidence of that unit.

**R-11-01 — Complete heterogeneous resource description.** Each admitted compute element MUST have an explicit resource and dependency description sufficient to identify its writable state, outward paths and enforceable allocation granularity. Unsupported isolation properties MUST NOT be inferred from processor type or packaging terminology.

A design can use many small units for deterministic transforms, intermediate cores for bounded services and larger processors for general or highly parallel workloads. Thousands of tiny units or dozens of size classes are research variables, not selected silicon dimensions. A credible design study must include guard area, memory arrays, wiring, buffering, clock distribution, test structures, yield and cooling. Counting arithmetic units while omitting those resources is not a feasible system budget.

A fifty-tier granularity experiment is an admissible design-space study: vary the numbers of tiny bounded engines, intermediate general-purpose cores and large accelerators while holding useful workload and protection obligations constant. Proposed transistor counts, die areas, future density multipliers and core populations are inputs to be justified, not facts about a realizable ASKA chip. The study must compare fewer tiers and conventional boards, quantify fragmentation and guard overhead, and reject configurations that exceed memory, wiring, power or thermal constraints.

## Placement, utilization and authority

Placement chooses resources that satisfy a cell’s admitted needs. The decision can consider memory locality, accelerator precision, availability, latency and thermal headroom. It cannot change the cell’s principals, object permissions or release policy. If a specialized implementation requires more access than the admitted contract allows, the placement is invalid even if the implementation would run faster.

Short-lived workers can improve utilization when state cleanup is bounded. They can also increase guard traffic, scheduling overhead and sanitization cost. The relevant comparison includes useful work per admitted lifetime, occupancy under realistic arrivals, fragmentation, transfer bytes, failure recovery and the reserved headroom needed by critical service. An unused resource may be borrowed through resource borrowing, but it remains subject to the reclaim and bandwidth rules in [resource scheduling](09_ies_cells_resources_and_scheduling.md).

**R-11-02 — Authority-preserving placement.** Placement and migration MUST retain the cell’s admitted authority and assurance requirements. A change that introduces shared writable state, a new management dependency or weaker reset isolation MUST be re-admitted as a profile change rather than hidden as a scheduling optimization.

[M3](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) is relevant because it makes communication mediation part of a heterogeneous manycore design. The particular prototype and simulation configurations are evidence about that work, not universal performance ratios. ASKA must qualify the selected processor, memory and transfer implementation together. Heterogeneity does not excuse an unmediated path from a device or core to a neighboring owner’s bank.

## Die-to-die links and package boundaries

A chiplet design can place compute, memory, communication and security functions on separate dies. This may make some interfaces easier to enumerate, but a die boundary is not automatically an independent trust boundary. Chiplets may share an interposer, power delivery, reset tree, thermal structure, manufacturing chain and management controller. A shared test-access controller can defeat an otherwise careful separation if it can read guard keys or alter memory ownership.

The [UCIe consortium’s public specifications overview](https://www.uciexpress.org/specifications) describes die-to-die integration and includes management and design-for-test considerations. Only that public overview is used here; a complete normative electrical and protocol qualification has not been performed. Selecting a UCIe-class link therefore does not establish confidentiality, non-bypassability or secure maintenance for an ASKA package.

The package manifest must enumerate data lanes, sideband management, training, repair, debug, power control and fault reporting. Link training and recovery are state changes that can affect identity binding. The receiving guard must know whether a retrained link still belongs to the same admitted endpoint. If continuity cannot be established, outstanding transactions are fenced and the endpoint is readmitted with fresh epochs before receiving authority.

**R-11-03 — Package path completeness.** All data, sideband, management, debug and test paths crossing an ownership boundary MUST be inventoried and constrained. Link repair, retraining or endpoint replacement MUST NOT preserve stale authority when identity or transaction continuity is uncertain.

Inside the RP-A boundary module `G-p`, MG, DG, BG, PO, EO and EG functions share a declared implementation cut set. Functional separation between those roles does not make them physically independent. A compromise of their common implementation can invalidate multiple claims at once. Higher assurance profiles may distribute those functions, but they must then account for the additional links, state synchronization and failure modes instead of merely multiplying the number of boxes in a diagram.

## Three-dimensional integration and common causes

Stacking can reduce some wire lengths and increase integration density. Its security evaluation must ask where heat, power and faults propagate, which layers are physically accessible, and whether isolation state survives supply or clock disturbances. A memory die stacked with a compute die may still be the same compromise and physical-fault domain. A separate observer die sharing a controllable reset line with its subject is not independent against reset control.

Common causes are recorded as a dependency graph. Nodes include regulators, oscillators, reset sources, package bridges, firmware roots, cooling systems and maintenance tools. An availability claim identifies the cut sets it survives. A privacy claim identifies which common dependencies are observable or influenceable by another principal. An independent power supply is useful only if its control and upstream feed do not reintroduce the assumed common failure.

**R-11-04 — Honest physical independence.** Packaging assurance MUST explicitly identify shared power, clock, reset, thermal, firmware, test and supply-chain dependencies. A claimed independent enforcement or observation boundary MUST survive the attacker actions named for that claim; otherwise the claim MUST be narrowed.

[CURE’s published threat model](https://www.usenix.org/system/files/sec21summer_bahmani.pdf) provides a useful comparison: customizable enclaves and resource partitioning address powerful software attackers under trusted-hardware assumptions, while physical attacks and certain physical side channels are outside its stated scope. ASKA’s additional physical-domain claims need their own evidence. The existence of a close enclave design is neither a reason to dismiss those obligations nor evidence that they are already satisfied.

## Maintenance, replacement and failure

Live replacement is qualified at the actual serviceable unit. A removable board or module may support isolation, power sequencing and connector interlocks; an arbitrary bonded chiplet is not assumed hot-swappable. The maintenance contract specifies quiescence, physical disconnection, key handling, firmware measurement, asset identity, reinstallation and evidence of correct wiring. An operator’s maintenance role may permit replacement without permitting access to another realm’s contents.

Failed components enter a state that prevents reallocation of uncertain retained state. A reset that clears visible registers may leave private SRAM, nonvolatile configuration or queued fabric transactions. Replacement therefore includes both physical removal and logical retirement of old epochs. The new component receives new authority only after the guard confirms that old paths cannot deliver delayed operations into its allocation.

**R-11-05 — Qualified replacement.** A hot-plug or replacement claim MUST identify a physically serviceable unit and a tested isolation and admission sequence. Replacement MUST retire prior endpoint epochs, close delayed operations and preserve unresolved-effect evidence before a new unit receives authority.

A repair service may inspect externally observable status and attest installation steps. It cannot prove the absence of every malicious circuit by reading a vendor certificate or microstructure identifier. Such identity evidence binds a claim to an artifact under a stated measurement model. It does not turn supply-chain trust into universal silicon truth. Stronger profiles may require destructive examination, independent fabrication evidence or redundant diverse components, each with its own limits.

## Engineering decision and example

Consider a cryptographic chiplet shared as a guarded service among three IESs. It accepts bounded requests containing immutable input bindings and operation grants. Its private queue, key slots and completion buffers are partitioned or scheduled under a declared profile. A deadline-sensitive tenant has a reservation covering request admission, memory traffic and completion delivery. If another tenant triggers thermal throttling, the deployment either maintains the reservation within its qualified envelope or records failure of that availability claim. It must not quietly read a neighboring tenant’s key slot or hide incomplete results.

A design comparison records at least end-to-end work, transfer and sanitization cost, memory capacity, energy, heat, area, failure recovery and proof surface. Forecast process improvements cannot waive present budgets. Power is an isolation resource as well as an operating cost; treating it as unlimited would erase an important attacker-controlled channel and a common failure mechanism.

Acceptance specifications are:

- **T-11-01:** Remove one sideband or retained-memory resource from a candidate manifest and compare it with board/package inspection. Qualification must fail until the omitted path or state is accounted for.
- **T-11-02:** Request migration to a faster resource with shared writable state or a broader management root. Admission must reject it unless the changed profile is explicitly authorized.
- **T-11-03:** Retrain a link and replace its endpoint while old transactions are queued. No old transaction may be accepted under the replacement’s authority.
- **T-11-04:** Exercise each declared common reset and power controller. The observed failure set must match the dependency graph; any supposedly independent guard reset by the subject is a failing counterexample.
- **T-11-05:** Interrupt a replacement at every admission stage. The system must expose either the old qualified unit, a closed/quarantined resource or the newly admitted unit, never ambiguous simultaneous ownership.
- **T-11-06:** Reproduce a claimed throughput or isolation result from its configuration and procedure. Missing workload, guard overhead or thermal conditions defeats the claim rather than being filled by assumption.
