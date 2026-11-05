# ASKA v6 — Substrate and unconventional compute research

## Research does not substitute for an enforcing boundary

ASKA permits new physical substrates where they can implement the same ownership, authority and effect contracts with justified assurance. No frontier mechanism is a mandatory dependency of the reference machine. Each candidate must state a falsifiable hypothesis, relevant prior art, physical assumptions, interfaces, evidence gate and a counterexample that would defeat its proposed advantage. A simulation, manufacturer demonstration, laboratory measurement and independently replicated result are different evidence classes.

The first question is what the mechanism is intended to improve: communication distance, energy, memory locality, parallelism, observation, tamper evidence or a specific computational task. The second is which security obligations remain outside it. Faster transport does not authenticate an owner. An unusual memory medium does not authorize release. A physically distinctive object does not prove that the processor attached to it implements the claimed circuit.

**R-19-01 — Falsifiable candidate admission.** Every unconventional substrate proposal MUST identify its intended benefit, assumptions, required interfaces, evidence class and defeating counterexample. It MUST remain optional until it satisfies the same applicable authority, lifecycle and consequence-boundary requirements as the conventional implementation.

## Optical communication and advanced integration

Optical interconnect is a candidate for longer reach or improved bandwidth and energy characteristics in a selected workload. [Intel’s June 2024 announcement](https://www.intel.com/content/www/us/en/newsroom/news/intel-unveils-first-integrated-optical-io-chiplet.html) reports a co-packaged optical I/O chiplet carrying live data. This is primary manufacturer evidence of that demonstration, not independent qualification of ASKA guards, isolation or reliability.

An ASKA optical experiment must include electrical conversion, buffering, link training, error handling, keys where used, and management paths. A fiber is not a data diode merely because light travels along it: the complete transmitter, receiver and control arrangement determines permitted direction. Bidirectional transceivers, diagnostics and sideband electrical paths must be inventoried. Shared lasers, control firmware and power can be common failure or interference sources.

The falsifiable hypothesis is that a selected optical arrangement improves an end-to-end metric while preserving the admitted boundary. Measurements must include conversion and guard overhead, realistic message sizes, link errors, recovery and environment. Failure to meet the metric after those costs defeats that advantage. A successful transport benchmark says nothing by itself about source release or destination acceptance.

Three-dimensional stacking, interposers and heterogeneous chiplets are treated similarly. Their placement can improve locality, but common power, heat, reset and test access remain dependencies. [Packaging qualification](11_heterogeneous_compute_chiplets_and_packaging.md) defines the required inventory. Neither speculative transistor-density forecasts nor a chosen number of compute tiers is a substitute for an area, memory, wiring and cooling budget.

**R-19-02 — End-to-end substrate comparison.** Substrate comparisons MUST include conversion, guard, buffering, control, cooling and lifecycle costs relevant to the claimed benefit. Shared physical dependencies MUST remain visible, and a favorable component metric MUST NOT be promoted to an unmeasured system guarantee.

## Near-memory and analogue computation

Near-memory computation can reduce movement for some workloads, but it places compute authority close to retained data. The candidate must identify whether it acts on ciphertext, plaintext or protected internal representations; who controls the operation; and how an MG-equivalent boundary prevents access beyond the admitted object. A memory device that computes is also a transaction source and belongs in the device threat model.

[IBM Research’s institutional description of its 64-core mixed-signal chip](https://research.ibm.com/publications/a-64-core-mixed-signal-in-memory-compute-chip-based-on-phase-change-memory-for-deep-neural-network-inference) describes analogue in-memory inference combined with digital operations and communication. Only the publication abstract was reviewed for this comparison; no performance number or security property is imported. The candidate establishes a useful research direction, not exact arithmetic or ASKA isolation.

An analogue result needs an error and calibration contract. A verifier may accept a bounded approximation for an inference task while rejecting it for a cryptographic or accounting operation. Calibration state, device drift, retained weights and diagnostic readout are protected state. A claimed energy advantage must include conversion, correction, retraining or recalibration costs required by the actual workload.

## Neuromorphic, dataflow and reversible candidates

[Intel’s Loihi 2 research brief](https://www.intel.com/content/dam/www/central-libraries/us/en/documents/neuromorphic-computing-loihi-2-brief.pdf) describes programmable event-based processing, retained neural state and chip interfaces. It provides a concrete neuromorphic research platform. It does not establish secure isolation, bounded leakage or a general-purpose advantage for ASKA workloads.

An event-driven engine receives explicit input-event objects and an admitted output interface. Event rate, queue growth and retained state are budgeted. A learning rule changes executable behavior or model state and therefore requires the corresponding update contract. A sparse event stream may reveal timing information even when its numeric values are protected. Cancellation must close pending events and state before reassignment.

A spatial/dataflow engine makes placement and communication explicit. Its research gate is not simply higher throughput: token authority, stale-generation rejection, bounded backpressure, interruption and recovery must be specified. A reversible-computing candidate must similarly account for the entire operation, including input preparation, retained history, error correction, output commitment and reset. A theoretical reduction in one form of dissipation is not an unqualified system-energy result.

**R-19-03 — Stateful accelerator semantics.** Analogue, neuromorphic, near-memory and dataflow candidates MUST declare numerical semantics, retained state, calibration or learning authority, cancellation and output checking. Their results MUST remain subject to independent effect authorization and any required semantic validation.

## Quantum and auxiliary-memory hypotheses

Quantum-computing and quantum-sensing ideas remain research hypotheses until a specific controllable physical degree of freedom, encoding, operation set, readout procedure and error model are demonstrated. Terms such as coherence, vortex, entanglement and quantum memory cannot stand in for those missing definitions. Coherent motion of a macroscopic pattern is not, by itself, evidence of an addressable coherent qubit or a useful entangled register.

Candidate directions include superconducting flux systems, optomechanical systems, superfluid vortices and hybrids. Each requires a concrete explanation of state preparation, controllable coupling, independent measurement, noise, scaling and the connection to a useful computation or sensing task. A proposal involving vortex braiding must demonstrate the relevant state space and operations; geometric motion alone is insufficient evidence for the desired computational property.

The primary abstract identifies Sachkou and colleagues’ [study of coherent vortex dynamics in a strongly-interacting superfluid on a silicon chip](https://arxiv.org/abs/1902.04409). Its full text was not available for qualification here. No coherence duration, qubit performance or ASKA feasibility claim is therefore derived from it. A research team must obtain and assess the primary experiment before using it to justify a substrate decision. The same gate applies to broader superfluid-turbulence inspiration: an interesting physical phenomenon is not yet a qualified memory architecture.

An auxiliary memory system, including a proposed quantum-entangled auxiliary memory system, must say exactly what it observes about primary storage. The design needs an authorized coupling, a falsifiable integrity predicate, measurement disturbance analysis, an adversary model and a procedure for distinguishing faults from legitimate writes. It cannot assume an invisible, universally faithful duplicate of arbitrary evolving storage. If the monitor reads classical data through an interface, that interface’s trust and privacy obligations remain. If it claims a new physical measurement, the experiment must establish the claimed observable and its limits.

The [IBM Quantum lesson on limitations of quantum information](https://quantum.cloud.ibm.com/learning/en/courses/basics-of-quantum-information/quantum-circuits/limitations-on-quantum-information) explains restrictions on copying unknown quantum states and discriminating nonorthogonal states. These restrictions concern quantum-state operations; they do not prohibit copying ordinary classical RAM. They also do not validate a proposed quantum-linked monitor of classical memory. That monitor still needs an explicit physical coupling and experimentally supported observable.

Spatiotemporal auxiliary memory (SAMS) and its passively radiative variant (PR-SAMS) are separately scoped sensing candidates. They propose binding write events to physical-context measurements or passive emissions. Qualification must test whether different data writes can produce indistinguishable measurements, whether an attacker can spoof the context and whether legitimate variation causes false alarms. A timestamped environmental digest can bind recorded evidence under its measurement assumptions; it cannot by itself prove the stored bits or the truth of the event description. Claims of negligible observation cost require actual energy, bandwidth and disturbance measurements.

**R-19-04 — Qualified quantum and auxiliary observation.** A quantum or auxiliary-memory mechanism MUST NOT be relied on for mandatory integrity, confidentiality or recovery before its encoding, operations, observation predicate and error behavior are experimentally established. Missing evidence MUST be recorded as a research gap, not filled by analogy to unrelated coherence or sensing results.

## Physical identity, key cartridges and independent sensing

Physical microstructures or other distinctive artifacts may support provenance and tamper-evidence workflows. The contract must specify enrollment, measurement resolution, environmental tolerance, false acceptance, replacement and binding to a digital statement. A measured identifier can help identify the artifact under those assumptions. It cannot alone establish the truth of firmware, the absence of malicious circuitry or the lawful authority of a claimant.

A physically delivered one-time-pad cartridge is a separate key-logistics candidate. Its security depends on pad generation, independent distribution, protected reading, exact consumption, prevention of reuse and handling of compromise or lost inventory. The reader’s counter and key erasure must survive the relevant crashes. If two receivers possess the same pad, confidentiality depends on both copies’ custody; physical delivery is not equivalent to unclonability. Encryption still needs a separate integrity/authentication contract and release authorization.

A cartridge may be useful in an offline deployment with an admitted supply chain. It must not introduce a universal remote headquarters key or a maintenance reader able to export every realm’s secrets. The key inventory, usage receipts and any evidence exports receive their own labels and retention. Deleting a consumed key from one slot is not proof that all copies disappeared.

A quantum-assisted one-time-pad proposal additionally needs a qualified key-generation or distribution protocol, authentication, custody and consumption model. Entanglement terminology does not supply those contracts. A zero-knowledge execution-environment candidate likewise must specify whether its goal is encrypted computation, distributed confidentiality or verification of a computation, and identify the protocol and leakage model for each claimed property. A proof result cannot be used as an unspecified substitute for all three.

**R-19-05 — Bounded physical identity and key logistics.** Physical identifiers, sensors and key media MUST have explicit enrollment, custody, measurement and recovery contracts. They MUST NOT be treated as universal hardware truth, authority or unclonability, and one-time key material MUST never be reused after an ambiguous consumption event.

## Research progression and stopping rules

A candidate moves from concept to physical model, bounded prototype, adversarial measurement, integration qualification and, where justified, replicated evidence. Each transition has a stopping rule. A model that requires an unavailable sensor resolution, uncontrollable noise source or unrealistic cooling condition is rejected or narrowed before it becomes a dependency of a safety claim. A prototype that works only with disabled guards must be reported as such.

The comparison baseline is an implementable conventional arrangement with the same authority and workload contract. A candidate can be valuable without replacing that baseline: optical links may carry guarded records, an analogue engine may propose an inference result, or a physical sensor may add evidence to reconciliation. These integrations keep benefits local and prevent a speculative substrate from acquiring machine-wide trust.

**R-19-06 — Staged evidence gates.** Research promotion MUST require documented passage through the applicable physical, semantic, adversarial and integration gates. Failure MUST preserve a viable conventional fallback or explicitly remove the unsupported service from the deployment claim.

Acceptance specifications are:

- **T-19-01:** Review a candidate without a measurable hypothesis or defeating counterexample. It must remain a research proposal and cannot become a mandatory protection dependency.
- **T-19-02:** Recalculate a claimed benefit including omitted conversion, guard and cooling costs. The claim must be revised or rejected if the advantage no longer holds.
- **T-19-03:** Cancel a stateful accelerator during learning or calibration, then reassign it. No prior-owner state or pending event may affect the new owner outside the declared sanitization scope.
- **T-19-04:** Demand a repeatable preparation, operation and readout experiment for an auxiliary quantum-memory claim. An analogy, simulation alone or unrelated coherence observation cannot pass the gate.
- **T-19-05:** Crash a key reader after pad consumption but before receipt delivery, and replay a physical identifier under altered conditions. Pad reuse must remain impossible, and identity evidence must retain its measured limits.
- **T-19-06:** Disable a proposed frontier component. The stated conventional fallback must preserve the claimed service, or the system must explicitly report that the unsupported service is unavailable.
