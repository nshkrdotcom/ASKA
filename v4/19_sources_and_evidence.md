# ASKA v4 — Sources and evidence register

[Start](01_architecture_and_reading_map.md) · [Previous](18_traceability_and_evolution.md)

**Research cut-off: 22 October 2026.** This register names the primary sources behind the mechanism comparisons and technology studies. These documents propose ASKA's selected composition, requirements, state machines, and hypothetical calculations. ASKA remains an unvalidated research architecture. No cited result demonstrates the complete system.

The inspection notes record what the source review read: a primary record, abstract, specification, or available relevant passages. They do not claim artifact reproduction, an audit of an entire proof, or independent validation of vendor claims. The review examined relevant mechanisms in large papers and specifications; it did not audit those documents exhaustively. Before an implementation relies on a mutable URL as evidence, its evidence record must pin or archive the referenced version.

## Concrete attack cases

| ID | Primary source | Status, inspection, and use |
|---|---|---|
| S01 | [PHP: RCE via OOM corruption, GHSA-w8hw-w9fx-j79w](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w) | The PHP project issued this advisory on 21 October 2026. The review consulted its description and impact for the CVE-2026-109618 incomplete-initialization and worker-authority stress case. |
| S02 | [PHP: RCE via stale global state, GHSA-6wmf-4rv5-p3rp](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp) | The PHP project issued this advisory on 21 October 2026. The review consulted its request-lifetime description for the CVE-2026-109619 cross-request stale-reference case. |
| S03 | [Project Zero: FORCEDENTRY initial execution](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html) | Project Zero published this primary analysis in December 2021. The review consulted its parser-path discussion to test complete mediation across format classification and helper paths. |
| S04 | [Project Zero: FORCEDENTRY sandbox escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html) | Project Zero published this primary analysis in March 2022. The review consulted its logic-escape discussion to distinguish memory-exploit prevention from authority containment. |

Document 15 derives ASKA test cases from these failure mechanisms. It does not report runs of the original exploits on ASKA.

## Isolation, execution, and software construction

| ID | Primary source | Evidence and comparison limit |
|---|---|---|
| S05 | [OctopOS / split-trust hardware, MobiSys 2023](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf) · [artifact](https://zenodo.org/records/7927948) | The paper and author artifact record describe exclusive-use physical partitioning in a prototype, relevant to candidate A/P1. The review did not run the artifact; it establishes no full ASKA governance or network result. |
| S06 | [M³, ASPLOS 2016](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) | The review consulted the paper's architecture and communication model: heterogeneous compute behind external communication enforcement. Its management and distributed-flow assumptions differ from ASKA's. |
| S07 | [TEEM³ artifact, ASPLOS 2026](https://zenodo.org/records/17936497) | The review consulted the artifact record but did not execute it. It supplies a cooperating core-independent TEE comparison; the review has not assessed detailed protocol equivalence. |
| S08 | [CHERI ISA version 9, UCAM-CL-TR-987](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-987.pdf) | The 2023 specification/reference model supplies candidate local-reference semantics. It mandates no ASKA ISA and supplies no complete temporal/physical model. |
| S09 | [HyperFlow, CCS 2018](https://www.cs.cornell.edu/andru/papers/hyperflow/) | The review consulted the author publication/architecture summary for processor IFC and timing-aware implementation. That proof does not extend to ASKA devices or networks. |
| S10 | [TRIPS project overview](https://www.cs.utexas.edu/~cart/trips/overview.html) | The authors describe an implemented EDGE/spatial processor direction. Dataflow itself defines no authority policy. |
| S11 | [Elasticlave, USENIX Security 2022](https://www.usenix.org/system/files/sec22-yu-jason.pdf) | The paper supplies a sharing/exclusive-access comparison. An ASKA comparison must explicitly check region ownership, device coverage, and source lifetime. |
| S12 | [Twizzler, USENIX ATC 2020](https://www.usenix.org/conference/atc20/presentation/bittman) | The review consulted the author conference abstract on data-centric persistent objects. It does not establish ASKA's crash/effect or physical-isolation contract. |
| S13 | [DStar, NSDI 2008](https://www.scs.stanford.edu/~nickolai/papers/zeldovich-dstar.pdf) | The review consulted the paper's distributed IFC/exporter model. It supplies a strong category/authority comparison under different trusted local enforcement. |
| S14 | [Fabric, SOSP 2009](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.html) | The review consulted the author abstract and object/policy model on distributed confidentiality, integrity, and transactions. They supply no new ASKA implementation evidence. |
| S15 | [capDL language revision 1.1](https://docs.sel4.systems/projects/capdl/lang-spec.html) | The official specification describes explicit capability distributions. It supplies a contract-representation comparison and imposes no requirement to use seL4. |
| S16 | [CakeML](https://cakeml.org/index.html) · [verified compilation on a verified processor](https://cakeml.org/pldi19.pdf) | Project documentation and a publication lead describe verified compiler/proof infrastructure. A new ASKA target needs its own semantics and refinement. |
| S17 | [Calyx](https://calyxir.org/) · [paper](https://arxiv.org/abs/2102.09713) | Project/compiler documentation and the paper record describe accelerator compilation and structural/control representation. They do not prove the security of generated hardware. |
| S18 | [Time Protection, EuroSys 2019](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract) | The author publication record supplies an observation/isolation comparison. An ASKA study must assess coverage and cost for each resource. |

## Physical and unconventional technology frontier

| ID | Primary source | Demonstrated capability versus research dependency |
|---|---|---|
| S19 | [Imec/EVG 200 nm wafer bonding, May 2026](https://www.imec-int.com/en/press/imec-and-ev-group-demonstrate-wafer-wafer-hybrid-bonding-200nm-interconnect-pitch-and-record) | The developers report a test vehicle and routable interconnects. That result establishes neither ASKA fabrication, thermal behavior, production yield, nor verified boundaries. |
| S20 | [Imec front/backside connectivity research](https://www.imec-int.com/en/articles/path-high-density-front-and-backside-wafer-connectivity) | The research organization describes integration work that could change memory/routing placement. It guarantees no process node or date. |
| S21 | [DARPA NGMM program and summit](https://www.darpa.mil/events/2025/ngmm-summit) | The official program description sets goals for 3D heterogeneous-integration infrastructure. Those goals do not establish completed capabilities. |
| S22 | [Intel optical I/O demonstration, June 2024](https://www.intel.com/content/www/us/en/newsroom/news/intel-unveils-first-integrated-optical-io-chiplet.html) | The developer reports a live optical-interconnect demonstration. It supplies neither optical authority enforcement nor ASKA energy/reach measurements. |
| S23 | [IBM mixed-signal AIMC chip, Nature Electronics 2023](https://research.ibm.com/publications/a-64-core-mixed-signal-in-memory-compute-chip-based-on-phase-change-memory-for-deep-neural-network-inference) | The author abstract reports fabricated inference hardware relevant to confined acceleration. Numerical accuracy and analog state still need separate contracts. |
| S24 | [Intel Loihi 2 technical brief](https://www.intel.com/content/dam/www/central-libraries/us/en/documents/neuromorphic-computing-loihi-2-brief.pdf) | The developer describes a research platform for event-driven compute. It establishes neither a high-assurance policy engine nor a general replacement processor. |
| S25 | [Sandia reversible-computing research](https://www.sandia.gov/news/publications/hpc-annual-reports/article/stretching-the-thermodynamic-limits-of-hpc-efficiency/) | The laboratory summarizes long-horizon energy research. It does not claim that reversible computing eliminates erasure, control, or error-correction costs. |

These sources identify mechanisms to investigate. They do not establish that ASKA's target will become inexpensive within a particular decade. New processes, dense stacking, optics, and alternative compute remain optional enablers unless a decision record establishes a necessary property.

## AI, communication, trust, and evolution

| ID | Primary source | Use and limits |
|---|---|---|
| S26 | [CaMeL, arXiv:2503.18813v2](https://arxiv.org/abs/2503.18813v2) · [implementation](https://github.com/google-research/camel-prompt-injection) | The review consulted the author abstract and repository. CaMeL separates model control/data and checks permitted flows in software agents. The review ran no artifact and makes no hardware-OS claim. |
| S27 | [SCION architecture v0.13](https://docs.scion.org/en/v0.13.0/overview.html) | The official architecture documentation defines path/trust concepts. ASKA additionally requires physical purpose separation. |
| S28 | [EPIC, USENIX Security 2020](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) | The preceding review consulted primary-paper passages; the source review reconfirmed the publication record but encountered intermittent repeat fetches. A comparison must explicitly select security levels and replay-suppression dependencies. |
| S29 | [COLIBRI, CoNEXT 2021](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf) · [author publication record](https://netsec.ethz.ch/publications/?key=conext2021colibri) | The review consulted the author record and indexed primary passages; PDF retrieval was intermittent. They support reservation/policing comparisons, but the review reproduced no bandwidth guarantees for ASKA. |
| S30 | [NIST data diode definition](https://csrc.nist.gov/glossary/term/data_diode) | NIST defines the one-way signaling boundary. That boundary neither authorizes disclosure nor validates content. |
| S31 | [RFC 9334: RATS](https://www.rfc-editor.org/rfc/rfc9334.html) | The RFC defines attestation architecture and roles. Local authorities still decide appraisal and authorization. |
| S32 | [RFC 8446: TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html) | TLS 1.3 supplies an existing authenticated control-channel candidate. An ASKA binding needs a suitable carrier and reviewed use; TLS grants no application authority. |
| S33 | [RFC 5116: AEAD](https://www.rfc-editor.org/rfc/rfc5116.html) | The RFC specifies associated-data and nonce requirements. A new data encoding/key schedule still needs review. |
| S34 | [The Update Framework specification](https://theupdateframework.github.io/specification/latest/) | The official specification displayed version 1.0.37 when the review consulted it. It supplies role, threshold, version, and expiry comparisons; it establishes neither signer independence nor firmware correctness. |
| S35 | [NIST FIPS 203](https://csrc.nist.gov/pubs/fips/203/final) | The review consulted the ML-KEM standard and then-current publication/errata notice. ML-KEM is a candidate for reviewed long-lived key-establishment profiles; the primitive does not construct a protocol automatically. |
| S36 | [NIST FIPS 204](https://csrc.nist.gov/pubs/fips/204/final) | The review consulted the ML-DSA standard and publication/errata notice. ML-DSA supplies a signature candidate; no signature proves that a program implements its intended semantics. |

## Cross-domain security and protected-network transfers

| ID | Primary source | Inspection and limits |
|---|---|---|
| S37 | [NCSC cross-domain architecture](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-architecture) | The review read the architecture and threat discussion in official guidance dated 21 April 2026, version 1.0. It describes layered end-to-end controls and ownership dependencies, but validates no ASKA design. |
| S38 | [NCSC cross-domain design principles](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-design-principles) | The review read the principles and import/export/bidirectional examples in official guidance dated 21 April 2026, version 1.0. The guidance separates release decisions from enforcement and recognizes free-form review limits. |
| S39 | [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) | The review consulted the official abstract. It rejects implicit trust based on physical/network location or ownership; it supplies no evidence of physical segregation. |
| S40 | [NIST SP 800-53 revision 5](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) | The review consulted relevant AC-4 and SC-31 passages in the public PDF with December 2020 updates. This record identifies that edition and claims no audit of later catalog changes. |
| S41 | [NSA NCDSMO and Raise the Bar](https://www.nsa.gov/Cybersecurity/Partnership/National-Cross-Domain-Strategy-Management-Office/) | The review read the public program page, but did not inspect detailed standards linked through Intelink. It makes no compliance claim. |
| S42 | [Air Force: cyberspace incident account, 18 October 2010](https://www.af.mil/News/Article/115277/cyberspace-is-the-new-domain-of-warfare/) | The review read the official account of a flash drive introducing malware into classified military networks in 2008. The account neither reconstructs the full intrusion nor demonstrates a specific live bridge. |
| S43 | [Air Force: Teixeira investigation summary, 11 December 2023](https://www.usafe.af.mil/News/Article-Display/Article/3613146/results-of-investigation-into-a1c-texieras-unit-following-unauthorized-disclosu/) | The review consulted the indexed official summary; the direct fetch returned 403. It supports access/supervision failure context, not a complete reconstruction of printing or physical paths. |
| S44 | [Marine Corps MARADMIN 683/10](https://www.marines.mil/News/Messages/MARADMINS/Article/888508/protection-of-classified-information-on-department-of-defense-dod-secret-intern/) | The review consulted the indexed official directive; the direct fetch returned 403. Its removable-media write restrictions supply historical precedent, not a claim about current military policy. |

The supplied network and protected-network discussions pose research questions; they supply no primary historical evidence. This review did not independently establish their Manning narrative or detailed Teixeira printing claims. Tests can exercise those mechanisms without claiming an unsupported reconstruction of either incident. The review could not access the CDSE case-study PDF and makes no claim based on reading it.

## Research completeness and limits

The register covers contrasting system organizations and enabling technologies. It is not an exhaustive prior-art or patent search. Prior work established separation, capabilities, IFC, explicit messages, transactions, and scoped delegation. This register credits that work. Only an implementation and matched comparison can determine whether the selected composition contributes a new result.

The following relationships remain unestablished: physical guard integrity under real management/reset paths; late-effect ownership across heterogeneous devices; current-policy publication and durable effects; user-intent binding with a malicious planner; and independent evolution of multiple trust roots. The cited work does not establish those relationships for ASKA.

Before relying on a comparison, inspect the referenced design's trusted components, behavior, limitations, and artifact version. Record the relevant passages and the requirement they support. If access is incomplete, mark the behavior unresolved rather than inferring absence or equivalence from an abstract.

The historical source review examined v1's overview, onboard-agent clarification, application-development discussion, dedicated resource/network roles, and compute proposal; v2/v3 enforcement and lifecycle contracts; and the five supplied v4 discussions. The review did not audit every repeated diagram or speculative brainstorm line by line. It accepts no historical claim of performance, novelty, patent status, or physical guarantees as external evidence.
