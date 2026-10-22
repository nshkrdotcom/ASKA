# ASKA v4 — Architectural candidates and decisions

[Start](0300_architecture_and_reading_map.md) · [Previous](0301_requirements_and_threat_model.md) · [Next](0303_physical_substrate_and_frontier.md)

The architecture must be chosen by how failures propagate, which authority paths remain, and what useful computation it supports. ISA familiarity, small prototypes, and market availability are secondary considerations. Four candidates expose different tradeoffs.

## Candidate comparison

| Candidate | Compute and state | Boundary construction | Assessment against the target |
|---|---|---|---|
| A. Spatial object islands | Exclusive execution engines and private memory; persistent state behind messages | No foreign memory path; mandatory mailbox/device guards; separate purpose fabrics | Selected system organization. Costs include stranded resources, transfer bandwidth, lifecycle, and wiring |
| B. Shared coherent capability machine | Many compartments share cores, caches, coherent memory, and a capability ISA | Fine-grained reference checks, monitor, IOMMU, scheduler | Strong comparison for R01/R17; shared resources alone fail the physical target in R03/R04 |
| C. Spatial/dataflow fabric | Task graphs occupy reconfigurable regions; values move along scheduled edges | Region ownership, typed edge endpoints, configuration guard | Candidate execution engine within A; whole-system safety depends on trusted configuration and persistent-effect gates |
| D. Independent appliances | Separate boards/enclosures, local memory and roots, narrow links | Physical reachability limits and separately administered gateways | Selected for high-consequence sovereign functions; larger integration and communication cost |

These are not different names for the same chiplet assembly. B changes the memory-sharing assumption; C changes instruction scheduling and computation placement; D moves important boundaries out of a common package. A can use C internally and D between critical realms without weakening its own physical ownership rule.

[OctopOS](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf) supplies an exclusive-use, physically partitioned hardware/OS comparison with a prototype. [M³](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) supplies heterogeneous execution behind communication enforcement. Neither demonstrates the complete ASKA application, AI, or purpose-network contract.

Dataflow is not inherently a security mechanism. The [TRIPS project](https://www.cs.utexas.edu/~cart/trips/overview.html) demonstrates spatial/EDGE execution as a processor design direction. ASKA would additionally need ownership, effect authority, sanitization, and configuration validation. A malicious graph must not be able to synthesize a wire to an unauthorized resource.

## Selected decisions

| Decision | Selection and reason | What would reopen it |
|---|---|---|
| D01: Whole-system organization | A, with D for sovereign policy/recovery and high-consequence objects; makes physical and administrative boundaries explicit | Another organization demonstrates the same access, physical, and common-cause properties with a clearer contract |
| D02: Native execution | Object/effect semantics defined in 0304; no global address or ambient syscall authority | A semantic counterexample or evidence that a different contract better expresses the invariants |
| D03: Binary ISA | Unselected; compare minimal object instructions, a capability extension to an existing ISA, and dataflow engines | Completion of the ISA study and refinement evidence, not compatibility pressure |
| D04: Mutable state | Private request regions; persistent owners expose transactions; cross-island exchange uses immutable values or exclusive transfer | A sharing mechanism establishes equivalent confinement, lifetime, observation, and physical ownership properties |
| D05: Communication | Separate physical purpose fabrics and explicit gateway effects | Different physical implementation passes the same topology and independence checks |
| D06: AI operating layer | Isolated intelligence plus trusted interaction, contract checking, and scoped orchestration | A stronger separation preserves user control and remains usable |
| D07: Governance | Local role-scoped authorities with independently required approvals for cross-root changes | A replacement reduces single-authority reach without hiding shared dependencies |
| D08: Protocol engineering | Specify required semantics before choosing an established protocol or developing a new one | Property comparison and review of complete processing/state costs |
| D09: Cross-domain release | Separate access, semantic release approval, exact-output enforcement, carriage, and receiving effects; forbid implicit rights from topology | A simpler construction establishes the same compromised-intermediary, insider, substitution, and physical-path properties |

No chosen ISA is needed to decide that an image decoder gets no storage, network, or administrative edge. Conversely, those edges need enforcement even if its instruction set prevents every tested pointer exploit.

## Processor and memory alternatives

A minimal new instruction family could expose local region allocation, checked object access, typed sends, budgeted calls, and explicit effect preparation. It could eliminate globally meaningful addresses and capability manipulation that the native application model does not need. Its cost is a new compiler target, runtime, verification model, and hardware implementation.

A CHERI-like core could implement local references while the island guard enforces external authority. This reuses substantial instruction/toolchain work but needs temporal safety and proof that privileged modes, debug, and page walks cannot bypass external ownership. Its capability tag does not supply information-flow policy.

A dataflow engine could map a bounded component graph directly onto local execution resources, reducing shared mutable state. Dynamic recursion, exceptions, graph reconfiguration, and interactive workloads may require sequential control islands. That heterogeneity is permitted when the external contract is uniform.

Near-memory or analog compute is considered for numerical acceleration; approximate arithmetic is unsuitable as the sole policy decision mechanism. Reversible or neuromorphic engines remain research candidates for particular workloads. Selection requires defined correctness and failure semantics, not a promise of future efficiency.

## Cross-domain alternatives

A monolithic gateway with both realms' plaintext, policy keys, and raw interfaces concentrates the failure scope and fails R24 unless another independent boundary contains it. A label-only overlay can enforce useful logical policy but does not meet R04. A diode restricts direction and needs separate disclosure control in that direction. The selected construction uses distinct source release control and destination effect enforcement, with confined transformations between them. [0318](0318_cross_domain_security_and_information_release.md) compares it with established cross-domain guidance and states what remains unproved.

One component can perform several noncritical functions within a declared compromise domain. It cannot be counted as multiple independent barriers against its own compromise. Separating semantic approval and emission prevents substitution; it does not make a malicious semantic approver correct.

## Evaluation method

Compare candidates using the same compromised-parser and compromised-planner application graph. Account for local and cross-island latency, private memory footprint, reserved idle capacity, failure containment, update authority, and resource reuse. Include beneficial work and malformed or malicious requests.

An alternative passes R03 only if it provides the required physical ownership and path inventory. A stronger logical proof does not substitute for a physical property it does not model. Likewise, using separate chips does not substitute for R06 effect checks or R11 independent management.

**Hypothesis H01:** private request memory plus typed object messages can make granular isolation the ordinary programming path without pervasive trusted application brokers. **H02:** a heterogeneous physical fabric can recover enough utilization through explicit batching and safe reuse to support useful general workloads. Neither has been demonstrated for ASKA.

The first decision experiments compare A/B/C on identical task contracts; D supplies a deliberately separate boundary for testing common management failure. [0315](0315_research_and_realizations.md) defines what each realization may claim and the evidence required to change a decision.
