# ASKA v4 — Purpose networks and cross-domain gateways

[Start](0300_architecture_and_reading_map.md) · [Previous](0309_ai_environment_and_trusted_interaction.md) · [Next](0311_admission_and_delivery.md)

**Requirements:** R01, R03, R04, R05, R06, R10, R11, R12, R15, R19, R21–R24.

The native network is a collection of purpose-specific physical fabrics. There is no universal route connecting every application, identity service, management controller, and recovery endpoint. Communication across purposes is a named application effect mediated by a gateway, not ordinary forwarding across a policy label.

## Network roles

| Fabric or boundary | Purpose | Native physical rule |
|---|---|---|
| Encounter boundary | Discovery, enrollment, and imports from untrusted environments | Separate edge resources and admission endpoints; no direct route to native services |
| Authenticated Trust Networks (ATNs) | Admitted application and collaboration traffic within a defined purpose/trust group | Dedicated interfaces and paths for each required physical separation; independent receiving policy |
| Sovereign Trust Networks (STNs) | High-consequence identity, policy, key, and recovery operations | Separately rooted equipment, control, and paths; no general application traffic |
| Observation fabrics | Bounded audit/health reporting | Explicit one-way or guarded export interfaces; classified logs remain protected |
| Dynamic Trust Gateways (DTGs) | Specific cross-purpose transactions | Terminate both sides and create a separately authorized effect; no transparent bridge |

ATN and STN are roles instantiated per realm or federation, not one worldwide “trusted network.” Membership establishes neither a peer's honesty nor permission for an operation. Every fabric, including an STN, can contain compromised endpoints and controllers. Each endpoint checks each operation against its own authority. The encounter boundary is a new explicit role for unavoidable public entry; its compromise must not reconfigure an ATN or STN.

## Physical topology contract

Each deployment records paths as a graph of actual interfaces, guards, switches, links, and management dependencies. For every pair of purposes requiring separation, identify disjoint physical facilities and every authorized gateway edge. The target excludes shared mutable switch tables as the sole separation mechanism.

Dedicated fibers or electrical paths can share a building while retaining a declared common physical risk. VLANs, tunnels, wavelengths on a common fiber, and different queues in one switch do not establish disjoint facilities. If a deployment shares them, it must report the weaker profile and its impact on R04/R11.

An island's network engine is bound to its purpose-specific endpoints. Workload code cannot select another physical network by supplying a different destination field. Host raw queues, management transmit paths, debug, reset fallback, and alternate device functions are included in the egress inventory.

Dynamic provisioning may allocate a previously unused path or safely reassign a resource after revocation, drain, sanitation, and fresh authority installation. It cannot temporarily join unrelated purpose fabrics through an unrestricted control-plane command. Circuit configuration is itself a governed effect with independently checked endpoints and purpose.

## Admission and routing

Route services discover candidate paths inside the allowed topology. Protected gates admit only paths/resources approved by their owners and accepted by the endpoints. A route proposal grants no permission. Session consent does not give a sender arbitrary forwarding rights, and a forwarding grant does not establish permission to disclose its payload.

The architecture permits packet-carried authorization, installed per-channel state, or admitted circuits. Selection depends on replay, reservation, key distribution, failure, and physical enforcement properties. No custom hop header is fixed here before comparison with existing protocols.

| Candidate | Potential fit | Missing ASKA obligation |
|---|---|---|
| Admitted circuits | Stable private channels and explicit physical routing | Provisioning authority, safe reconfiguration, utilization, and fault isolation |
| Packet-carried path grants | Dynamic multiplexing within one purpose fabric | Grant-to-port/payload binding, expiry, replay exposure, and mandatory gate placement |
| Installed channel tables | Narrow local/industrial fabrics | Protected state scale, update ordering, and recovery consistency |
| SCION-family routing | Explicit trust/path concepts for inter-realm communication | Physical purpose separation and compromised local controller containment |

[SCION](https://docs.scion.org/en/v0.13.0/overview.html) is a path/trust architecture comparison. [EPIC](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) adds data-plane authorization/authentication/validation alternatives; [COLIBRI](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf) addresses bandwidth reservation. Their logical paths and assumptions must not be reported as proof of private cable geography.

## Gateway transaction

A DTG consists of separately confined ingress parsing, a small effect/release checker, and an egress constructor. High-consequence crossings use independently controlled enforcement on both sides. Sharing one signing key, firmware installer, or reset controller would defeat the claimed independence and must be reported.

The gateway receives an admitted typed request, binds immutable inputs and their restrictions, validates the permitted transformation, resolves the destination's independent acceptance, and prepares a new target-side operation. Each local boundary commits under its own current policy. Those commits are separate: no gateway assumes a simultaneous policy snapshot across partitioned realms. The target receives an assertion scoped to the specific gateway service. The original sender's unrestricted authority does not cross with it.

Allow only explicit operations such as importing a bounded document object or returning an approved policy decision. A gateway does not expose arbitrary STN RPC, raw packet forwarding, or broad memory sharing. Decrypting and scanning a payload is not a general proof that it is harmless. Narrow schemas, release semantics, budgets, and recipient checks remain necessary.

Gateway failure before commit publishes nothing on the target side. Failure after target-side commit may leave an uncertain response; operation identifiers and receipts support reconciliation. Separate local policy withdrawal cannot recall data already crossed. Multi-party commit must state partition and crash behavior rather than assuming an atomic inter-network action.

## Adversarial interconnections

A DTG is a transfer pipeline with source-side disclosure enforcement and independently owned destination enforcement. A single gateway instance must not hold both domains' unrestricted policy authority or bypass their guards. Parsing, transformation, release proposal, release control, and carriage have distinct contracts and failure scopes. The detailed transaction is in [0318](0318_cross_domain_security_and_information_release.md).

A newly attached cable, dual-connected endpoint, or rogue switch changes reachability only. Its traffic still needs a valid source effect, permitted release, path contract, and receiver consent. The added connection can create load and new observations; it must not create permissions. Report a physical tap behind a guard and an authorized unrestricted export as distinct failure modes; each must be identified explicitly.

Analyze paired directions together. Reusing a compromised import transformer for unrestricted responses can expose response plaintext and create command-and-control even if every outer session authenticates. Separate the workers and their state, then mediate any necessary correlation through bounded typed identifiers. No raw return path is implied by a request.

## One-way paths

Data diodes are appropriate where the required operation truly has one direction. The lack of a return channel affects acknowledgment, key renewal, failure reporting, and capacity control. Returning a status on another path creates a new information-flow edge that must be authorized separately. A high-to-low diode can still carry an unauthorized disclosure in its permitted direction; a low-to-high diode can still deliver malicious imports. [NIST's data-diode definition](https://csrc.nist.gov/glossary/term/data_diode) identifies the one-way boundary concept; ASKA still needs an apparatus-specific path and signaling analysis.

## Availability and intermediates

Admission must act upstream of a protected bottleneck to preserve its capacity. Finite queues cannot accommodate sustained excess load. Reserve control/recovery service and police admitted senders, including valid replays. Exact per-sender allowances require accounting; “stateless transit” cannot remember every use of a copyable token.

An IP overlay can test endpoint authority and ciphertext integrity through hostile transit. It is an interoperability/testing realization and establishes no native physical-purpose separation. A legacy gateway occupies an encounter domain and receives no native administrative authority. The native system must remain operable with that gateway disconnected.

**Open research:** scalable purpose-specific infrastructure, circuit/grant tradeoffs, independently enforceable gateway composition, physical inventory assurance, and affordable bandwidth isolation under admitted abuse. Successful validation requires both forbidden-crossing tests and useful inter-domain applications.
