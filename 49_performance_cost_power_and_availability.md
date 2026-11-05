# ASKA v6 — Performance, cost, power and availability

## Evaluation contract

The native architecture has explicit costs: physical allocation can strand compute or memory; confinement adds staging and metadata; observation consumes bandwidth and power; separate roots add hardware, lifecycle and operational work. These costs must be measured with required protections enabled and against alternatives under the same attacker and workload model.

Every number in the worked arithmetic below is an **illustrative assumption**, not a simulated or measured ASKA result. A deployment must supply its own capacities, latency distributions, energy measurements and failure data. A theoretical bandwidth ceiling cannot be reported as achieved useful throughput.

## Resource fragmentation and safe borrowing

Let domain allocations be `a_i`, demands `d_i`, and total capacity `N`. A static instantaneous utilization bound is `U = Σ min(a_i,d_i) / N`; unmet demand is `Σ max(0,d_i-a_i)`. The formula ignores scheduling and dependency stalls and therefore is not an application-performance predictor.

For an illustrative 64-engine machine with four allocations of 16 and demand `(24,8,4,4)`, useful occupied engines total 32: 50% utilization while 8 requested engines remain unavailable to the busy domain. Safe borrowing of eight idle engines could raise occupied capacity to 40/64 = 62.5%, but only after permitted ownership transfer, drain and sanitation. Borrowing an already active foreign resource or erasing its confidentiality obligations would invalidate the comparison.

If useful request time is `T_u` and lifecycle cost is `T_l`, a serial useful-time fraction is `T_u/(T_u+T_l)`. With assumed 10 ms useful work and 2 ms lifecycle, the fraction is 83.33%. Batching reduces lifecycle amortization but increases retained state, cancellation scope and the consequences of one compromised worker. A study must evaluate that security/utility change rather than treating larger batches as a free optimization.

## Metadata and memory traffic

For memory capacity `M`, ownership granularity `g` and record size `m`, ownership-table storage is `(M/g) × m`. With assumed 1 GiB, 4 KiB extents and 32-byte records, it is 8 MiB, or 0.78125% before alignment, indexing, replicas and cache effects. An independent one-bit tag per 16-byte unit would add another 8 MiB. This arithmetic does not select a tag design or include temporal-revocation structures.

A single copy of payload `S` entails at least S bytes read and S written at the relevant memory interface. Staging followed by crypto and transmission may read it again. With assumed 1 MiB and 20 GiB/s sustainable aggregate memory service, one read-plus-write has an ideal 97.65625 microsecond lower bound. At an assumed 1 Gbit/s wire rate the payload alone needs 8.388608 ms. Neither bound includes authentication, queues, reservations, partial records, errors, memory contention or device waits.

Copy, exclusive transfer and immutable loan must be compared using equal snapshot, revocation and confidentiality guarantees. A no-copy path that leaves a device writer active is a different security model. Cache coherence within one IES can reduce local copies; cross-IES ownership transitions still need alias and in-flight-state accounting.

## Packet and cryptographic overhead

For payload length P and fixed overhead H, payload efficiency is `η=P/(P+H)`. Using an illustrative 80-byte total overhead yields 44.44% efficiency for 64-byte payloads, 94.94% for 1,500-byte payloads and 98.08% for 4,096-byte payloads. These are arithmetic examples, not an ASKA wire format. A selected protocol adds its actual framing, nonce, path, authentication and retransmission costs.

Record verification cost includes bounded parsing, lookup, cryptography, current policy, replay arbitration, label placement and publication. First-contact cost can be much higher than established-session service and needs a separate queue and budget. Cryptographic acceleration can move the bottleneck to protected memory or counter updates. Report latency percentiles and queue occupancy, not only peak packet rate.

A record authenticated at a destination does not establish protected physical forwarding at intermediate nodes. The cost comparison must preserve the distinction between logical acceptance and managed-path enforcement.

## Monitoring and evidence storms

Suppose, illustratively, five LSM input groups each receive 20,000 events/s with 128 serialized bytes/event. Aggregate event traffic is 12.8 MB/s, or 102.4 Mbit/s before transport overhead. A fifty-fold storm is 640 MB/s, or 5.12 Gbit/s. A 16 MiB ring per illustrated group holds approximately 6.55 seconds with no consumer at the assumed normal rate and only 0.131 seconds during that storm. E and W retain separate queue and capacity reservations within their shared LSM group; an encounter flood cannot consume the W reservation.

The ring cannot make an overload disappear. Export policy must prioritize essential counters, preserve sequence/drop evidence and bound payload collection. Observer backpressure cannot silently stall critical workload buses unless that dependency is explicitly selected. A fail-closed response trades service availability for a stated safety condition and must be measured as such.

Security response traffic, watcher health and recovery channels need reserved work budgets separate from bulk analysis. Repeated valid but expensive records are adversarial inputs too. Upstream saturation can defeat remote reporting even while local evidence remains available; the report must distinguish those outcomes.

## False alarms and service cost

Detection precision depends on attack prevalence as well as sensitivity and false-positive rate. In an illustrative million-window evaluation containing 100 attacks, 99 true detections and a 1% false-positive rate over 999,900 benign windows produce approximately 9,999 false alerts: fewer than 1% of positive alerts correspond to attacks. These are constructed values, not detector measurements.

Therefore containment evaluation records false freezes, cumulative frozen time, affected legitimate operations, reauthorization work and recovery. A detector that eventually recognizes all injected attacks but repeatedly blocks ordinary work can fail useful-service requirements. Threshold tuning needs held-out conditions, confidence intervals and a documented cost model; authorized recipients can still abuse valid rights without producing a detectable boundary violation.

## Availability accounting and power

Availability is measured for a named service, workload, observer and interval. Count the union of outage intervals attributable to update, recovery, false containment, queue loss and facility failures to avoid double counting overlaps. As an arithmetic example, a 1,000-second window with 10 seconds of recovery, 15 seconds of false containment and 5 seconds overlap has 20 unavailable seconds, yielding 98% availability for that constructed window. It is not a production target or prediction.

Energy accounting includes useful compute, idle isolated resources, memory movement, cryptographic engines, always-on observers/watchers, optical/electrical interfaces, cooling and recovery. Report joules per completed useful operation and total idle power. A faster accelerator can increase total energy if its host, memory and observation overhead dominate. Process-node forecasts and vendor maximum throughput cannot substitute for apparatus measurements.

Shared supply, cooling, clock and provider facilities remain correlated failure sources. Redundant links do not yield multiplied availability probabilities without evidence about the dependence structure. RP-A and RP-B declare different physical assumptions in [Chapter 04](04_reference_machine_and_reachability.md).

### Operating and custody cost

A deployable profile must name an operator for each installed guard, monitor, witness, key, recovery path and maintained physical interface. Its annual cost model counts acquisition, reserved spare capacity, energy/cooling, facility and network service, staff for patching and key rotation, independent audits, custody incidents, replacement parts, repair travel, qualification re-runs and decommissioning. A separately rooted watcher may have a separate **technical** installer yet rely on the same employer, contractor or power utility; record those common causes and their cost rather than claiming administrative independence from circuit separation.

Report `cost_per_approved_effect = (amortized_capital + annual_operations + qualification + failure_recovery) / successful_authorized_effects`, using measured workload and accounting period. Also report useful-work share and energy per permitted effect at the same security contract. A zero-throughput denial-only implementation has no finite cost-per-useful-effect success claim. None of these ratios establishes a market, operator incentive or financial sustainability without named payers and practical maintenance arrangements.

## Required workload matrix

| Workload | Useful result | Stress and cost dimensions |
|---|---|---|
| Native document review | Correct approved extract and private context retention | Parser takeover, copies, rendering, release checking |
| Interactive companion | Completed bounded user task | Context size, private inference, consent latency, tool attacks |
| Invoice/payment | Correct once-scoped financial submission and qualified receipt | Business approval, retries, uncertainty and witness outage |
| Civic service | Admitted local response under encounter flood | Reserved queues, upstream loss, credential checks |
| Storage/backup | Recoverable committed object and lawful retention | Flush latency, media failure, erase/restore and key scope |
| Security monitoring | Qualified events and bounded incident response | Sampling, dropped events, false alarms and independent health |
| Mixed heterogeneous work | Completed CPU/GPU/dataflow tasks | Fragmentation, memory ownership, device reset and energy |

Compare a strong shared capability/verified-kernel baseline, spatial guarded islands and separated appliances. Keep the same authorization, output, lifetime and observation requirements. The [time-protection work](https://trustworthy.systems/publications/full_text/Ge_YCH_19.pdf) illustrates that isolation costs and residual channels depend on hardware and mitigation details; its measured results are not ASKA forecasts.

## Stop and reopen criteria

Reject an implementation that meets an attack-denial metric by blocking all positive work. Reopen granularity when lifecycle or stranded-resource cost prevents declared service targets. Reopen monitoring configuration when observation cost exhausts reserved capacity or private activity leaks through event patterns. Reopen a physical profile when its assumed independent facility is discovered to be shared. The invariant remains; the candidate mechanism or claim scope changes through explicit review.

## Reference-count scope for the examples

The four-purpose allocation examples concern their workload resource pool. Dedicated encounter compute/banks, guards, observers, watchers and trusted services are additional costs and must be included in a whole-machine evaluation. The reference machine has six exporter interfaces but five LSM groups because TE-E and TE-W feed separately bounded inputs to LS-W. The five-group telemetry arithmetic is illustrative aggregate input per group; actual event rates must include encounter traffic and its independent dropping/accounting limits. RP-A has six duplex interfaces including J-E; RP-B has eleven. The sixteen simplex intermodule security links remain a separate subtotal.

## Required behavior and test oracles

**R-49-01 — Protected benchmark parity.** Comparisons MUST use the same workload, attacker, authority, output and observation contracts with guards enabled.

**Acceptance T-49-01:** Run guarded candidates and an explicitly weaker baseline; do not credit the latter with unsupported physical properties.

**Additional test T-49-02:** Recompute the worked examples and reject a report that labels these assumptions measured results.

**R-49-03 — Full resource cost.** Studies MUST account for fragmentation, lifecycle, copying, tags/caches, crypto, observer work and recovery.

**Acceptance T-49-03:** Run a mixed workload and reconcile requested, reserved, occupied and denied resources across all subsystems.

**R-49-04 — Storm-safe evidence.** Monitoring budgets MUST include overload, protected loss evidence and independence from critical traffic.

**Acceptance T-49-04:** Inject above-capacity events; observe bounded buffers, explicit drops and remaining admitted useful service.

**R-49-05 — False-containment accounting.** Detection/response results MUST include false alarms, frozen service time, renewals and recovery costs.

**Acceptance T-49-05:** Replay benign anomalies and malicious events; account for both missed attacks and legitimate work lost.

**R-49-06 — Conditional service availability.** Availability claims MUST identify service boundary, outage-union accounting and shared physical dependencies.

**Acceptance T-49-06:** Fail shared power/relay resources and verify local versus remote availability claims without double-counting overlaps.

**R-49-07 — Useful-work gate.** A candidate MUST complete authorized positive workloads under its stated assumptions to support a security/service claim.

**Acceptance T-49-07:** Compare deny-all and guarded useful variants; deny-all cannot pass the useful-service gate.
