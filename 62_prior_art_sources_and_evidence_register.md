# ASKA v6 — Prior art, sources and evidence register

## 1. Evidence policy and scope

This register identifies the primary sources used to delimit mechanisms, compare architectural choices and specify falsifiable evidence obligations. It contains 106 distinct primary-source records. Entries based on abstracts, catalog records or unavailable full text are identified by their stated access limits. Full text, author summaries, publisher abstracts and catalog metadata have different evidentiary weight; each entry records the material available for the stated comparison.

Each entry names the responsible institution or authors, publication/version status, exact URL, inspected location, supported proposition and boundary beyond which it supplies no evidence. Source IDs are navigation aids accompanied by actual links. They are not certificates. ASKA design obligations remain proposed even when an external system demonstrates a useful related mechanism. No patent grant, novelty determination or manufactured ASKA system is asserted.

Standards versions are pinned where supplied. Living documentation requires rechecking before an implementation freezes a profile. A draft remains a draft; a vendor demonstration remains a vendor report. Successful retrieval establishes availability of the cited text, not truth of every statement in it. A temporary retrieval failure is reported as an access limitation, not evidence that a publication is nonexistent.

## 2. Property-driven comparison matrix

The comparison asks which boundary each source controls. The architectural delta is an ASKA requirement or inference, not a claim made by the source authors.

| Property and primary sources | Comparison axis | ASKA evidence gap |
|---|---|---|
| Classical protection, privilege and integrity: [H01: Lampson](https://bwlampson.site/08-Protection/WebPage.html); [H02: Saltzer–Schroeder](https://web.mit.edu/Saltzer/www/publications/protection/); [H03: Multics](https://doi.org/10.1145/361011.361067); [H11: Confused Deputy](https://doi.org/10.1145/54289.871709); [H12: Clark–Wilson](https://doi.org/10.1109/SP.1987.10001); [H24: KeyKOS](https://pdos.csail.mit.edu/6.828/2008/readings/keykos-osr.pdf) | Access control, complete mediation, rings, authority confusion and integrity-preserving transactions have a long lineage. | The claimed delta is cross-domain effect binding and physical enforcement in a specified apparatus, not invention of capabilities or a small trusted base. |
| Flow policy and proof lineage: [H04: Bell–LaPadula](https://lukemuehlhauser.com/wp-content/uploads/Bell-LaPadula-Secure-computer-systems-mathematical-foundations.pdf); [H05: Biba](https://www.cerias.purdue.edu/apps/reports_and_papers/view/2834/); [H06: Denning](https://doi.org/10.1145/360051.360056); [H09: HiStar](https://static.usenix.org/event/osdi06/tech/zeldovich.html); [H10: Flume](https://doi.org/10.1145/1294261.1294293); [H16: robust declassification](https://www.cs.cornell.edu/andru/papers/robdecl-jcs/) | Confidentiality, integrity, lattices, DIFC and controlled release are prior art. | An ASKA-specific refinement must establish semantics and implement all named output channels; terminology supplies no novelty. |
| Verified and compartmentalized alternatives: [H23: seL4 functional correctness](https://researchportalplus.anu.edu.au/en/publications/sel4-formal-verification-of-an-os-kernel/); [H25: Qubes architecture](https://www.qubes-os.org/doc/QubesArchitecture/) | Machine-checked minimal kernels and purpose-specific isolated VMs are viable pre-existing approaches. | Physical-owner design must justify extra hardware and institution roots with measured separation, useful work and lifecycle economics. |
| Partition and distributed effect lineage: [H07: Rushby](https://www.csl.sri.com/papers/sosp81/); [H08: MILS](https://www.inderscience.com/info/inarticle.php?artid=14859); [H13: Sagas](https://www.cs.princeton.edu/techreports/1987/070.pdf); [H14: end-to-end arguments](https://web.mit.edu/saltzer/www/publications/endtoend/endtoend.pdf); [H15: Helland](https://www.cidrdb.org/cidr2007/papers/cidr07p15.pdf); [H17: linearizability](https://doi.org/10.1145/78969.78972) | Separability, compositional assurance, compensation and scoped finality are established lines of work. | Source/receiver finality across physical effect owners still requires a defined model, inspection and negative controls. |
| Attenuating credentials: [H22: Macaroons](https://research.google/pubs/macaroons-cookies-with-contextual-caveats-for-decentralized-authorization-in-the-cloud/); [H11: Confused Deputy](https://doi.org/10.1145/54289.871709) | Caveated distributed credentials already attenuate delegated authority; preventing confused deputies is not a new idea. | ASKA must show its added locally enforced obligations, physical consequence finality and separate recipient admission. |
| Capability and trusted interaction: [H18: EROS](https://doi.org/10.1145/319151.319163); [H19: EROS trusted window](https://www.usenix.org/conference/13th-usenix-security-symposium/design-eros-trusted-window-system) | Fine-grained object capabilities, persistent object protection and small trusted intent paths have prior implementations. | ASKA must prove its own object-lifetime semantics and exact effect binding under an explicit trusted-input threat model. |
| AI tool-use control: [H20: Fides](https://www.microsoft.com/en-us/research/publication/securing-ai-agents-with-information-flow-control/); [A17: CaMeL](https://arxiv.org/abs/2503.18813) | Deterministic information-flow restrictions and tool authorization for agents are active prior art. | An ASKA model may propose only effects already admitted and enforced by the local owner; an agent-IFC publication is not an ASKA proof. |
| Hardware one-way links: [H21: NIST SP 800-53 AC-4(7)](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) | Hardware-based one-way flow controls and cross-domain policy are documented standards practice. | Inspect every alternate management and data path; independently validate payload and receiver policy before publication. |
| Owned compute and heterogeneous interfaces: [P01: CHERI FAQ](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html); [P02: M3: A Hardware/Operating-System Co-Design to Tame Heterogeneous Manycores](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf); [P03: Minimizing a Smartphone’s TCB for Security-Critical Programs with Exclusively-Used, Physically-Isolated, Statically-Partitioned Hardware (OctopOS)](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf); [P04: CHERIoT book: Memory management](https://cheriot.org/book/memory.html); [P15: CURE: A Security Architecture with CUstomizable and Resilient Enclaves](https://www.usenix.org/system/files/sec21summer_bahmani.pdf) | Local reference checks, external communication guards and exclusive resources are different boundaries. | Native spatial ownership, guard placement, lifetime and common roots require their own combined evidence. |
| Devices, memory and packaging: [P05: RISC-V IOMMU Introduction](https://docs.riscv.org/reference/iommu/v20260222/iommu_intro.html); [P06: IOPMP architecture](https://github.com/riscv-non-isa/riscv-iopmp/blob/main/chapter2.adoc); [P16: ACAI: Protecting Accelerator Execution with Arm Confidential Computing Architecture](https://www.usenix.org/system/files/usenixsecurity24-sridhara.pdf); [P17: Elasticlave: An Efficient Memory Model for Enclaves](https://www.usenix.org/system/files/sec22-yu-jason.pdf); [P18: Guidelines for Media Sanitization](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-88r2.pdf); [P14: UCIe Specifications overview](https://www.uciexpress.org/specifications) | Device translation, shared enclave memory, accelerator protection and sanitization address specific resource paths. | No cited interface standard eliminates every peer-DMA, management, persistence or package failure path. |
| Flow, authority and timing: [F01: Securing Distributed Systems with Information Flow Control (DStar)](https://usenix.org/events/nsdi08/tech/full_papers/zeldovich/zeldovich.pdf); [F02: What the Proofs Assume](https://sel4.systems/Verification/assumptions.html); [F03: Flow-Limited Authorization](https://www.cs.cornell.edu/andru/papers/flam/flam-csf15.pdf); [F04: Fabric: A Platform for Secure Distributed Computation and Storage](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.pdf); [F05: Time Protection: The Missing OS Abstraction](https://trustworthy.systems/publications/full_text/Ge_YCH_19.pdf); [F06: HyperFlow: A Processor Architecture for Nonmalleable, Timing-Safe Information Flow Security](https://www.cs.cornell.edu/andru/papers/hyperflow/hyperflow.pdf); [F07: A Verified Information-Flow Architecture](https://davidpichardie.github.io/papers/popl14.pdf); [F08: PUMP: A Programmable Unit for Metadata Processing](https://ic.ese.upenn.edu/pdf/pump_hasp2014.pdf); [F21: Ryoan: A Distributed Sandbox for Untrusted Computation on Secret Data](https://www.usenix.org/system/files/conference/osdi16/osdi16-hunt.pdf) | Distributed labels, authorization logic, tagged execution and request confinement have distinct models and assumptions. | An ASKA implementation must refine its exact release, physical and side-channel claims instead of combining source guarantees by name. |
| Independent observation and recovery: [S01: Remote ATtestation procedureS (RATS) Architecture, RFC 9334](https://www.rfc-editor.org/rfc/rfc9334.html); [S04: Platform Firmware Resiliency Guidelines, SP 800-193](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-193.pdf); [S05: Security Protocol and Data Model (SPDM), DSP0274](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf); [S06: DMTF-2026-0003: SPDM FINISH transcript OpaqueData advisory](https://github.com/DMTF/libspdm/security/advisories/GHSA-chjj-xvqx-c8w4); [S12: Copilot—a Coprocessor-based Kernel Runtime Integrity Monitor](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/); [S13: Vigilare: Toward Snoop-based Kernel Integrity Monitor](https://cysec.kr/publications/vigilare.pdf); [F19: Secure connectivity principles for operational technology: Principle 5, Harden your OT boundary](https://www.ncsc.gov.uk/collection/operational-technology/secure-connectivity/principle-5) | Attestation, firmware resilience, snapshot and bus-snoop observation expose different evidence boundaries. | No source supplies complete passive RAM/SSD semantics, infinitely independent watchers or safe arbitrary response. |
| Distribution and synthesis: [S02: The Update Framework Specification](https://theupdateframework.github.io/specification/v1.0.36/); [S03: Secure Software Development Framework (SSDF) Version 1.1, SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final); [S07: SLSA v1.2: Build requirements for producing artifacts](https://slsa.dev/spec/v1.2/build-requirements); [S08: Definitions: When is a build reproducible?](https://reproducible-builds.org/docs/definition/); [S09: in-toto: Providing farm-to-table guarantees for bits and bytes](https://www.usenix.org/system/files/sec19-torres-arias.pdf); [S15: SSDF publications and SP 800-218 Revision 1 initial public draft](https://csrc.nist.gov/pubs/sp/800/218/r1/ipd) | Artifact origin, build provenance, reproducibility and development practice are separate from program behavior. | Correctly signed or reproducible defects still require local scope checks, protected tests and controlled deployment. |
| Authenticated paths and records: [P07: SCION Header Specification](https://docs.scion.org/en/latest/protocols/scion-header.html); [P08: The Transport Layer Security Protocol Version 1.3](https://www.rfc-editor.org/rfc/rfc8446.html); [P09: An Interface and Algorithms for Authenticated Encryption](https://www.rfc-editor.org/rfc/rfc5116.html); [P11: EPIC: Every Packet Is Checked](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf); [P12: Verifying and Enforcing Network Paths with ICING](https://www.cs.utexas.edu/icing/papers/icing-conext11.pdf); [P13: FABRID: Flexible Attestation-Based Routing for Inter-Domain Networks](https://www.usenix.org/system/files/sec23fall-prepub-135-krahenbuhl.pdf); [F22: FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard](https://csrc.nist.gov/pubs/fips/203/final); [F23: FIPS 204: Module-Lattice-Based Digital Signature Standard](https://csrc.nist.gov/pubs/fips/204/final); [F24: FIPS 205: Stateless Hash-Based Digital Signature Standard](https://csrc.nist.gov/pubs/fips/205/final); [F25: Quantum Cryptographic Solutions are Limited Compared to Post-Quantum Algorithms](https://www.nsa.gov/Cybersecurity/Post-Quantum-Cryptography-Resource-Hub/Article-Display/Article/4616320/quantum-cryptographic-solutions-are-limited-compared-to-post-quantum-algorithms/) | Transport integrity and path validation have defined endpoint and network assumptions. | Physical cable geography, source disclosure and receiving permission are separate obligations. |
| Optional cross-party computation: [A16: MPC from somewhat homomorphic encryption](https://pure.au.dk/portal/en/publications/multiparty-computation-from-somewhat-homomorphic-encryption/); [A15: threshold cryptography roadmap](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8214A.pdf) | MPC and threshold cryptography give distinct constructions under selected threat models. | Each deployment must specify corruptions, output control, abort and side-channel assumptions; neither method supplies authorizing authority. |
| Civil objects, provenance and privacy: [A01: Concise Binary Object Representation (CBOR)](https://www.rfc-editor.org/rfc/rfc8949); [A02: CBOR Object Signing and Encryption (COSE): Structures and Process](https://www.rfc-editor.org/rfc/rfc9052); [A03: Verifiable Credentials Data Model v2.0](https://www.w3.org/TR/vc-data-model-2.0/); [A04: Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/); [A05: OAuth 2.0 Rich Authorization Requests](https://www.rfc-editor.org/rfc/rfc9396); [A06: C2PA Technical Specification](https://spec.c2pa.org/specifications/specifications/2.3/specs/C2PA_Specification.html); [A10: Voluntary Voting System Guidelines Version 2.0](https://www.eac.gov/sites/default/files/TestingCertification/Voluntary_Voting_System_Guidelines_Version_2_0.pdf); [A11: ODRL Information Model 2.2](https://www.w3.org/TR/odrl-model/); [A12: Certificate Transparency Version 2.0](https://www.rfc-editor.org/rfc/rfc9162); [A13: Digital Identity Guidelines: Authentication and Authenticator Management](https://pages.nist.gov/800-63-4/sp800-63b.html); [A14: Guidelines for Evaluating Differential Privacy Guarantees](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-226.pdf); [A15: NIST Roadmap Toward Criteria for Threshold Schemes for Cryptographic Primitives](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8214A.pdf) | Encoding, credentials, provenance and governance guidelines contribute scoped mechanisms or assessment criteria. | They do not establish legal legitimacy, ballot secrecy in an arbitrary deployment, scene truth or universal key access. |
| AI and signal quality: [A07: Model Context Protocol: Tools](https://modelcontextprotocol.io/specification/2025-06-18/server/tools); [A08: Model Context Protocol: Security Best Practices](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices); [A09: Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf); [A17: Defeating Prompt Injections by Design (CaMeL)](https://arxiv.org/html/2503.18813v2); [S10: On Calibration of Modern Neural Networks](https://proceedings.mlr.press/v70/guo17a/guo17a.pdf); [S11: Outside the Closed World: On Using Machine Learning for Network Intrusion Detection](https://www.icir.org/robin/papers/oakland10-ml.pdf); [S14: Guide to Operational Technology (OT) Security, SP 800-82 Revision 3](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r3.pdf); [S16: SP 800-82 Revision 3 publication record and Revision 4 planning note](https://csrc.nist.gov/pubs/sp/800/82/r3/final) | Tool interfaces, constrained agent execution, calibration and operational risk guidance inform separate design obligations. | Model confidence, tool metadata or a detector alert cannot mint permission or establish actuator safety. |
| Formal methods, fault cases and frontier physics: [F09: Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119.html); [F10: Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174.html); [F11: Identifiers and Test Vectors for HMAC-SHA-224, HMAC-SHA-256, HMAC-SHA-384, and HMAC-SHA-512](https://www.rfc-editor.org/rfc/rfc4231.html); [F12: TLA+ Tools](https://lamport.azurewebsites.net/tla/tools.html); [F13: Tamarin Prover Manual: Introduction](https://tamarin-prover.com/manual/master/book/001_introduction.html); [F14: RCE via OOM corruption](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w); [F15: RCE via stale global state](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp); [F16: FORCEDENTRY: Sandbox Escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html); [F17: A deep dive into an NSO zero-click iMessage exploit: Remote Code Execution](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html); [F18: Impossibility of Distributed Consensus with One Faulty Process](https://groups.csail.mit.edu/tds/papers/Lynch/jacm85.pdf); [F20: Limitations on quantum information](https://quantum.cloud.ibm.com/learning/en/courses/basics-of-quantum-information/quantum-circuits/limitations-on-quantum-information); [P19: Intel Demonstrates First Fully Integrated Optical I/O Chiplet](https://www.intel.com/content/www/us/en/newsroom/news/intel-unveils-first-integrated-optical-io-chiplet.html); [P20: A 64-core mixed-signal in-memory compute chip based on phase-change memory for deep neural network inference](https://research.ibm.com/publications/a-64-core-mixed-signal-in-memory-compute-chip-based-on-phase-change-memory-for-deep-neural-network-inference); [P21: Taking Neuromorphic Computing to the Next Level with Loihi 2](https://www.intel.com/content/dam/www/central-libraries/us/en/documents/neuromorphic-computing-loihi-2-brief.pdf) | Conformance notation, primitive vectors, formal tools, real vulnerability analyses and component demonstrations support bounded comparisons. | No finite model, vendor component result or quantum limitation proves the complete machine or a proposed sensor. |

## 3. Primary source register

The baseline of comparison includes early capability models, information-flow lattices, integrity controls, Multics, separation kernels, MILS and distributed transaction semantics. These are architectural predecessors, not evidence of ASKA novelty. Distinguish a proposed combination from each mechanism already documented in the literature.

### H01 — Protection

**Primary source:** [Protection](https://bwlampson.site/08-Protection/WebPage.html). **Responsibility:** Butler W. Lampson. **Publication:** 1971; Princeton Symposium, reprinted 1974.

**Access and inspected material:** Author-hosted text, introduction and abstract. **Supported proposition:** Access control and protection models predate the proposed grant vocabulary. **Limit:** A protection model alone establishes neither live effect finality nor complete hardware reachability.

**Architectural comparison:** [Chapter 01](01_system_architecture.md), [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 31](31_accord_system_and_machine_authorization.md).

### H02 — The Protection of Information in Computer Systems

**Primary source:** [The Protection of Information in Computer Systems](https://web.mit.edu/Saltzer/www/publications/protection/). **Responsibility:** Jerome H. Saltzer and Michael D. Schroeder. **Publication:** Proceedings of the IEEE 63(9), 1975.

**Access and inspected material:** Author-hosted text, introduction and design-principle material. **Supported proposition:** Economy of mechanism, complete mediation, least privilege and separation of privilege are established design guidance. **Limit:** Design guidance does not verify the size or correct implementation of an ASKA reference monitor.

**Architectural comparison:** [Chapter 02](02_requirements_and_threat_model.md), [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 31](31_accord_system_and_machine_authorization.md).

### H03 — Protection and the Control of Information Sharing in Multics

**Primary source:** [Protection and the Control of Information Sharing in Multics](https://doi.org/10.1145/361011.361067). **Responsibility:** Jerome H. Saltzer. **Publication:** Communications of the ACM 17(7), 1974.

**Access and inspected material:** Publisher bibliographic record and abstract; author publication record. **Supported proposition:** Multics applied rings, access control and protected sharing in an earlier general-purpose system. **Limit:** The Multics design does not show that per-purpose physical boards are necessary or economically superior.

**Architectural comparison:** [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 04](04_reference_machine_and_reachability.md), [Chapter 10](10_processor_isa_and_execution_semantics.md).

### H04 — Secure Computer Systems: Mathematical Foundations

**Primary source:** [Secure Computer Systems: Mathematical Foundations](https://lukemuehlhauser.com/wp-content/uploads/Bell-LaPadula-Secure-computer-systems-mathematical-foundations.pdf). **Responsibility:** David E. Bell and Leonard J. LaPadula. **Publication:** MITRE MTR-2547, Vol. I; 1973.

**Access and inspected material:** Public copy of report, title and abstract; mirror, not publisher site. **Supported proposition:** Formal confidentiality policy and state-machine security predate the ASKA flow calculus. **Limit:** The model does not settle integrity, declassification, effects or physical device paths.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 55](55_formal_properties_and_state_models.md).

### H05 — Integrity Considerations for Secure Computer Systems

**Primary source:** [Integrity Considerations for Secure Computer Systems](https://www.cerias.purdue.edu/apps/reports_and_papers/view/2834/). **Responsibility:** Kenneth J. Biba. **Publication:** MITRE ESD-TR-76-372; April 1977.

**Access and inspected material:** Purdue CERIAS report catalog and abstract only; full report not inspected. **Supported proposition:** Integrity is a distinct policy problem from confidentiality, with formal access constraints. **Limit:** Catalog metadata is not an inspected proof; no ASKA endorsement or device guarantee follows.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md).

### H06 — A Lattice Model of Secure Information Flow

**Primary source:** [A Lattice Model of Secure Information Flow](https://doi.org/10.1145/360051.360056). **Responsibility:** Dorothy E. Denning. **Publication:** Communications of the ACM 19(5), 1976.

**Access and inspected material:** Publisher abstract and bibliographic record. **Supported proposition:** Security classes and information-flow restrictions admit a lattice formulation. **Limit:** ASKA needs explicit endorsement, release, identity and physical-enforcement semantics beyond the lattice.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 55](55_formal_properties_and_state_models.md).

### H07 — Design and Verification of Secure Systems

**Primary source:** [Design and Verification of Secure Systems](https://www.csl.sri.com/papers/sosp81/). **Responsibility:** John Rushby. **Publication:** SOSP / ACM OSR 15(5), 1981.

**Access and inspected material:** Author/institution landing page and abstract. **Supported proposition:** The separation-kernel argument explicitly considers physically separated components and small verifiable mediation. **Limit:** Separation is not novel by itself; proof and independent hardware claims are apparatus-specific.

**Architectural comparison:** [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 04](04_reference_machine_and_reachability.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md).

### H08 — The MILS Architecture for High-Assurance Embedded Systems

**Primary source:** [The MILS Architecture for High-Assurance Embedded Systems](https://www.inderscience.com/info/inarticle.php?artid=14859). **Responsibility:** Jim Alves-Foss, Paul W. Oman, Carol Taylor and W. Scott Harrison. **Publication:** International Journal of Embedded Systems 2(3/4), 2006.

**Access and inspected material:** Publisher abstract and bibliographic record; full text not inspected. **Supported proposition:** MILS decomposes assurance into manageable isolated components and a separation substrate. **Limit:** Composition and physical-path soundness require evidence; the abstract is not an ASKA assurance result.

**Architectural comparison:** [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 04](04_reference_machine_and_reachability.md), [Chapter 20](20_master_and_local_security_meshes.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md).

### H09 — Making Information Flow Explicit in HiStar

**Primary source:** [Making Information Flow Explicit in HiStar](https://static.usenix.org/event/osdi06/tech/zeldovich.html). **Responsibility:** Nickolai Zeldovich, Silas Boyd-Wickizer, Eddie Kohler and David Mazières. **Publication:** OSDI 2006.

**Access and inspected material:** USENIX proceedings abstract. **Supported proposition:** An operating system with explicit IFC and no superuser predates ASKA non-universal-administrator terminology. **Limit:** HiStar does not establish ASKA physical device isolation or external effect finality.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 09](09_ies_cells_resources_and_scheduling.md).

### H10 — Information Flow Control for Standard OS Abstractions

**Primary source:** [Information Flow Control for Standard OS Abstractions](https://doi.org/10.1145/1294261.1294293). **Responsibility:** Maxwell Krohn, Alexander Yip, Micah Brodsky, Natan Cliffer, M. Frans Kaashoek, Eddie Kohler and Robert Morris. **Publication:** SOSP 2007.

**Access and inspected material:** Publisher abstract and bibliographic record. **Supported proposition:** Flume demonstrates DIFC across processes and standard operating-system abstractions. **Limit:** The paper does not prove that software-only isolation survives a hostile kernel or DMA path.

**Architectural comparison:** [Chapter 07](07_information_flow_and_release.md), [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 38](38_native_apps_toolchains_and_interoperability.md).

### H11 — The Confused Deputy (or Why Capabilities Might Have Been Invented)

**Primary source:** [The Confused Deputy (or Why Capabilities Might Have Been Invented)](https://doi.org/10.1145/54289.871709). **Responsibility:** Norm Hardy. **Publication:** ACM SIGOPS OSR 22(4), 1988.

**Access and inspected material:** Publisher record and author text available through archival copies. **Supported proposition:** A privileged intermediary can misuse its own broad authority on an untrusted caller's behalf. **Limit:** Capability discipline does not by itself identify permissible real-world effects or independent receivers.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md).

### H12 — A Comparison of Commercial and Military Computer Security Policies

**Primary source:** [A Comparison of Commercial and Military Computer Security Policies](https://doi.org/10.1109/SP.1987.10001). **Responsibility:** David D. Clark and David R. Wilson. **Publication:** IEEE Symposium on Security and Privacy, 1987.

**Access and inspected material:** Publisher abstract and bibliographic record. **Supported proposition:** Commercial integrity needs duties and well-formed transactions beyond confidentiality lattices. **Limit:** The model does not establish a particular legal mandate, payment finality or ASKA implementation.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 35](35_governance_profiles_conflicts_and_institutions.md), [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md).

### H13 — Sagas

**Primary source:** [Sagas](https://www.cs.princeton.edu/techreports/1987/070.pdf). **Responsibility:** Hector Garcia-Molina and Kenneth Salem. **Publication:** Princeton TR-070-87; SIGMOD 1987.

**Access and inspected material:** University-hosted primary report, title and abstract. **Supported proposition:** Long-running workflows can use ordered subtransactions and compensating operations. **Limit:** Compensation cannot literally reverse an external physical effect; exact finality still needs an owner.

**Architectural comparison:** [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 17](17_transactions_effects_and_reconciliation.md), [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md).

### H14 — End-to-End Arguments in System Design

**Primary source:** [End-to-End Arguments in System Design](https://web.mit.edu/saltzer/www/publications/endtoend/endtoend.pdf). **Responsibility:** Jerome H. Saltzer, David P. Reed and David D. Clark. **Publication:** ACM TOCS 2(4), 1984.

**Access and inspected material:** Author-hosted primary paper, abstract and introduction. **Supported proposition:** Acknowledgment, recovery and security guarantees often require checks at endpoints, not only lower-level carriers. **Limit:** An end-to-end argument does not license omission of mandatory physical enforcement on a hostile path.

**Architectural comparison:** [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 42](42_physical_transit_topology_and_routing.md), [Chapter 45](45_packet_records_delivery_and_egress.md).

### H15 — Life Beyond Distributed Transactions: An Apostate's Opinion

**Primary source:** [Life Beyond Distributed Transactions: An Apostate's Opinion](https://www.cidrdb.org/cidr2007/papers/cidr07p15.pdf). **Responsibility:** Pat Helland. **Publication:** CIDR 2007; position paper.

**Access and inspected material:** Conference-hosted position paper, abstract. **Supported proposition:** Inter-organizational workflows cannot casually assume a single global atomic transaction. **Limit:** This is an architectural position, not a proof that a specific retry or compensation method is safe.

**Architectural comparison:** [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 17](17_transactions_effects_and_reconciliation.md), [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md).

### H16 — Enforcing Robust Declassification and Qualified Robustness

**Primary source:** [Enforcing Robust Declassification and Qualified Robustness](https://www.cs.cornell.edu/andru/papers/robdecl-jcs/). **Responsibility:** Andrew C. Myers, Andrei Sabelfeld and Steve Zdancewic. **Publication:** Journal of Computer Security 14(2), 2006.

**Access and inspected material:** Author-hosted abstract. **Supported proposition:** Attacker influence on declassification and endorsement must be part of the formal flow claim. **Limit:** A type-system result does not establish physical guards, trusted approval or ASKA release correctness.

**Architectural comparison:** [Chapter 07](07_information_flow_and_release.md), [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 55](55_formal_properties_and_state_models.md).

### H17 — Linearizability: A Correctness Condition for Concurrent Objects

**Primary source:** [Linearizability: A Correctness Condition for Concurrent Objects](https://doi.org/10.1145/78969.78972). **Responsibility:** Maurice P. Herlihy and Jeannette M. Wing. **Publication:** ACM TOPLAS 12(3), 1990.

**Access and inspected material:** Publisher bibliographic record and abstract. **Supported proposition:** Concurrent-object operations can be specified by a single abstract point between invocation and response. **Limit:** Linearizability of a local owner is not remote acknowledgment, physical completion or durable outcome.

**Architectural comparison:** [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 17](17_transactions_effects_and_reconciliation.md), [Chapter 55](55_formal_properties_and_state_models.md).

“Reviewed” means the relevant content at the stated locator was inspected, not that the entire publication was independently reproduced or verified. Repeated appearances of one URL are consolidated and preserve their source-ID aliases. The chapter list shows where the source controls a comparison; those chapters remain responsible for their ASKA requirements.

### H18 — EROS: A Fast Capability System

**Primary source:** [EROS: A Fast Capability System](https://doi.org/10.1145/319151.319163). **Responsibility:** Jonathan S. Shapiro, Jonathan M. Smith and David J. Farber. **Publication:** ACM SOSP 1999.

**Access and inspected material:** Publisher/proceedings bibliographic record and university-hosted paper abstract. **Supported proposition:** EROS and its KeyKOS lineage demonstrate fast, fine-grained object-capability protection and persistence. **Limit:** Capability object isolation alone does not validate ASKA physical device reachability or governed multi-party effects.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 31](31_accord_system_and_machine_authorization.md).

### H19 — Design of the EROS Trusted Window System

**Primary source:** [Design of the EROS Trusted Window System](https://www.usenix.org/conference/13th-usenix-security-symposium/design-eros-trusted-window-system). **Responsibility:** Jonathan S. Shapiro, John Vanderburgh, Eric Northup and David Chizmadia. **Publication:** 13th USENIX Security Symposium, 2004.

**Access and inspected material:** USENIX paper and abstract page. **Supported proposition:** A small trusted display and input mediator with traceability of user intent predates Keystone. **Limit:** Intent-channel isolation alone does not prove users understand consequences or that a downstream effect matches a prompt.

**Architectural comparison:** [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 36](36_keystone_trusted_user_interaction.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md).

### H20 — Securing AI Agents with Information-Flow Control

**Primary source:** [Securing AI Agents with Information-Flow Control](https://www.microsoft.com/en-us/research/publication/securing-ai-agents-with-information-flow-control/). **Responsibility:** Manuel Costa, Boris Koepf, Aashish Kolluri, Andrew Paverd, Mark Russinovich, Ahmed Salem, Shruti Tople, Lukas Wutschitz and Santiago Zanella-Beguelin. **Publication:** Microsoft Research / arXiv, May 2025.

**Access and inspected material:** Institution-hosted abstract describing the Fides planner and formal IFC model. **Supported proposition:** Deterministic information-flow restrictions on agent plans and tools predate ASKA agent boundaries. **Limit:** Its reported model and evaluation do not prove ASKA owner-installed rights or hardware observation independence.

**Architectural comparison:** [Chapter 25](25_security_analysis_ai_and_false_alarm_control.md), [Chapter 37](37_ai_native_operating_environment.md), [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md).

### H21 — Security and Privacy Controls for Information Systems and Organizations, SP 800-53 Revision 5

**Primary source:** [Security and Privacy Controls for Information Systems and Organizations, SP 800-53 Revision 5](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final). **Responsibility:** NIST Joint Task Force. **Publication:** NIST SP 800-53 Rev. 5, corrected December 2020; later minor releases noted.

**Access and inspected material:** Official NIST publication page; AC-4(7) one-way flow mechanism description in publication text. **Supported proposition:** Hardware-based one-way flow mechanisms and cross-domain policy controls are established and cataloged, not an ASKA invention. **Limit:** A diode alone cannot authenticate content, classify payloads, remove physical alternate paths or ensure remote admission.

**Architectural comparison:** [Chapter 20](20_master_and_local_security_meshes.md), [Chapter 23](23_security_mesh_fabrics_and_one_way_links.md), [Chapter 42](42_physical_transit_topology_and_routing.md).

### H22 — Macaroons: Cookies with Contextual Caveats for Decentralized Authorization in the Cloud

**Primary source:** [Macaroons: Cookies with Contextual Caveats for Decentralized Authorization in the Cloud](https://research.google/pubs/macaroons-cookies-with-contextual-caveats-for-decentralized-authorization-in-the-cloud/). **Responsibility:** Arnar Birgisson, Joe Gibbs Politz, Úlfar Erlingsson, Ankur Taly, Michael Vrable and Mark Lentczner. **Publication:** NDSS 2014.

**Access and inspected material:** Research-institution publication abstract. **Supported proposition:** Chained caveats support decentralized, attenuating bearer credentials and conditional discharge at a relying service. **Limit:** Credential attenuation is not semantic correctness of policy evidence, user intent, source disclosure or a protected hardware effect.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md). ASKA grant attenuation must not be presented as newly invented; its additional check is the receiver's installed, locally enforced consequence contract.

### H23 — seL4: Formal Verification of an OS Kernel

**Primary source:** [seL4: Formal Verification of an OS Kernel](https://researchportalplus.anu.edu.au/en/publications/sel4-formal-verification-of-an-os-kernel/) (ANU author-institution publication record; [seL4 publication index](https://www.sel4.systems/Research/publications.html)). **Responsibility:** Gerwin Klein and colleagues. **Publication:** ACM Symposium on Operating Systems Principles (SOSP), 2009; DOI [10.1145/1629575.1629596](https://doi.org/10.1145/1629575.1629596).

**Access and inspected material:** Author-institution abstract and project publication record. **Supported proposition:** Machine-checked functional correctness from a formal kernel specification to its C implementation is established prior art, with hardware, assembly, compiler and boot assumptions in the published proof's scope. **Limit:** A kernel proof does not validate ASKA policy interpretation, live hardware paths, human intent or an external effect's finality.

**Architectural comparison:** [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md). A simpler verified software boundary is an alternative requiring a matched threat model and operating cost comparison; more guards are not automatically stronger.

### H24 — The KeyKOS Architecture

**Primary source:** [The KeyKOS Architecture](https://pdos.csail.mit.edu/6.828/2008/readings/keykos-osr.pdf) (Norman Hardy's document, university-hosted archival copy). **Responsibility:** Norman Hardy and Key Logic. **Publication:** *Operating Systems Review*, September 1985; linked eighth edition, December 1990.

**Access and inspected material:** University-hosted archived edition, bibliographic identification; full edition not independently analyzed. **Supported proposition:** Capability-based kernel objects and message-mediated delegation were established before EROS and ASKA. **Limit:** The paper is not an implementation-specific proof of ASKA's bank guards, modern DMA protections, or social authority interpretation.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 16](16_persistent_objects_storage_and_hese_dar.md). The claimed contribution cannot rest on capability names or object isolation alone.

### H25 — Qubes OS Security by Compartmentalization

**Primary source:** [Qubes OS architecture](https://www.qubes-os.org/doc/QubesArchitecture/) (project documentation; [security design goals](https://doc.qubes-os.org/en/r4.3/developer/system/security-design-goals.html)). **Responsibility:** Qubes OS Project. **Publication:** Living project architecture documentation, Qubes OS 4.3 series.

**Access and inspected material:** Primary project architecture and stated design goals. **Supported proposition:** Purpose-specific isolated desktop compartments, protected user-facing separation and constrained cross-VM transfers are deployed design patterns atop a hypervisor. **Limit:** Virtual-machine boundaries and privileged service domains are not equivalent to ASKA's proposed separately owned physical banks; neither the Qubes project nor ASKA has thereby proven the other's scope.

**Architectural comparison:** [Chapter 04](04_reference_machine_and_reachability.md), [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md), [Chapter 58](58_performance_cost_power_and_availability.md). A credible physical-owner profile must demonstrate incremental protection relative to a compartmentalized software baseline at matched useful work and cost.

### F01 — Securing Distributed Systems with Information Flow Control (DStar)

**Primary source:** [Securing Distributed Systems with Information Flow Control (DStar)](https://usenix.org/events/nsdi08/tech/full_papers/zeldovich/zeldovich.pdf). **Responsibility:** Nickolai Zeldovich, Silas Boyd-Wickizer and David Mazières; Stanford/USENIX. **Date/version:** NSDI 2008.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** Sections 2.1, 3.2–3.4 and 4.2–4.3. **Supported proposition:** Exporter label mapping and separately assessed distributed trust support bilateral IFC. **Limit:** No whole ASKA machine, physical geography or arbitrary device-path guarantee.

**Architectural comparison:** [Chapter 01](01_system_architecture.md), [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 55](55_formal_properties_and_state_models.md).

### F02 — What the Proofs Assume

**Primary source:** [What the Proofs Assume](https://sel4.systems/Verification/assumptions.html). **Responsibility:** seL4 project. **Date/version:** Live project statement inspected 2026-11-04.

**Publication/access status:** official project documentation. Primary text opened; cited sections inspected

**Inspected location:** The Assumptions; hardware, boot, DMA, information side-channels. **Supported proposition:** Names proof assumptions and confidentiality observation limits. **Limit:** No proof for an arbitrary seL4 deployment, extra drivers or ASKA hardware.

**Architectural comparison:** [Chapter 01](01_system_architecture.md), [Chapter 03](03_assurance_trust_and_failure_domains.md), [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 59](59_assurance_claims_profiles_and_manifests.md).

### F03 — Flow-Limited Authorization

**Primary source:** [Flow-Limited Authorization](https://www.cs.cornell.edu/andru/papers/flam/flam-csf15.pdf). **Responsibility:** Owen Arden, Jed Liu and Andrew C. Myers; Cornell. **Date/version:** CSF 2015.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** Sections II, IV and V. **Supported proposition:** Authorization and delegation can themselves create flows; robust authorization constrains inference. **Limit:** Not a complete physical effect-finality implementation or ASKA noninterference proof.

**Architectural comparison:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 55](55_formal_properties_and_state_models.md).

### F04 — Fabric: A Platform for Secure Distributed Computation and Storage

**Primary source:** [Fabric: A Platform for Secure Distributed Computation and Storage](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.pdf). **Responsibility:** Jed Liu, Michael D. George, K. Vikram, Xin Qi, Lucas Waye and Andrew C. Myers; Cornell. **Date/version:** SOSP 2009.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** Section 3.3 object labels; architecture and transactions. **Supported proposition:** Labeled distributed objects and transactional computation are concrete precedents. **Limit:** No inherent physical partition, independent observer hierarchy or unrestricted hostile-device containment.

**Architectural comparison:** [Chapter 05](05_unified_execution_data_and_effect_contract.md), [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 55](55_formal_properties_and_state_models.md).

### F05 — Time Protection: The Missing OS Abstraction

**Primary source:** [Time Protection: The Missing OS Abstraction](https://trustworthy.systems/publications/full_text/Ge_YCH_19.pdf). **Responsibility:** Qian Ge, Yuval Yarom, Tom Chothia and Gernot Heiser. **Date/version:** EuroSys 2019.

**Publication/access status:** peer-reviewed paper; author copy. Primary text opened; cited sections inspected

**Inspected location:** Sections 3.1–3.3 and 5.3–5.4. **Supported proposition:** Temporal protection requires treatment of shared microarchitectural resources; evaluated limits are apparatus-specific. **Limit:** No universal absence of timing/physical channels or ASKA performance result.

**Architectural comparison:** [Chapter 07](07_information_flow_and_release.md), [Chapter 18](18_physical_side_channels_and_temporal_protection.md), [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 58](58_performance_cost_power_and_availability.md).

### F06 — HyperFlow: A Processor Architecture for Nonmalleable, Timing-Safe Information Flow Security

**Primary source:** [HyperFlow: A Processor Architecture for Nonmalleable, Timing-Safe Information Flow Security](https://www.cs.cornell.edu/andru/papers/hyperflow/hyperflow.pdf). **Responsibility:** Andrew Ferraiuolo, Mark Zhao, Andrew C. Myers and G. Edward Suh; Cornell. **Date/version:** CCS 2018.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** Sections 2–3; processor and HDL architecture. **Supported proposition:** A processor IFC architecture includes dynamic policy and timing considerations. **Limit:** No complete ASKA device, external network, watcher or civil authority proof.

**Architectural comparison:** [Chapter 10](10_processor_isa_and_execution_semantics.md), [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F07 — A Verified Information-Flow Architecture

**Primary source:** [A Verified Information-Flow Architecture](https://davidpichardie.github.io/papers/popl14.pdf). **Responsibility:** Arthur Azevedo de Amorim and coauthors; Penn, Portland State, INRIA, Harvard. **Date/version:** POPL 2014.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** Sections 8–10, refinement and modeled noninterference. **Supported proposition:** Machine-checked refinement connects a modeled tagged architecture to an IFC abstraction. **Limit:** No proof for arbitrary added peripherals, maintenance paths or ASKA realization.

**Architectural comparison:** [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F08 — PUMP: A Programmable Unit for Metadata Processing

**Primary source:** [PUMP: A Programmable Unit for Metadata Processing](https://ic.ese.upenn.edu/pdf/pump_hasp2014.pdf). **Responsibility:** Udit Dhawan and coauthors; University of Pennsylvania and collaborators. **Date/version:** HASP 2014.

**Publication/access status:** primary research paper. Primary text opened; cited sections inspected

**Inspected location:** Architectural model; policy tag-use tables. **Supported proposition:** Programmable metadata rules are an implementation comparison for multiple safety policies. **Limit:** Tags alone do not select sound rules, protect update authority or cover all external I/O.

**Architectural comparison:** [Chapter 10](10_processor_isa_and_execution_semantics.md), [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F09 — Key words for use in RFCs to Indicate Requirement Levels

**Primary source:** [Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119.html). **Responsibility:** Scott Bradner; IETF. **Date/version:** RFC 2119 / BCP 14, March 1997.

**Publication/access status:** Best Current Practice. Primary text opened; cited sections inspected

**Inspected location:** Sections 1–5. **Supported proposition:** Defines conventional requirement keywords. **Limit:** No certification or technical evidence for requirements using those words.

**Architectural comparison:** [Chapter 08](08_terminology_and_specification_conventions.md).

### F10 — Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words

**Primary source:** [Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174.html). **Responsibility:** Barry Leiba; IETF. **Date/version:** RFC 8174 / BCP 14, May 2017.

**Publication/access status:** Best Current Practice. Primary text opened; cited sections inspected

**Inspected location:** Section 2. **Supported proposition:** Uppercase keywords carry the defined special meaning. **Limit:** No implementation conformance result.

**Architectural comparison:** [Chapter 08](08_terminology_and_specification_conventions.md).

### F11 — Identifiers and Test Vectors for HMAC-SHA-224, HMAC-SHA-256, HMAC-SHA-384, and HMAC-SHA-512

**Primary source:** [Identifiers and Test Vectors for HMAC-SHA-224, HMAC-SHA-256, HMAC-SHA-384, and HMAC-SHA-512](https://www.rfc-editor.org/rfc/rfc4231.html). **Responsibility:** Magnus Nystrom; IETF. **Date/version:** RFC 4231, December 2005.

**Publication/access status:** Standards Track RFC. Primary text opened; cited sections inspected

**Inspected location:** Sections 4.2–4.3, cases 1 and 2. **Supported proposition:** Provides exact HMAC known-answer inputs and outputs. **Limit:** Passing vectors does not validate ASKA serialization, key custody, authorization or a complete protocol.

**Architectural comparison:** [Chapter 56](56_conformance_tests_and_vectors.md).

### F12 — TLA+ Tools

**Primary source:** [TLA+ Tools](https://lamport.azurewebsites.net/tla/tools.html). **Responsibility:** Leslie Lamport and TLA+ tool authors. **Date/version:** Page revision 18 March 2022, inspected 2026-11-04.

**Publication/access status:** official tool documentation. Primary text opened; cited sections inspected

**Inspected location:** TLC, Apalache and TLAPS descriptions. **Supported proposition:** Distinguishes explicit-state model checking and proof tooling. **Limit:** No TLA+/TLC run or unbounded proof is claimed for ASKA here.

**Architectural comparison:** [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F13 — Tamarin Prover Manual: Introduction

**Primary source:** [Tamarin Prover Manual: Introduction](https://tamarin-prover.com/manual/master/book/001_introduction.html). **Responsibility:** Tamarin project. **Date/version:** Live manual inspected 2026-11-04.

**Publication/access status:** official tool documentation. Primary text opened; cited sections inspected

**Inspected location:** Introduction: multiset rewriting and symbolic adversary. **Supported proposition:** Supports symbolic protocol specification and trace/equivalence reasoning under explicit models. **Limit:** No physical-channel result or completed ASKA Tamarin proof.

**Architectural comparison:** [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F14 — RCE via OOM corruption

**Primary source:** [RCE via OOM corruption](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w). **Responsibility:** PHP project, php/php-src security advisory. **Date/version:** GHSA-w8hw-w9fx-j79w, 21 October 2026.

**Publication/access status:** primary project security advisory. Primary text opened; cited sections inspected

**Inspected location:** Description and resource-initialization weakness. **Supported proposition:** Documents an initialization/cleanup failure case motivating hostile-worker containment tests. **Limit:** Not an ASKA exploit, containment result or proof that every configuration is affected identically.

**Architectural comparison:** [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md), [Chapter 56](56_conformance_tests_and_vectors.md).

### F15 — RCE via stale global state

**Primary source:** [RCE via stale global state](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp). **Responsibility:** PHP project, php/php-src security advisory. **Date/version:** GHSA-6wmf-4rv5-p3rp, 21 October 2026.

**Publication/access status:** primary project security advisory. Primary text opened; cited sections inspected

**Inspected location:** Description; producer/consumer lifecycle; confirmed and conditional cases. **Supported proposition:** Documents request-owned state surviving into another request under specified configurations. **Limit:** Not evidence that resetting one ASKA worker fixes every persistent owner or device reference.

**Architectural comparison:** [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md), [Chapter 56](56_conformance_tests_and_vectors.md).

### F16 — FORCEDENTRY: Sandbox Escape

**Primary source:** [FORCEDENTRY: Sandbox Escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html). **Responsibility:** Ian Beer and Samuel Groß; Google Project Zero. **Date/version:** 31 March 2022.

**Publication/access status:** primary exploit analysis. Primary text opened; cited sections inspected

**Inspected location:** Opening analysis and logic-bug escape mechanism. **Supported proposition:** Shows a documented logic-based sandbox escape relevant to confused-deputy tests. **Limit:** No general claim that every memory mitigation is useless or ASKA prevents the entire exploit.

**Architectural comparison:** [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md), [Chapter 56](56_conformance_tests_and_vectors.md).

### F17 — A deep dive into an NSO zero-click iMessage exploit: Remote Code Execution

**Primary source:** [A deep dive into an NSO zero-click iMessage exploit: Remote Code Execution](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html). **Responsibility:** Google Project Zero. **Date/version:** December 2021.

**Publication/access status:** primary exploit analysis. Primary text opened; cited sections inspected

**Inspected location:** Attachment dispatch and ImageIO/JBIG2 analysis. **Supported proposition:** Documents a mislabeled attachment reaching complex decoding, motivating complete import-path tests. **Limit:** No proof of ASKA decoder containment or universal exploit prevention.

**Architectural comparison:** [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md), [Chapter 56](56_conformance_tests_and_vectors.md).

### F18 — Impossibility of Distributed Consensus with One Faulty Process

**Primary source:** [Impossibility of Distributed Consensus with One Faulty Process](https://groups.csail.mit.edu/tds/papers/Lynch/jacm85.pdf). **Responsibility:** Michael J. Fischer, Nancy A. Lynch and Michael S. Paterson. **Date/version:** JACM 1985.

**Publication/access status:** peer-reviewed paper. Primary text opened; cited sections inspected

**Inspected location:** System assumptions and main impossibility theorem. **Supported proposition:** Under its deterministic asynchronous model, one possible process failure defeats guaranteed consensus termination. **Limit:** Does not forbid useful consensus under additional timing/randomization/failure assumptions; not an ASKA impossibility theorem.

**Architectural comparison:** [Chapter 55](55_formal_properties_and_state_models.md), [Chapter 58](58_performance_cost_power_and_availability.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F19 — Secure connectivity principles for operational technology: Principle 5, Harden your OT boundary

**Primary source:** [Secure connectivity principles for operational technology: Principle 5, Harden your OT boundary](https://www.ncsc.gov.uk/collection/operational-technology/secure-connectivity/principle-5). **Responsibility:** UK National Cyber Security Centre. **Date/version:** Page published 14 January 2026; version 1.0.

**Publication/access status:** official guidance. Primary technical sections opened and inspected; page review metadata has an earlier date than publication, so no inferred revision chronology.

**Inspected location:** Hardware flow controls, Cross Domain solutions and Data diodes. **Supported proposition:** Distinguishes physical directionality from a complete cross-domain solution and identifies paired-diode software orchestration as an anti-pattern. **Limit:** No certification of ASKA configuration/report links or semantic release guards.

**Architectural comparison:** [Chapter 23](23_security_mesh_fabrics_and_one_way_links.md), [Chapter 43](43_dynamic_trust_gateways_and_crossings.md), [Chapter 59](59_assurance_claims_profiles_and_manifests.md).

### F20 — Limitations on quantum information

**Primary source:** [Limitations on quantum information](https://quantum.cloud.ibm.com/learning/en/courses/basics-of-quantum-information/quantum-circuits/limitations-on-quantum-information). **Responsibility:** IBM Quantum Learning. **Date/version:** Living technical lesson; accessed 5 November 2026.

**Publication/access status:** official technical educational derivation. The theorem, proof and basis-state qualification were reviewed.

**Inspected location:** No-cloning theorem; Non-orthogonal states cannot be perfectly discriminated. **Supported proposition:** Derives limits on perfect copying of arbitrary unknown quantum states and exact discrimination of nonorthogonal states. **Limit:** Does not prohibit copying classical bits or validate proposed quantum storage, passive RAM sensing or scene authenticity.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md), [Chapter 21](21_passive_observation_sensors_and_coverage.md), [Chapter 48](48_media_provenance_and_physical_evidence.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F21 — Ryoan: A Distributed Sandbox for Untrusted Computation on Secret Data

**Primary source:** [Ryoan: A Distributed Sandbox for Untrusted Computation on Secret Data](https://www.usenix.org/system/files/conference/osdi16/osdi16-hunt.pdf). **Responsibility:** Tyler Hunt, Zhiting Zhu, Yuanzhong Xu, Simon Peter and Emmett Witchel; University of Texas at Austin / USENIX. **Date/version:** OSDI 2016, pages 533–549.

**Publication/access status:** peer-reviewed paper and prototype report. Conference record and full-text threat/limitation sections reviewed.

**Inspected location:** Sections 2.1–2.3, request-oriented confinement and Section 4.2. **Supported proposition:** Combines trusted sandbox and enclave assumptions for request-oriented untrusted processing; distinguishes software-interface leakage from excluded timing/hardware channels. **Limit:** No ASKA physical ownership, observer independence, universal availability or complete side-channel guarantee.

**Architectural comparison:** [Chapter 07](07_information_flow_and_release.md), [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 57](57_reference_realizations_and_legacy_interoperability.md).

### F22 — FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard

**Primary source:** [FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard](https://csrc.nist.gov/pubs/fips/203/final). **Responsibility:** National Institute of Standards and Technology. **Date/version:** Final; published 13 August 2024.

**Publication/access status:** final federal standard; current primary publication record checked. Publication page identifies a potential-update errata note dated 17 November 2025. Primary status and linked standard introductory sections reviewed; errata spreadsheets not technically audited and no detailed erratum claim is made.

**Inspected location:** Publication abstract/status and planning notices; linked standard announcement and explanation. **Supported proposition:** Defines ML-KEM as the named key-encapsulation mechanism. **Limit:** No ASKA protocol composition, hybrid security, implementation certification or automatic authority from keys.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md), [Chapter 44](44_admission_identity_and_sessions.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F23 — FIPS 204: Module-Lattice-Based Digital Signature Standard

**Primary source:** [FIPS 204: Module-Lattice-Based Digital Signature Standard](https://csrc.nist.gov/pubs/fips/204/final). **Responsibility:** National Institute of Standards and Technology. **Date/version:** Final; published 13 August 2024.

**Publication/access status:** final federal standard; current primary publication record checked. Publication page identifies a potential-update errata note dated 31 July 2026. Primary status and linked standard introductory sections reviewed; errata spreadsheets not technically audited and no detailed erratum claim is made.

**Inspected location:** Publication abstract/status and planning notices; linked standard announcement and explanation. **Supported proposition:** Defines ML-DSA as the named digital-signature mechanism. **Limit:** No ASKA protocol composition, hybrid security, implementation certification or automatic authority from keys.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md), [Chapter 44](44_admission_identity_and_sessions.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F24 — FIPS 205: Stateless Hash-Based Digital Signature Standard

**Primary source:** [FIPS 205: Stateless Hash-Based Digital Signature Standard](https://csrc.nist.gov/pubs/fips/205/final). **Responsibility:** National Institute of Standards and Technology. **Date/version:** Final; published 13 August 2024.

**Publication/access status:** final federal standard; current primary publication record checked. Publication page identifies the final standard; implementation profiles must still check current notices. Primary status and linked standard introductory sections reviewed; errata spreadsheets not technically audited and no detailed erratum claim is made.

**Inspected location:** Publication abstract/status and planning notices; linked standard announcement and explanation. **Supported proposition:** Defines SLH-DSA as the named digital-signature mechanism. **Limit:** No ASKA protocol composition, hybrid security, implementation certification or automatic authority from keys.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md), [Chapter 44](44_admission_identity_and_sessions.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### F25 — Quantum Cryptographic Solutions are Limited Compared to Post-Quantum Algorithms

**Primary source:** [Quantum Cryptographic Solutions are Limited Compared to Post-Quantum Algorithms](https://www.nsa.gov/Cybersecurity/Post-Quantum-Cryptography-Resource-Hub/Article-Display/Article/4616320/quantum-cryptographic-solutions-are-limited-compared-to-post-quantum-algorithms/). **Responsibility:** US National Security Agency. **Date/version:** 1 October 2026.

**Publication/access status:** official technical and policy assessment. Primary article and source-authentication limitation reviewed; only that narrow technical fact is used.

**Inspected location:** Technical limitations: Partial Solution. **Supported proposition:** QKD key distribution does not by itself authenticate its source; separate authentication is required. **Limit:** No ASKA QKD realization or universal prohibition outside the source’s National Security Systems policy scope.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md), [Chapter 41](41_stn_atn_mcn_and_purpose_network_roles.md), [Chapter 60](60_research_program_and_architectural_decisions.md).

### P01 — CHERI FAQ

**Primary source:** [CHERI FAQ](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html). **Responsibility:** University of Cambridge. **Date/version:** living official FAQ, accessed 2026-11-05.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Capability representation, monotonicity, memory protection. **Supported proposition:** Bounds, permissions, protected tags and capability provenance provide spatial authority mechanisms. **Limit:** Confidentiality labels, complete temporal revocation, physical independence or ASKA silicon.

**Architectural comparison:** [Chapter 10](10_processor_isa_and_execution_semantics.md), [Chapter 12](12_memory_cache_and_revocation.md).

### P02 — M3: A Hardware/Operating-System Co-Design to Tame Heterogeneous Manycores

**Primary source:** [M3: A Hardware/Operating-System Co-Design to Tame Heterogeneous Manycores](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf). **Responsibility:** TU Dresden. **Date/version:** ASPLOS 2016.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 3–4; DTU endpoints, message credits, prototype and limitations. **Supported proposition:** Dedicated data-transfer units can mediate communications among heterogeneous processing elements with a separate microkernel. **Limit:** Universal cache independence, ASKA performance, physical tamper protection or a production ASKA implementation.

**Architectural comparison:** [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 11](11_heterogeneous_compute_chiplets_and_packaging.md), [Chapter 14](14_dmnoc_and_internal_communications.md).

### P03 — Minimizing a Smartphone’s TCB for Security-Critical Programs with Exclusively-Used, Physically-Isolated, Statically-Partitioned Hardware (OctopOS)

**Primary source:** [Minimizing a Smartphone’s TCB for Security-Critical Programs with Exclusively-Used, Physically-Isolated, Statically-Partitioned Hardware (OctopOS)](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf). **Responsibility:** UC Irvine and University of Washington. **Date/version:** MobiSys 2023.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 4.2,4.3,4.6 and threat/limitations. **Supported proposition:** Hardware mailbox ownership and time/message bounded exclusive delegation can constrain resource-manager behavior. **Limit:** ASKA emergency revocation semantics, hardware manufacture truth or universal physical resistance.

**Architectural comparison:** [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 15](15_object_mailboxes_and_handoff.md).

### P04 — CHERIoT book: Memory management

**Primary source:** [CHERIoT book: Memory management](https://cheriot.org/book/memory.html). **Responsibility:** CHERIoT project. **Date/version:** living book, accessed 2026-11-05.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 9.1–9.3. **Supported proposition:** Allocation quotas, revocation filtering and quarantine/scanning are concrete temporal-safety mechanisms. **Limit:** Automatic coverage of arbitrary DMA, server caches, device-private memory or all CHERI systems.

**Architectural comparison:** [Chapter 12](12_memory_cache_and_revocation.md).

### P05 — RISC-V IOMMU Introduction

**Primary source:** [RISC-V IOMMU Introduction](https://docs.riscv.org/reference/iommu/v20260222/iommu_intro.html). **Responsibility:** RISC-V International. **Date/version:** v1.0.1, 2026-02-22.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** DMA assignment, MSI translation, Figures 2–5. **Supported proposition:** First and second stage translations and interrupt routing protect mapped DMA subject to integration. **Limit:** Unforgeable endpoint identity, complete ATS invalidation implementation or all-path protection.

**Architectural comparison:** [Chapter 13](13_dma_devices_and_accelerators.md).

### P06 — IOPMP architecture

**Primary source:** [IOPMP architecture](https://github.com/riscv-non-isa/riscv-iopmp/blob/main/chapter2.adoc). **Responsibility:** RISC-V non-ISA IOPMP project. **Date/version:** main working text accessed 2026-11-05.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** RRID and memory-domain source association. **Supported proposition:** RRID participates in transaction permission selection; platform integration defines requester association. **Limit:** Ratified release status, cryptographic authenticity of RRID or a universal physical isolation proof.

**Architectural comparison:** [Chapter 13](13_dma_devices_and_accelerators.md).

### P07 — SCION Header Specification

**Primary source:** [SCION Header Specification](https://docs.scion.org/en/latest/protocols/scion-header.html). **Responsibility:** SCION project. **Date/version:** living specification accessed 2026-11-05.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Hop fields, ingress/egress identifiers and MAC fields. **Supported proposition:** Authenticated forwarding fields support path-oriented routing. **Limit:** Proof of fiber geography, no covert tunnels, application release authority or permanent availability.

**Architectural comparison:** [Chapter 42](42_physical_transit_topology_and_routing.md).

### P08 — The Transport Layer Security Protocol Version 1.3

**Primary source:** [The Transport Layer Security Protocol Version 1.3](https://www.rfc-editor.org/rfc/rfc8446.html). **Responsibility:** IETF. **Date/version:** RFC 8446, August 2018.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** RFC 8446 §§5.5 (key-use limits), 7.5 (exporters), 8 (0-RTT and replay).. **Supported proposition:** TLS1.3 normal-exporter binding and early-data replay limitations; §5.5 explicitly identifies key-use limits and recommends key update before those limits. ASKA chooses no universal numerical key ceiling. **Limit:** Exactly-once effects, resource authorization or mandatory selection of a particular ASKA crypto profile.

**Architectural comparison:** [Chapter 44](44_admission_identity_and_sessions.md), [Chapter 45](45_packet_records_delivery_and_egress.md).

### P09 — An Interface and Algorithms for Authenticated Encryption

**Primary source:** [An Interface and Algorithms for Authenticated Encryption](https://www.rfc-editor.org/rfc/rfc5116.html). **Responsibility:** IETF. **Date/version:** RFC 5116, January 2008.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 3 and 3.2. **Supported proposition:** AEAD nonce construction and uniqueness impose sender/key-lifecycle constraints. **Limit:** Replay suppression, safe retries after rollback or authority to release plaintext.

**Architectural comparison:** [Chapter 45](45_packet_records_delivery_and_egress.md).

### P10, S01 — Remote ATtestation procedureS (RATS) Architecture

**Primary source:** [Remote ATtestation procedureS (RATS) Architecture](https://www.rfc-editor.org/rfc/rfc9334.html). **Responsibility:** IETF. **Date/version:** RFC 9334, January 2023.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** RFC9334 §§3–4 (roles, concepts and architecture) and §7 (trust model); primary full text reviewed. Chapter44 locator corrected during cross-review.. **Supported proposition:** Evidence, verifier appraisal and relying-party decisions are distinct roles. **Limit:** Hardware correctness, present integrity forever or direct resource entitlement.

**Architectural comparison:** [Chapter 20](20_master_and_local_security_meshes.md), [Chapter 24](24_security_event_provenance_and_telemetry.md), [Chapter 29](29_monitoring_privacy_and_observation_authority.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md), [Chapter 44](44_admission_identity_and_sessions.md).

### P11 — EPIC: Every Packet Is Checked

**Primary source:** [EPIC: Every Packet Is Checked](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf). **Responsibility:** ETH Zurich and collaborators. **Date/version:** USENIX Security 2020.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Protocol-family overview and replay/time discussion. **Supported proposition:** Packet authentication and path-validation mechanisms have explicit key, time and replay assumptions. **Limit:** Physical route geography or ASKA semantic release authority.

**Architectural comparison:** [Chapter 42](42_physical_transit_topology_and_routing.md), [Chapter 45](45_packet_records_delivery_and_egress.md).

### P12 — Verifying and Enforcing Network Paths with ICING

**Primary source:** [Verifying and Enforcing Network Paths with ICING](https://www.cs.utexas.edu/icing/papers/icing-conext11.pdf). **Responsibility:** University research collaboration. **Date/version:** CoNEXT 2011.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Introduction and consent/compliance threat scope. **Supported proposition:** Path consent and compliance can be checked with declared participating-node assumptions. **Limit:** Detection of every hidden tunnel or copied packet, sovereign legal authority or physical cable location.

**Architectural comparison:** [Chapter 42](42_physical_transit_topology_and_routing.md).

### P13 — FABRID: Flexible Attestation-Based Routing for Inter-Domain Networks

**Primary source:** [FABRID: Flexible Attestation-Based Routing for Inter-Domain Networks](https://www.usenix.org/system/files/sec23fall-prepub-135-krahenbuhl.pdf). **Responsibility:** ETH Zurich and University of Oxford. **Date/version:** USENIX Security 2023 prepublication PDF.

**Publication/access status:** primary full text reviewed. Prepublication full-text introduction reviewed; no implementation/security detail beyond reviewed scope is relied on.

**Inspected location:** Abstract, introduction and attestation-based policy architecture. **Supported proposition:** Router properties and attestation can inform inter-domain routing policy. **Limit:** Actual factory truth, permanent integrity or ASKA physical-path assurance.

**Architectural comparison:** [Chapter 42](42_physical_transit_topology_and_routing.md).

### P14 — UCIe Specifications overview

**Primary source:** [UCIe Specifications overview](https://www.uciexpress.org/specifications). **Responsibility:** UCIe Consortium. **Date/version:** public specifications overview accessed 2026-11-05.

**Publication/access status:** official overview reviewed; full normative specification not retrieved. Public overview only; publication identifies this limitation.

**Inspected location:** Public stack and management/DFx overview. **Supported proposition:** Die-to-die standardization includes management and debug considerations beyond data transport. **Limit:** Full normative protocol qualification, electrical isolation or ASKA conformance.

**Architectural comparison:** [Chapter 11](11_heterogeneous_compute_chiplets_and_packaging.md).

### P15 — CURE: A Security Architecture with CUstomizable and Resilient Enclaves

**Primary source:** [CURE: A Security Architecture with CUstomizable and Resilient Enclaves](https://www.usenix.org/system/files/sec21summer_bahmani.pdf). **Responsibility:** TU Darmstadt and collaborators. **Date/version:** USENIX Security 2021.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Architecture overview and Section 3 threat model. **Supported proposition:** Customizable enclaves and resource partitioning address privileged software and peripheral compromise under trusted-hardware assumptions. **Limit:** Physical tamper/fault resistance, absence of physical side channels, DoS freedom or ASKA proof.

**Architectural comparison:** [Chapter 11](11_heterogeneous_compute_chiplets_and_packaging.md), [Chapter 13](13_dma_devices_and_accelerators.md).

### P16 — ACAI: Protecting Accelerator Execution with Arm Confidential Computing Architecture

**Primary source:** [ACAI: Protecting Accelerator Execution with Arm Confidential Computing Architecture](https://www.usenix.org/system/files/usenixsecurity24-sridhara.pdf). **Responsibility:** ETH Zurich and collaborators. **Date/version:** USENIX Security 2024.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 4–6; INVid, INVown, INVhost, INVdev, INVbind. **Supported proposition:** Device identity, exclusive assignment and synchronized CPU/device mappings are separate protected-I/O obligations. **Limit:** All accelerator implementations, benign device outputs or ASKA physical-domain independence.

**Architectural comparison:** [Chapter 13](13_dma_devices_and_accelerators.md).

### P17 — Elasticlave: An Efficient Memory Model for Enclaves

**Primary source:** [Elasticlave: An Efficient Memory Model for Enclaves](https://www.usenix.org/system/files/sec22-yu-jason.pdf). **Responsibility:** NUS and ETH Zurich. **Date/version:** USENIX Security 2022.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 4.1–4.2. **Supported proposition:** Static permission ceilings and atomic exclusive-lock transfer can support enclave sharing; lock transfer differs from ownership transfer. **Limit:** Physical bank reassignment, general DMA sanitization or ASKA temporal safety.

**Architectural comparison:** [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 15](15_object_mailboxes_and_handoff.md).

### P18 — Guidelines for Media Sanitization

**Primary source:** [Guidelines for Media Sanitization](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-88r2.pdf). **Responsibility:** NIST. **Date/version:** SP 800-88 Revision 2, September 2025.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Sections 3.2–3.2.4. **Supported proposition:** Cryptographic erase assurance depends on encryption, key management and sanitization preconditions. **Limit:** Proof that arbitrary device reset or key deletion eliminates all plaintext and key copies.

**Architectural comparison:** [Chapter 16](16_persistent_objects_storage_and_hese_dar.md).

### P19 — Intel Demonstrates First Fully Integrated Optical I/O Chiplet

**Primary source:** [Intel Demonstrates First Fully Integrated Optical I/O Chiplet](https://www.intel.com/content/www/us/en/newsroom/news/intel-unveils-first-integrated-optical-io-chiplet.html). **Responsibility:** Intel. **Date/version:** 26 June 2024.

**Publication/access status:** primary manufacturer technical announcement reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Demonstration and architecture description. **Supported proposition:** Manufacturer reports live-data optical chiplet co-packaging demonstration. **Limit:** Independent replication, ASKA endpoint guards, data-diode behavior or immunity to shared packaging faults.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md).

### P20 — A 64-core mixed-signal in-memory compute chip based on phase-change memory for deep neural network inference

**Primary source:** [A 64-core mixed-signal in-memory compute chip based on phase-change memory for deep neural network inference](https://research.ibm.com/publications/a-64-core-mixed-signal-in-memory-compute-chip-based-on-phase-change-memory-for-deep-neural-network-inference). **Responsibility:** IBM Research. **Date/version:** 10 August 2023.

**Publication/access status:** primary institutional abstract reviewed; full article not reviewed. Only abstract-level claims used; no benchmark numbers transferred.

**Inspected location:** Institutional publication abstract. **Supported proposition:** Published mixed-signal inference device combines analogue compute, digital operations and communication. **Limit:** Secure exact arithmetic, general workloads, ASKA efficiency or end-to-end independent validation.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md).

### P21 — Taking Neuromorphic Computing to the Next Level with Loihi 2

**Primary source:** [Taking Neuromorphic Computing to the Next Level with Loihi 2](https://www.intel.com/content/dam/www/central-libraries/us/en/documents/neuromorphic-computing-loihi-2-brief.pdf). **Responsibility:** Intel Labs. **Date/version:** 2021 technology brief.

**Publication/access status:** primary full text reviewed. Relevant technical sections reviewed; no ASKA implementation inference.

**Inspected location:** Pages 1–3; programmable neurons, state, interfaces and research platforms. **Supported proposition:** Programmable event-based research hardware is a concrete neuromorphic candidate. **Limit:** Secure memory isolation, bounded leakage, general-purpose superiority or ASKA performance.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md).

### P22 — Coherent vortex dynamics in a strongly-interacting superfluid on a silicon chip

**Primary source:** [Coherent vortex dynamics in a strongly-interacting superfluid on a silicon chip](https://arxiv.org/abs/1902.04409). **Responsibility:** Yauhen P. Sachkou, Christopher G. Baker and collaborators. **Date/version:** arXiv:1902.04409v1, 7 February 2019; related DOI 10.1126/science.aaw9229.

**Publication/access status:** primary abstract and bibliography reviewed; full-text access gap. Primary arXiv abstract directly reviewed. PDF and experimental HTML retrieval failed; author-hosted PDF exceeded retrieval size. No coherence-duration, qubit or ASKA-feasibility result used.

**Inspected location:** arXiv abstract and submission metadata. **Supported proposition:** Exact title, authorship, preprint identifier and abstract-level study of superfluid vortex dynamics on a silicon chip; no technical qualification imported. **Limit:** Addressable coherent qubits, non-destructive quantum random-access memory or ASKA substrate feasibility.

**Architectural comparison:** [Chapter 19](19_substrate_and_unconventional_compute_research.md).

### P23 — SIBRA: Scalable Internet Bandwidth Reservation Architecture

**Primary source:** [SIBRA: Scalable Internet Bandwidth Reservation Architecture](https://www.ndss-symposium.org/wp-content/uploads/2017/09/sibra-scalable-internet-bandwidth-reservation-architecture.pdf). **Responsibility:** ETH Zurich, Beihang University, National Taiwan University and KDDI R&D. **Date/version:** NDSS 2016.

**Publication/access status:** primary full text reviewed. Relevant threat, network-assumption and design text reviewed.

**Inspected location:** Section II assumptions and Section III reservation hierarchy. **Supported proposition:** Hierarchical bandwidth reservation design under explicit source-controllable-path and non-hijackable-flow assumptions. **Limit:** Unconditional availability against physical failure or all compromised carriers; object release rights; ASKA performance.

**Architectural comparison:** [Chapter 42](42_physical_transit_topology_and_routing.md).

### P24 — Composite Enclaves: Towards Disaggregated Trusted Execution

**Primary source:** [Composite Enclaves: Towards Disaggregated Trusted Execution](https://www.syssec.ethz.ch/publications/2021-11-19-composite-enclaves-towards-disaggregated-trusted-execution-20-500-11850-517576/). **Responsibility:** ETH Zurich System Security Group. **Date/version:** TCHES 2022(1), 630–656; institutional publication November 2021.

**Publication/access status:** primary institutional abstract reviewed; full-text access gap. ETH repository PDF returned HTTP 403; DOI retrieval unavailable. Only abstract-level architecture cited; no measurements reused.

**Inspected location:** Institutional abstract and bibliography; DOI 10.46586/TCHES.V2022.I1.630-656. **Supported proposition:** Research architecture proposes configurable hardware/software trust spanning compute and I/O. **Limit:** Detailed threat assumptions or performance conclusions not verified from full text; no ASKA proof.

**Architectural comparison:** [Chapter 13](13_dma_devices_and_accelerators.md).

### S02 — The Update Framework Specification

**Primary source:** [The Update Framework Specification](https://theupdateframework.github.io/specification/v1.0.36/). **Responsibility:** TUF project; Cappos, Kuppusamy, Lock, Moore and Pühringer. **Date/version:** 1.0.36; modified 2026-08-05.

**Publication/access status:** Published project specification. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §1.4;§§4.3–4.6,5.1–5.7. **Supported proposition:** Roles, thresholds, root continuity, version/expiry/hash/length checks and bounded delegation workflows. **Limit:** Semantic safety of correctly signed software, package installation or initial trust bootstrap.

**Architectural comparison:** [Chapter 23](23_security_mesh_fabrics_and_one_way_links.md), [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md).

### S03 — Secure Software Development Framework (SSDF) Version 1.1, SP 800-218

**Primary source:** [Secure Software Development Framework (SSDF) Version 1.1, SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final). **Responsibility:** NIST; Souppaya, Scarfone and Dodson. **Date/version:** Final; 2022-02-03.

**Publication/access status:** Final publication. Primary publication page and PDF technical tasks reviewed; bare PDF timed out twice, indexed primary copy with query parameter was readable.

**Inspected location:** Table1: PW.2.1,PS.3.1,PW.8.1–PW.8.2. **Supported proposition:** Development review, release preservation and scoped executable-code tests with recorded outcomes. **Limit:** An ASKA certification, absence of defects or permission for an AI producer to certify itself.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 28](28_aesds_iama_and_autonomous_evolution.md).

### S04 — Platform Firmware Resiliency Guidelines, SP 800-193

**Primary source:** [Platform Firmware Resiliency Guidelines, SP 800-193](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-193.pdf). **Responsibility:** NIST; Andrew Regenscheid. **Date/version:** Final; May 2018.

**Publication/access status:** Final publication; current NIST page checked. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §§2.1,3.1,4.1–4.4; printed pp20–28. **Supported proposition:** Protection, detection and recovery roots; host inputs untrusted; update recovery across interrupted writes. **Limit:** Recovery from every physical failure, semantic correctness or independent roots merely from different names.

**Architectural comparison:** [Chapter 22](22_independent_watchers_and_meta_monitoring.md), [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md).

### S05 — Security Protocol and Data Model (SPDM), DSP0274

**Primary source:** [Security Protocol and Data Model (SPDM), DSP0274](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf). **Responsibility:** DMTF. **Date/version:** 1.4.1;2026-06-26.

**Publication/access status:** Published normative specification; supersedes1.4.0. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** Cover; GET_CAPABILITIES measurement capability fields pp68–69; measurement and session protocol clauses. **Supported proposition:** Negotiated device-authentication, measurement and session protocol with freshness capabilities. **Limit:** Measurement of all runtime state, truthful compromised-device reports or application authorization.

**Architectural comparison:** [Chapter 21](21_passive_observation_sensors_and_coverage.md), [Chapter 24](24_security_event_provenance_and_telemetry.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md).

### S06 — DMTF-2026-0003: SPDM FINISH transcript OpaqueData advisory

**Primary source:** [DMTF-2026-0003: SPDM FINISH transcript OpaqueData advisory](https://github.com/DMTF/libspdm/security/advisories/GHSA-chjj-xvqx-c8w4). **Responsibility:** DMTF/libspdm maintainers. **Date/version:** Published2026-07-03.

**Publication/access status:** Primary security advisory;1.4.0affected,1.4.1patched. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** Impact;affected transcript definitions;patched versions. **Supported proposition:** Specified1.4.0transcripts omitted new opaque fields; corrected version is1.4.1. **Limit:** That every deployed implementation was exploited or that1.4.1is free of other defects.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md).

### S07 — SLSA v1.2: Build requirements for producing artifacts

**Primary source:** [SLSA v1.2: Build requirements for producing artifacts](https://slsa.dev/spec/v1.2/build-requirements). **Responsibility:** SLSA project / OpenSSF. **Date/version:** v1.2; checked2026-11-05.

**Publication/access status:** Approved project specification. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** Build levels;Provenance generation;Isolation strength. **Supported proposition:** Producer/platform responsibilities and build provenance authenticity/isolation requirements. **Limit:** Safe application behavior, independently reviewed tests or an ASKA SLSA level without assessment.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 28](28_aesds_iama_and_autonomous_evolution.md).

### S08 — Definitions: When is a build reproducible?

**Primary source:** [Definitions: When is a build reproducible?](https://reproducible-builds.org/docs/definition/). **Responsibility:** Reproducible Builds project. **Date/version:** Undated current definition;checked2026-11-05.

**Publication/access status:** Project technical definition. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** Definition and explanations. **Supported proposition:** Artifact identity under specified source, instructions and environment; bitwise comparison. **Limit:** Safe source code, independent toolchain trust or malicious-compiler detection by repeating identical environment.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 28](28_aesds_iama_and_autonomous_evolution.md).

### S09 — in-toto: Providing farm-to-table guarantees for bits and bytes

**Primary source:** [in-toto: Providing farm-to-table guarantees for bits and bytes](https://www.usenix.org/system/files/sec19-torres-arias.pdf). **Responsibility:** Torres-Arias, Afzali, Kuppusamy, Curtmola and Cappos; USENIX Security. **Date/version:** 2019.

**Publication/access status:** Peer-reviewed paper; author-described implementation/evaluation. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §§2.2–2.3,3.1;pp1394–1396. **Supported proposition:** Threat model, role/step authentication, artifact flow and supply-chain layout integrity. **Limit:** Security of every correctly authorized step, unconditional resilience to compromised owner keys or ASKA implementation.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md), [Chapter 28](28_aesds_iama_and_autonomous_evolution.md).

### S10 — On Calibration of Modern Neural Networks

**Primary source:** [On Calibration of Modern Neural Networks](https://proceedings.mlr.press/v70/guo17a/guo17a.pdf). **Responsibility:** Guo, Pleiss, Sun and Weinberger;ICML/PMLR70. **Date/version:** 2017.

**Publication/access status:** Peer-reviewed empirical paper. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §2 calibration/ECE;§4 temperature scaling;§5evaluation. **Supported proposition:** Confidence calibration differs from classification accuracy; empirical calibration methods under evaluated datasets. **Limit:** Calibrated ASKA security signals, adversarial robustness or validity after arbitrary distribution shift.

**Architectural comparison:** [Chapter 25](25_security_analysis_ai_and_false_alarm_control.md).

### S11 — Outside the Closed World: On Using Machine Learning for Network Intrusion Detection

**Primary source:** [Outside the Closed World: On Using Machine Learning for Network Intrusion Detection](https://www.icir.org/robin/papers/oakland10-ml.pdf). **Responsibility:** Sommer and Paxson;IEEE Symposium on Security and Privacy. **Date/version:** 2010.

**Publication/access status:** Peer-reviewed analysis. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §III.B high cost of errors;§III.C semantic gap;research guidance. **Supported proposition:** Operational consequences of misclassification and the gap between anomaly and actionable attack evidence. **Limit:** A current measured error rate, proof that all ML detection fails or an ASKA detector evaluation.

**Architectural comparison:** [Chapter 25](25_security_analysis_ai_and_false_alarm_control.md).

### S12 — Copilot—a Coprocessor-based Kernel Runtime Integrity Monitor

**Primary source:** [Copilot—a Coprocessor-based Kernel Runtime Integrity Monitor](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/). **Responsibility:** Petroni Jr., Fraser, Molina and Arbaugh;USENIX Security. **Date/version:** 2004.

**Publication/access status:** Peer-reviewed prototype paper. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §§4–6;DMA and virtual-address translation. **Supported proposition:** Concrete independent coprocessor memory-inspection design using DMA and explicit kernel interpretation. **Limit:** Passive noninteracting observation, modern cache completeness or ASKA performance.

**Architectural comparison:** [Chapter 20](20_master_and_local_security_meshes.md), [Chapter 21](21_passive_observation_sensors_and_coverage.md), [Chapter 22](22_independent_watchers_and_meta_monitoring.md).

### S13 — Vigilare: Toward Snoop-based Kernel Integrity Monitor

**Primary source:** [Vigilare: Toward Snoop-based Kernel Integrity Monitor](https://cysec.kr/publications/vigilare.pdf). **Responsibility:** Moon, Lee, Lee, Kim, Paek and Kang;ACM CCS. **Date/version:** 2012.

**Publication/access status:** Peer-reviewed prototype paper. Author-hosted PDF reviewed; KAIST catalogue confirms bibliographic metadata. Original cysec.kaist.ac.kr PDF unavailable; cysec.kr author copy readable.

**Inspected location:** §5.4cache discussion;§5.5snapshot comparison;pp28–37. **Supported proposition:** Bus-snoop observation and cache/writeback limitations in a specified prototype. **Limit:** Generic detection of all cache/register activity, side-channel immunity or zero overhead for ASKA.

**Architectural comparison:** [Chapter 21](21_passive_observation_sensors_and_coverage.md), [Chapter 22](22_independent_watchers_and_meta_monitoring.md).

### S14 — Guide to Operational Technology (OT) Security, SP 800-82 Revision 3

**Primary source:** [Guide to Operational Technology (OT) Security, SP 800-82 Revision 3](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r3.pdf). **Responsibility:** NIST;Stouffer etal.. **Date/version:** Final;September2023.

**Publication/access status:** Final;Revision4initial public draft separately noted by NIST. Primary technical content reviewed through web reader; access checked 2026-11-05.

**Inspected location:** §2.3.7Safety Systems;§3.2 safety impact;§4.2.2. **Supported proposition:** Cybersecurity response and safety assessment must account for physical process hazards. **Limit:** A certified safe state for a particular actuator, medical device or ASKA deployment.

**Architectural comparison:** [Chapter 26](26_protective_response_and_containment.md), [Chapter 30](30_boot_key_custody_recovery_and_continuity.md).

### S15 — SSDF publications and SP 800-218 Revision 1 initial public draft

**Primary source:** [SSDF publications and SP 800-218 Revision 1 initial public draft](https://csrc.nist.gov/pubs/sp/800/218/r1/ipd). **Responsibility:** NIST. **Date/version:** SSDF1.2draft;2025-12-17.

**Publication/access status:** Initial public draft;not final. Primary status page and https://csrc.nist.gov/projects/ssdf/publications reviewed;used for status only.

**Inspected location:** Publication status/date;NIST SSDF publications index. **Supported proposition:** SSDF1.2 remains designated draft on checked page;SSDF1.1 remains final publication. **Limit:** Adoption or final status of proposed1.2requirements.

**Architectural comparison:** [Chapter 27](27_software_update_and_supply_chain_safety.md).

### S16 — SP 800-82 Revision 3 publication record and Revision 4 planning note

**Primary source:** [SP 800-82 Revision 3 publication record and Revision 4 planning note](https://csrc.nist.gov/pubs/sp/800/82/r3/final). **Responsibility:** NIST. **Date/version:** Planning note2026-09-21.

**Publication/access status:** FinalRevision3record;Revision4IPD announced. Primary status record reviewed;Revision4technical content is not used.

**Inspected location:** Planning Note and document history. **Supported proposition:** Revision4initial public draft with comment deadline2026-11-30;Revision3technical reference remains identified as final. **Limit:** That draftRevision4is final or that its content was reviewed.

**Architectural comparison:** [Chapter 26](26_protective_response_and_containment.md).

### A01 — Concise Binary Object Representation (CBOR)

**Primary source:** [Concise Binary Object Representation (CBOR)](https://www.rfc-editor.org/rfc/rfc8949). **Responsibility:** IETF. **Date/version:** RFC 8949; December 2020.

**Publication/access status:** Internet Standard. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Sections 4.2.1–4.2.3 and 5. **Supported proposition:** Defines CBOR encoding and distinct deterministic-encoding requirements. **Limit:** Does not choose ASKA canonical application schemas, authority or replay semantics.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md).

### A02 — CBOR Object Signing and Encryption (COSE): Structures and Process

**Primary source:** [CBOR Object Signing and Encryption (COSE): Structures and Process](https://www.rfc-editor.org/rfc/rfc9052). **Responsibility:** IETF. **Date/version:** RFC 9052; August 2022.

**Publication/access status:** Proposed Standard. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Sections 3 and 4.4. **Supported proposition:** Defines protected/unprotected headers, critical parameters and signature structures. **Limit:** Does not qualify a signer for an ASKA resource or make an application serialization canonical.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md).

### A03 — Verifiable Credentials Data Model v2.0

**Primary source:** [Verifiable Credentials Data Model v2.0](https://www.w3.org/TR/vc-data-model-2.0/). **Responsibility:** W3C. **Date/version:** Recommendation; version 2.0.

**Publication/access status:** W3C Recommendation. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Data model and privacy considerations, including identifier correlation. **Supported proposition:** Defines roles and data structures for verifiable credential statements. **Limit:** Does not mint local resource authority or settle the truth and applicability of every credential.

**Architectural comparison:** [Chapter 32](32_claim_contract_grant_receipt_schemas.md), [Chapter 34](34_identity_relationships_delegation_and_revocation.md).

### A04 — Decentralized Identifiers (DIDs) v1.0

**Primary source:** [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/). **Responsibility:** W3C. **Date/version:** Recommendation; version 1.0.

**Publication/access status:** W3C Recommendation. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Privacy considerations: correlation, pairwise identifiers and verification methods. **Supported proposition:** Explains identifier correlation risks and mitigation considerations. **Limit:** Pairwise identifiers do not guarantee anonymity, institutional qualification or legal capacity.

**Architectural comparison:** [Chapter 34](34_identity_relationships_delegation_and_revocation.md).

### A05 — OAuth 2.0 Rich Authorization Requests

**Primary source:** [OAuth 2.0 Rich Authorization Requests](https://www.rfc-editor.org/rfc/rfc9396). **Responsibility:** IETF. **Date/version:** RFC 9396; May 2023.

**Publication/access status:** Proposed Standard. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Sections 2 and 11. **Supported proposition:** Defines structured authorization_details and associated security considerations. **Limit:** Does not define ASKA installation, physical finality, distributed atomicity or label release.

**Architectural comparison:** [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 33](33_pact_protocol_and_state_machines.md).

### A06 — C2PA Technical Specification

**Primary source:** [C2PA Technical Specification](https://spec.c2pa.org/specifications/specifications/2.3/specs/C2PA_Specification.html). **Responsibility:** Coalition for Content Provenance and Authenticity. **Date/version:** Version 2.3; accessed 2026-11-05.

**Publication/access status:** Technical specification. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Sections 1.2–1.3, asset bindings, trust, validation and harms. **Supported proposition:** Defines signed provenance assertions, asset bindings and validation processes with stated scope. **Limit:** Does not guarantee physical scene truth, consent, legal sufficiency or sensor honesty.

**Architectural comparison:** [Chapter 48](48_media_provenance_and_physical_evidence.md).

### A07 — Model Context Protocol: Tools

**Primary source:** [Model Context Protocol: Tools](https://modelcontextprotocol.io/specification/2025-06-18/server/tools). **Responsibility:** Model Context Protocol project. **Date/version:** Specification path 2025-06-18; accessed 2026-11-05.

**Publication/access status:** Protocol specification. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Tool schemas, annotations and security considerations. **Supported proposition:** Describes structured tool interfaces and limits on trusting annotations. **Limit:** Does not establish hardware confinement, ASKA grant semantics or trusted human approval.

**Architectural comparison:** [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md).

### A08 — Model Context Protocol: Security Best Practices

**Primary source:** [Model Context Protocol: Security Best Practices](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices). **Responsibility:** Model Context Protocol project. **Date/version:** Documentation path 2025-11-25; resolved and checked 2026-11-05.

**Publication/access status:** Security guidance. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Confused deputy, token passthrough, SSRF, session hijacking and scope minimization. **Supported proposition:** Describes protocol-level security hazards and mitigations for tool integrations. **Limit:** Does not prove model robustness or supply ASKA owner, label and effect guarantees.

**Architectural comparison:** [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md).

### A09 — Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile

**Primary source:** [Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf). **Responsibility:** NIST. **Date/version:** NIST AI 600-1; July 2024.

**Publication/access status:** Voluntary risk-management guidance. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Information-security risks in section 2, including prompt injection. **Supported proposition:** Identifies generative-AI risks, including direct and indirect prompt-injection concerns. **Limit:** Does not certify an agent, prove confinement or establish a complete ASKA implementation.

**Architectural comparison:** [Chapter 37](37_ai_native_operating_environment.md).

### A10 — Voluntary Voting System Guidelines Version 2.0

**Primary source:** [Voluntary Voting System Guidelines Version 2.0](https://www.eac.gov/sites/default/files/TestingCertification/Voluntary_Voting_System_Guidelines_Version_2_0.pdf). **Responsibility:** U.S. Election Assistance Commission. **Date/version:** February 10, 2021.

**Publication/access status:** Election technical requirements. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Section 9.1.1 software independence; Principle 10 ballot secrecy. **Supported proposition:** Provides concrete technical voting-system requirements concerning software independence and ballot secrecy. **Limit:** Is not an ASKA certification, universal election law or validation of a proposed microstructure ballot system.

**Architectural comparison:** [Chapter 50](50_civic_services_elections_and_public_accountability.md).

### A11 — ODRL Information Model 2.2

**Primary source:** [ODRL Information Model 2.2](https://www.w3.org/TR/odrl-model/). **Responsibility:** W3C. **Date/version:** Recommendation; February 15, 2018.

**Publication/access status:** W3C Recommendation. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Permissions, prohibitions, duties; section 2.10 conflicts and section 3 profiles. **Supported proposition:** Defines a policy vocabulary including permissions, prohibitions, duties and profiles. **Limit:** Does not determine universal legal precedence, institutional legitimacy or ASKA enforcement.

**Architectural comparison:** [Chapter 31](31_accord_system_and_machine_authorization.md), [Chapter 35](35_governance_profiles_conflicts_and_institutions.md).

### A12 — Certificate Transparency Version 2.0

**Primary source:** [Certificate Transparency Version 2.0](https://www.rfc-editor.org/rfc/rfc9162). **Responsibility:** IETF. **Date/version:** RFC 9162; December 2021.

**Publication/access status:** Experimental RFC. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Introduction and authenticated append-only log/consistency model. **Supported proposition:** Provides a transparency-log comparison involving append-only histories and detectable inconsistencies. **Limit:** Does not prove arbitrary witnessed events true or ensure availability, complete observation or no isolated fork.

**Architectural comparison:** [Chapter 47](47_steles_witness_receipts_and_notice.md).

### A13 — Digital Identity Guidelines: Authentication and Authenticator Management

**Primary source:** [Digital Identity Guidelines: Authentication and Authenticator Management](https://pages.nist.gov/800-63-4/sp800-63b.html). **Responsibility:** NIST. **Date/version:** SP 800-63B-4; 2025 edition.

**Publication/access status:** Technical guidance. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Section 3.2.3 biometrics; authentication lifecycle and privacy context. **Supported proposition:** Constrains biometric use within authentication arrangements and addresses alternative mechanisms. **Limit:** Does not establish human intention, legal capacity, trusted display ownership or unrestricted recovery.

**Architectural comparison:** [Chapter 34](34_identity_relationships_delegation_and_revocation.md), [Chapter 36](36_keystone_trusted_user_interaction.md).

### A14 — Guidelines for Evaluating Differential Privacy Guarantees

**Primary source:** [Guidelines for Evaluating Differential Privacy Guarantees](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-226.pdf). **Responsibility:** NIST. **Date/version:** SP 800-226; March 2025.

**Publication/access status:** Technical guidance. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Privacy definitions and composition; section 4.2 trust models and section 4.4 access controls. **Supported proposition:** Explains how privacy guarantees depend on definitions, parameters, composition and system assumptions. **Limit:** Does not validate arbitrary aggregates, federated learning or cryptographic claims of an ASKA application.

**Architectural comparison:** [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 48](48_media_provenance_and_physical_evidence.md), [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md), [Chapter 53](53_community_realm_governance_and_disputes.md).

### A15 — NIST Roadmap Toward Criteria for Threshold Schemes for Cryptographic Primitives

**Primary source:** [NIST Roadmap Toward Criteria for Threshold Schemes for Cryptographic Primitives](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8214A.pdf). **Responsibility:** NIST. **Date/version:** NIST IR 8214A; 2020.

**Publication/access status:** Research roadmap. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Section 5 features, corruption/adversary models, composition and termination. **Supported proposition:** Explains dimensions and operational distinctions among threshold cryptographic schemes. **Limit:** A threshold of keys does not establish institutional independence, honest input or authorized release.

**Architectural comparison:** [Chapter 35](35_governance_profiles_conflicts_and_institutions.md), [Chapter 38](38_native_apps_toolchains_and_interoperability.md), [Chapter 48](48_media_provenance_and_physical_evidence.md), [Chapter 53](53_community_realm_governance_and_disputes.md).

### A16 — Multiparty Computation from Somewhat Homomorphic Encryption

**Primary source:** [Multiparty Computation from Somewhat Homomorphic Encryption](https://pure.au.dk/portal/en/publications/multiparty-computation-from-somewhat-homomorphic-encryption/) (Aarhus University research record; [2011 IACR preprint](https://eprint.iacr.org/2011/535); [CRYPTO 2012 publication](https://doi.org/10.1007/978-3-642-32009-5_38)). **Responsibility:** Ivan Damgård, Valerio Pastro, Nigel P. Smart and Sarah Zakarias. **Publication:** IACR Cryptology ePrint 2011/535; peer-reviewed version in CRYPTO 2012, LNCS 7417, pp. 643–662.

**Access and inspected material:** Author-institution preprint abstract and 2012 conference bibliographic record; the ePrint PDF was not inspected. **Supported proposition:** Describes an actively secure multi-party computation protocol with a preprocessing phase based on somewhat homomorphic encryption, under an explicit corruption bound and arithmetic-circuit model. **Limit:** The abstract does not establish security for every application, side-channel resistance, authorization of released outputs or the honesty of participating institutions.

**Architectural comparison:** [Chapter 38](38_native_apps_toolchains_and_interoperability.md) and [Chapter 53](53_community_realm_governance_and_disputes.md). An ASKA profile using MPC must select and validate its actual corruption, input, output, abort and composition assumptions.

### A17 — Defeating Prompt Injections by Design (CaMeL)

**Primary source:** [Defeating Prompt Injections by Design (CaMeL)](https://arxiv.org/html/2503.18813v2). **Responsibility:** Authors of arXiv:2503.18813. **Date/version:** Version 2; June 24, 2025.

**Publication/access status:** Research preprint. Primary full text opened and selected relevant sections inspected with web tools.

**Inspected location:** Sections 3, 5 and 7: threat model, capability/data-control design and limitations. **Supported proposition:** Studies separation of control/data and capability-mediated tool execution under a stated threat model. **Limit:** Does not establish universal prompt-injection immunity, ASKA hardware isolation or all side-channel protection.

**Architectural comparison:** [Chapter 37](37_ai_native_operating_environment.md).

## 4. Access gaps and non-evidence

Public overviews, educational derivations, vendor briefs and abstract-only comparisons in the main register retain their stated limits. Unspecified proprietary algorithms, undisclosed passive-memory decoding mechanisms and conceptual physical-media constructions have no supplied reproducible evidence. Their hypotheses and defeating experiments are recorded in the owning chapters and the research program; a missing mechanism is not filled by an invented implementation.

## 5. What the literature does not establish

The cited results do not collectively prove ASKA by composition. The complete implementation still needs guard/compiler refinement, exhaustive physical reachability, scoped update and recovery custody, sensor calibration, privacy-authorized telemetry, independent source/receiver admission, durable effect semantics, useful applications and measured resource costs. Combining two results with incompatible attacker or hardware assumptions yields no valid whole-system theorem.

Physical inspection must support physical claims; model checking must identify the explored abstraction; measurements need actual apparatus and controls. Civil and legal profiles require the applicable institutional process and evidence of technical capability, with consent and compulsion kept separate. Neither a standards citation nor an accredited component automatically establishes those broader obligations.

A deployment may reuse a demonstrated technique without claiming invention. A claim that differs from prior work must describe the changed assumption or boundary and the evidence needed for it. If that evidence is absent, the claim remains unestablished. Research can legitimately conclude that an existing technique already meets a local need while the integrated machine remains a research target.

## Normative requirements and acceptance obligations

**R-62-01 — Identified primary sources.** External factual claims MUST link to identifiable primary sources with status, location and exact supported scope.

**Acceptance T-62-01:** Follow each URL and compare the cited proposition with the named technical section; a title-only inference fails review.

**R-62-02 — Source status.** A draft, vendor report, abstract, educational derivation or inaccessible text MUST retain its actual evidence classification.

**Acceptance T-62-02:** Attempt to label an abstract-only or draft comparison a reproduced final standard; the evidence register rejects the promotion.

**R-62-03 — No inherited certification.** External results MUST NOT be represented as proof, manufacture, certification or novelty of the integrated ASKA machine.

**Acceptance T-62-03:** Trace a whole-system claim to an external component paper alone; mark it unestablished.

**R-62-04 — Version and access precision.** Implementation profiles MUST pin relied-upon source revisions and disclose redirects, access gaps and relevant limitations.

**Acceptance T-62-04:** A changed or unavailable technical source triggers review without fabricating its missing content.

**R-62-05 — Property-driven comparison.** Every architectural use of prior art MUST identify the controlled property and the remaining ASKA-specific obligation.

**Acceptance T-62-05:** Combine two sources with incompatible roots or attacker assumptions; no composed claim is accepted without a bridging argument.

