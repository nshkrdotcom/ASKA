# 05 — Costs, limits, and unresolved questions

[Start](README.md) · [Previous](04_network_transport_and_realms.md) · [Next: research plan](06_research_plan_and_evidence.md)

ASKA must improve security against the stated attacker while keeping useful computation affordable. Evaluate security, utility, performance and implementation cost together.

ASKA has no measurements yet. The calculations below use hypothetical inputs to identify costs worth measuring; they cannot predict chip performance.

Mechanism-specific measurements and tradeoffs already exist in [M³](07_prior_art_and_sources.md#a01), [M³ real-time regulation](07_prior_art_and_sources.md#a06), [FractOS](07_prior_art_and_sources.md#a08), [Elasticlave](07_prior_art_and_sources.md#b05), [CapChecker](07_prior_art_and_sources.md#a15), [ICING](07_prior_art_and_sources.md#d01). Recent host/GPU crossing measurements are [Serialized Bridge preprint](07_prior_art_and_sources.md#e10), [Blackwell benchmark preprint](07_prior_art_and_sources.md#e11) (preprints, configuration-dependent). Use these results to plan experiments under matching conditions. Their reported numbers cannot serve as ASKA estimates.

## The most consequential unresolved questions

These are ASKA research questions. The mechanism-specific baselines are cited in the sections below and organized in the [discussion coverage map](07_prior_art_and_sources.md#discussion-coverage).

| Question | Why it matters | Evidence that would change the design |
|---|---|---|
| Can classification remain sound across CPU, memory, DMA, and accelerators? | An egress gate cannot repair a false classification | A refinement argument and adversarial traces covering every producer and writer |
| Can coarse cells support useful workloads? | Conservative labels may block most desired communication | Application traces showing required releases and retained utility |
| Can an atomic handoff be made inexpensive? | Freezing, copying, and authentication may dominate small operations | Measured handoff latency and throughput against ownership-transfer alternatives |
| Can sharing preserve the required observation boundary? | Memory isolation does not imply timing isolation | A resource-specific interference model and supported measurements/proofs |
| Can independent policy remain operable? | Key rotation, mappings, and disputes can overwhelm operators | Failure and recovery exercises with separate administrators |
| Does the full architecture beat a simpler baseline? | Custom silicon and a new software ecosystem are major costs | A matched comparison under the same threat model and workload |

## Metadata has a storage and access cost

If each `g` bytes of data carries `b` bits of fixed metadata, the raw storage ratio is:

```text
metadata / data = b / (8 × g)
```

For example, 32 metadata bits per 64 data bytes add 6.25% raw storage before alignment, error correction, caches, coherence traffic, or policy tables. ASKA has not selected this hypothetical tag layout.

A compact index can move label representation into a table. It does not eliminate the information or its management. The design must pay for lookup bandwidth, capacity, reclamation, cache behavior, and identifiers that remain valid while references exist. If the namespace fills, the system needs a defined denial or reclamation rule. Silent aliasing of two distinct policies would be a correctness failure.

A label-cache miss can also reveal information through latency. Whether that is an exploitable channel depends on what determines the lookup and what an adversary can observe. Fixed schedules, partitioning, or other mitigations may reduce exposure while increasing cost. The timing model must include lookup behavior and the costs of mitigation.

Metadata design comparisons include [PUMP](07_prior_art_and_sources.md#c02), [SAFE](07_prior_art_and_sources.md#c01), [HyperFlow](07_prior_art_and_sources.md#c03), [TensorTEE](07_prior_art_and_sources.md#b10), [CapChecker](07_prior_art_and_sources.md#a15). The `b/(8g)` expression and 32-bit/64-byte example use hypothetical ASKA parameters, independently of those systems’ layouts.

## Memory scheduling has workload-dependent losses

Suppose a protected schedule gives domain `i` a service interval `q_i` during a repeating period `T`. Even under ideal device behavior, its average service is bounded by roughly:

```text
B_i <= B_ideal × q_i / T
```

where `T` includes any reserved guard or idle periods. Real DRAM adds bank conflicts, refresh, turnaround, row behavior, and controller constraints.

If four domains each receive one quarter of an unborrowable schedule and only one is busy, that domain can use at most one quarter of the ideal aggregate service. If all four are busy, the aggregate loss can be much smaller. A work-conserving scheduler may reclaim idle service, but the resulting service times can reveal other domains' activity. This is a tradeoff to analyze for a particular threat model.

The available evidence supports no universal 40–60% DRAM-throughput penalty, or a claim that the penalty disappears. Measure the workload mix, latency tails and sustained bandwidth, and state the security assumptions and resources shared.

Traffic regulation and interference comparisons include [M³ real-time regulation](07_prior_art_and_sources.md#a06), [HyperFlow](07_prior_art_and_sources.md#c03), [SIBRA](07_prior_art_and_sources.md#d08). The schedule bound and four-domain example follow from the assumed unborrowable schedule. They are calculations, not measurements of the cited systems.

Time-protection research demonstrates why spatial memory isolation and temporal isolation need separate treatment. It does not supply a universal remedy for every shared resource in an ASKA package. [Ge et al., *Time Protection: The Missing OS Abstraction*](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract).

[Wang et al. and Shafiee et al.](07_prior_art_and_sources.md#memtime) supply concrete static-slot and fixed-service memory-controller precedents. Their measured costs belong to their configurations. The duty-cycle expression above is a calculation under the stated schedule assumptions.

## The illustrative record has visible overhead

The [experimental record](04_network_transport_and_realms.md) adds a 64-byte header and 16-byte tag. For application payload `P`, its record-level payload fraction is `P / (P + 80)`.

| Application payload | Record bytes | Payload fraction | With an additional 48-byte IPv6/UDP header |
|---:|---:|---:|---:|
| 64 bytes | 144 bytes | 44.4% | 33.3% |
| 256 bytes | 336 bytes | 76.2% | 66.7% |
| 1024 bytes | 1104 bytes | 92.8% | 88.9% |

These figures give the cost of the experimental encoding. The same security requirements may fit a smaller format. Removing the 12 bytes of repeated session state and four bytes of constant format fields would reduce the header from 64 to 48 bytes, and header-plus-tag overhead from 80 to 64 bytes. A 64-byte payload would then occupy 128 record bytes, for a 50% payload fraction. A smaller format would need its own framing, parser and compatibility rules.

These figures exclude link-layer framing, inter-packet gaps, retransmissions, enrollment and transit-authorization fields. Comparing secure transports requires including each format’s full overhead. The 64-byte row means 64 bytes of application payload, not a 64-byte Ethernet frame or a particular TCP acknowledgment.

Amortizing metadata over multiple application messages can improve efficiency. It can also add batching latency, couple release decisions, enlarge the damage of a dropped record, and complicate accounting. Removing repeated fields by keeping more session state exchanges wire cost for memory and synchronization cost.

Use [RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [TLS 1.3](07_prior_art_and_sources.md#tls), [ICING](07_prior_art_and_sources.md#d01), [EPIC](07_prior_art_and_sources.md#d03) as baselines, including their complete formats and security processing. The payload fractions above are calculated solely from ASKA’s chosen 80-byte overhead; a performance ranking would require measurements against those protocols.

## Authentication, buffering, and wire delay

Serializing `n` bytes at link rate `R` requires at least `8n/R` seconds, ignoring framing. A 1104-byte record on a hypothetical 100 Gbit/s link takes 88.32 ns just to serialize. The rate is hypothetical. At any rate, a receiver must receive the full record before it can finish authenticating that record.

Pipelining can improve the interval between accepted records without removing the latency of a single record. Full buffering, independently authenticated chunks, and header-first authorization have different security meanings. A benchmark must measure the version that enforces the claimed boundary, including work at minimum packet sizes.

For queue capacity `Q` and maximum staged payload `B`, payload storage alone is `Q × B`. At 4096 slots and 1024 bytes, that is 4 MiB before headers, tags, ownership state, parity, or a second direction. Those are illustrative capacity choices. Even a small control state machine may need substantial protected buffer memory.

With 100,000 sessions and an assumed 256 bytes of protected state per session, state storage is 25.6 MB before indexing and allocator overhead. The assumed record size must eventually be replaced by a real layout. Reducing transit tables leaves this endpoint storage cost.

Compare protected copying/exclusive-access costs with [Elasticlave §§3,6](07_prior_art_and_sources.md#b05), endpoint/message costs with [M³](07_prior_art_and_sources.md#a01), [FractOS](07_prior_art_and_sources.md#a08) and secure host/device transfers with [Serialized Bridge preprint](07_prior_art_and_sources.md#e10), [Blackwell benchmark preprint](07_prior_art_and_sources.md#e11). The link rate, queue count and session size used above are hypothetical inputs. Measured throughput from another platform cannot validate them.

## Availability is a separate design problem

Authenticated senders can still abuse the service. A compromised source can spend its allowance, send useless data or replay valid transit credentials. An unauthenticated source can consume parser, lookup, cryptographic or upstream bandwidth before rejection.

The receiver can reject accepted duplicates and below-window sequences before authentication, but an eligible sequence rejected by policy remains unmarked. Repeated copies may therefore consume cryptographic work. Measure those costs under changing policy, alongside accepted duplicates and failed tags. A rejection cache needs bounds and invalidation rules of its own.

The system needs limits on outstanding work and on the work induced by one request. Candidate mechanisms include bounded queues, per-ingress budgets, class scheduling, and explicit backpressure. They have different fairness and state costs. Backpressure can propagate interference across a fabric or reveal activity; it must be modeled where timing is in scope.

For a simple queue receiving sustained rate `lambda` above service rate `mu`, spare capacity `Q` fills in approximately `Q / (lambda - mu)` time units. No finite queue resolves sustained overload. The design must specify who loses service, bound the damage and keep the protected control path usable.

Existing admission/regulation designs to compare are [TVA](07_prior_art_and_sources.md#d06), [M³ real-time regulation](07_prior_art_and_sources.md#a06), [SIBRA](07_prior_art_and_sources.md#d08), [M³](07_prior_art_and_sources.md#a01). The queue-fill calculation assumes continuous arrival and service rates; it supplies no availability proof for these implementations. [security-triggered throttling](07_prior_art_and_sources.md#obs) provides another comparison for attacks on automatic responses.

Automatic quarantine can itself be an attack target. A flood of rejected requests might induce an observer to disable legitimate work. A useful experiment measures both containment and service continuity under such triggers.

Permission checks also do not establish deadlock freedom in an on-chip fabric. Requests, responses, buffer ownership, and reserved destination space can form circular dependencies. A candidate needs an explicit resource-acquisition discipline and a model of those dependencies. Virtual channels or separate queues may help, but their buffers and arbitration still require cost and interference analysis. A protected message path that deadlocks during ordinary load is an architectural failure even when every access check is correct.

## Physical isolation still has shared dependencies

Dedicated memory or execution resources may reduce some interference while increasing area and leaving other couplings: power distribution, clocks, reset trees, package links, thermal limits, shared controllers, debug access, and supply-chain trust.

Two veto gates in series can provide additional protection only if a relevant fault leaves at least one effective, non-bypassable gate. Shared specifications, signing keys, toolchains, or physical bypasses can defeat both. Test independence by identifying shared failure paths. Calculating a joint failure rate requires evidence for both the probabilities and their independence.

Independent serial filtering is existing background in [US8122495B2, Background/Fig.2](07_prior_art_and_sources.md#serial). [EURO-MILS](07_prior_art_and_sources.md#mils), [OctopOS](07_prior_art_and_sources.md#a10), [Composite Enclaves](07_prior_art_and_sources.md#a12) motivate careful trusted-boundary decomposition. The physical-gate experiment must separately examine signing authorities, reset paths and bypasses.

A high-assurance IES may eventually require dedicated resources that are uneconomic for ordinary workloads. That can be a useful architectural result if the applicable workloads and benefit are clear. It would not justify advertising the same guarantee for a cheaper shared configuration.

## Policy complexity can defeat usability

Coarse labels may require frequent releases. Fine labels may create large policy state and difficult explanations. A receiver's mapping may change while messages are in flight. A recovered source may no longer possess the state needed to demonstrate continuity. Two organizations may disagree about acceptable evidence.

These problems affect distributed coordination and operation as well as the interface. If operators routinely need a broad bypass to keep services functioning, the proposed boundary is failing its intended use. The research should measure denied useful operations, policy churn, recovery work, and the amount of trusted application-specific code.

Relevant policy/operation experience comes from [DStar](07_prior_art_and_sources.md#c05), [Fabric](07_prior_art_and_sources.md#c06), [CamFlow](07_prior_art_and_sources.md#c08), [WAVE](07_prior_art_and_sources.md#e02), [IPsec failover RFCs](07_prior_art_and_sources.md#ha). [Komodo](07_prior_art_and_sources.md#c13), [Sanctorum](07_prior_art_and_sources.md#c14), [seL4 IFC proofs](07_prior_art_and_sources.md#c11) offer ways to limit or verify privileged enforcement. Assess TCB size by what must be trusted, including any hardware implementation.

Minimizing the trusted computing base also involves a tradeoff. Moving a complicated policy from software into an opaque hardware state machine does not necessarily make it easier to verify. A small protected software component may be preferable to extensive custom logic for some functions. The comparison must include firmware, update tooling, provisioning and release policy alongside datapath logic.

## The 2036 horizon

The project treats substantial improvement in design automation as a plausible planning scenario. AI could reduce the effort of exploring architectures, generating compilers and operating-system support, producing tests, and searching for counterexamples. That can change which ideas a small team can investigate and which ecosystem costs dominate.

Automation already helps at particular stages: DeepMind describes AlphaChip's use in chip floorplanning, and Tiny Tapeout provides an accessible route for small designs to reach fabrication. Neither provides an autonomous, verified process from an arbitrary concept to competitive hardware at scale ([AlphaChip](07_prior_art_and_sources.md#chip), [Tiny Tapeout](07_prior_art_and_sources.md#tt)). [AlphaChip](https://deepmind.google/blog/how-alphachip-transformed-computer-chip-design/), [Tiny Tapeout](https://tinytapeout.com/).

Use changes in cost and verification capacity to decide which designs to investigate:

| Future condition | Decision criterion |
|---|---|
| Software generation becomes much cheaper; verification remains difficult | Prototype ISA extensions when external enforcement cannot express a required operation; retain the smaller trusted design unless the extension’s benefit survives verification and workload comparison |
| Hardware verification and physical design become substantially more automated | Advance a component to RTL comparison only when synthesis and verification can test it against the existing-core baseline within available resources |
| Fabrication, packaging, memory, or deployment remain expensive | Prefer an existing core with external enforcement unless measured benefits justify the added fabrication and maintenance costs; defer a full custom machine if they do not |
| Automation improves slowly | Keep the first deliverable at the model and existing-component comparison stage; require a counterexample or measured shortfall before expanding the architecture |

Automation may make some designs practical while other bottlenecks remain. State those dependencies explicitly, including the requirements whose consistency still needs checking.

At-scale adoption remains distinct from technical feasibility. A working design would still need reliable manufacturing, software maintenance, deployment paths, operators, and an economic reason to replace or complement incumbent systems. Those adoption questions can remain open while the research tests specific designs.
