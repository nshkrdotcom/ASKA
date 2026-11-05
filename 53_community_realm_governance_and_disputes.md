# ASKA v6 — Community, realm governance and disputes

**Status:** proposed architectural requirements. Acceptance oracles specify evidence to obtain; no ASKA implementation or validation result is asserted.

A community deployment joins independently governed participants without creating a universal authority over their private realms. It may provide shared compute, connectivity, public information, mutual assistance, local services, dispute procedures and collective infrastructure. Membership defines a relationship with specified rights and duties. It does not make every member's data public or give a community administrator authority to operate all connected machines.

A realm has a bounded namespace, resource owners, policy roots, accepted profiles and interfaces to other realms. Different realms can cooperate through negotiated contracts while retaining different admission decisions. Federation requires interoperable evidence and consequences, not agreement on every institutional judgment. A community may decline a service contract without being entitled to inspect the prospective participant's unrelated private data.

## 53.1 Community constitution and resource authority

A community profile specifies membership and representation, resource ownership, admission, charging or contribution rules, service commitments, amendment procedures, dispute routes, privacy, emergency powers, oversight and exit. Each clause must identify the institution or resource owner that can enforce it. A community vote about shared infrastructure does not automatically amend a person's private source policy or transfer custody of their keys.

**R-53-01 — Bounded community governance.** Community decisions MUST operate within explicitly admitted shared resources, relationships and amendment procedures. Membership, a majority vote or an administrator role MUST NOT create universal control of independent realms or override unrelated source owners.

Shared resources need concrete scheduling and accounting. Compute access can be allocated by quotas, reservations, priority classes or admitted contribution policies. A scheduler may know enough to enforce resource bounds without reading workloads. A service's financial or operational rules must not be confused with a universal reputation measure of its users. Scarcity decisions should identify their basis, qualified owner and review route where required.

A participant's decision to leave may terminate future service access while preserving obligations already incurred. Outstanding charges, shared-object ownership, retained public commitments and unresolved disputes require an explicit exit treatment. The system must not promise instantaneous deletion of records held by independent parties or retain unlimited access as a condition of portability.

## 53.2 Federation and interoperability

Federated admission identifies each participating realm, accepted issuer classes, applicable profiles, source and destination policies, grant owners, permitted effects, budgets, status freshness and dispute handling. An interrealm gateway translates agreed formats and routes admitted exchanges. It does not become the owner of every endpoint or infer authority from network reachability.

**R-53-02 — Independent federation admission.** Each realm MUST independently admit its applicable source release, destination acceptance and resource effects. A federation agreement MUST NOT turn one realm's positive authorization, trust score or credential issuer into permission at every other realm.

A destination can accept a narrow qualification proof without importing the source institution's complete policy. If profile meanings are incompatible, the parties can negotiate a restricted intersection, use a qualified translation or decline the exchange. Silent weakening is not acceptable. A gateway that cannot enforce retention, revocation freshness or output restrictions must expose that limitation before the effect is admitted.

Availability also has independent boundaries. A regional outage need not stop local private computation if the local profile permits continued operation. However, an effect requiring fresh remote status may have to pause. Offline authority must be limited by a declared lease, budget and reconciliation rule. A community's desire for continuity cannot make revoked authority permanently valid.

## 53.3 Disputes and qualified review

Disputes can concern facts, identity bindings, contract interpretation, governance procedure, service quality or resource accounting. The record should identify the disputed predicates, parties, requested remedy, evidence scope, reviewer qualification, deadlines, stays and appeal path. Reviewers need only the evidence appropriate to their role. Public interest in a dispute does not automatically authorize disclosure of every participant's personal records.

**R-53-03 — Scoped dispute procedure.** A dispute process MUST specify qualified reviewers, evidence access, contest and stay semantics, decision scope and correction or appeal routes. An unresolved predicate MUST not be replaced by an AI confidence score or an undocumented administrator override.

Independence is a factual architecture claim. Reviewers may share legal control, funding, identity infrastructure, software, hosting or physical facilities. Those dependencies matter when the profile claims resistance to collusion or common-cause failure. A threshold of signatures is useful only under the stated threshold and corruption model; it does not prove institutional independence by itself.

**R-53-04 — Explicit review independence.** Quorum and independent-review claims MUST identify control roots, shared dependencies, tolerated corruption and recovery rules. Multiple agents, accounts or keys under a disallowed common controller MUST NOT satisfy an independence requirement.

Review outcomes become attributable decisions with bounded effects. A reviewer may direct correction of a shared accounting record without receiving general authority to rewrite private histories. Compensation requires a new admitted effect. A corrected decision should link to the earlier record and explain the scope of correction; it should not silently erase evidence that an erroneous decision occurred.

## 53.4 Public participation and AI-supported policy work

Communities can use AI to summarize proposals, translate materials, identify conflicting clauses, simulate resource allocations and organize feedback. These functions can improve participation if their sources, assumptions and limitations are visible. A summary should preserve material disagreement and uncertainty rather than present a synthetic consensus that no participant approved.

**R-53-05 — Advisory public models.** AI-supported consultation and policy simulation MUST remain distinguishable from binding governance decisions. Model-generated interpretations, eligibility judgments or conflict resolutions MUST enter the qualified adoption or review procedure before changing authority.

Participation analytics require their own privacy policy. Counts and trends may be released while individual submissions remain protected. Repeated queries, small communities and distinctive writing can make apparent aggregation identifying. A platform must not infer a member's private beliefs or relationships simply to improve its policy model. A member's explicit public statement is different from a model's speculative attribution.

Federated analytics or learning may distribute computation among realms. Keeping raw inputs local does not itself prevent leakage through updates, models, outputs or participation timing. Any multiparty or differential-privacy mechanism must identify its adversary, privacy unit, composition limits and failure behavior. A community service cannot claim collective privacy merely because it avoids one central database.

## 53.5 Amendments, emergencies and exit

A profile amendment names the proposed change, qualified initiators, voting or approval procedure, affected contracts, activation time, compatibility treatment and review route. Existing grants must either remain valid under their pinned terms, narrow, expire or undergo renewed admission as specified. A routine software update cannot silently change the community constitution. Conversely, an authorized governance change still needs a technically safe deployment procedure.

**R-53-06 — Governed amendment and exit.** Community amendments MUST follow the admitted procedure and explicitly address active grants, retained evidence, portability and continuing obligations. Exit MUST retire future membership authority without silently transferring private keys or eliminating independently applicable duties.

Emergency authority is limited to admitted shared resources and protective templates. An infrastructure incident may justify RATE_LIMIT or ENTER_SAFE_STATE for a community service, but does not grant a council access to all private content. Duration, renewal, affected interests, notice and after-action review remain explicit. A repeated emergency declaration must not become a permanent route around ordinary amendments.

**R-53-07 — Bounded collective emergency response.** Community emergency powers MUST name targets, triggers, operations, duration, renewal ceilings, responsible owners and review duties. They MUST NOT confer general private-realm access or silently persist after their admitted conditions end.

## 53.6 Operational example and acceptance

A community operates shared research compute and a local notice service. Members receive quotas under a published profile. Private workloads run under their own source restrictions, while the scheduler sees only the information required for allocation. Two laboratories negotiate an aggregate analysis; each independently admits its input and the resulting output policy. A dispute about accounting is reviewed by qualified people with access to the relevant receipts, not all workload contents. An AI simulates alternative quota policies and summarizes member feedback, but a change becomes binding only through the admitted amendment procedure.

During an upstream outage, the community continues admitted local work. Remote-dependent effects pause or use bounded offline leases according to their contracts. If an administrator leaves, their future grants are revoked and unresolved tasks are assigned to qualified successors. A departing member exports their admitted objects through an explicit portability workflow; protected coauthored data and public commitments follow their existing ownership and retention rules.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-53-01 | Approve a community motion concerning shared compute; private-realm keys and unrelated data remain outside its enforceable scope. |
| T-53-02 | Present one realm's valid grant at another realm lacking admission; no local effect occurs. |
| T-53-03 | Contest a billing predicate with no declared precedence rule; the dispute follows its stay and review procedure rather than an administrator shortcut. |
| T-53-04 | Place nominally independent reviewers under a common prohibited root; the quorum's claimed independence fails qualification. |
| T-53-05 | Change an AI policy recommendation; installed community authority remains unchanged until qualified adoption. |
| T-53-06 | Amend membership rules or process exit while contracts remain active; each grant and continuing obligation receives the declared treatment. |
| T-53-07 | Renew an emergency beyond its ceiling; further exercise is blocked or requires a new qualified basis, and private data remains protected. |

Community governance is therefore a composition of explicit authority and evidence boundaries. Its legitimacy and resilience depend on the actual institutions, control roots and remedies described in the profile; architectural terminology alone cannot supply them.
