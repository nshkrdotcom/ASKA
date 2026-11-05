# ASKA v6 — Physical side channels and temporal protection

## The claim names an observer

Physical separation reduces particular interactions; it does not establish zero leakage. A confidentiality claim must name the attacker, observable signals, controllable resources, operating conditions and acceptance bound. An attacker running on another core, operating a management controller, measuring chassis power or holding an electromagnetic probe has different capabilities. A deployment must not use evidence against one of those observers as proof against all of them.

The relevant paths include caches, predictors, shared queues, memory controllers, coherence traffic, scheduling, clocks, power delivery, heat, electromagnetic radiation, acoustic output, fault behavior and maintenance interfaces. Intentional output also interacts with side channels: a protected application can encode data in the timing or size of otherwise authorized messages. Authorization for one recipient does not authorize arbitrary metadata disclosure to every observer along the path.

**R-18-01 — Scoped leakage claim.** Every side-channel or physical-observation claim MUST define the attacker’s placement, measurements, influence and environmental envelope. It MUST identify residual channels and evidence limits rather than assert universal noninterference or zero leakage without a supporting model and measurement.

The assurance profile records functional isolation separately from temporal and physical leakage properties. A design that prevents a neighboring core from loading private memory can still reveal workload timing through a shared resource. A constant instruction trace does not by itself establish constant power, and encryption of payloads does not hide packet sizes or access locations.

## Time and microarchitectural state

Temporal protection may use spatial partitioning, time partitioning, flushing, padding or combinations. Each choice has a coverage boundary. Spatially partitioning a last-level cache does not necessarily partition every memory queue or interconnect. Flushing architectural caches does not establish that all implementation-specific predictors and buffers have been reset. Padding one operation does not hide a longer workflow if its admission or completion schedule remains data dependent.

The [time-protection study by Ge and colleagues](https://trustworthy.systems/publications/full_text/Ge_YCH_19.pdf), particularly sections 3 and 5, separates temporal isolation mechanisms from ordinary functional protection and reports limitations including residual channel observations. It does not provide a universal zero-leakage guarantee. ASKA deployments must reproduce relevant tests on their own hardware and software configuration before making a quantitative claim.

**R-18-02 — Qualified temporal isolation.** Temporal protection MUST enumerate the shared microarchitectural state and scheduler transitions it covers. Flushes, partitions and padding MUST have verified completion conditions and declared residual limits; an unqualified component MUST narrow the claim.

A scheduling policy can leak arrivals, priority, occupancy and cancellation. Reserved time slots may reduce some interference while revealing the reservation pattern itself. Randomized scheduling may make inference harder under a model, but it is not a substitute for a bound on unauthorized access or an unqualified promise that metadata is concealed. The profile should state which timing information is intentionally released and to whom.

## Memory access patterns and obfuscation

Address remapping, encrypted memory and access-pattern obfuscation are separate candidate mechanisms. Encryption can protect retained contents under its key and integrity assumptions while leaving addresses and timing visible. Randomized layout can disrupt simple inference while still leaking repeated access. An ORAM-like service may hide a declared class of access patterns at a cost in bandwidth, latency, memory and trusted state; no such protection is assumed merely because the memory controller changes addresses.

The object owner must also define the granularity of a protected access. A service that hides block addresses but exposes object size and query rate has a narrower claim than one hiding those properties. Dynamic obfuscation cannot change object ownership or create a hidden alias that bypasses generation checks. Reconfiguration must remain compatible with revocation and crash recovery.

**R-18-03 — Distinct content and access-pattern protection.** A memory or transport privacy claim MUST distinguish plaintext confidentiality from address, size, timing and frequency leakage. Any obfuscation mechanism MUST state its protected observations, overhead and failure behavior, and MUST preserve the underlying authority and lifecycle rules.

## Power, heat and electromagnetic coupling

Separate chips can share a regulator, board ground, cooling structure or enclosure. A workload that modulates power or temperature may affect another domain’s timing, reliability or observable emissions. Independent oscillators remove one dependency but do not remove a common supply. Likewise, adding shielding changes the measurement environment without proving that all coupling paths are eliminated.

A physical qualification plan identifies accessible surfaces and conductors, probe placements, measurement bandwidth, environmental variation and attacker time. It separates passive observation from active disturbance. Temperature, voltage and clock excursions can induce faults as well as reveal activity. Fault detection must identify what is detected, how quickly and whether the guard can still prevent a consequence during the interval.

**R-18-04 — Physical coupling inventory.** The deployment MUST inventory power, clock, thermal, electromagnetic and maintenance couplings relevant to its attacker model. Any claimed independent observer or guard MUST remain effective under the specific disturbances included in that claim, or the claim MUST explicitly exclude them.

Physical sabotage also limits availability. Shared chassis power in RP-A is an acknowledged common failure; the workstation does not claim survival of its removal. RP-B’s independently powered appliances support a different failure argument, subject to shared upstream supply and civil works declared in [the reference machine](04_reference_machine_and_reachability.md). Multiplying logical nodes on one physical dependency does not create independent survival evidence.

## Observation and bounded responses

Trusted exporters can make selected boundary events visible to an LSM even when the workload does not cooperate. They do not supply omniscient observation. Private cache activity, encrypted device contents or an uninstrumented analog path may remain invisible. The security mesh must publish coverage and loss conditions, and an absence of events must not be treated as proof of inactivity when the source can be blind.

A physical anomaly can trigger an installed protective template such as `FREEZE_EGRESS`, `ISOLATE_CELL` or `ENTER_SAFE_STATE`. The template specifies its trigger, target, duration, budget and owner priority. The response is constrained to the named consequence boundary. A suspicious power trace does not authorize a security AI to read every cell’s memory or reconfigure unrelated grants.

**R-18-05 — Bounded physical response.** Physical anomaly handling MUST preserve observation uncertainty and use only installed response authority. Loss of a sensor or observer MUST cause the declared downgrade or bounded safe response, not an invented healthy reading or unrestricted emergency privilege.

The observer itself may create leakage through its reports. High-resolution traces can expose sensitive workloads even when no payload is copied. Exported features, raw traces, retention and recipients therefore require a release contract. Sampling can reduce volume and privacy exposure, but the resulting detection limit must be documented. A watcher verifies specified health and continuity conditions; it does not prove that the observed model detects every attack.

## Measurement and falsification

A test dossier distinguishes hypothesis, simulation, measurement and independent replication. It gives hardware revision, firmware, microcode or configuration where relevant, workload, adversary access, measurement equipment, sample selection, statistical method and stopping rule. The acceptance metric must be selected before examining results. “No attack found” means only that the attempted procedure did not demonstrate the forbidden inference under its tested conditions.

For example, a candidate profile may claim that a co-resident tenant cannot infer a protected workload’s chosen branch beyond a specified advantage during a fixed observation interval. The experiment must hold allowed public information constant, vary the secret condition, test the actual shared resources and measure on independent runs. A successful classifier defeats that bound. A failed classifier does not prove resistance to a better attacker or a different physical probe.

**R-18-06 — Reproducible leakage evidence.** Quantitative leakage and fault-resistance claims MUST include a reproducible procedure, declared metric, configuration and uncertainty. Evidence MUST be requalified when a relevant resource, firmware, scheduler or physical arrangement changes.

Acceptance specifications are:

- **T-18-01:** Compare each asserted protection with its named attacker and signal inventory. An unbounded claim supported only by a narrower test must fail review.
- **T-18-02:** Exercise cache, queue and scheduler contention across a protection transition. A forbidden residual observation exceeding the declared metric defeats the temporal profile.
- **T-18-03:** Keep plaintext encrypted while varying access location, size and timing. The report must identify which variations remain observable and must not label them hidden without evidence.
- **T-18-04:** Apply each in-scope supply, clock and thermal disturbance while monitoring guards and observers. A shared disturbance disabling a supposedly independent control defeats that claim.
- **T-18-05:** Remove or corrupt sensor input and inject a plausible alarm. The configured downgrade and bounded response must occur; unrelated data access or new authority must not appear.
- **T-18-06:** Reproduce a claimed leakage bound on held-out measurements and repeat after a relevant configuration change. Unsupported transfer of the old result is a failing counterexample.
