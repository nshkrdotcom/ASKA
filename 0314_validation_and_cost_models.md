# ASKA v4 — Validation and cost models

[Start](0300_architecture_and_reading_map.md) · [Previous](0313_compromise_and_failure_cases.md) · [Next](0315_research_and_realizations.md)

**Requirements:** R03–R08, R11–R14, R16–R18, R19–R24.

Validation must connect the architecture's requirements to observable implementation effects. Performance studies must measure the version that enforces those requirements. Neither an abstract proof with unexplained atomic operations nor a fast weakened implementation establishes the target.

## Assurance layers

| Layer | Artifact | What it can establish |
|---|---|---|
| Policy and application graph | Explicit effects, category mappings, physical dependencies | Intended authority and missing/overbroad edges |
| Transition model | Interleavings, invariants, bounded traces | Safety within stated model bounds and assumptions |
| Protocol analysis | Canonical encodings, key schedule, replay/recovery model | Cryptographic and state relationships under the chosen model |
| Implementation refinement | Mapping of concrete instructions/transactions to abstract events | Whether the implementation realizes the checked transitions |
| Physical implementation | RTL/netlist/board inventory and external observations | Actual memory/egress paths and fault behavior on that apparatus |
| Whole application | Native document-review workflow with malicious components | Composition, useful service, and ergonomics under the tested attacks |

Keep proof assumptions and test coverage separate. A verified checker depends on its specification and execution environment. A board test cannot exhaust all inputs, and a model cannot infer a missing physical path.

## First executable models

**Receive/effect model.** Include at least two receive lanes; separate framing, preliminary replay check, authentication, consumed-state update, policy lookup, reservation, policy change, commit, publication, and reset. Model large sequence gaps caused by abort, bounded verification queues, forged session identifiers, and replacement contracts over existing control channels. The property observes actual publication and policy history independently of a gate's `allow` output.

**Ownership model.** Define allocation/record lifetime first. Model CPU cached writers, a DMA requester, alias removal, revoke requests/acknowledgments, outstanding transactions, delayed responses, generation reuse, cancellation, and reset separately. Compare context-checked delayed effects with complete quiescence before reuse. Do not assume `freeze_and_copy` or `revoke_all` as an atomic primitive when those steps are what the model is meant to investigate.

**Authority graph model.** Model an application parser, AI planner, intent verifier, state owner, renderer, gateway, and update roles. Search for paths from compromised components to forbidden effects, including broad brokers and fallback parsers. Add common dependencies as nodes; two keys controlled by one build/release system do not count as two independent barriers.

**Persistence model.** Separate volatile prepare, durable operation record, visibility, receipt, external action, crash, and restore. Inject a lost acknowledgment after a device effect. Require a durable outcome or explicit uncertainty under the declared strategy.

TLA+, Alloy, an interactive theorem prover, and executable reference models are candidates. Tool choice follows the property. Formal syntax does not repair an omitted writer, an unrealistic clock, or a false independence assumption. Publish model bounds, fairness, abstraction, counterexamples, and weakened variants.

## Crossing and release model

Add two domains with independent policy, a malicious reader, import/export workers, a release proposer, an exact-output enforcer, a device service, and a destination owner. Represent reachability separately from permitted operations. Interleave cable attachment, route edits, approval, byte substitution, label changes, policy withdrawal, first emission, receipt loss, and restart with uncertain accounting.

Check that no topology change mints authority; read access does not install export; each emitted prefix belongs to an approved representation; and consumed release rights cannot reopen after reset. Separately model a compromised semantic approver: exact binding alone must not be asserted to prove permitted content. Include a broken variant that accepts any bytes under an approved label.

The observation profile includes status codes, response existence, metadata, and scheduling choices where claimed. For a channel with at most `k` independently selectable visible outcomes per fixed opportunity, the simple upper bound is `log2(k)` bits per opportunity; a one-bit status once per second can carry one bit per second before other observations. This is illustrative arithmetic, not a measured covert-channel capacity. Correlations, adaptive queries, timing resolution, and noisy physical channels require their own models. [0318](0318_cross_domain_security_and_information_release.md) defines the profiles and campaign matrix.

## Physical verification

Verify every crossing in the path inventory: local cache/memory, DMA, peer-to-peer, fabric retries, management, debug, reset, and physical transmit enable. Use probes or independent endpoints at the actual memory/egress boundary. Gate logs are supporting evidence, not the only observer.

Inspect generated netlists and configuration so forbidden paths cannot be enabled through a different interface. For P2/P3 claims, test the specified shared-failure and probing/fault model. A second implementation should differ in a way relevant to the failure being studied; cosmetic code differences do not establish independence.

Instruction-level IFC work and [time protection research](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract) provide comparisons for observation-aware reasoning. Their assumptions must be carried into any extension across devices, memory controllers, and networks.

## Cost arithmetic

The following examples use hypothetical inputs and are not ASKA measurements.

- If `N` islands each reserve `M` private bytes, memory capacity is at least `N × M`, before code, metadata, ECC, staging, and state owners. At 1024 islands and 8 MiB each, private memory alone is 8 GiB.
- A full payload copy reads and writes each byte: at least `2P` bytes of memory traffic for payload `P`. Encryption and assembly can add passes. Transfer avoids a copy only when the engine can access the transferred allocation directly.
- With `b` metadata bits per `g` data bytes, raw metadata/data ratio is `b/(8g)`. A hypothetical 32-bit label reference per 64-byte line adds 6.25% before alignment, tag caches, and integrity protection.
- Serialization of `n` bytes at rate `R` takes at least `8n/R`. A hypothetical 4096-byte record at 100 Gbit/s takes 327.68 ns before framing, propagation, queuing, or verification.
- With spare queue capacity `Q` and sustained arrival/service rates `a > s`, approximate fill time is `Q/(a-s)`. Finite buffers cannot absorb sustained overload.

Memory and transfer costs must include controller traffic, cache maintenance, interconnect acknowledgments, and the time source resources remain unavailable. Comparing coherent copy with naive mutable-memory copying would test different guarantees.

For lifecycle time `T_l` and useful task time `T_u`, an otherwise serial worker's useful-time fraction is `T_u/(T_u+T_l)`. This exposes why request granularity matters. Batching can amortize lifecycle and admission, but larger batches also enlarge compromise domains, retained state, and cancellation consequences.

For unborrowable time slots, a domain with fraction `f` of a resource's schedule obtains at most approximately `f × B` of ideal service `B`. Reclaiming idle slots may improve utilization while exposing other domains' activity. The security profile decides which observations are permitted.

## Measurement matrix

Compare A/B/C from [0302](0302_architectural_candidates_and_decisions.md) with the same inputs, authority graph, output policy, and observation assumptions. Report private-memory utilization, useful throughput, latency distribution, data movement, context lifecycle, energy, area, wiring/packaging assumptions, and operator/developer effort.

For AI, include context access breadth, unauthorized effects denied, in-scope abuse, proof/checker costs, private inference state, and usable task completion. For networking, include admission/recovery work, per-hop state/bytes, replay before rejection, useful bandwidth under overload, and physical paths actually controlled.

A native target comparison must not credit P0 sharing with P1/P2 guarantees. A trusted-host baseline remains useful if its trust difference is visible. Roadmap process-node or optical bandwidth figures cannot be substituted for measurements on the selected apparatus.

## Research acceptance

A candidate proceeds when it meets its declared invariants, completes useful work, and has a reproducible explanation of cost and remaining dependencies. Negative results can invalidate a design, change its granularity, or show that an existing mechanism already suffices. They do not justify relabeling an unmet target requirement as satisfied.

All results record source/artifact revision, tools, inputs, commands, firmware/configuration, observer placement, assumptions, and outcomes. AI-generated prose and agreement between models are not evidence that a checker ran or a physical boundary held.
