# ASKA v4 — Sources and evidence register

[Start](0300_architecture_and_reading_map.md) · [Previous](0316_traceability_and_evolution.md) · [Next](0318_cross_domain_security_and_information_release.md)

**Research cut-off: 22 October 2026.** This register records primary sources used to compare mechanisms and investigate enabling technologies. ASKA's selected composition, requirements, state machines, and hypothetical calculations are proposals in this set. No cited result demonstrates the complete architecture.

Inspection means reading the identified primary record, abstract, specification, or relevant available passages. It does not mean reproducing an artifact, auditing an entire proof, or validating vendor claims independently. Large papers/specifications were reviewed for relevant mechanisms, not exhaustively audited. Mutable URLs must be pinned or archived before implementation evidence relies on them.

## Concrete attack cases

| ID | Primary source | Status, inspection, and use |
|---|---|---|
| S01 | [PHP: RCE via OOM corruption, GHSA-w8hw-w9fx-j79w](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w) | Project advisory, 21 October 2026; description/impact consulted. Supports the incomplete-initialization and worker-authority stress case for CVE-2026-109618. |
| S02 | [PHP: RCE via stale global state, GHSA-6wmf-4rv5-p3rp](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp) | Project advisory, 21 October 2026; request-lifetime description consulted. Supports the cross-request stale-reference case for CVE-2026-109619. |
| S03 | [Project Zero: FORCEDENTRY initial execution](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html) | Primary analysis, December 2021; parser-path discussion consulted. Supports complete mediation across format classification and helper paths. |
| S04 | [Project Zero: FORCEDENTRY sandbox escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html) | Primary analysis, March 2022; logic-escape discussion consulted. Distinguishes memory-exploit prevention from authority containment. |

The case studies in 0313 are ASKA-designed tests derived from these failure mechanisms. They are not reported executions of the original exploits on ASKA.

## Isolation, execution, and software construction

| ID | Primary source | Evidence and comparison limit |
|---|---|---|
| S05 | [OctopOS / split-trust hardware, MobiSys 2023](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf) · [artifact](https://zenodo.org/records/7927948) | Paper/author artifact record; exclusive-use physical partitioning with a prototype. Relevant to candidate A/P1. Artifact not run; no claim of full ASKA governance or networks. |
| S06 | [M³, ASPLOS 2016](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) | Paper's architecture and communication model consulted. Heterogeneous compute with external communication enforcement; management and distributed flow assumptions remain distinct. |
| S07 | [TEEM³ artifact, ASPLOS 2026](https://zenodo.org/records/17936497) | Artifact record consulted, not executed; cooperating core-independent TEE comparison. Detailed protocol equivalence remains unassessed. |
| S08 | [CHERI ISA version 9, UCAM-CL-TR-987](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-987.pdf) | 2023 specification/reference model. Candidate local reference semantics, not a required ISA or complete temporal/physical model. |
| S09 | [HyperFlow, CCS 2018](https://www.cs.cornell.edu/andru/papers/hyperflow/) | Author publication/architecture summary consulted; processor IFC and timing-aware implementation comparison. Does not extend its proof to ASKA devices or networks. |
| S10 | [TRIPS project overview](https://www.cs.utexas.edu/~cart/trips/overview.html) | Author project account of an implemented EDGE/spatial processor direction. Dataflow is not itself an authority policy. |
| S11 | [Elasticlave, USENIX Security 2022](https://www.usenix.org/system/files/sec22-yu-jason.pdf) | Paper and sharing/exclusive-access comparison. Region ownership, device coverage, and source lifetime must be compared explicitly. |
| S12 | [Twizzler, USENIX ATC 2020](https://www.usenix.org/conference/atc20/presentation/bittman) | Author conference abstract consulted; data-centric persistent objects. Does not establish ASKA's crash/effect or physical-isolation contract. |
| S13 | [DStar, NSDI 2008](https://www.scs.stanford.edu/~nickolai/papers/zeldovich-dstar.pdf) | Paper's distributed IFC/exporter model consulted. Strong category/authority comparison with different trusted local enforcement. |
| S14 | [Fabric, SOSP 2009](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.html) | Author abstract and object/policy model consulted. Distributed confidentiality/integrity and transactions; no new ASKA implementation evidence. |
| S15 | [capDL language revision 1.1](https://docs.sel4.systems/projects/capdl/lang-spec.html) | Official specification; explicit capability distributions. A comparison for contract representation, not a mandate to use seL4. |
| S16 | [CakeML](https://cakeml.org/index.html) · [verified compilation on a verified processor](https://cakeml.org/pldi19.pdf) | Project documentation and publication lead; verified compiler/proof infrastructure. A new ASKA target needs its own semantics and refinement. |
| S17 | [Calyx](https://calyxir.org/) · [paper](https://arxiv.org/abs/2102.09713) | Project/compiler documentation and paper record; accelerator compilation and structural/control representation. Not a proof of secure generated hardware. |
| S18 | [Time Protection, EuroSys 2019](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract) | Author publication record, used as an observation/isolation comparison. Coverage and costs must be assessed resource by resource. |

## Physical and unconventional technology frontier

| ID | Primary source | Demonstrated capability versus research dependency |
|---|---|---|
| S19 | [Imec/EVG 200 nm wafer bonding, May 2026](https://www.imec-int.com/en/press/imec-and-ev-group-demonstrate-wafer-wafer-hybrid-bonding-200nm-interconnect-pitch-and-record) | Developer report of a test vehicle and routable interconnects. Does not establish ASKA fabrication, thermal behavior, production yield, or verified boundaries. |
| S20 | [Imec front/backside connectivity research](https://www.imec-int.com/en/articles/path-high-density-front-and-backside-wafer-connectivity) | Research-organization account of integration work. A trajectory for memory/routing placement, not a guaranteed node/date forecast. |
| S21 | [DARPA NGMM program and summit](https://www.darpa.mil/events/2025/ngmm-summit) | Official program description for 3D heterogeneous integration. Enabling infrastructure goals are not completed capabilities. |
| S22 | [Intel optical I/O demonstration, June 2024](https://www.intel.com/content/www/us/en/newsroom/news/intel-unveils-first-integrated-optical-io-chiplet.html) | Developer-reported live optical interconnect demonstration. Does not supply optical authority enforcement or ASKA energy/reach measurements. |
| S23 | [IBM mixed-signal AIMC chip, Nature Electronics 2023](https://research.ibm.com/publications/a-64-core-mixed-signal-in-memory-compute-chip-based-on-phase-change-memory-for-deep-neural-network-inference) | Author abstract reports fabricated inference hardware. Relevant to confined acceleration; numerical accuracy and analog state need separate contracts. |
| S24 | [Intel Loihi 2 technical brief](https://www.intel.com/content/dam/www/central-libraries/us/en/documents/neuromorphic-computing-loihi-2-brief.pdf) | Developer research-platform description. Event-driven compute candidate, not a high-assurance policy engine or general replacement processor. |
| S25 | [Sandia reversible-computing research](https://www.sandia.gov/news/publications/hpc-annual-reports/article/stretching-the-thermodynamic-limits-of-hpc-efficiency/) | Laboratory research summary. Long-horizon energy investigation; no claim that reversible computing eliminates erasure, control, or error-correction costs. |

These sources motivate research, not a forecast that ASKA's target becomes cheap within a given decade. New processes, dense stacking, optics, and alternative compute remain optional enablers unless a decision record establishes a necessary property.

## AI, communication, trust, and evolution

| ID | Primary source | Use and limits |
|---|---|---|
| S26 | [CaMeL, arXiv:2503.18813v2](https://arxiv.org/abs/2503.18813v2) · [implementation](https://github.com/google-research/camel-prompt-injection) | Author abstract and repository consulted. Separates model control/data and checks permitted flows in a software agent setting. No artifact run or hardware-OS claim. |
| S27 | [SCION architecture v0.13](https://docs.scion.org/en/v0.13.0/overview.html) | Official architecture documentation. Path/trust concepts; physical purpose separation is an additional ASKA requirement. |
| S28 | [EPIC, USENIX Security 2020](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) | Primary-paper passages consulted in the preceding review and publication record reconfirmed; repeat fetches were intermittent. Security levels and replay-suppression dependencies must be selected explicitly. |
| S29 | [COLIBRI, CoNEXT 2021](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf) · [author publication record](https://netsec.ethz.ch/publications/?key=conext2021colibri) | Author record and indexed primary passages consulted; PDF retrieval was intermittent. Reservation/policing comparison; no reproduced bandwidth guarantees for ASKA. |
| S30 | [NIST data diode definition](https://csrc.nist.gov/glossary/term/data_diode) | Terminology/reference boundary. One-way signaling does not authorize disclosure or validate content. |
| S31 | [RFC 9334: RATS](https://www.rfc-editor.org/rfc/rfc9334.html) | Attestation architecture and roles. Appraisal and authorization remain local decisions. |
| S32 | [RFC 8446: TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html) | Existing authenticated control-channel candidate. Requires a suitable carrier binding and reviewed use; it does not grant application authority. |
| S33 | [RFC 5116: AEAD](https://www.rfc-editor.org/rfc/rfc5116.html) | Associated-data and nonce requirements. A new data encoding/key schedule still needs review. |
| S34 | [The Update Framework specification](https://theupdateframework.github.io/specification/latest/) | Official specification, version 1.0.37 displayed when consulted. Role/threshold/version/expiry comparison. Does not establish signer independence or firmware correctness. |
| S35 | [NIST FIPS 203](https://csrc.nist.gov/pubs/fips/203/final) | ML-KEM standard and current publication/errata notice. Candidate for reviewed long-lived key-establishment profiles, not an automatic protocol construction. |
| S36 | [NIST FIPS 204](https://csrc.nist.gov/pubs/fips/204/final) | ML-DSA standard and publication/errata notice. Signature candidate; no signature proves a program implements its intended semantics. |

## Cross-domain security and protected-network transfers

| ID | Primary source | Inspection and limits |
|---|---|---|
| S37 | [NCSC cross-domain architecture](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-architecture) | Official guidance, 21 April 2026, version 1.0; architecture and threat discussion read. End-to-end layered controls and ownership dependencies; no ASKA validation. |
| S38 | [NCSC cross-domain design principles](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-design-principles) | Official guidance, 21 April 2026, version 1.0; principles and import/export/bidirectional examples read. Distinguishes release decisions and enforcement; recognizes free-form review limits. |
| S39 | [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) | Official abstract consulted; rejects implicit trust based on physical/network location or ownership. Not evidence of physical segregation. |
| S40 | [NIST SP 800-53 revision 5](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) | Public PDF with December 2020 updates; AC-4 and SC-31 relevant passages consulted. This is the identified edition, not a claim to have audited all later catalog changes. |
| S41 | [NSA NCDSMO and Raise the Bar](https://www.nsa.gov/Cybersecurity/Partnership/National-Cross-Domain-Strategy-Management-Office/) | Public program page read. Detailed standards linked through Intelink were not inspected; no compliance assertion is made. |
| S42 | [Air Force: cyberspace incident account, 18 October 2010](https://www.af.mil/News/Article/115277/cyberspace-is-the-new-domain-of-warfare/) | Official account read; flash-drive introduction into classified military networks in 2008. Does not reconstruct the full intrusion or demonstrate a specific live bridge. |
| S43 | [Air Force: Teixeira investigation summary, 11 December 2023](https://www.usafe.af.mil/News/Article-Display/Article/3613146/results-of-investigation-into-a1c-texieras-unit-following-unauthorized-disclosu/) | Indexed official summary consulted; direct fetch returned 403. Used for access/supervision failure context, not a complete reconstruction of printing or physical paths. |
| S44 | [Marine Corps MARADMIN 683/10](https://www.marines.mil/News/Messages/MARADMINS/Article/888508/protection-of-classified-information-on-department-of-defense-dod-secret-intern/) | Indexed official directive consulted; direct fetch returned 403. Removable-media write restrictions are historical precedent, not a claim about current military policy. |

The supplied network and protected-network discussions identify questions to investigate, rather than serving as primary historical evidence. Their Manning narrative and detailed Teixeira printing claims are not independently established here. Tests based on those mechanisms are useful without asserting an unsupported incident reconstruction. The CDSE case-study PDF was inaccessible during this review; no claim relies on having read it.

## Research completeness and limits

The register covers contrasting system organizations and enabling directions, not an exhaustive prior-art or patent search. Established separation, capabilities, IFC, explicit messages, transactions, and scoped delegation are credited as mechanisms rather than claimed as ASKA inventions. Whether the selected composition contributes a new result requires implementation and matched comparison.

The difficult unestablished relationships remain concrete: physical guard integrity under real management/reset paths; late-effect ownership across heterogeneous devices; current-policy publication and durable effects; user-intent binding with a malicious planner; and independent evolution of multiple trust roots. No citation fills those gaps by implication.

Before a design relies on a comparator, inspect its exact trusted components, behavior, limitations, and artifact version. Record the relevant passages and the requirement they support. If access is incomplete, mark the behavior unresolved rather than inferring absence or equivalence from an abstract.

The historical source review concentrated on v1's overview, onboard-agent clarification, application-development discussion, dedicated resource/network roles, and compute proposal; v2/v3 enforcement and lifecycle contracts; and the five supplied v4 discussions. It was not a line-by-line audit of every repeated diagram or speculative brainstorm in the historical archive. Historical claims of performance, novelty, patent status, or physical guarantees are not accepted as external evidence.
