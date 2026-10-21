# 07 — Prior art and sources

[Start](README.md) · [Previous: research plan](06_research_plan_and_evidence.md) · [Next: defensive structural disclosure](08_defensive_structural_disclosure.md)

ASKA combines questions with long histories: separation, capabilities, protected messaging, information-flow control, network admission, and independently administered trust. The presence of a new project name or a larger diagram establishes no novelty.

The candidate contribution is an explicit contract for composing selected mechanisms under a demanding compromise model, followed by evidence about whether an IES-based implementation can satisfy it at acceptable cost. Even that contribution remains to be established against existing work.

The sources below were checked during preparation of ASKA 2.0 on 20 October 2026. “Author/project description” means the stated scope was checked there; it does not imply reproduction of the result. Linked papers and specifications support the particular mechanisms described, not the feasibility of ASKA as a whole. This is a focused reading map, not an exhaustive literature review.

## Closest architectural comparisons

| Work | What it contributes to the comparison | Question ASKA still has to answer |
|---|---|---|
| [Rushby, *Design and Verification of Secure Systems* (1981)](https://www.csl.sri.com/papers/sosp81/) | Separation and trusted mediation as a way to structure secure systems; author abstract | How should the proposed IES resources and mediators be decomposed and implemented? |
| [Lee et al., *An Efficient, Protected Message Interface* (1998)](https://www.cs.utexas.edu/~skeckler/pubs/ieeecomputer98.pdf) | M-Machine mechanisms for protected, efficient messaging; primary paper | Which messaging protections survive ASKA's different host, device, lifecycle, and realm assumptions? |
| [CHERI project FAQ](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html) | Hardware-protected pointers, bounds, permissions, and compartmentalization | What additional data classification and device enforcement are needed for the chosen IES contract? |
| [Amar et al., *CHERIoT: Complete Memory Safety for Embedded Devices* (2023)](https://cheriot.org/papers/2023-micro-cheriot-uarch.pdf) | Embedded capability architecture and system co-design, including capability propagation restrictions; primary paper | Which parts can serve a candidate IES, and which desired payload-flow properties require more? |
| [Ferraiuolo et al., *HyperFlow* (2018)](https://www.cs.cornell.edu/andru/papers/hyperflow/hyperflow.pdf) | Processor design with configurable information-flow enforcement and timing-channel considerations; primary paper | How do the properties extend through memory, DMA, devices, and external transport? |
| [Zagieboylo, Suh, and Myers, *Using Information Flow to Design an ISA That Controls Timing Channels* (2019)](https://www.cs.cornell.edu/andru/papers/hyperisa/) | An ISA-level interface for relating hardware and software information-flow guarantees; author description | Which execution contract should ASKA require, and can an existing ISA support it economically? |
| [Zeldovich, Boyd-Wickizer, and Mazières, *Securing Distributed Systems with Information Flow Control* (2008)](https://www.scs.stanford.edu/~nickolai/papers/zeldovich-dstar.pdf) | DStar extends decentralized information-flow control across machines using local protection and network cryptography; primary paper | Which per-principal trust assumptions can be retained, and which must change when ordinary host kernels are compromised? |
| [Liu et al., *Fabric: A Platform for Secure Distributed Computation and Storage* (2009)](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.html) | Distributed computation and storage with confidentiality and integrity policies despite mutual distrust; author description | Where does ASKA's proposed physical enforcement add a property beyond language/runtime enforcement? |

DStar and Fabric are especially important comparisons because they already address distributed information-flow concerns. It would be misleading to imply that prior work stops at a processor boundary or assumes one universally trusted organization. A proper comparison must identify the trust relation for each protected principal and datum, rather than describe an entire system as simply “trusted” or “untrusted.”

Hardware messaging also predates ASKA. It is useful to revisit these designs for their mechanisms, assumptions, and costs. The case for IES must rest on a specific organization of authority and enforcement, not on declaring actors or channels unprecedented.

## Network and authority comparisons

| Work | Relevant mechanism or scope | Limit on what it establishes for ASKA |
|---|---|---|
| [Yang, Wetherall, and Anderson, *A DoS-limiting Network Architecture* (TVA, 2005)](https://users.cs.duke.edu/~xwy/publications/tva.pdf) | Receiver-authorized capabilities and mechanisms addressing denial-of-service attacks | Packet permission does not by itself establish protected local payload classification |
| [Casado et al., *SANE: A Protection Architecture for Enterprise Networks* (2006)](https://www.usenix.org/legacy/event/sec06/tech/full_papers/casado/casado_html/paper.html) | Capabilities enforced by switches within an enterprise protection architecture | Its policy/control structure must be compared explicitly with independently rooted ASKA gates |
| [SCION header specification](https://docs.scion.org/en/latest/protocols/scion-header.html) | Defined path and hop fields, authenticated forwarding information, and MAC chaining | Path-field authentication is not a proof of arbitrary physical geography or payload information flow |
| [NVIDIA BlueField modes of operation](https://networking-docs.nvidia.com/bsp/latest/modes-of-operation) | Restricted mode separates specified host privileges from device-side control | The management, firmware, and hardware trust boundary must be assessed for a particular configuration |
| [OpenTitan security documentation](https://opentitan.org/book/doc/security/index.html) | Documented roots, boot and key-management functions, lifecycle, and security assumptions | Incorporating a root does not automatically enforce ASKA's memory, DMA, or message contracts |

These sources make two broad claims inappropriate: that industry has never separated network enforcement from host control, and that independently accepted communication is a new concept. They also do not show that any one existing product supplies every proposed IES guarantee. That is a comparison to perform, not a gap to declare in advance.

A capability network can be a strong baseline even if it uses different mechanisms. A DPU can be a useful building block even if some device software remains trusted. The research needs to state exactly which component may be compromised and which invariant is expected to survive.

## Cryptographic and assurance foundations

| Source | Use in ASKA 2.0 | Scope |
|---|---|---|
| [RFC 5116, *An Interface and Algorithms for Authenticated Encryption*](https://www.rfc-editor.org/rfc/rfc5116.html) | AEAD interface, AES-GCM parameters, and nonce requirements for the experimental record | Existing cryptography; not review of the proposed session or admission protocol |
| [RFC 4303, *IP Encapsulating Security Payload*](https://www.rfc-editor.org/rfc/rfc4303.html) | A relevant established transport-security comparison, including sequence and anti-replay machinery | A candidate baseline; ASKA 2.0 defines no interoperable ASKA-to-ESP mapping |
| [RFC 8446, *The Transport Layer Security Protocol Version 1.3*](https://www.rfc-editor.org/rfc/rfc8446.html) | An established secure-channel comparison for a protected endpoint implementation | Endpoint security depends on where keys, plaintext, and application authority terminate |
| [Ge, Yarom, Chothia, and Heiser, *Time Protection: The Missing OS Abstraction* (2019)](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract) | Distinguishes temporal isolation from ordinary spatial protection; author abstract and publication record | Does not establish timing security for ASKA's entire shared-resource graph |

The illustrative record uses an existing primitive and explicit state rules. It remains a protocol proposal needing analysis. Reusing a secure primitive is necessary but insufficient: wrong nonce handling, ambiguous encoding, stale admission, or an unprotected plaintext buffer can defeat the larger construction.

## Evidence relevant to the longer horizon

[DeepMind's AlphaChip report](https://deepmind.google/blog/how-alphachip-transformed-computer-chip-design/) describes AI-assisted chip layout work and its use in Google's designs. It is a primary account from the organization developing the method, with that attribution retained. [Tiny Tapeout](https://tinytapeout.com/) demonstrates a route for small designs to reach shared fabrication infrastructure.

These support the narrower observation that design assistance and access to some fabrication paths are developing. The forecast that a small team could take a much more ambitious architecture through an increasingly automated pipeline by 2036 remains a scenario. ASKA 2.0 neither treats it as an established capability nor requires it for the first research steps.

## What to investigate next in the literature

The next pass should compare distributed information-flow systems, separation kernels and guards, capability revocation, I/O isolation, trusted execution with device assignment, protected user-level messaging, and authenticated path designs using the exact contract in [Documents 01](01_vision_problem_and_threat_model.md)–[04](04_network_transport_and_realms.md).

For each close candidate, record who classifies input; who may read plaintext; who controls DMA, policy updates, and recovery; what an authenticated message means; what survives a particular compromise; and where timing, availability, or lifecycle guarantees stop. Review the full relevant papers and implementations before making strong comparative claims from abstracts.

An omitted precedent should be added and the claimed contribution revised. Finding an existing solution is a successful research outcome. Finding a limitation is useful only when the comparison preserves the existing system's actual assumptions and does not weaken its implementation for convenience.

## Short glossary

| Term | Meaning in this revision |
|---|---|
| IES | Isolated Execution Stack: proposed hardware-enforced computation and resource compartment |
| Gate | Mandatory enforcement function at a defined boundary; implementation may include protected firmware |
| Realm | An independently administered set of resources and policy authorities |
| Capability | Protected authority to perform specified operations on an object; not automatically a data-flow label |
| Label | Protected information-flow restriction interpreted under a defined policy |
| Release | Explicit authorization for a particular otherwise-forbidden disclosure |
| Session | Installed directional authority, interpretation, cryptographic, and freshness state |
| Boundary continuity | The proposed preservation of authority and restrictions across representation and enforcement boundaries |
| Protected state | State whose integrity, and where necessary confidentiality, ordinary compromised software cannot defeat under the stated model |
| Trusted computing base | The components and authorities whose correct behavior is required for a particular claimed property |
| Explicit transfer | Delivery of modeled data through a named interface; it does not include every timing or physical observation |

Earlier ASKA terms for internal fabrics, external channels, trust services, and gateways are described here by their function. This reduces vocabulary while preserving the architectural questions. The project remains ASKA 2.0: its subject is the machine and its enforceable boundaries.
