# ASKA v6 — Physical transit topology and routing

## The topology is a qualified graph

A transport topology contains endpoints, guards, switches or routers, carrier segments and shared dependencies. Its security graph is richer than a list of IP addresses. The manifest records which component can inject, observe, modify, delay or terminate traffic; which manager can reconfigure it; and which physical failure can remove several apparently separate paths. Routing operates within that graph and the admitted authority contract.

RP-A provides separate selected purpose interfaces and a Steles interface at the installation boundary. RP-B provides local/community and region/upstream carriage on each purpose appliance and separate witness carriage: ten duplex purpose/witness interfaces as a subtotal, and eleven duplex interfaces in total after adding the dedicated local `J-E`. RP-A similarly has five purpose/witness interfaces and six duplex interfaces including `J-E`. Both retain sixteen simplex security links, as specified in [the reference machine](04_reference_machine_and_reachability.md). Local taps, maintenance, proposal and health interfaces remain separately enumerated. Those counts describe the reference installations, not every conforming deployment.

**R-42-01 — Complete transit manifest.** A deployment MUST identify endpoints, physical or logical segments, management roots and relevant common-failure dependencies for every admitted transit path. Interface counts MUST state their installation boundary and exclusions, and a logical route MUST NOT be presented as a complete physical cable map without evidence.

The graph distinguishes local IES communication, local/community carriage, inter-realm transit and security-mesh paths. A local DMNoC record does not become an Internet packet by changing a route field; the crossing terminates and admits the next protocol context at a qualified boundary.

The topology register also includes the local `J-E` encounter attachment selected by [the reference profiles](04_reference_machine_and_reachability.md). It terminates in the dedicated Wilder-governed encounter resources, not an established-session front-end FIFO. A route-discovery or authentication packet entering there can propose only the bounded metadata transfer admitted by the local installer; it cannot create a transit shortcut into a purpose fabric.

## Path-aware mechanisms and their scope

[SCION’s header specification](https://docs.scion.org/en/latest/protocols/scion-header.html) provides explicit forwarding-path fields, including ingress/egress information and hop authenticators. Such mechanisms are candidates for path-oriented transport policy. They do not prove the geographical route of a fiber or exclude every hidden tunnel and copied packet inside a participating network.

[ICING](https://www.cs.utexas.edu/icing/papers/icing-conext11.pdf) studies path consent and compliance under its participating-node assumptions. Its discussion explicitly limits what can be inferred about hidden forwarding behavior. [EPIC](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) develops packet-level authentication and path-validation mechanisms with key, time and replay assumptions. ASKA must state which mechanism and which property a chosen transport profile actually uses rather than treating all path-aware systems as equivalent.

**R-42-02 — Scoped path evidence.** A path-validation claim MUST identify its protocol, participating nodes, protected fields, key and time assumptions, and the property established. It MUST distinguish authorized logical traversal from physical geography, absence of copying and semantic release permission.

[FABRID’s attestation-based routing proposal](https://www.usenix.org/system/files/sec23fall-prepub-135-krahenbuhl.pdf) is a relevant comparison for policy based on router properties. The reviewed prepublication architecture supports that comparison; it is not evidence that an attested router remains uncompromised forever or that an ASKA route has been qualified. A route policy depending on device evidence must define appraisal freshness, failure behavior and how a change in that evidence affects already admitted traffic.

## Source, transit and destination authority

A source release contract names exact output or transform, recipient, permitted transit constraints and budget. A transit reservation authorizes use of particular network resources. A destination acceptance contract authorizes protected publication at the receiver. These decisions can be independently issued and revoked. A transit node cannot turn a bandwidth grant into permission to decrypt or modify the source object.

Where a native protected-transit profile is selected, its gate binds incoming traffic to an authenticated session, permitted ingress, exact output port or next hop, record digest and current route epoch. It verifies the full bounded record before crossing the specified first-byte egress boundary when that is the claimed finality. An implementation that forwards unverified initial bytes has a weaker contract and cannot claim this property.

**R-42-03 — Independent transit authorization.** Transit admission MUST preserve source release and destination acceptance as independent obligations. A gate promising verified-before-emission behavior MUST validate the complete bounded record and actual egress binding before its first externally visible byte.

Capability-Enhanced Packet-Carried Forwarding State (CE-PCFS) remains a candidate representation for bounded per-hop authority, including internal inter-component paths. It would have to bind capabilities to actual ingress/egress, record or object context, epochs, permitted operations and finite use. Aggregating capability evidence or spreading a flow over several paths cannot union incompatible grants, bypass a restriction or turn a resource reservation into disclosure authority. A compact header is useful only if its encoding and validation preserve those distinctions; no native CE-PCFS format is selected here.

A candidate encoding can use a bounded prefix plus a bounded number of hop records. The actual widths, hop limit, digest binding, domain separation and algorithm suite must be selected and reviewed in a protocol manifest. Illustrative byte layouts are not automatically wire standards. The scope hash must cover the ordered policy-relevant path representation so reordering or splicing cannot preserve an inappropriate authorization.

## Reservation and availability

Bandwidth reservation can make a service commitment conditional on admitted load and network assumptions. [SIBRA’s design](https://www.ndss-symposium.org/wp-content/uploads/2017/09/sibra-scalable-internet-bandwidth-reservation-architecture.pdf) uses hierarchical inter-domain reservations and explicitly assumes source-controllable paths and non-hijackable flow identity. Its adversary and deployment assumptions are essential to the claim; it does not establish unlimited availability against every physical outage or compromised carrier.

An ASKA reservation specifies the resource, owner, interval, rate or byte ceiling, burst behavior, queue limit, renewal and revocation rules. It also states whether a replayed packet consumes reservation capacity, how authenticated duplicates are accounted and which resources are reserved for admission itself. Authentication work, memory traffic and per-session state can become bottlenecks even when link bandwidth remains available.

**R-42-04 — Bounded reservation semantics.** Transit reservations MUST define capacity, burst, lifetime, identity, replay accounting and reclaim rules. Availability claims MUST include admission, cryptographic, buffering and physical dependencies, and MUST not imply rights to foreign data or immunity to excluded failures.

Connection attempts from unauthenticated or not-yet-admitted peers have a bounded encounter budget. Their resource pool must not consume the entire protected service needed by established sessions under a claimed reservation. Admission control should reject excess work before expensive processing when the protocol safely permits it. A syntactically valid packet is not entitled to unlimited cryptographic retries.

## Multipath, failover and route changes

Multipath can improve service when its paths fail differently. The analysis identifies common trenches, power feeds, buildings, routers, firmware, credentials and operators. Two routes through different logical nodes may still share one physical cut. A topology claim should state the failure sets it tolerates and the environmental conditions under which alternatives remain usable.

Failover selects only paths allowed by the current release and transit contracts. A path prohibited for confidentiality, jurisdiction, recipient or evidence reasons does not become permissible during congestion. If no qualifying path remains, the owner records unavailability or an unresolved delivery state. It does not silently downgrade the route policy.

**R-42-05 — Authority-preserving failover.** Route changes and multipath scheduling MUST preserve admitted transit constraints and protected endpoint binding. They MUST retire stale topology state and MUST stop when only unauthorized alternatives remain.

A link flap may preserve a session only when key, replay, grant and endpoint continuity are established. Otherwise the peers install fresh epochs and keys, fence old traffic and reconcile outstanding effects. Restoring the old route table from a snapshot must not revive expired leases or reset already consumed reservation budgets. The path manager cannot declare remote delivery merely because an alternate route is available.

## Evidence and operational example

A transit receipt identifies the gate, ingress and egress binding, route/session epoch, record commitment, grant, resource debit and local emission outcome. The receipt is evidence of that gate’s named action. Destination publication and application completion require separate evidence. A trusted exporter may expose selected traffic metadata to an observer, but the observation contract must declare payload visibility, sampling and loss.

Suppose a community appliance sends a protected institutional record through two admitted carriers. One route is lost when shared civil works fail. The path manager selects the remaining qualifying route if its reservation and evidence are current. A malicious relay replaying a valid packet may consume only the resources allowed by the specified replay policy and cannot cause duplicate protected publication at the receiver. If both routes fail, the sender retains a pending or uncertain delivery outcome while preserving any established local emission receipts.

**R-42-06 — Scoped transit receipts.** Transit evidence MUST identify the exact local event and its dependencies. It MUST NOT be substituted for destination publication, application acceptance, real-world completion or proof of a hidden physical route.

Acceptance specifications are:

- **T-42-01:** Compare the topology and interface count with physical and management inspection. An omitted sideband or common dependency defeats the corresponding completeness or independence claim.
- **T-42-02:** Construct a permitted logical path containing an undisclosed internal tunnel. The assurance report must not claim physical geography from path authentication alone.
- **T-42-03:** Alter a hop order, egress port or record after authorization. A verified-before-emission gate must emit no unauthorized first byte.
- **T-42-04:** Exhaust encounter traffic and replay admitted traffic at maximum rate. Established service and debit behavior must match the declared reservation assumptions without granting new object rights.
- **T-42-05:** Fail all authorized routes while leaving a prohibited carrier reachable, then restore a stale route snapshot. Neither circumstance may bypass current route or lease constraints.
- **T-42-06:** Lose a packet after one gate emits it. That gate’s receipt may establish local emission, but the workflow must retain the absence of destination-publication evidence.
