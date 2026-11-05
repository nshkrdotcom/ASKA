# ASKA v6 — Master and local security meshes

## 1. Security outside the execution domain

ASKA places its local security analysis outside the authority of the workload being observed. A compromised application, kernel, driver or UAI cell should not be able to stop the observation hardware, replace its policy or forge the protected source identity of its events. This is a relative claim: independence from a compute module does not imply independence from a shared power supply, boundary controller, manufacturing defect or installation custodian. The declaration of those dependencies is part of the claim.

The Master Security Mesh (MSM) distributes admitted configuration and correlates permitted reports. A Local Security Mesh (LSM) observes one declared scope and produces findings and protective proposals. Neither component acquires an unrestricted management role. A memory guard still decides whether a memory operation is permitted; an egress guard still decides whether information may leave; an effect owner still decides whether a response may become final. Observation may reveal a bypass or loss of confidence, but it cannot make a compromised enforcement boundary sound by assertion.

The reference wiring is owned by [chapter 04](04_reference_machine_and_reachability.md). RP-A contains LS-S, LS-P, LS-A, LS-W and LS-T, with separate WM-L watchers, one MSM, WM-M and the independent oversight receiver OV. LS-T covers authorized exports from trusted services; it is not another application plane. Keystone and Steles remain distinct. A Steles commitment can preserve evidence about a security event without becoming the watcher that discovered it.

**R-20-01 — Declared physical independence.** Each mesh deployment MUST identify its observed components, separate processing and writable storage, boot and installation roots, reset/debug reachability, clocks, power and reporting paths. It MUST claim independence only against adversaries unable to control those dependencies. The implementation manifest MUST instantiate chapter 04’s interfaces rather than substitute logical process separation for a claimed physical boundary.

## 2. Division of responsibility

| Component | Information it may consume | Permitted product | Boundary it cannot cross by itself |
|---|---|---|---|
| TE | Authorized guard and owner events | Source-bound event records and loss accounting | Changing the event-generating operation |
| LSM | Its TE streams, admitted sensors, bounded rule packages | Local posture, incident hypothesis, response proposal | Installing grants, reading arbitrary banks or writing devices |
| MSM | Separate LSM reports and approved intelligence | Correlation and addressed distribution packages | Overriding a local receiver or claiming another realm’s rights |
| WM-L | Independent local observation and LSM health evidence | Watcher report to OV | Repairing or reprogramming the LSM directly |
| WM-M | Independent MSM distribution and health evidence | Master-watcher report to OV | Becoming a second universal distributor |
| SAI | Released evidence in a bounded analysis domain | Ranked hypotheses and proposals | Signing updates or exercising a raw device command |
| OV | Authenticated watcher reports | Qualified oversight findings | Writing arbitrary guard state |

**R-20-02 — Hierarchy without inherited privilege.** MSM membership, report receipt and a high DTMS reputation MUST NOT create authority over an LSM, its monitored resources or another realm. Distribution MUST be addressed to a receiver and package class accepted by a live local policy. Each LSM MUST retain its own admission decision and disclose which dependencies are shared with the MSM.

An LSM can perform deterministic checks without an AI model: missing sequence ranges, stale policy epochs, forbidden transaction attempts and exceeded queue budgets are examples. More complex inference runs within bounded cells. The distinction avoids making ordinary guard operation dependent on a model service, a remote threat feed or a central correlation queue. A deployment may require fresh observation for a particular high-consequence contract, but that is an explicit admission condition with a defined degraded result.

**R-20-03 — Observation, proposal and enforcement separation.** Mesh outputs MUST use the event and proposal interfaces defined in [chapters 24](24_security_event_provenance_and_telemetry.md) and [26](26_protective_response_and_containment.md). A mesh or SAI process MUST NOT possess a general guard-table writer, arbitrary code loader, raw DMA master or unrestricted actuator interface merely because it performs security work. Protective effects MUST be admitted by their protected owner.

## 3. Normal operation and feedback

At deployment, the local owner admits a coverage contract, export schema, receiving policy, event budget and response standing grants. Boot establishes the relevant identities and epochs. TE emits the approved event classes; the LSM verifies provenance and accounts for gaps before interpreting their meaning. A finding references the evidence and the scope of inference. It can be reported upstream, proposed to a local effect owner, retained locally, or some combination permitted by the disclosure policy.

MSM-to-LSM configuration travels over the dedicated directional interface. LSM-to-MSM reporting uses a different interface. A request for a new rule may therefore return in a report and influence later engineering work, but the report is never an installation command. Any resulting package passes the producer, reviewer, signer and receiver controls of [chapter 27](27_software_update_and_supply_chain_safety.md). This is a feedback loop of typed records and admitted effects, with no assumption that the complete system graph is acyclic.

The mesh may help reconcile a promised operation. It can show that an owner emitted a receipt, that a device command crossed an observed interface, or that an expected event was missing. It does not substitute for the finality owner. The reconciliation procedure in [Chapter 17](17_transactions_effects_and_reconciliation.md) compares those observations with durable state and records unresolved disagreement.

## 4. Compromised security components

A malicious LSM may conceal a suspicious pattern, emit a false alarm or exploit its permitted report bandwidth. Its watcher can compare independently acquired source counts with claimed ingestion, observe configuration changes and detect some forms of silence. The watcher cannot infer all unreported semantics. The contained outcome is therefore narrower than “compromise detected”: the LSM remains unable to write another bank, invent a valid owner receipt or exceed an installed protective grant; its detection reliability may be lost.

A malicious MSM may send obsolete, malformed or maliciously chosen signed content, withhold updates or attempt to install the same bad rule everywhere. Local admission, package typing and rollout cohorts limit that influence. A compromised MSM reporting service cannot be allowed to reconfigure its own WM-M. If a common signer authorizes both MSM and every watcher image, that signer is a common failure dependency even if all processors sit on separate boards.

**R-20-04 — Explicit mesh compromise case.** The threat model and conformance campaign MUST separately grant the attacker full software control of an LSM and the MSM. For each case, they MUST identify lost detection capabilities and verify the remaining owner, receiver, watcher and installation boundaries. Detection of the compromise itself MUST NOT be assumed as the prerequisite for preserving those boundaries.

A compromised watcher is tested independently in [chapter 22](22_independent_watchers_and_meta_monitoring.md). A compromised SAI may deliberately request plausible but harmful containment; its limited proposal privilege does not make those proposals safe. Authorized abuse is possible within a standing grant, which is why response duration, service impact and cumulative quotas belong in the grant rather than only in the model’s recommendation.

## 5. Resource budgets and degraded operation

Security traffic consumes real resources. A profile allocates TE buffers, local analysis memory, report queues, model execution time, cryptographic verification capacity and retained evidence storage. Saturating one LSM must not consume every MSM parser slot or the separate watcher reporting capacity. Reserved bandwidth is a capacity allocation to be measured, not an assurance that observations are lossless under all traffic.

**R-20-05 — Bounded security workload.** Each deployment MUST specify finite per-source and aggregate processing, storage and transport budgets for the mesh. Admission MUST reject packages and reports outside the schema or size budget before expensive interpretation. Overload MUST produce protected loss or degradation evidence, and MUST NOT cause an otherwise passive observation path to exert hidden workload backpressure.

Health is represented as independent facts, not one green status bit. `NO_EVENT` means an admitted event class produced no observed records in a specified interval with stated coverage. `NO_DATA` means the required evidence did not arrive. `SENSOR_FAILED`, `TELEMETRY_PARTITIONED`, `OBSERVER_DISAGREES`, `POLICY_EXPIRED` and `RESPONSE_REJECTED` describe different conditions and can coexist. A silent bus under a valid coverage contract differs from a cut report cable. An expired policy differs from a successful response.

**R-20-06 — Honest degraded states.** LSM and MSM posture reports MUST distinguish no observed event from absent, stale, dropped or disputed evidence. Reports MUST include the affected interface, interval, epoch and consequence for each dependent claim. Aggregation MUST preserve these qualifications rather than converting partial coverage into a complete healthy posture.

**R-20-07 — Local continuity contract.** A profile MUST define which local functions continue during MSM, SAI, watcher or upstream loss, which new effects are denied, and which bounded standing responses remain valid. The policy MUST preserve required safety services and cannot acquire new authority because connectivity is lost. Reconnection MUST reconcile epochs, queued reports and installation state before renewing dependent claims.

For RP-A, loss of the common supply can remove compute, enforcement and observation together. The existence of separate oscillators and boards does not establish power-failure continuity. RP-B supports stronger compartmentalization where its independent appliance and infrastructure assumptions hold. Those are profile claims to validate, not interchangeable names for the same installation.

## 6. Conformance and evidence

All tests below are specified experiments; passing results for a complete physical ASKA system have not been supplied. Each negative case needs a legitimate positive operation and a deliberately weakened fixture that demonstrates the oracle can detect the injected breach.

| Test | Stimulus | Required oracle |
|---|---|---|
| T-20-01 | Compromised compute attempts observer reset, debug access and key replacement | Manifest matches wiring; forbidden writes fail; any shared dependency is reported |
| T-20-02 | MSM sends a validly signed package for a different receiver or realm | Local admission rejects it without changing the active policy |
| T-20-03 | LSM sends a script or raw device command on its proposal interface | Bounded parser rejects it; no guard table or device state changes |
| T-20-04 | Replace LSM and MSM software with adversarial implementations in separate runs | Declared detection losses occur; unauthorized cross-boundary effects remain denied |
| T-20-05 | Flood events, intelligence and reports while running useful work | Measured quotas hold; loss is counted; reserved paths and declared service budgets remain observable |
| T-20-06 | Cut a sensor, delay a report, expire policy and inject disagreement | Distinct health facts survive aggregation and cannot be displayed as complete coverage |
| T-20-07 | Disconnect upstream and later reconnect across an epoch change | Only declared local functions continue; stale packages and grants cannot reactivate |

## 7. Prior art and boundary of comparison

[Copilot, Petroni et al., USENIX Security 2004, §§4–6](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/) provides a concrete independent coprocessor monitor using DMA to inspect kernel memory. It is relevant evidence that external monitoring has implementable precedents; its access mechanism and threat model do not establish ASKA’s proposed passive sensors or complete workload visibility.

[RFC 9334, IETF, January 2023, §§3–4 and 7](https://www.rfc-editor.org/rfc/rfc9334.html) separates attestation evidence, appraisal and relying-party decisions. It is an Informational architecture, not proof that an attested mesh is uncompromised. ASKA uses the same essential distinction between evidence and a separately authorized effect, with the concrete authority rules owned by [chapter 06](06_authority_calculus_and_nonexpansion.md).
