# ASKA v6 — Security-substrate research frontier and independent validation

**Status:** open research agenda and evidence policy. Optional technologies must remain outside the trusted proof boundary until their defined mechanisms and relevant costs are demonstrated.

## 1. Research ordering

A secure architecture begins with effects and observable invariants, not attractive components. For each candidate, define the adversary, protected resource, claim, necessary hardware/software boundary, counterexample, credible comparison system, test oracle and manufacturing/runtime cost. Existing approaches—separation kernels, IOMMUs, capabilities, confidential computing, device assignment, attested channels and guarded gateways—must be evaluated before selecting a new ISA, physical sensor or network protocol. Reusing an established mechanism is valid when it meets the declared property.

The independent-security research program has several interacting hypotheses. **H-OBS:** a physically rooted, non-writable telemetry exporter and observer can preserve selected security visibility when an ordinary host kernel is fully compromised. **H-SCOPE:** protected local response gates can preserve useful authorized work while confining attackers and false alarm cascades. **H-DIST:** physically one-way configuration distribution plus independent reporting and local admission can prevent compromise of one mesh role from granting all roles' privileges. **H-EVOL:** independent staging and update roots can reduce correlated fleet damage from signer-valid defective packages. Each requires a demonstrator and a falsifiable failure metric.

## 2. Candidate sensing mechanisms

Study on-chip event mirroring at interconnect endpoints, protected DMA fault exports, memory-controller counters, storage-controller sidebands, external PHY mirroring, chiplet-to-observer link isolation, and independent optical/electrical buses. For each mechanism, specify what it cannot see (registers, caches, hidden device work, encrypted contents, alternate paths), how it changes timing and power, and which silicon/firmware must be trusted. A 'passive' design that uses debug-bus commands or polling DMA becomes an active observation profile and must be evaluated as such.

A proposed sideband RAM/SSD integrity sensor must demonstrate that its output is physically coupled to the intended data, cannot write or suppress observed transactions, handles queue saturation, and reports false negatives. A research paper's block diagram and claims of 'zero overhead' cannot substitute for transistor-level or at least FPGA/board-level evidence. Real systems may need multiple taps or explicit admission snapshots; acceptable partial coverage may still be useful if accurately described.

## 3. Compute organization

Investigate (a) private execution islands with small externally enforced message endpoints, (b) CHERI-like native capability cores, (c) task/dataflow engines with typed edge authority, (d) heterogeneous GPU/FPGA services behind mandatory I/O boundaries, and (e) physically independent sovereign appliances. Compare instruction and ABI costs, capability memory/tag overhead, invalidation latency, context reuse, cache/isolation leakage, DMA attack reachability and dependency on a privileged runtime. The first prototype may use conventional processors provided it does not reclassify shared-kernel isolation as physical independence.

The research may explore dense 3D integration, modular chiplets, photonic interconnect, near-memory compute, reversible compute, analog acceleration or neuromorphic engines. None supplies security by itself. They must preserve the object/effect contract and provide concrete resource/clock/repair failure models. Hardware placement decisions should follow measured guard latency, copy traffic, per-cell idle capacity and physically inspectable authority routing.

## 4. Network and key-system research

Compare independently guarded physical transceivers, optical diodes, protocol-level unidirectionality, SCION/path-aware routing, reserved-capacity fabrics, transport AEAD and independent destination acceptance. An authenticated path does not authorize the content. A path proof is not physical geography. A private STN for key custody must be measured for service latency, physical independence, governance and outage recovery; using a separate network name is insufficient.

Select reviewed conventional and post-quantum cryptographic suites by risk and compatibility. Evaluate QKD only under an explicit optical-channel and trusted-endpoint assumption; the presence of entangled photons does not attest an OS, sensor or human authorization. Study threshold or multiparty custody as needed for independent key recovery, documenting participation thresholds and potential common administrators.

## 5. Media and physical-evidence research

Calibrated environmental spatiotemporal signals may support forensic correlation and media provenance if the sensor and capture chain are trusted under a specified observation model. They do not make a cryptographic digest a proof of scene truth. Privacy blurring and biometric-protection systems need adversarial re-identification and consent tests. Physical microstructure witness artifacts require measurements of reproducibility, forgery/clone cost, independent verification and custody. Quantum-entangled auxiliary memory as a general remote nondestructive integrity technique has no established implementation contract here and cannot be relied on for operational safety.

## 6. Evaluation evidence hierarchy

An ASKA result must name which of these was supplied: architectural proposal, executable model, mechanized proof with assumptions, verified RTL/netlist claim, FPGA proof-of-concept, fabricated measurement, independent replication or long-running production field evidence. A paper demonstrating an isolated module does not prove the full networked machine; a vendor result is attributed to that vendor; a standard specifies an interface but does not demonstrate safe implementation. Patent claims and speculative diagrams are not validation evidence.

The source register [30](30_sources_and_evidence.md) contains external mechanisms for comparison; it is not an assertion of novelty, patent entitlement or a comprehensive literature review. For each newly researched mechanism, record primary source, version/date, exact inspected sections, relevant threat model, trusted functions, measured variables, artifacts and missing evidence. Re-evaluate claims when firmware or source revisions change.

## 7. Independent test rigs and adversarial methods

Build a physical laboratory with at least two independent IES/LSM sites, a one-way configuration link, separate telemetry and watcher channels, a protected response owner and a recovered host fault path. Deliberately compromise one participant at a time. Test crashes, signed malformed configuration, partial reconfiguration, forged security telemetry, disabled clock, BMC access, co-resident DMA, cache-only operations, storage journal replay, source-key compromise and multiple shared-root failures.

Reference results compare against: well-configured conventional OS+EDR, a properly configured separation microkernel, a capability system, and a guarded physical-appliance design where each matches the tested threat model. Include time to deploy, operator burden, silicon/interconnect costs, throughput, power, energy per useful effect, detection specificity and recovery from failure. Do not select only adversaries a new mechanism was designed to beat.

## 8. Stopping rules

A candidate is postponed or rejected if it cannot make an independently measurable security claim; repeatedly fails a basic negative test; cannot be manufactured or recovered within a stated cost envelope; transfers an unacceptable privileged TCB into a supposedly passive observer; or creates more correlated failure than it prevents. If an existing proven abstraction meets the requirement under the target workload, prefer it unless another candidate establishes a meaningful improvement. An unbuilt long-term component does not excuse a bypass in the integrated design.

The research roadmap [28](28_research_program_and_realizations.md) owns milestones; conformance [27](27_conformance_tests_and_vectors.md) and [43](43_security_mesh_formal_model_and_test_vectors.md) own test claims; traceability [29](29_traceability_and_conformance.md) carries known deficits through every realization.
