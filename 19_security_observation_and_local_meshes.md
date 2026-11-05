# ASKA v6 — Security observation, mesh roles and sensor coverage

## Security outside the execution domain

ASKA places its local security analysis outside the authority of the workload being observed. A compromised application, kernel, driver or UAI cell should not be able to stop the observation hardware, replace its policy or forge the protected source identity of its events. This is a relative claim: independence from a compute module does not imply independence from a shared power supply, boundary controller, manufacturing defect or installation custodian. The declaration of those dependencies is part of the claim.

The Master Security Mesh (MSM) distributes admitted configuration and correlates permitted reports. A Local Security Mesh (LSM) observes one declared scope and produces findings and protective proposals. Neither component acquires an unrestricted management role. A memory guard still decides whether a memory operation is permitted; an egress guard still decides whether information may leave; an effect owner still decides whether a response may become final. Observation may reveal a bypass or loss of confidence, but it cannot make a compromised enforcement boundary sound by assertion.

The reference wiring is owned by [chapter 04](04_reference_machine_and_reachability.md). RP-A contains LS-S, LS-P, LS-A, LS-W and LS-T, with separate WM-L watchers, one MSM, WM-M and the independent oversight receiver OV. LS-T covers authorized exports from trusted services; it is not another application plane. Keystone and Steles remain distinct. A Steles commitment can preserve evidence about a security event without becoming the watcher that discovered it.

**R-19-01 — Declared physical independence.** Each mesh deployment MUST identify its observed components, separate processing and writable storage, boot and installation roots, reset/debug reachability, clocks, power and reporting paths. It MUST claim independence only against adversaries unable to control those dependencies. The implementation manifest MUST instantiate chapter 04’s interfaces rather than substitute logical process separation for a claimed physical boundary.

## Division of responsibility

| Component | Information it may consume | Permitted product | Boundary it cannot cross by itself |
|---|---|---|---|
| TE | Authorized guard and owner events | Source-bound event records and loss accounting | Changing the event-generating operation |
| LSM | Its TE streams, admitted sensors, bounded rule packages | Local posture, incident hypothesis, response proposal | Installing grants, reading arbitrary banks or writing devices |
| MSM | Separate LSM reports and approved intelligence | Correlation and addressed distribution packages | Overriding a local receiver or claiming another realm’s rights |
| WM-L | Independent local observation and LSM health evidence | Watcher report to OV | Repairing or reprogramming the LSM directly |
| WM-M | Independent MSM distribution and health evidence | Master-watcher report to OV | Becoming a second universal distributor |
| SAI | Released evidence in a bounded analysis domain | Ranked hypotheses and proposals | Signing updates or exercising a raw device command |
| OV | Authenticated watcher reports | Qualified oversight findings | Writing arbitrary guard state |

**R-19-02 — Hierarchy without inherited privilege.** MSM membership, report receipt and a high reputation score MUST NOT create authority over an LSM, its monitored resources or another realm. Distribution MUST be addressed to a receiver and package class accepted by a live local policy. Each LSM MUST retain its own admission decision and disclose which dependencies are shared with the MSM.

An LSM can perform deterministic checks without an AI model: missing sequence ranges, stale policy epochs, forbidden transaction attempts and exceeded queue budgets are examples. More complex inference runs within bounded cells. The distinction avoids making ordinary guard operation dependent on a model service, a remote threat feed or a central correlation queue. A deployment may require fresh observation for a particular high-consequence contract, but that is an explicit admission condition with a defined degraded result.

**R-19-03 — Observation, proposal and enforcement separation.** Mesh outputs MUST use the event and proposal interfaces defined in [chapters 21](21_security_fabrics_telemetry_and_provenance.md) and [23](23_protective_response_and_containment.md). A mesh or SAI process MUST NOT possess a general guard-table writer, arbitrary code loader, raw DMA master or unrestricted actuator interface merely because it performs security work. Protective effects MUST be admitted by their protected owner.

## Normal operation and feedback

At deployment, the local owner admits a coverage contract, export schema, receiving policy, event budget and response standing grants. Boot establishes the relevant identities and epochs. TE emits the approved event classes; the LSM verifies provenance and accounts for gaps before interpreting their meaning. A finding references the evidence and the scope of inference. It can be reported upstream, proposed to a local effect owner, retained locally, or some combination permitted by the disclosure policy.

MSM-to-LSM configuration travels over the dedicated directional interface. LSM-to-MSM reporting uses a different interface. A request for a new rule may therefore return in a report and influence later engineering work, but the report is never an installation command. Any resulting package passes the producer, reviewer, signer and receiver controls of [chapter 24](24_software_update_generation_and_supply_chain.md). This is a feedback loop of typed records and admitted effects, with no assumption that the complete system graph is acyclic.

The mesh may help reconcile a promised operation. It can show that an owner emitted a receipt, that a device command crossed an observed interface, or that an expected event was missing. It does not substitute for the finality owner. The reconciliation procedure in [Chapter 17](17_transactions_effects_and_reconciliation.md) compares those observations with durable state and records unresolved disagreement.

## Compromised security components

A malicious LSM may conceal a suspicious pattern, emit a false alarm or exploit its permitted report bandwidth. Its watcher can compare independently acquired source counts with claimed ingestion, observe configuration changes and detect some forms of silence. The watcher cannot infer all unreported semantics. The contained outcome is therefore narrower than “compromise detected”: the LSM remains unable to write another bank, invent a valid owner receipt or exceed an installed protective grant; its detection reliability may be lost.

A malicious MSM may send obsolete, malformed or maliciously chosen signed content, withhold updates or attempt to install the same bad rule everywhere. Local admission, package typing and rollout cohorts limit that influence. A compromised MSM reporting service cannot be allowed to reconfigure its own WM-M. If a common signer authorizes both MSM and every watcher image, that signer is a common failure dependency even if all processors sit on separate boards.

**R-19-04 — Explicit mesh compromise case.** The threat model and conformance campaign MUST separately grant the attacker full software control of an LSM and the MSM. For each case, they MUST identify lost detection capabilities and verify the remaining owner, receiver, watcher and installation boundaries. Detection of the compromise itself MUST NOT be assumed as the prerequisite for preserving those boundaries.

A compromised watcher is tested independently in [chapter 20](20_independent_watchers_and_meta_monitoring.md). A compromised SAI may deliberately request plausible but harmful containment; its limited proposal privilege does not make those proposals safe. Authorized abuse is possible within a standing grant, which is why response duration, service impact and cumulative quotas belong in the grant rather than only in the model’s recommendation.

## Resource budgets and degraded operation

Security traffic consumes real resources. A profile allocates TE buffers, local analysis memory, report queues, model execution time, cryptographic verification capacity and retained evidence storage. Saturating one LSM must not consume every MSM parser slot or the separate watcher reporting capacity. Reserved bandwidth is a capacity allocation to be measured, not an assurance that observations are lossless under all traffic.

**R-19-05 — Bounded security workload.** Each deployment MUST specify finite per-source and aggregate processing, storage and transport budgets for the mesh. Admission MUST reject packages and reports outside the schema or size budget before expensive interpretation. Overload MUST produce protected loss or degradation evidence, and MUST NOT cause an otherwise passive observation path to exert hidden workload backpressure.

Health is represented as independent facts, not one green status bit. `NO_EVENT` means an admitted event class produced no observed records in a specified interval with stated coverage. `NO_DATA` means the required evidence did not arrive. `SENSOR_FAILED`, `TELEMETRY_PARTITIONED`, `OBSERVER_DISAGREES`, `POLICY_EXPIRED` and `RESPONSE_REJECTED` describe different conditions and can coexist. A silent bus under a valid coverage contract differs from a cut report cable. An expired policy differs from a successful response.

**R-19-06 — Honest degraded states.** LSM and MSM posture reports MUST distinguish no observed event from absent, stale, dropped or disputed evidence. Reports MUST include the affected interface, interval, epoch and consequence for each dependent claim. Aggregation MUST preserve these qualifications rather than converting partial coverage into a complete healthy posture.

**R-19-07 — Local continuity contract.** A profile MUST define which local functions continue during MSM, SAI, watcher or upstream loss, which new effects are denied, and which bounded standing responses remain valid. The policy MUST preserve required safety services and cannot acquire new authority because connectivity is lost. Reconnection MUST reconcile epochs, queued reports and installation state before renewing dependent claims.

For RP-A, loss of the common supply can remove compute, enforcement and observation together. The existence of separate oscillators and boards does not establish power-failure continuity. RP-B supports stronger compartmentalization where its independent appliance and infrastructure assumptions hold. Those are profile claims to validate, not interchangeable names for the same installation.

## Conformance and evidence

All tests below are specified experiments; passing results for a complete physical ASKA system have not been supplied. Each negative case needs a legitimate positive operation and a deliberately weakened fixture that demonstrates the oracle can detect the injected breach.

| Test | Stimulus | Required oracle |
|---|---|---|
| T-19-01 | Compromised compute attempts observer reset, debug access and key replacement | Manifest matches wiring; forbidden writes fail; any shared dependency is reported |
| T-19-02 | MSM sends a validly signed package for a different receiver or realm | Local admission rejects it without changing the active policy |
| T-19-03 | LSM sends a script or raw device command on its proposal interface | Bounded parser rejects it; no guard table or device state changes |
| T-19-04 | Replace LSM and MSM software with adversarial implementations in separate runs | Declared detection losses occur; unauthorized cross-boundary effects remain denied |
| T-19-05 | Flood events, intelligence and reports while running useful work | Measured quotas hold; loss is counted; reserved paths and declared service budgets remain observable |
| T-19-06 | Cut a sensor, delay a report, expire policy and inject disagreement | Distinct health facts survive aggregation and cannot be displayed as complete coverage |
| T-19-07 | Disconnect upstream and later reconnect across an epoch change | Only declared local functions continue; stale packages and grants cannot reactivate |

## Prior art and boundary of comparison

[Copilot, Petroni et al., USENIX Security 2004, §§4–6](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/) provides a concrete independent coprocessor monitor using DMA to inspect kernel memory. It is relevant evidence that external monitoring has implementable precedents; its access mechanism and threat model do not establish ASKA’s proposed passive sensors or complete workload visibility.

[RFC 9334, IETF, January 2023, §§3–4 and 7](https://www.rfc-editor.org/rfc/rfc9334.html) separates attestation evidence, appraisal and relying-party decisions. It is an Informational architecture, not proof that an attested mesh is uncompromised. ASKA uses the same essential distinction between evidence and a separately authorized effect, with the concrete authority rules owned by [chapter 06](06_authority_calculus_and_nonexpansion.md).

## None

### Four different acquisition mechanisms

An observer can be physically separate and still interact with the resource it examines. ASKA therefore classifies acquisition by what it does at the observed interface, not by whether its software calls the operation “read-only.” A DMA read creates a transaction, consumes bandwidth and may involve coherence. A debug read can halt a core or change architectural state. An instrumented export consumes implementation resources even when it is inaccessible to the workload. These distinctions affect both the security claim and the performance comparison.

| Acquisition class | Observable material | Interaction and required authority | Principal limits |
|---|---|---|---|
| Passive digital tap | Signals already traversing a named link | Receives copies; cannot initiate, acknowledge, block or reorder transactions | Only traffic crossing that point; loading, loss and decoding must be measured |
| Protected TE export | Guard decisions, owner transitions, counters and admitted metadata | Instrumentation emits a bounded record from a protected source | Depends on exporter implementation and event selection |
| Authorized active snapshot | Selected state copied at a defined consistency point | Acquisition owner reads, freezes or copies under a grant | Perturbs execution; state can change outside the snapshot interval |
| Read-only DMA acquisition | Accessible memory extents | Device initiates bounded reads through DG/MG | Active transactions, address interpretation and cache visibility |
| Analog or radiative sensing | Measured power, EM, optical, acoustic or thermal features | Sensor-specific physical coupling; active emitters separately admitted | Calibration, ambiguity, interference and limited semantic reconstruction |

**R-19-08 — Acquisition classification.** Every sensor and export path MUST declare its acquisition class, physical attachment, initiator privileges and possible effects on the observed resource. A path described as passive MUST have no ability to issue, modify, acknowledge, block, reorder or inject observed transactions. Active snapshots, DMA, debug access and emitting sensors MUST NOT be described as passive merely because their intended use is observation.

The interface inventory in [chapter 04](04_reference_machine_and_reachability.md) provides the RP-A and RP-B attachment points. It does not specify a fabricated RAM reconstruction device. The lab profile can begin with protected exports and instrumented interconnect taps while assigning weaker coverage to register-only, cache-resident and internal device activity.

### A coverage contract

A coverage contract says what can be concluded from a record and from the absence of a record. It identifies the observed interface, relevant operation classes, physical source mapping, acquisition frequency or trigger, encoding, retention, time accuracy, sampling policy and saturation behavior. It states whether the observer sees payloads, addresses, lengths, outcomes or only activity counts. It also identifies the component that could lie, disable acquisition or change interpretation.

**R-19-09 — Explicit observable set.** Each admitted sensor MUST provide a coverage contract defining observable events, unobservable state, consistency assumptions, time bounds, sampling and loss behavior. A detector MUST limit conclusions to that contract. Absence of an observed event MUST NOT imply absence of an attack outside the observable set or during a coverage gap.

For example, a tap before an egress gate sees attempted sends, while a tap after the gate sees admitted transmissions. Neither necessarily sees reception by the remote application. A storage command trace can show that an NVMe write or flush command was issued and acknowledged; the durable object owner’s commit protocol and the device’s persistence guarantees determine the corresponding finality claim. A device may lie about an internal state even while its external transcript remains correctly authenticated.

An observation map records these distinctions per claim:

| Claim under investigation | Minimum useful evidence | Residual ambiguity |
|---|---|---|
| A stale cell attempted DMA | Hardware-attached cell/device generation at DG decision | Internal malicious computation may have produced no DMA |
| A protected bank was written | MG-admitted transaction with physical extent and generation | Dirty cache state above the tap may not yet appear |
| A message was released | Last egress owner’s receipt and post-gate observation | Recipient acceptance and subsequent copying remain separate |
| A persistent version became durable | PO commit record plus required device completion evidence | Device firmware or media failure can invalidate a durability assumption |
| A rule became active | Receiver’s admitted configuration digest and activation epoch | Correctly installed rule can still be defective |

### Attribution and semantic reconstruction

Operating-system process names, virtual addresses and log strings are useful context but are not protected source identities. A hostile kernel can reuse a PID, alias an address or mislabel an event. TE records attach the physical owner and cell lifetime at the protected boundary before untrusted interpretation. Higher-level analysis can associate those records with software objects, but it preserves the provenance of that association.

**R-19-10 — Protected attribution.** Events used to enforce or evaluate a security contract MUST bind to the hardware-assigned owner, object or device generation and relevant cell epoch at acquisition. Software-provided names and translations MUST be separately marked claims. A later lookup MUST NOT silently reattribute an old observation to a newly allocated resource with the same address.

Passive inspection is especially limited when the data is encrypted before the tap, compressed internally, transformed by an accelerator, or held in a private cache. A bus trace may expose access patterns without content. That can be sufficient for some anomaly hypotheses and still insufficient to establish a value-level invariant. The same trace can disclose sensitive behavior, so observational usefulness and privacy cost must be assessed together.

A snapshot has a distinct contract. It can be a consistent copy made by a protected owner after quiescing writers, or a sequence of sampled reads that never represented one simultaneous state. The record states which. A “read-only” active acquisition that races revocation must not read the next tenant’s bank after ownership transfer.

**R-19-11 — Authorized active acquisition.** Active acquisition MUST use an installed observation grant specifying extents, generations, allowable interference, recipients, retention and a consistency method. Its owner MUST enforce lifecycle ordering, including revocation and reuse barriers. The resulting evidence MUST identify the acquisition interval and distinguish a coherent snapshot from a sequence of inconsistent samples.

### Saturation, caches and device internals

A passive tap cannot promise losslessness by stopping the observed machine whenever its buffer fills. Such a mechanism would be an inline flow-control participant and needs a different authority and availability analysis. ASKA allows admitted instrumentation to consume a bounded budget, but hidden backpressure contradicts a passive claim. Overflow must be visible at a protected source that a compromised LSM cannot rewrite.

**R-19-12 — Loss without hidden control.** Each observation path MUST specify finite buffers and a measurable overload policy. A passive path MUST not delay the observed transaction to conceal loss. Source sequence and drop accounting MUST identify the affected event classes and intervals, and an unavailable loss counter MUST itself invalidate claims of complete coverage.

There is no single “RAM observation” guarantee. The implementation must distinguish committed main-memory writes, dirty cache lines, speculative values, architectural registers and device-local memory. A protected memory guard can prevent an unauthorized transfer at its interface without seeing all computation that preceded it. A sensor may detect a transient change in an immutable region but fail to infer the malicious use of a legitimate mutable object. An accelerator can perform internal operations that no external bus tap exposes.

**R-19-13 — Memory and device fidelity.** A realization MUST document the relationship between each observation point and caches, coherence, writebacks, registers, speculative execution, storage buffers and device-local state. It MUST test representative transient and delayed operations. Storage or device acknowledgements MUST be interpreted under their stated semantics, never promoted automatically to durable or physical completion.

[Copilot, Petroni et al., 2004, §§4–6](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/) explicitly performs DMA and interprets host address structures. [Vigilare, Moon et al., ACM CCS 2012, §5.4](https://cysec.kr/publications/vigilare.pdf) discusses cache-hit and writeback visibility in its bus-snoop design. These implementations motivate specific observation tests; neither supplies a universal byte-level observer or an ASKA overhead measurement.

Device authentication is another separate layer. [DMTF SPDM 1.4.1, 26 June 2026, measurement capability fields](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf) distinguishes supported measurement and recomputation capabilities. A successful authenticated exchange must still be appraised against the component’s measurement scope. A report of firmware identity is not a complete transcript of what the firmware did.

### Physical sensing research boundary

Radiative RAM/SSD observation, auxiliary FeRAM/MRAM logs, micro-PUF bindings, environmental signatures and optical or other unconventional sensors are candidates, not baseline prerequisites. No demonstrated mechanism is assumed here to reconstruct arbitrary bytes from emissions, detect every access, avoid all loading, or operate at zero cost. An auxiliary memory can hold protected logs only if the path that writes it is trustworthy and its own lifecycle is enforced. Calling a record physically derived does not make its content correct.

A sensor campaign must identify the actual measured quantity, transfer function, calibration, spatial resolution, time resolution, noise distribution and attacker control. It must include known operations, adversarially selected operations, interference, temperature and supply variation, aged components, and a blind validation set. The report separates a useful correlation from the stronger claim that the observation uniquely identifies a security event.

Environmental broadcasts and physical signatures may help constrain a capture narrative, but signed receipt of a genuine signal can be relayed into a false scene. Chaotic processing does not establish cryptographic collision resistance without an appropriate construction and analysis. Quantum entanglement does not supply an authenticated alarm or recover arbitrary classical memory contents merely by being named. Active sonar and lidar emit into the environment and need their own device and privacy grants. [Chapter 40](40_witnesses_media_provenance_and_notice.md) owns the media implications.

### Test obligations

| Test | Experiment | Required oracle |
|---|---|---|
| T-19-08 | Inspect and stimulate every tap signal and active acquisition endpoint | No transaction generation or blocking on a passive path; active mechanisms correctly classified |
| T-19-09 | Execute visible and intentionally invisible operations, including quiet intervals and sensor removal | Conclusions match the declared observable set; gaps remain explicit |
| T-19-10 | Reuse a bank/address/device identifier after an epoch change while old events remain queued | Old records retain old ownership; untrusted aliases cannot replace it |
| T-19-11 | Race snapshot acquisition with revoke, writeback and reassignment | Only granted generations are acquired; consistency and interference are honestly reported |
| T-19-12 | Saturate acquisition and export while measuring observed transaction timing | Loss counters advance; no undeclared backpressure or false completeness |
| T-19-13 | Exercise cache-only changes, delayed writeback, device-local work, write/flush and power interruption | Each inferred property is supported at its actual finality or visibility boundary |
| T-19-14 | Compare a candidate sensor against independent ground truth under benign and hostile conditions | Published detection, false-alarm, latency, cost and blind-spot results support only the measured claim |

The acceptance result is a coverage dossier, not a generic “passive security” badge. It links each usable conclusion to an observed boundary, a protected source and the experiment capable of falsifying it.
