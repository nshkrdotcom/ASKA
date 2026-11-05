# ASKA v6 — DMNoC and internal communications

## Routing fabric and consequence boundaries

The decentralized mesh network-on-chip (DMNoC) is an architectural role for explicit communication among local compute and service domains. A realization may use an on-chip mesh, a guarded switch fabric, chiplet links or board-level interconnects. “Decentralized” does not mean that every endpoint controls every route, and “network-on-chip” does not turn an inter-realm carrier network into a local hardware fabric. External transport has its own contracts in [physical transit](42_physical_transit_topology_and_routing.md).

The DMNoC transports bounded records or object fragments between named endpoints. BG, MG, DG and EG/RG functions authorize consequences at their respective boundaries. A switch may reject invalid paths or excess traffic, but successful routing is not evidence that the source may disclose an object or that the destination accepts it. Route availability, payload integrity and semantic authorization are separate claims.

**R-14-01 — Guarded endpoint reachability.** Every DMNoC path crossing an ownership boundary MUST terminate at an identified enforcing endpoint. Routing state MUST NOT grant memory, device, storage or output authority, and a routing bypass MUST NOT bypass the consequence guard.

The reference topology may place several guards in one boundary module. Their roles remain explicit even when they share implementation and failure roots. The protection argument must identify that shared cut set. Treating a logical BG and MG as mutually independent when the same writable controller state governs both would overstate the architecture.

## Endpoint and route contracts

A local endpoint record contains physical attachment, endpoint identity, owning guard, current endpoint epoch, permitted protocol classes, bounded queue capacity and route-policy constraints. A route description identifies allowed ingress and egress attachments, intermediate resources where relevant, failure alternatives and whether any shared component can inspect or alter traffic. Route identifiers are scoped to the current topology epoch; they are not reusable raw port numbers with indefinite authority.

At injection, the source guard validates the object or record binding and checks the installed communication grant. At reception, the destination guard checks its own acceptance policy, current capacity and object-generation constraints. Intermediates validate whatever protected route and reservation state their profile promises. No step assumes that another step’s successful check implies all remaining checks.

**R-14-02 — Protected endpoint identity.** DMNoC injection and reception MUST bind traffic to protected endpoint identities and current topology or session epochs. Reconfiguration MUST prevent a newly attached endpoint from inheriting the prior occupant’s queues, reservations or authority.

[M3’s DTU design](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) offers a concrete example of hardware-mediated messages, endpoint credits and a separate management kernel for heterogeneous processing elements. Its mechanisms motivate a narrow communication boundary. ASKA still requires evidence for its selected mapping, cache, reset and interconnect integration; the paper’s prototype does not qualify those different physical paths.

## Hierarchical fabric candidate

An optional DMNoC organization groups endpoints into IES-local or zone-local sub-meshes connected through guarded inter-sub-mesh gateways. The hierarchy makes locality and admission boundaries explicit; a zone does not acquire ambient access to its members' writable memory. A physical-separation claim identifies the actual distinct links, buffers, controllers and management roots. A logical subdivision with shared resources is recorded at that weaker scope. Each gateway retains source-release and receiving-owner checks, and its route role supplies no foreign installation or object authority.

Reservations cover both local queues and inter-sub-mesh bottlenecks. Dynamic zone membership or topology changes require independent local admission, bounded transition resources, retirement of stale endpoint epochs and closure of outstanding ownership obligations. A hierarchy coordinator cannot manufacture membership rights or reuse another domain's credits. Security configuration, exporter and watcher interfaces remain separately inventoried from this application-fabric hierarchy. Evaluation must measure contention, transition loss, failure recovery and shared dependencies; the additional hierarchy does not itself establish a scale, latency, attestation or availability guarantee.

## Internal channels and the security mesh

Virtual channels can isolate buffering and reduce interference under a qualified implementation. They are not physical separation. Physical channels require an inventory of distinct conductors or optical paths, transceivers, buffers and management dependencies appropriate to the claim. A channel called “trusted” does not authorize its content. Control and diagnostic traffic are parsed and admitted according to their own schemas.

The security observation and configuration paths are not an unrestricted backplane into the compute fabric. Trusted exporters emit declared events; LSM and MSM roles observe or correlate those events; installed protective grants allow narrowly defined responses. A configuration diode permits traffic in its specified direction. A separate report path is a separate interface with its own release policy; it does not make the diode bidirectional or convert an LSM report into installation authority.

**R-14-03 — Explicit channel separation.** Every claim of physical or logical channel separation MUST identify its actual shared and separate resources. Security-mesh links MUST retain their declared direction and authority constraints, including separate reporting and local update admission.

The local fabric can carry application collaboration, distributed storage fragments, inference tasks, software candidates and threat reports. These uses do not create a universal channel exemption. Threat intelligence can contain sensitive payloads, an update can carry executable authority requests, and a storage fragment can reveal ownership metadata. Each receives an explicit label and destination contract.

## Flow control, reservations and denial

Backpressure protects finite buffers but can propagate a denial of service. The fabric design identifies queue ownership, allocation limits, credit accounting, timeout policy and which control messages are necessary to release blocked resources. A compromised endpoint must not mint credits or retain an unbounded number of fabric buffers. Credit return describes local capacity; it does not prove remote application consumption or persistent commitment.

A reservation is end-to-end only if all required resources are covered. The design includes injection bandwidth, switches, receive buffers, cryptographic engines and the destination owner’s processing budget. If the receiver can block indefinitely, a transmitter’s reserved lane alone does not provide a delivery deadline. Failure behavior must distinguish rejected admission, admitted-but-not-delivered work and an effect whose outcome is uncertain.

**R-14-04 — Bounded fabric resources.** Fabric queues, credits, reservations and control work MUST be bounded per admitted principal or grant. A stated latency or availability guarantee MUST include every bottleneck it depends on and specify behavior when a dependency fails.

Deadlock analysis includes both data traffic and lifecycle controls. A revocation acknowledgement must not depend on a data queue that can be permanently filled by the revoked endpoint. Separate bounded control resources, escape paths or a proved acyclic dependency scheme may satisfy this obligation. Reserved control capacity must itself be protected from arbitrary “urgent” markings by an attacker. A local controller also must not hold a global ownership lock while waiting for an unbounded external response.

## Reconfiguration and failures

Adaptive routing can respond to congestion, faults or admitted risk evidence. The alternative path must satisfy the same confidentiality, destination and physical-route restrictions. If a surviving path crosses a disallowed carrier, shared controller or inspection point, it is not an authorized fallback. Availability loss is recorded rather than hidden by weakening the contract.

Topology changes use preparation, local installation and a defined transition boundary. Old route state remains valid only for the bounded outstanding traffic explicitly covered by the transition, or it is fenced. Inconsistent routing-table versions cannot reinterpret a record’s source identity or merge queues across owners. A link flap retains session state only if the implementation can establish continuity; otherwise it requires fresh binding and retirement of the prior state.

**R-14-05 — Safe adaptive routing.** Route changes MUST preserve admitted authority and physical constraints, bind traffic to a coherent topology transition and retire stale endpoint state. If no qualifying path remains, the fabric MUST fail according to the declared availability policy rather than choose an unauthorized path.

Fault handling includes corrupted records, partial frames, misrouting, duplicate delivery, lost credits, failed links and compromised switches. End-to-end payload protection may detect modification but does not prevent traffic analysis or all denial. Redundant routes sharing the same power regulator or switch firmware remain a common-cause risk. The graph must name those dependencies before claiming resilience.

## Dataflow and remote-address-space candidates

A spatial or dataflow implementation can make placement and channels explicit at compilation or admission. It still needs protected token identity, queue bounds, cancellation and stale-state closure. Tokens cannot carry authority to an object generation that has been revoked. An engine that autonomously emits outputs must place an EG-equivalent check at the actual output boundary, not only at initial graph loading.

A remote-address-space acceleration candidate is acceptable only through authorized object operations, immutable loans or acknowledged exclusive transfer. It must not introduce ambient cross-IES writable load/store reachability. An optimization can remove an unnecessary copy after proving equivalent ownership and revocation behavior; it cannot remove the ownership contract itself.

**R-14-06 — Equivalent communication optimizations.** Any fabric, dataflow or remote-access optimization MUST preserve object identity, labels, generation checks, lifecycle closure and effect-final authorization. Its equivalence argument MUST include cancellation, congestion and reconfiguration, not only successful steady-state transfers.

For example, a local AI worker sends a candidate model update to an independent checker. The fabric reserves bounded buffers and may reroute around a failed switch. The checker receives only the authorized immutable update object. Its approval is a new evidence object; it does not let the fabric install the model into another domain. If the checker stops receiving, the sender’s credits eventually exhaust and admission stops without converting buffer pressure into a broad write capability.

Acceptance specifications are:

- **T-14-01:** Install a route directly toward protected memory or egress while omitting the endpoint grant. The record may reach a guard, but no protected consequence may occur.
- **T-14-02:** Replace an endpoint during queued traffic. Old identifiers and credits must not authorize the new occupant or deliver prior-owner plaintext to it.
- **T-14-03:** Inspect the claimed separate channels and attempt reverse traffic on a configuration diode. Shared dependencies must match the manifest and forbidden direction must remain unavailable.
- **T-14-04:** Fill every attacker-controlled data queue while triggering revocation. The bounded control path must still reach its declared completion or fail-closed outcome without a dependency deadlock.
- **T-14-05:** Remove all authorized paths while leaving an unauthorized path live. Traffic must stop with a scoped failure record rather than silently use the forbidden route.
- **T-14-06:** Compare a copy-based transfer with an optimized path under cancellation and epoch changes. Both must preserve the same ownership and finality outcomes; a stale token causing a new effect is a failing counterexample.
