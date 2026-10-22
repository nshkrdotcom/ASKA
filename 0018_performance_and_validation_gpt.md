# ASKA — Performance and validation

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0017_chiplets_and_hardware_integration_gpt.md) · [Next](0019_implementation_contracts_and_sources_gpt.md)

Evaluate useful protected work completed under attack alongside latency, memory traffic, protected state, and implementation complexity. Tests must demonstrate successful authorized work and enforce ownership and publication checks on the measured path.

The calculations below use stated assumptions. ASKA has no measured results yet.

## Bandwidth and buffer costs

At 100 Gbit/s, raw link capacity is 12.5 GB/s. At 400 Gbit/s, it is 50 GB/s. Actual payload capacity is lower after framing and protocol overhead.

A streaming memory encryption pass that reads plaintext and writes ciphertext consumes at least two payload bytes of memory traffic per payload byte. At a hypothetical 50 GB/s payload rate, that is 100 GB/s before descriptors, cache traffic, or receive processing. An additional full payload copy adds another read and write, taking that simplified total to 200 GB/s.

Direct engine access to transferred memory can remove the additional copy. Encryption still requires its own data path. Inline encryption to the wire can avoid a separate ciphertext write, while retransmission and native packet authentication may require retaining ciphertext. Each benchmark must identify its actual storage path.

For queue depth `Q` and maximum retained payload `P`, payload storage is `Q × P`. At 4096 slots and 1024 bytes, that is 4 MiB, excluding metadata and extra representations. That storage can be protected DRAM rather than all on-chip SRAM; latency, access control, and bandwidth then need measurement.

## Wire overhead

The endpoint record adds 80 bytes. The native envelope adds `128 + 96h` bytes for `h` gates. IPv6/UDP adds another 48 bytes under the stated no-extension profile.

| Payload | Overlay IP bytes | One-gate native IP bytes | Four-gate native IP bytes |
|---:|---:|---:|---:|
| 64 | 192 | 416 | 704 |
| 256 | 384 | 608 | 896 |
| 1024 | 1152 | 1376 | 1664 |

Eight gates with a 1024-byte payload use 2048 IP bytes. The native experiment therefore requires a verified path MTU of at least 2048 bytes for that configuration. Ethernet framing and interpacket gaps are additional costs. A 1500-byte path cannot carry the four-gate maximum without reducing the negotiated payload.

For a 1024-byte payload, endpoint-record efficiency is `1024/1104 = 92.8%`. Four-gate native efficiency including IPv6/UDP is `1024/1664 = 61.5%`. These costs make compact grants, larger messages, and existing path formats worth comparing after the safety contract works.

At 100 Gbit/s, serializing 1664 bytes takes at least 133.12 ns before link framing. Store-and-forward adds receipt and verification delay at every gate. Pipelining raises aggregate throughput without making one record's store-and-forward latency disappear.

## Work per record

The sender performs ownership synchronization, policy lookup, AEAD, and one per-record native authenticator per hop when using the native profile. Each native gate hashes the complete endpoint record and verifies its grant and per-record authenticators. The receiver performs AEAD and serialized freshness/delivery decisions.

To evaluate operation at 100–400 Gbit/s, measure minimum-size records, maximum hop count, session lookup misses, rejection paths, and contention on one session. Parallel engines can increase aggregate throughput while leaving a single session's arbitration as a bottleneck.

A hypothetical 256-byte session state allocation for 100,000 sessions uses 25.6 MB before indexing. The 256-bit consumed bitmap alone uses 32 bytes per session. Immutable contracts, keys, budgets, and quarantine references add more. Replace this estimate with an actual packed layout before hardware sizing.

## Contract and compute studies

Before modeling ownership, define allocation-to-record lifetime: parent bindings, child slices, local credits, sequence allocation, cancellation, retransmission retention, and reclaim. Use the contracts in [0013](0013_memory_ownership_and_lifecycle_gpt.md) and model their transitions separately. A local credit is not evidence of receiver progress.

Study compute costs alongside endpoint and gate work. Compare native capability and compatibility profiles on the same useful workload, while reporting their different internal protection. Measure pointer footprint, cache behavior, tag/ECC storage and bandwidth, compiler/runtime porting, allocator sweeping/quarantine, revocation pauses, and device paths. X730 and Morello are concrete comparison sources, not evidence of server-scale ASKA performance. [X730](https://cheri-alliance.org/cheri-enabled/x730/), [Morello performance methodology](https://ctsrd-cheri.github.io/morello-early-performance-results/headline-results/essential-overheads.html).

## Development stages and exit criteria

| Stage | Deliverable | Exit criterion |
|---|---|---|
| 1. Executable contracts | Allocation/record contract, then receive and ownership models with admission, policy updates, and reset | Independent safety checks pass within published bounds; deliberately broken variants produce expected counterexamples |
| 2. Protocol reference | Independent encoders/decoders, crypto vectors, admission transcript vectors | Byte agreement, malformed-input rejection, and reviewed key/nonce separation |
| 3. Endpoint prototype | Protected sender and receiver on a pinned platform | Host cannot read plaintext/keys or expand receiver policy; permitted transfers succeed |
| 4. Ownership implementation | Controller plus CPU/device completion model, then FPGA or board realization | All writer classes are fenced and stale completions cannot affect reused allocations |
| 5. Protected transit | Separate gate with instrumented ingress/egress | Hostile controller cannot cause prohibited transmission; native replay load and useful service are measured |
| 6. Native compute/package study | RV64 capability runtime and chiplet/interface implementation plan | Toolchain, ABI, tag storage, timing, area, and workload evidence justify further integration |

Each stage tests its own requirements and depends on the earlier invariants it uses. The plan sets no schedule or fabrication commitment. Revise or stop a branch if a simpler existing system meets the contract more effectively.

## Independent properties

The independent oracle checks histories and effects against policy. It must not treat the gate's `allow` output as evidence that the decision was correct.

| Property | Independent observation |
|---|---|
| Access isolation | Actual memory effects agree with owner, extent, and generation at the permitted access point |
| Snapshot coherence | Authenticated payload equals the bound allocation after prior writes drain and before new writes resume |
| Flow confinement | Delivered categories satisfy source execution policy and destination confinement, or a specific valid release |
| Receiver authority | Only receiver-authorized local installation expands receive scope |
| At-most-once transport delivery | Each live session/sequence publishes at most once, including concurrent duplicates |
| Denial consumption | An authenticated denied sequence cannot later publish or repeatedly enter verification after consumption |
| Publication ordering | Current policy, delivery budget, destination generation, and restriction assignment precede visibility |
| Physical egress | Independent wire observation sees no record at a forbidden instrumented port |

A separate noninterference study must define its observer and compare executions differing in secret input. Timing and whole-system noninterference need evidence beyond explicit-transfer tests.

## Attack campaigns

1. Retain CPU pointers and DMA aliases through ownership transfer; delay dirty writebacks and completions until after allocation reuse.
2. Reassign or remap memory during offer, revoke, drain, authentication, and reclaim. Check both permitted completion and safe abort.
3. Submit forged low labels, wrong operation codes, changed destination generations, and unauthorized release references.
4. Replay installation transcripts across reboot; restore old key/counter images; race rotation and withdrawal with first-byte emission.
5. Race identical records across receive lanes and withdraw policy between preliminary evaluation and commit. Separately test tag-valid denials, bad tags naming a victim session, forged high sequences, large valid jumps after aborts or loss, and unknown-session floods. Verify that invalid traffic cannot trigger session retirement and that useful sessions retain their declared service.
6. Fill quarantine and destination queues. Verify bounded state, charged work, retry semantics, and reserved control service.
7. Splice native entries, change path metadata, select the wrong physical egress, copy valid tokens to a different ingress, and modify ciphertext after token creation.
8. Trigger device reset, root-complex reset, link loss, firmware recovery, and clock discontinuity. Observe closed protected paths until fresh association.
9. Abuse valid source authority and transit replays at maximum admitted rates while concurrently sending useful authorized traffic.

Each campaign includes a weakened configuration whose violation is independently visible. For example, retain one writable DMA alias, skip the second replay check, expose quarantine early, or enable a raw transmit bypass. Failure to detect that configuration invalidates the campaign's observation method.

## First model boundaries

The receive model includes at least two authentication lanes, preliminary and serialized freshness checks, sequence consumption, policy versions, resource reservation, publication, and reset. Explore withdrawal between preliminary allow and delivery commit. Include sender slot release, aborted allocated sequences, large authenticated jumps, forged victim session IDs, bounded scheduler service, and replacement sessions over an existing control channel. Model recovery cost separately from a full handshake or renewed attestation.

The ownership model follows the allocation/child contract and includes CPU cached writers, DMA, revocation requests and acknowledgments, pending transactions, generation reuse, abort, reset, and delayed writebacks/responses. Distinguish writes admitted before revocation from new writes that should be blocked. Do not assume a revoke acknowledgment proves a drain unless that is the interface being implemented and tested.

Compare generation checks on late effects with a complete-quiescence strategy that prevents reuse until old effects are impossible. Identify the hardware needed by either strategy; do not assume existing links preserve unchecked metadata. Check safety and bounded resources; state fairness and network-progress assumptions before asserting liveness. Latency, the copy/transfer crossover, and recovery costs need service-time models or measurements in addition to transition checks.

## Performance comparisons

Compare protected copy, exclusive transfer, and immutable sharing under the same snapshot and threat requirements. Also compare a conventional system with a trusted host, recording that difference in assumptions. Include a protected software adapter and existing secure transports before assuming dedicated constructor logic is beneficial.

Record throughput and latency distributions, memory traffic, ownership-transition time, crypto utilization, session-state size, queue occupancy, denial rates, useful service under load, and trusted code/firmware dependencies. Record the exact hardware, firmware, compiler, enabled protections, inputs, commands, and implementation revision needed to reproduce the result.

Report false denials and recovery effort alongside escapes. If routine operation needs broad release powers or an all-access management exception, revise the workload decomposition or the architecture.

## Liveness and resource discipline

No finite queue survives sustained offered load above service rate. For spare capacity `Q`, arrival rate `a`, and service rate `s`, with `a > s`, approximate fill time is `Q/(a-s)`. Admission must define which traffic is dropped and reserve resources for control and recovery.

Ownership, queues, and mailbox credits can form circular waits. The first implementation uses bounded reservations, a fixed lock order, no indefinite authenticated waiting queue, and separate control service. Prove or explore deadlock freedom for the selected fabric rather than inferring it from access correctness.

Accept a candidate only when it supports useful workloads under the declared trust assumptions, demonstrates the required invariants, and has measured costs suited to its intended deployment. Report model results, synthesis estimates, FPGA measurements, and fabricated-silicon results separately.
