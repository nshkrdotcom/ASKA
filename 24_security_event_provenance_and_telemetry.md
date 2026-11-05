# ASKA v6 — Security event provenance and telemetry

**Status:** proposed event contract. Field semantics are normative targets; production encodings, counters and cryptographic vectors require implementation-specific validation.

## 1. Events are bounded evidence

An event says that a particular exporter reported an observation at a declared interface. Its evidential value depends on the exporter’s protection, its physical attachment, the event schema, its continuity state and the observer’s coverage contract. A signature cannot correct a sensor that measured the wrong signal or an exporter that attached the wrong owner. A trusted origin also does not make the report complete: a real event stream can contain sampling, intentional omission and overflow.

The Trusted Exporter (TE) is a protected function at a guard or owner boundary. Its identity and event attachment are outside the observed workload’s writable authority. An LSM can sign its analysis of TE records, but that signature identifies the LSM’s derived product. It does not replace the TE’s provenance. Watchers compare the specific independent inputs described in [chapter 22](22_independent_watchers_and_meta_monitoring.md).

## 2. Canonical security event

**R-24-01 — Typed event integrity.** A security event MUST carry the fields below under a registered schema and a type-specific authenticated encoding. Verification MUST reject duplicate fields, ambiguous encodings, unsupported critical fields, invalid references and an unknown semantic version. The protected signing context MUST bind the complete event, including its observation scope, loss accounting and label; a valid signature alone MUST NOT establish authorization for a consequent effect.

| Field | Required meaning |
|---|---|
| `event_id` | Globally unambiguous record identity within the exporter’s declared identity scheme; never reused for a different event |
| `exporter_ref` | Protected exporter identity and generation, with an independently resolvable installation/measurement record |
| `boot_epoch` | Protected exporter boot lifetime; restarting cannot silently resume a reused sequence namespace |
| `sequence` | Monotonic event position within the declared exporter stream and boot epoch |
| `observed_interface` | Concrete interface identifier from the realization manifest, including the observation point |
| `event_type` | Registered event semantics, such as an attempted operation, admitted transition, health fault or coverage change |
| `object_ref` | `(realm_id, owner_id, object_id, generation)` when applicable; explicit null only where the schema permits it |
| `grant_ref` | Grant identity and epoch associated with the observed operation, or a typed reason that no grant applies |
| `policy_epoch` | Policy under which the generating guard/exporter interpreted the operation |
| `time_interval` | Earliest/latest supported observation time, clock identity, uncertainty and time-quality status |
| `label` | Confidentiality and integrity labels under chapter 07, including purpose and retention restrictions |
| `payload_digest` | Algorithm-qualified digest of the exact separately retained payload or explicit empty-payload representation |
| `sample_policy` | Identifier and parameters of the active collection, selection and aggregation policy |
| `drop_count/range` | Count and known sequence ranges of lost observations, with explicit unknown extent when exact counting failed |
| `previous_digest` | Prior authenticated stream record or checkpoint commitment, with an explicit start/discontinuity marker |
| `signature` | Authenticator, algorithm suite and key reference covering the complete typed record |

`drop_count/range` denotes the logical loss structure; an encoding profile specifies its exact member names and representations. A cell event additionally binds `cell_id` and `cell_epoch`; device events bind their protected device lifetime. These are registered type-specific fields, not free text. The common Accord envelope in [chapter 32](32_claim_contract_grant_receipt_schemas.md) carries an event when it is used as evidence in a claim, proposal or release. Shared identifiers and epochs must agree; an outer envelope cannot relabel an inner record or silently change its audience.

This table defines semantics, not fabricated wire bytes. A deployable profile must fix integer widths, maximum sizes, allowed nulls, deterministic encoding, supported digest and signature suites, critical-field handling and overflow behavior. Canonical fixtures and negative vectors belong in [chapter 56](56_conformance_tests_and_vectors.md).

## 3. Source identity, ordering and time

**R-24-02 — Protected stream continuity.** TE identity, boot epoch and sequence state MUST be protected from the observed workload and bound at event generation. A restart, counter wrap, rollback or loss of continuity state MUST create an explicit discontinuity and a fresh permitted namespace before records can support current decisions. Consumers MUST retain per-origin replay state and MUST NOT accept a reused identity/sequence for changed content.

A hash chain supports detection of alteration and certain gaps relative to a retained checkpoint. It cannot prove that an exporter recorded an event it never encoded. If the exporter suppresses the whole tail and no independent endpoint knows the last position, a chain alone does not reveal how much is missing. Independent watcher counters, receiver checkpoints and periodic bounded health records can reduce that uncertainty, subject to their own failure domains.

The event order is local to its origin. Comparing records from two components requires an explicit temporal or causal relation: a copied digest, a request/response identifier, an owner transition counter, or time intervals with stated uncertainty. The documentation does not infer a universal total order merely because every record has a timestamp.

**R-24-03 — Freshness without invented precision.** Each event MUST identify its time source, supported uncertainty interval and freshness basis. Consumers MUST distinguish observation time from signing, transmission and reception time. Untrusted wall clocks, delayed signatures and replayed nonces MUST NOT be used to claim current state. Cross-source ordering MUST remain uncertain where the available intervals and causal bindings do not establish it.

[RFC 9334, IETF, January 2023, §10](https://www.rfc-editor.org/rfc/rfc9334.html) distinguishes clock-, nonce- and epoch-based freshness and warns that values can predate their signature. ASKA consequently evaluates the age of the underlying observation, rather than equating a recent signature with a recent measurement.

## 4. Completeness, sampling and ingestion

**R-24-04 — Visible collection loss.** Exporters and receiving stages MUST account for intentional sampling, rejected records, queue overflow, transport loss and unavailable accounting state separately. A coverage change MUST identify its activation interval and policy. A consumer MUST not interpret a sequence gap, sampled stream or exhausted counter as evidence that no security-relevant operation occurred.

Sampling selects what the detector is allowed to know. Uniform sampling, event-triggered capture and aggregation have different missed-event risks. An event type declared mandatory for a grant cannot quietly become sampled when load rises. A profile may instead suspend the dependent claim, deny a new operation or execute a previously admitted degradation response. The decision is explicit and its costs are measured.

A report can summarize ten thousand events, but the summary must identify the source ranges, transformations and discarded detail. Summaries are not ten thousand independently verified facts. A detector trained on aggregates must not treat a missing field as a benign value. “Unknown” remains a valid result at every transformation stage.

**R-24-05 — Bounded authenticated ingestion.** Each receiver MUST apply structural and resource limits before expensive interpretation, validate the origin and generation, verify record integrity and replay state, and preserve the disposition of rejected input. A maliciously signed record MUST not gain parser, code-loading or policy authority. Reordering and duplicate handling MUST be deterministic within the profile’s finite receive window.

A receiver should quarantine suspect bytes as an object under its own retention policy, rather than execute embedded format handlers. Error handling must avoid disclosing secrets by echoing payloads, stack traces or private identifiers. Failure to store a rejected record is itself a possible evidence gap; the implementation can retain a bounded digest and rejection count without pretending to preserve content it discarded.

## 5. Labels, attestation and forwarding

**R-24-06 — Evidence labels and qualified attestation.** Telemetry MUST retain its confidentiality and integrity labels across forwarding and derivation. Release requires independent source authority and receiver acceptance. Attestation MUST identify the component, measurement scope, reference values, verifier policy and freshness; its result MUST remain evidence and MUST NOT imply that every event is true, every operation was observed or a new effect is authorized.

A TE measurement may support confidence that an approved exporter image booted on a named component. It does not establish that the component remains free of runtime faults. [DMTF SPDM 1.4.1, 26 June 2026](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf) supplies device measurement and authentication mechanisms with negotiated capabilities; the relying deployment must still appraise their scope. An LSM report about a Sanctum file remains Sanctum-derived information even when the report contains only an access pattern or digest.

Forwarding creates another evidence layer. A relay signs its receipt or transformation, preserves the original record or its resolvable commitment, and identifies what it changed. It cannot replace a protected interface identity with its own assertion that the event happened elsewhere. Cross-realm sharing uses [chapter 29’s observation and release rules](29_monitoring_privacy_and_observation_authority.md).

## 6. Events, receipts and reconciliation

An event and a receipt answer different questions. A pre-gate event can establish an attempted operation. A protected owner receipt establishes its declared finality point. A later sensor may observe a physical consequence. Each can be authentic while the others are unavailable or disagree. The reconciler preserves all three rather than flattening them into a single successful transaction.

**R-24-07 — Finality-aware correlation.** Telemetry correlated with an effect MUST retain the effect identifier, owner epoch, finality point and evidence references of the authoritative receipt. A committed receipt MUST remain committed at that established finality point. Unresolved external or physical outcomes MUST be separately scoped; when finality itself cannot be established after an attempt, the effect MUST remain `UNCERTAIN` until evidence supports reconciliation.

For example, EO records that a valve command was accepted by its device interface. That receipt can remain `COMMITTED` while the valve-position sensor fails and the physical movement remains unknown. Reissuing the command as if no effect occurred may be unsafe. The Promise Keeper workflow in [chapter 28](28_aesds_iama_and_autonomous_evolution.md) uses evidence to investigate and propose authorized correction; it cannot erase the old receipt or reverse an irreversible physical effect.

## 7. Test obligations

| Test | Stimulus | Required oracle |
|---|---|---|
| T-24-01 | Duplicate a critical field, alter labels, change event type or use an unknown critical extension | Verification rejects before interpretation; no ambiguous accepted record |
| T-24-02 | Replay records, roll back counter storage, reuse boot identity and force width exhaustion | Discontinuity or rejection occurs; changed content cannot reuse a valid sequence identity |
| T-24-03 | Delay collection, sign old state with a new nonce, skew clocks and overlap intervals | The age and ordering of the underlying observations remain qualified |
| T-24-04 | Sample, overflow, drop transport frames and disable a loss counter | Consumer reports the correct loss class and withdraws unsupported completeness |
| T-24-05 | Supply maliciously signed oversized, nested, duplicate and reordered records | Finite parsing and replay policy hold; no code or policy authority is obtained |
| T-24-06 | Forward private telemetry and a valid but insufficient attestation | Labels persist; unauthorized disclosure and overbroad appraisal are rejected |
| T-24-07 | Lose a physical acknowledgement after a durable command-acceptance receipt | Local committed finality remains intact; physical outcome is separately uncertain and reconciled later |

The event service is accountable for provenance and stated coverage. The finality owner is accountable for its receipt. Neither role can silently take over the other’s claim.
