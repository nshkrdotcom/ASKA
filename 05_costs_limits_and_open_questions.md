# 05 — Costs, limits, and unresolved questions

[Start](README.md) · [Previous](04_network_transport_and_realms.md) · [Next: research plan](06_research_plan_and_evidence.md)

ASKA is worthwhile only if its boundaries improve security under a meaningful threat model while leaving useful computation affordable. Security properties, utility, performance, and implementation cost all belong in that assessment.

There are no ASKA measurements in this revision. The examples below are arithmetic under stated assumptions. They identify what to measure; they do not predict a fabricated chip's performance.

## The most consequential unresolved questions

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

For example, 32 metadata bits per 64 data bytes add 6.25% raw storage before alignment, error correction, caches, coherence traffic, or policy tables. This is a hypothetical layout, not a selected ASKA tag format.

A compact index can move label representation into a table. It does not eliminate the information or its management. The design must pay for lookup bandwidth, capacity, reclamation, cache behavior, and identifiers that remain valid while references exist. If the namespace fills, the system needs a defined denial or reclamation rule. Silent aliasing of two distinct policies would be a correctness failure.

A label-cache miss can also reveal information through latency. Whether that is an exploitable channel depends on what determines the lookup and what an adversary can observe. Fixed schedules, partitioning, or other mitigations may reduce exposure while increasing cost. This belongs in the timing model, not in a footnote claiming that table lookup is effectively free.

## Memory scheduling has workload-dependent losses

Suppose a protected schedule gives domain `i` a service interval `q_i` during a repeating period `T`. Even under ideal device behavior, its average service is bounded by roughly:

```text
B_i <= B_ideal × q_i / T
```

where `T` includes any reserved guard or idle periods. Real DRAM adds bank conflicts, refresh, turnaround, row behavior, and controller constraints.

If four domains each receive one quarter of an unborrowable schedule and only one is busy, that domain can use at most one quarter of the ideal aggregate service. If all four are busy, the aggregate loss can be much smaller. A work-conserving scheduler may reclaim idle service, but the resulting service times can reveal other domains' activity. This is a tradeoff to analyze for a particular threat model.

There is no justified universal claim that ASKA must lose 40–60% of DRAM throughput. Nor is there a basis for claiming the penalty disappears. The right comparison includes workload mix, latency tails, sustained bandwidth, security assumptions, and the resources actually shared.

Time-protection research demonstrates why spatial memory isolation and temporal isolation need separate treatment. It does not supply a universal remedy for every shared resource in an ASKA package. [Ge et al., *Time Protection: The Missing OS Abstraction*](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract).

## The illustrative record has visible overhead

The [experimental record](04_network_transport_and_realms.md) adds a 64-byte header and 16-byte tag. For application payload `P`, its record-level payload fraction is `P / (P + 80)`.

| Application payload | Record bytes | Payload fraction | With an additional 48-byte IPv6/UDP header |
|---:|---:|---:|---:|
| 64 bytes | 144 bytes | 44.4% | 33.3% |
| 256 bytes | 336 bytes | 76.2% | 66.7% |
| 1024 bytes | 1104 bytes | 92.8% | 88.9% |

These figures exclude link-layer framing, inter-packet gaps, retransmissions, enrollment, and any transit-authorization fields. They also do not compare against the full overhead of an alternative secure transport. The 64-byte row means 64 bytes of application payload, not a 64-byte Ethernet frame or a particular TCP acknowledgment.

Amortizing metadata over multiple application messages can improve efficiency. It can also add batching latency, couple release decisions, enlarge the damage of a dropped record, and complicate accounting. Removing repeated fields by keeping more session state exchanges wire cost for memory and synchronization cost.

## Authentication, buffering, and wire delay

Serializing `n` bytes at link rate `R` requires at least `8n/R` seconds, ignoring framing. A 1104-byte record on a hypothetical 100 Gbit/s link takes 88.32 ns just to serialize. This says nothing about an achievable ASKA link rate. It shows why a full-record authentication decision cannot precede the arrival of the full record at that link's receiver.

Pipelining can improve the interval between accepted records without removing the latency of a single record. Full buffering, independently authenticated chunks, and header-first authorization have different security meanings. A benchmark must measure the version that enforces the claimed boundary, including work at minimum packet sizes.

For queue capacity `Q` and maximum staged payload `B`, payload storage alone is `Q × B`. At 4096 slots and 1024 bytes, that is 4 MiB before headers, tags, ownership state, parity, or a second direction. Those are illustrative capacity choices. A gate advertised as a small state machine may still need substantial protected memory.

With 100,000 sessions and an assumed 256 bytes of protected state per session, state storage is 25.6 MB before indexing and allocator overhead. The assumed record size must eventually be replaced by a real layout. Transit-table reductions do not erase this edge cost.

## Availability is a separate design problem

Authentication does not make valid senders polite. A compromised source can spend its entire allowance, send useless data, or replay valid transit credentials. An unauthenticated source can consume parser, lookup, crypto, or upstream bandwidth before rejection.

The system needs limits on outstanding work and on the work induced by one request. Candidate mechanisms include bounded queues, per-ingress budgets, class scheduling, and explicit backpressure. They have different fairness and state costs. Backpressure can propagate interference across a fabric or reveal activity; it must be modeled where timing is in scope.

For a simple queue receiving sustained rate `lambda` above service rate `mu`, spare capacity `Q` fills in approximately `Q / (lambda - mu)` time units. No finite queue resolves sustained overload. The architectural question is who loses service, what damage is bounded, and whether the protected control path remains usable.

Automatic quarantine can itself be an attack target. A flood of rejected requests might induce an observer to disable legitimate work. A useful experiment measures both containment and service continuity under such triggers.

Permission checks also do not establish deadlock freedom in an on-chip fabric. Requests, responses, buffer ownership, and reserved destination space can form circular dependencies. A candidate needs an explicit resource-acquisition discipline and a model of those dependencies. Virtual channels or separate queues may help, but their buffers and arbitration still require cost and interference analysis. A protected message path that deadlocks during ordinary load is an architectural failure even when every access check is correct.

## Physical isolation still has shared dependencies

Dedicated memory or execution resources may reduce some interference while increasing area and leaving other couplings: power distribution, clocks, reset trees, package links, thermal limits, shared controllers, debug access, and supply-chain trust.

Two veto gates in series can provide additional protection only if a relevant fault leaves at least one effective, non-bypassable gate. Shared specifications, signing keys, toolchains, or physical bypasses can defeat both. Independence is an engineering property to investigate, not something established by two vendor logos. No unsupported probabilities should be multiplied to claim a failure rate.

A high-assurance IES may eventually require dedicated resources that are uneconomic for ordinary workloads. That can be a useful architectural result if the applicable workloads and benefit are clear. It would not justify advertising the same guarantee for a cheaper shared configuration.

## Policy complexity can defeat usability

Coarse labels may require frequent releases. Fine labels may create large policy state and difficult explanations. A receiver's mapping may change while messages are in flight. A recovered source may no longer possess the state needed to demonstrate continuity. Two organizations may disagree about acceptable evidence.

These are distributed-systems and operational problems, not merely interface polish. If operators routinely need a broad bypass to keep services functioning, the proposed boundary is failing its intended use. The research should measure denied useful operations, policy churn, recovery work, and the amount of trusted application-specific code.

Minimizing the trusted computing base also involves a tradeoff. Moving a complicated policy from software into an opaque hardware state machine does not necessarily make it easier to verify. A small protected software component may be preferable to extensive custom logic for some functions. The comparison must include firmware, update tooling, provisioning, and release policy—not just the number of gates in the datapath.

## The 2036 horizon

The project treats substantial improvement in design automation as a plausible planning scenario. AI could reduce the effort of exploring architectures, generating compilers and operating-system support, producing tests, and searching for counterexamples. That can change which ideas a small team can investigate and which ecosystem costs dominate.

There is already evidence of automation improving particular stages: DeepMind describes AlphaChip's use in chip floorplanning, and Tiny Tapeout provides an accessible route for small designs to reach fabrication. Those examples establish narrower capabilities than an autonomous, verified path from arbitrary concept to competitive hardware at scale. [AlphaChip](https://deepmind.google/blog/how-alphachip-transformed-computer-chip-design/), [Tiny Tapeout](https://tinytapeout.com/).

The useful question is how the preferred architecture changes under different future costs:

| Future condition | Effect on ASKA's choices |
|---|---|
| Software generation becomes much cheaper; verification remains difficult | New interfaces become easier to build, while small enforceable contracts remain valuable |
| Hardware verification and physical design become substantially more automated | More execution and interconnect candidates become practical to compare |
| Fabrication, packaging, memory, or deployment remain expensive | Reuse, smaller components, and compatibility retain substantial value |
| Automation improves slowly | A precise contract, comparative models, and negative results still advance the research |

AI does not need to eliminate every bottleneck for the opportunity to change. It also cannot make an inconsistent security contract true. The architecture should expose its dependencies so progress in one area can be used without assuming all other constraints have disappeared.

At-scale adoption remains distinct from technical feasibility. A working design would still need reliable manufacturing, software maintenance, deployment paths, operators, and an economic reason to replace or complement incumbent systems. The research can respect that reality without deciding the final ISA or market ten years in advance.
