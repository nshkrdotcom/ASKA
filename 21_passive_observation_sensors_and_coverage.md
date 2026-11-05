# ASKA v6 — Passive observation, sensors and coverage

## 1. Four different acquisition mechanisms

An observer can be physically separate and still interact with the resource it examines. ASKA therefore classifies acquisition by what it does at the observed interface, not by whether its software calls the operation “read-only.” A DMA read creates a transaction, consumes bandwidth and may involve coherence. A debug read can halt a core or change architectural state. An instrumented export consumes implementation resources even when it is inaccessible to the workload. These distinctions affect both the security claim and the performance comparison.

| Acquisition class | Observable material | Interaction and required authority | Principal limits |
|---|---|---|---|
| Passive digital tap | Signals already traversing a named link | Receives copies; cannot initiate, acknowledge, block or reorder transactions | Only traffic crossing that point; loading, loss and decoding must be measured |
| Protected TE export | Guard decisions, owner transitions, counters and admitted metadata | Instrumentation emits a bounded record from a protected source | Depends on exporter implementation and event selection |
| Authorized active snapshot | Selected state copied at a defined consistency point | Acquisition owner reads, freezes or copies under a grant | Perturbs execution; state can change outside the snapshot interval |
| Read-only DMA acquisition | Accessible memory extents | Device initiates bounded reads through DG/MG | Active transactions, address interpretation and cache visibility |
| Analog or radiative sensing | Measured power, EM, optical, acoustic or thermal features | Sensor-specific physical coupling; active emitters separately admitted | Calibration, ambiguity, interference and limited semantic reconstruction |

**R-21-01 — Acquisition classification.** Every sensor and export path MUST declare its acquisition class, physical attachment, initiator privileges and possible effects on the observed resource. A path described as passive MUST have no ability to issue, modify, acknowledge, block, reorder or inject observed transactions. Active snapshots, DMA, debug access and emitting sensors MUST NOT be described as passive merely because their intended use is observation.

The interface inventory in [chapter 04](04_reference_machine_and_reachability.md) provides the RP-A and RP-B attachment points. It does not specify a fabricated RAM reconstruction device. The lab profile can begin with protected exports and instrumented interconnect taps while assigning weaker coverage to register-only, cache-resident and internal device activity.

## 2. A coverage contract

A coverage contract says what can be concluded from a record and from the absence of a record. It identifies the observed interface, relevant operation classes, physical source mapping, acquisition frequency or trigger, encoding, retention, time accuracy, sampling policy and saturation behavior. It states whether the observer sees payloads, addresses, lengths, outcomes or only activity counts. It also identifies the component that could lie, disable acquisition or change interpretation.

**R-21-02 — Explicit observable set.** Each admitted sensor MUST provide a coverage contract defining observable events, unobservable state, consistency assumptions, time bounds, sampling and loss behavior. A detector MUST limit conclusions to that contract. Absence of an observed event MUST NOT imply absence of an attack outside the observable set or during a coverage gap.

For example, a tap before an egress gate sees attempted sends, while a tap after the gate sees admitted transmissions. Neither necessarily sees reception by the remote application. A storage command trace can show that an NVMe write or flush command was issued and acknowledged; the durable object owner’s commit protocol and the device’s persistence guarantees determine the corresponding finality claim. A device may lie about an internal state even while its external transcript remains correctly authenticated.

An observation map records these distinctions per claim:

| Claim under investigation | Minimum useful evidence | Residual ambiguity |
|---|---|---|
| A stale cell attempted DMA | Hardware-attached cell/device generation at DG decision | Internal malicious computation may have produced no DMA |
| A protected bank was written | MG-admitted transaction with physical extent and generation | Dirty cache state above the tap may not yet appear |
| A message was released | Last egress owner’s receipt and post-gate observation | Recipient acceptance and subsequent copying remain separate |
| A persistent version became durable | PO commit record plus required device completion evidence | Device firmware or media failure can invalidate a durability assumption |
| A rule became active | Receiver’s admitted configuration digest and activation epoch | Correctly installed rule can still be defective |

## 3. Attribution and semantic reconstruction

Operating-system process names, virtual addresses and log strings are useful context but are not protected source identities. A hostile kernel can reuse a PID, alias an address or mislabel an event. TE records attach the physical owner and cell lifetime at the protected boundary before untrusted interpretation. Higher-level analysis can associate those records with software objects, but it preserves the provenance of that association.

**R-21-03 — Protected attribution.** Events used to enforce or evaluate a security contract MUST bind to the hardware-assigned owner, object or device generation and relevant cell epoch at acquisition. Software-provided names and translations MUST be separately marked claims. A later lookup MUST NOT silently reattribute an old observation to a newly allocated resource with the same address.

Passive inspection is especially limited when the data is encrypted before the tap, compressed internally, transformed by an accelerator, or held in a private cache. A bus trace may expose access patterns without content. That can be sufficient for some anomaly hypotheses and still insufficient to establish a value-level invariant. The same trace can disclose sensitive behavior, so observational usefulness and privacy cost must be assessed together.

A snapshot has a distinct contract. It can be a consistent copy made by a protected owner after quiescing writers, or a sequence of sampled reads that never represented one simultaneous state. The record states which. A “read-only” active acquisition that races revocation must not read the next tenant’s bank after ownership transfer.

**R-21-04 — Authorized active acquisition.** Active acquisition MUST use an installed observation grant specifying extents, generations, allowable interference, recipients, retention and a consistency method. Its owner MUST enforce lifecycle ordering, including revocation and reuse barriers. The resulting evidence MUST identify the acquisition interval and distinguish a coherent snapshot from a sequence of inconsistent samples.

## 4. Saturation, caches and device internals

A passive tap cannot promise losslessness by stopping the observed machine whenever its buffer fills. Such a mechanism would be an inline flow-control participant and needs a different authority and availability analysis. ASKA allows admitted instrumentation to consume a bounded budget, but hidden backpressure contradicts a passive claim. Overflow must be visible at a protected source that a compromised LSM cannot rewrite.

**R-21-05 — Loss without hidden control.** Each observation path MUST specify finite buffers and a measurable overload policy. A passive path MUST not delay the observed transaction to conceal loss. Source sequence and drop accounting MUST identify the affected event classes and intervals, and an unavailable loss counter MUST itself invalidate claims of complete coverage.

There is no single “RAM observation” guarantee. The implementation must distinguish committed main-memory writes, dirty cache lines, speculative values, architectural registers and device-local memory. A protected memory guard can prevent an unauthorized transfer at its interface without seeing all computation that preceded it. A sensor may detect a transient change in an immutable region but fail to infer the malicious use of a legitimate mutable object. An accelerator can perform internal operations that no external bus tap exposes.

**R-21-06 — Memory and device fidelity.** A realization MUST document the relationship between each observation point and caches, coherence, writebacks, registers, speculative execution, storage buffers and device-local state. It MUST test representative transient and delayed operations. Storage or device acknowledgements MUST be interpreted under their stated semantics, never promoted automatically to durable or physical completion.

[Copilot, Petroni et al., 2004, §§4–6](https://www.usenix.org/legacy/events/sec04/tech/full_papers/petroni/petroni_html/) explicitly performs DMA and interprets host address structures. [Vigilare, Moon et al., ACM CCS 2012, §5.4](https://cysec.kr/publications/vigilare.pdf) discusses cache-hit and writeback visibility in its bus-snoop design. These implementations motivate specific observation tests; neither supplies a universal byte-level observer or an ASKA overhead measurement.

Device authentication is another separate layer. [DMTF SPDM 1.4.1, 26 June 2026, measurement capability fields](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf) distinguishes supported measurement and recomputation capabilities. A successful authenticated exchange must still be appraised against the component’s measurement scope. A report of firmware identity is not a complete transcript of what the firmware did.

## 5. Physical sensing research boundary

Radiative RAM/SSD observation, auxiliary FeRAM/MRAM logs, micro-PUF bindings, environmental signatures and optical or other unconventional sensors are candidates, not baseline prerequisites. No demonstrated mechanism is assumed here to reconstruct arbitrary bytes from emissions, detect every access, avoid all loading, or operate at zero cost. An auxiliary memory can hold protected logs only if the path that writes it is trustworthy and its own lifecycle is enforced. Calling a record physically derived does not make its content correct.

A sensor campaign must identify the actual measured quantity, transfer function, calibration, spatial resolution, time resolution, noise distribution and attacker control. It must include known operations, adversarially selected operations, interference, temperature and supply variation, aged components, and a blind validation set. The report separates a useful correlation from the stronger claim that the observation uniquely identifies a security event.

Environmental broadcasts and physical signatures may help constrain a capture narrative, but signed receipt of a genuine signal can be relayed into a false scene. Chaotic processing does not establish cryptographic collision resistance without an appropriate construction and analysis. Quantum entanglement does not supply an authenticated alarm or recover arbitrary classical memory contents merely by being named. Active sonar and lidar emit into the environment and need their own device and privacy grants. [Chapter 48](48_media_provenance_and_physical_evidence.md) owns the media implications.

**R-21-07 — Measured admission of sensing claims.** A sensor-dependent assurance claim MUST be supported by a reproducible experiment with a stated adversary, independent ground truth, calibration, negative controls, measured interference and resource costs. Its claim MUST be withdrawn or narrowed when the experiment fails. Undisclosed or speculative mechanisms MUST remain research hypotheses and MUST NOT be required for baseline conformance.

## 6. Test obligations

| Test | Experiment | Required oracle |
|---|---|---|
| T-21-01 | Inspect and stimulate every tap signal and active acquisition endpoint | No transaction generation or blocking on a passive path; active mechanisms correctly classified |
| T-21-02 | Execute visible and intentionally invisible operations, including quiet intervals and sensor removal | Conclusions match the declared observable set; gaps remain explicit |
| T-21-03 | Reuse a bank/address/device identifier after an epoch change while old events remain queued | Old records retain old ownership; untrusted aliases cannot replace it |
| T-21-04 | Race snapshot acquisition with revoke, writeback and reassignment | Only granted generations are acquired; consistency and interference are honestly reported |
| T-21-05 | Saturate acquisition and export while measuring observed transaction timing | Loss counters advance; no undeclared backpressure or false completeness |
| T-21-06 | Exercise cache-only changes, delayed writeback, device-local work, write/flush and power interruption | Each inferred property is supported at its actual finality or visibility boundary |
| T-21-07 | Compare a candidate sensor against independent ground truth under benign and hostile conditions | Published detection, false-alarm, latency, cost and blind-spot results support only the measured claim |

The acceptance result is a coverage dossier, not a generic “passive security” badge. It links each usable conclusion to an observed boundary, a protected source and the experiment capable of falsifying it.
