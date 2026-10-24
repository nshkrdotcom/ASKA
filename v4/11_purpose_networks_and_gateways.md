# ASKA v4 — Purpose networks and cross-domain gateways

[Start](01_architecture_and_reading_map.md) · [Previous](10_ai_environment_and_trusted_interaction.md) · [Next](12_cross_domain_security_and_information_release.md)

**Requirements:** R01, R03, R04, R05, R06, R10, R11, R12, R15, R19, R21–R24.

Native endpoints attach to physical fabrics with distinct purposes. No universal route connects every application, identity service, management controller, and recovery endpoint. To cross purposes, a gateway terminates one transaction and authorizes a named effect on the other side. A policy label cannot turn ordinary forwarding into that boundary.

## Network roles

| Fabric or boundary | Purpose | Native physical rule |
|---|---|---|
| Encounter boundary | Discovery, enrollment, and imports from untrusted environments | Separate edge resources and admission endpoints; no direct route to native services |
| Authenticated Trust Networks (ATNs) | Admitted application and collaboration traffic within a defined purpose/trust group | Dedicated interfaces and paths for each required physical separation; independent receiving policy |
| Sovereign Trust Networks (STNs) | High-consequence identity, policy, key, and recovery operations | Separately rooted equipment, control, and paths; no general application traffic |
| Observation fabrics | Bounded audit/health reporting | Explicit one-way or guarded export interfaces; classified logs remain protected |
| Dynamic Trust Gateways (DTGs) | Specific cross-purpose transactions | Terminate both sides and create a separately authorized effect; no transparent bridge |

Each realm or federation instantiates its own ATN and STN roles. Neither names one worldwide “trusted network.” Membership establishes neither a peer's honesty nor permission for an operation. Every fabric, including an STN, can contain compromised endpoints and controllers. Each endpoint checks each operation against its own authority. The encounter boundary gives unavoidable public entry its own explicit role. A compromised encounter service must not reconfigure an ATN or STN.

## Physical topology contract

Each deployment records paths as a graph of actual interfaces, guards, switches, links, and management dependencies. For each pair of purposes that requires separation, the topology record must identify disjoint physical facilities and every authorized gateway edge. The target excludes shared mutable switch tables as the sole separation mechanism.

Dedicated fibers or electrical paths can share a building while retaining a declared common physical risk. VLANs and tunnels classify traffic on shared forwarding hardware; separate switch queues still share the switch; separate wavelengths still share the fiber. None establishes the disjoint facilities that R04 requires. If a deployment shares them, it must report the weaker profile and its impact on R04/R11.

The protected configuration binds each island's network engine to its purpose-specific endpoints. Workload code cannot select another physical network by supplying a different destination field. The egress inventory must include host raw queues, management transmit paths, debug, reset fallback, and alternate device functions.

Dynamic provisioning may allocate a previously unused path or safely reassign a resource after revocation, drain, sanitation, and fresh authority installation. It cannot temporarily join unrelated purpose fabrics through an unrestricted control-plane command. Circuit configuration itself requires authority: independent endpoint and purpose checks must govern each change.

## Encounter resource separation

Native first-contact traffic uses dedicated encounter ports, receive/parser lanes, ingress FIFOs, buffer banks, and DMA paths. Established ATN/STN traffic must not pass through an encounter FIFO or depend on its free-buffer pool. A shared front-end queue followed by classification does not meet this requirement: classification occurs after the shared bottleneck.

Encounter parsers, authentication work, installation requests, interrupts, and telemetry have bounded resource allowances. They cannot consume resources reserved for established sessions or modify established-session tables directly. A protected installer applies only locally authorized changes under independent policy. Existing-session control and recovery use separately reserved service.

The path inventory includes downstream memory controllers, interconnects, cryptographic engines, policy stores, power, clocks, cooling, and reset. For each shared facility, the deployment states the coupling and provides enforceable service bounds or reports the unmet isolation requirement. Different FIFO names alone do not establish physical independence. Even a separated encounter path can lose first-contact availability under saturation; separation protects the declared established-service resources, not every upstream carrier or shared physical facility.

## Admission and routing

Route services discover candidate paths inside the allowed topology. Protected gates admit only paths/resources approved by their owners and accepted by the endpoints. A route proposal grants no permission. Session consent does not give a sender arbitrary forwarding rights, and a forwarding grant does not establish permission to disclose its payload.

The architecture permits packet-carried authorization, installed per-channel state, or admitted circuits. The protocol study must compare replay, reservation, key distribution, failure, and physical enforcement properties before choosing among them. This specification fixes no custom hop header ahead of that comparison.

| Candidate | Potential fit | Missing ASKA obligation |
|---|---|---|
| Admitted circuits | Stable private channels and explicit physical routing | Provisioning authority, safe reconfiguration, utilization, and fault isolation |
| Packet-carried path grants | Dynamic multiplexing within one purpose fabric | Grant-to-port/payload binding, expiry, replay exposure, and mandatory gate placement |
| Installed channel tables | Narrow local/industrial fabrics | Protected state scale, update ordering, and recovery consistency |
| SCION-family routing | Explicit trust/path concepts for inter-realm communication | Physical purpose separation and compromised local controller containment |

[SCION](https://docs.scion.org/en/v0.13.0/overview.html) is a path/trust architecture comparison. [EPIC](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) adds data-plane authorization/authentication/validation alternatives; [COLIBRI](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf) addresses bandwidth reservation. An ASKA report must not treat those logical paths and assumptions as proof of private cable geography.

## Gateway transaction

A DTG consists of separately confined ingress parsing, a small effect/release checker, and an egress constructor. High-consequence crossings use independently controlled enforcement on both sides. A shared signing key, firmware installer, or reset controller would defeat that independence. The dependency record must disclose any such shared control.

The gateway receives an admitted typed request, binds immutable inputs and their restrictions, validates the permitted transformation, resolves the destination's independent acceptance, and prepares a new target-side operation. Each local boundary commits under its own current policy. Those commits are separate: no gateway assumes a simultaneous policy snapshot across partitioned realms. The target receives an assertion scoped to the specific gateway service. The original sender's unrestricted authority does not cross with it.

The gateway admits only explicit operations, such as importing a bounded document object or returning an approved policy decision. A gateway does not expose arbitrary STN RPC, raw packet forwarding, or broad memory sharing. Decrypting and scanning a payload is not a general proof that it is harmless. Narrow schemas, release semantics, budgets, and recipient checks remain necessary.

If the gateway fails before target-side commit, the target publishes nothing. Failure after target-side commit may leave an uncertain response; operation identifiers and receipts support reconciliation. Separate local policy withdrawal cannot recall data already crossed. A multi-party commit protocol must define what each participant does during partitions and crashes. It cannot assume an atomic inter-network action.

## Adversarial interconnections

A DTG is a transfer pipeline with source-side disclosure enforcement and independently owned destination enforcement. A single gateway instance must not hold both domains' unrestricted policy authority or bypass their guards. Parsing, transformation, release proposal, release control, and carriage have distinct contracts and failure scopes. The detailed transaction is in [12](12_cross_domain_security_and_information_release.md).

A newly attached cable, dual-connected endpoint, or rogue switch changes reachability only. Its traffic still needs a valid source effect, permitted release, path contract, and receiver consent. The added connection can create load and new observations; it must not create permissions. Report a physical tap behind a guard and an authorized unrestricted export as distinct failure modes; each must be identified explicitly.

Analyze paired directions together. Reusing a compromised import transformer for unrestricted responses can expose response plaintext and create command-and-control even if every outer session authenticates. Separate the workers and their state, then mediate any necessary correlation through bounded typed identifiers. A request grants no raw return path.

## One-way paths

A data diode can enforce a one-direction operation. The lack of a return channel affects acknowledgment, key renewal, failure reporting, and capacity control. Returning status on another path creates a new information-flow edge. That edge needs separate authority. A high-to-low diode can still carry an unauthorized disclosure in its permitted direction; a low-to-high diode can still deliver malicious imports. [NIST's data-diode definition](https://csrc.nist.gov/glossary/term/data_diode) identifies the one-way boundary concept; ASKA still needs an apparatus-specific path and signaling analysis.

## Availability and intermediates

Admission must act upstream of a protected bottleneck to preserve its capacity. Finite queues cannot accommodate sustained excess load. Controllers must reserve control/recovery service and police admitted senders, including valid replays. Exact per-sender allowances require accounting; “stateless transit” cannot remember every use of a copyable token.

An IP overlay can test endpoint authority and ciphertext integrity through hostile transit. It is an interoperability/testing realization and establishes no native physical-purpose separation. A legacy gateway occupies an encounter domain and receives no native administrative authority. The native system must remain operable with that gateway disconnected.

**Open research:** scalable purpose-specific infrastructure, circuit/grant tradeoffs, independently enforceable gateway composition, physical inventory assurance, and affordable bandwidth isolation under admitted abuse. Successful validation requires both forbidden-crossing tests and useful inter-domain applications.
