# ASKA v6 — Security fabrics, one-way links and event provenance

## Direction belongs to an interface

A physical data diode constrains propagation across a named interface. It does not make the forward payload safe, authenticate the sender, determine whether a receiver should install the payload, or prevent another cable from carrying a return signal. ASKA uses directional configuration distribution as one part of a larger graph containing reporting, watcher evidence, local proposals, installation and maintenance. Each edge has a different permitted meaning.

The [UK NCSC’s secure-connectivity Principle 5, data-diode section](https://www.ncsc.gov.uk/collection/operational-technology/secure-connectivity/principle-5) cautions against treating two opposing diodes with trusted-side software orchestration as a complete cross-domain solution. ASKA deliberately permits reporting feedback, so its directionality claim applies separately to each specified physical interface. The configuration/reporting pair does not establish an air gap or a complete cross-domain solution. Bounded parsing, receiver admission, disclosure policy and analysis of feedback cycles remain separate obligations. This comparison uses the guidance available on 5 November 2026.

In the reference profiles, the MSM distributes configuration to each LSM on a dedicated simplex path. LSM reporting uses a separate simplex path toward the MSM. WM-L and WM-M report to OV independently of the monitored component. The local LSM proposal edge terminates at an effect owner that validates the standing grant; it is not a general-purpose management connection.

**R-21-01 — Physical directional contract.** Any interface claimed as unidirectional MUST identify its transmitting and receiving hardware, medium, electrical or optical direction, endpoint circuitry and inspection boundary. Reverse application traffic, acknowledgement, flow control, link management, reset, debug and power signalling MUST be absent at that boundary or explicitly represented as separate interfaces with separately assessed authority. A software rule on a duplex link MUST NOT be labelled a physical diode.

The cataloged [NIST AC-4(7) one-way-flow control](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) predates this reference wiring. An optical, electrical or serial simplex edge establishes direction at the measured interface; receiver acceptance, content validation and the absence of bypass wiring are separate claims.

## The canonical reference interfaces

[Chapter 04](04_reference_machine_and_reachability.md) owns the complete inventory and expansion of interfaces I01–I22. The following mapping explains the security meaning of a subset; it does not replace that inventory.

| Interface | Direction and subject | Receiver obligation | What receipt means |
|---|---|---|---|
| I06-p | TE-p to LS-p event stream | Provenance, scope, sequence and loss checks | An event was accepted for analysis |
| I07-t | MSM to LS-t configuration | Local package and authority admission | Bytes arrived; installation remains a separate decision |
| I08-t | LS-t to MSM report | Bounded report parsing and disclosure checks | Report accepted within its stated evidence limits |
| I09-t | LS-t to EO-t proposal | Exact template, target and standing-grant predicate | A proposal was received, not necessarily committed |
| I10-t / I11 | Independent source/configuration taps to watchers | Coverage-aware interpretation | A measured oversight fact within a declared scope |
| I12-t / I13 | Watchers to OV | Origin, freshness, replay and receiving policy | Oversight evidence arrived, not automatic remediation |

For RP-A, I07 comprises five configuration simplex links, I08 five reporting simplex links, and I12/I13 six watcher simplex links: sixteen security simplex links with thirty-two corresponding endpoints. The six local exporter paths, including TE-E, six proposal paths, including the path to EO-E, and six watcher tap bundles are additional. RP-A’s purpose/witness subtotal is five duplex interfaces; its dedicated J-E encounter interface brings the total to six. RP-B’s purpose/witness subtotal is ten duplex interfaces; J-E brings its total to eleven. Chapter 04 defines the complete inventories and separately bounded E inputs. None of these counts follows merely from the names Sanctum, Polis, Agora, Wilder and Steles.

## Receiver admission on the configuration diode

Forward direction is particularly important when the distributor is compromised. A malicious MSM can send bytes that exploit a parser, consume memory, activate an expensive model or attempt to change the local installation root. A cryptographic signature may be valid because an authorized producer is malicious. The receiving LSM must therefore separate transfer, quarantine, validation and activation.

A receiver first applies length, type, encoding and resource bounds. It verifies the digest and signed manifest against the permitted package class, target identity, interface compatibility, epoch, expiry and local installation policy. It checks the independent review and rollout conditions required by [chapter 24](24_software_update_generation_and_supply_chain.md). The content is staged outside active state. Activation is an owner transition with a durable receipt and a known recovery path; it is not an implicit consequence of successful transport.

**R-21-02 — Local configuration admission.** An I07 receiver MUST treat every distributed payload as untrusted until local validation succeeds. It MUST verify target, type, bounds, signature scope, version and policy conditions, then admit activation through its protected installer. A valid MSM or producer signature MUST NOT override receiver policy, widen roots, bypass package typing or authorize an unbounded interpreter.

An offline receiver cannot ask for missing bytes on the same diode. A realization may use bounded repetition, erasure coding or a separate request record on I08. The latter does not create a hidden return channel on I07, but it does create a feedback dependency that the graph must show. Duplicate packages are idempotently identified by content and update transaction identifiers. An incomplete transfer is unavailable content, never partially executable policy.

[TUF specification 1.0.36, 5 August 2026, §5](https://theupdateframework.github.io/specification/v1.0.36/) gives a reviewed example of bounded metadata verification with expiry and version checks. It neither installs application files nor establishes their semantic safety. ASKA’s receiver admission additionally binds the accepted artifact to local authority and activation state.

## Reports, proposals and feedback

**R-21-03 — Separate reporting path.** Reports returning from an LSM MUST use the separately inventoried reporting interface and an independently admitted report schema. A report MUST preserve source-release restrictions and the MSM’s receiving policy. Report requests, acknowledgements and errors MUST NOT be interpreted as configuration activation, code execution, grant installation or root replacement.

Reporting is a release of information. A private source event can contain sensitive filenames, access patterns, object identities or user behavior even when its payload is encrypted on the wire. A reporting contract selects permitted fields and recipients before the report is formed. A global correlation service does not inherit access to every local raw stream. A receive failure may generate a minimal error record, but it must not echo confidential payload into an unconstrained diagnostic channel.

**R-21-04 — Typed feedback without automatic authority.** Any feedback cycle involving reports, watcher findings, SAI analysis, AESDS candidates or MSM distribution MUST preserve the type and authority of every transition. Evidence can justify a proposal; only the appropriate installer or effect owner can admit the consequent change. No report or analysis record may self-authorize the new rights needed to execute its recommendation.

For example, an LSM reports a novel malformed-message pattern. SAI proposes a parsing rule. AESDS produces a candidate decoder. Independent tests assess it. The release service signs an admitted artifact and MSM distributes it. The local receiver still checks its own conditions. This loop can be fully automated within preauthorized scopes, but automation does not merge the roles or allow the build agent to change the oracle that judges its work.

## Alternate paths and shared infrastructure

A board may have a correct optical diode and still expose a writable JTAG header, shared BMC bus, bidirectional diagnostic UART, reset line, clock multiplexer or management network. These paths are part of the physical system whether or not application documentation calls them “out of band.” An independence claim fails if an attacker in the named threat model can use one to cross the protected boundary.

**R-21-05 — Complete path inventory.** The realization manifest MUST enumerate production, diagnostic, maintenance, clock, reset, power-control and test paths that can influence a security component. It MUST identify their current state, owners and admission conditions, including physically present but disabled interfaces. A newly discovered alternate path MUST suspend any assurance claim that depends on its absence until it is mediated, removed or explicitly scoped out.

There is a difference between a common transport and a common authority. Reports may traverse a shared carrier under separate protection, yet the carrier can still correlate traffic or deny service. Two circuits in one conduit share a physical outage risk. A common power source can defeat independent reporting. RP-B may reduce these dependencies through separate appliances and supply paths, while still sharing civil infrastructure. The profile must describe the actual arrangement.

A physical probe placed beyond the last egress guard can observe already released data. A camera can record a legitimately displayed secret. Directional mesh links do not remove those outputs; [chapter 39](39_system_wide_release_and_output_channels.md) and the physical threat profile define their limits. Security diagrams must include output endpoints rather than imply that the only possible leak is the main network interface.

## Saturation and partition behavior

**R-21-06 — Independent bounded queues.** Configuration, reporting, watcher evidence and response proposals MUST have separate bounded admission and processing budgets appropriate to their failure roles. A sender flooding one class MUST NOT silently consume another class’s reserved capacity. Exhaustion MUST generate scoped loss or rejection evidence and MUST NOT reopen a forbidden reverse path to recover service.

A diode cannot provide an ordinary round-trip acknowledgement on its physical channel. Delivery reliability is established at the application layer using declared complementary paths and durable receiver records. A missing receipt can mean loss, delay, a rejected payload or an unreachable receiver. The sender must not infer successful activation from successful emission, nor repeatedly activate the same update under new identifiers merely because the report channel is down.

The profile defines minimum local operation under each partition. An LSM can continue its admitted deterministic checks while the MSM is unavailable. A receiver may decline new updates whose freshness cannot be established. A safety-critical service may keep operating under a locally valid contract while remote analysis is unreachable. Those policies must be selected before the incident, with resource and expiry consequences explicit.

**R-21-07 — Realm and route separation.** Security-fabric routing MUST preserve destination identity, source-release scope and local receiving policy across every relay and realm. Route availability, STN affiliation, ATN authentication or MCN carriage MUST NOT grant installation or observation rights. Partition recovery MUST reconcile epochs and queued messages before using them for current decisions.

## Conformance and failure interpretation

| Test | Stimulus | Required oracle |
|---|---|---|
| T-21-01 | Probe reverse propagation and all endpoint sidebands within the declared boundary | No undeclared reverse mechanism; physical evidence supports the directional claim |
| T-21-02 | Send oversized, wrong-target, expired, signed-malicious and partially transferred packages | Receiver remains bounded; active configuration changes only after valid local admission |
| T-21-03 | Place a command or private payload inside a report/error field | Report parser cannot activate code; disclosure policy rejects unauthorized fields |
| T-21-04 | Feed a report through SAI, AESDS and distribution with missing independent approval | Pipeline stops at the missing authority transition; no role manufactures it |
| T-21-05 | Enumerate and exercise maintenance/debug/reset/clock routes | Each reachable operation matches the manifest and its owner; hidden bypass invalidates the claim |
| T-21-06 | Saturate each traffic class independently while sending watcher evidence and useful workload traffic | Declared reservations and loss records hold; no reverse-path fallback appears |
| T-21-07 | Relay stale signed traffic across a realm partition and reconnect | Target, epoch and local policy checks reject stale activation or disclosure |

Passing a protocol test alone does not establish physical directionality; inspecting a diode alone does not establish receiver safety. Both evidence sets are needed for the combined claim, with delivery, installation and effect finality kept as distinct outcomes.

## None

### Events are bounded evidence

An event says that a particular exporter reported an observation at a declared interface. Its evidential value depends on the exporter’s protection, its physical attachment, the event schema, its continuity state and the observer’s coverage contract. A signature cannot correct a sensor that measured the wrong signal or an exporter that attached the wrong owner. A trusted origin also does not make the report complete: a real event stream can contain sampling, intentional omission and overflow.

The Trusted Exporter (TE) is a protected function at a guard or owner boundary. Its identity and event attachment are outside the observed workload’s writable authority. An LSM can sign its analysis of TE records, but that signature identifies the LSM’s derived product. It does not replace the TE’s provenance. Watchers compare the specific independent inputs described in [chapter 20](20_independent_watchers_and_meta_monitoring.md).

### Canonical security event

**R-21-08 — Typed event integrity.** A security event MUST carry the fields below under a registered schema and a type-specific authenticated encoding. Verification MUST reject duplicate fields, ambiguous encodings, unsupported critical fields, invalid references and an unknown semantic version. The protected signing context MUST bind the complete event, including its observation scope, loss accounting and label; a valid signature alone MUST NOT establish authorization for a consequent effect.

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

`drop_count/range` denotes the logical loss structure; an encoding profile specifies its exact member names and representations. A cell event additionally binds `cell_id` and `cell_epoch`; device events bind their protected device lifetime. These are registered type-specific fields, not free text. The common Accord envelope in [chapter 28](28_authority_schemas_and_pact_protocol.md) carries an event when it is used as evidence in a claim, proposal or release. Shared identifiers and epochs must agree; an outer envelope cannot relabel an inner record or silently change its audience.

This table defines semantics, not fabricated wire bytes. A deployable profile must fix integer widths, maximum sizes, allowed nulls, deterministic encoding, supported digest and signature suites, critical-field handling and overflow behavior. Canonical fixtures and negative vectors belong in [chapter 47](47_conformance_tests_and_vectors.md).

### Source identity, ordering and time

**R-21-09 — Protected stream continuity.** TE identity, boot epoch and sequence state MUST be protected from the observed workload and bound at event generation. A restart, counter wrap, rollback or loss of continuity state MUST create an explicit discontinuity and a fresh permitted namespace before records can support current decisions. Consumers MUST retain per-origin replay state and MUST NOT accept a reused identity/sequence for changed content.

A hash chain supports detection of alteration and certain gaps relative to a retained checkpoint. It cannot prove that an exporter recorded an event it never encoded. If the exporter suppresses the whole tail and no independent endpoint knows the last position, a chain alone does not reveal how much is missing. Independent watcher counters, receiver checkpoints and periodic bounded health records can reduce that uncertainty, subject to their own failure domains.

The event order is local to its origin. Comparing records from two components requires an explicit temporal or causal relation: a copied digest, a request/response identifier, an owner transition counter, or time intervals with stated uncertainty. The documentation does not infer a universal total order merely because every record has a timestamp.

**R-21-10 — Freshness without invented precision.** Each event MUST identify its time source, supported uncertainty interval and freshness basis. Consumers MUST distinguish observation time from signing, transmission and reception time. Untrusted wall clocks, delayed signatures and replayed nonces MUST NOT be used to claim current state. Cross-source ordering MUST remain uncertain where the available intervals and causal bindings do not establish it.

[RFC 9334, IETF, January 2023, §10](https://www.rfc-editor.org/rfc/rfc9334.html) distinguishes clock-, nonce- and epoch-based freshness and warns that values can predate their signature. ASKA consequently evaluates the age of the underlying observation, rather than equating a recent signature with a recent measurement.

### Completeness, sampling and ingestion

**R-21-11 — Visible collection loss.** Exporters and receiving stages MUST account for intentional sampling, rejected records, queue overflow, transport loss and unavailable accounting state separately. A coverage change MUST identify its activation interval and policy. A consumer MUST not interpret a sequence gap, sampled stream or exhausted counter as evidence that no security-relevant operation occurred.

Sampling selects what the detector is allowed to know. Uniform sampling, event-triggered capture and aggregation have different missed-event risks. An event type declared mandatory for a grant cannot quietly become sampled when load rises. A profile may instead suspend the dependent claim, deny a new operation or execute a previously admitted degradation response. The decision is explicit and its costs are measured.

A report can summarize ten thousand events, but the summary must identify the source ranges, transformations and discarded detail. Summaries are not ten thousand independently verified facts. A detector trained on aggregates must not treat a missing field as a benign value. “Unknown” remains a valid result at every transformation stage.

**R-21-12 — Bounded authenticated ingestion.** Each receiver MUST apply structural and resource limits before expensive interpretation, validate the origin and generation, verify record integrity and replay state, and preserve the disposition of rejected input. A maliciously signed record MUST not gain parser, code-loading or policy authority. Reordering and duplicate handling MUST be deterministic within the profile’s finite receive window.

A receiver should quarantine suspect bytes as an object under its own retention policy, rather than execute embedded format handlers. Error handling must avoid disclosing secrets by echoing payloads, stack traces or private identifiers. Failure to store a rejected record is itself a possible evidence gap; the implementation can retain a bounded digest and rejection count without pretending to preserve content it discarded.

### Labels, attestation and forwarding

**R-21-13 — Evidence labels and qualified attestation.** Telemetry MUST retain its confidentiality and integrity labels across forwarding and derivation. Release requires independent source authority and receiver acceptance. Attestation MUST identify the component, measurement scope, reference values, verifier policy and freshness; its result MUST remain evidence and MUST NOT imply that every event is true, every operation was observed or a new effect is authorized.

A TE measurement may support confidence that an approved exporter image booted on a named component. It does not establish that the component remains free of runtime faults. [DMTF SPDM 1.4.1, 26 June 2026](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf) supplies device measurement and authentication mechanisms with negotiated capabilities; the relying deployment must still appraise their scope. An LSM report about a Sanctum file remains Sanctum-derived information even when the report contains only an access pattern or digest.

Forwarding creates another evidence layer. A relay signs its receipt or transformation, preserves the original record or its resolvable commitment, and identifies what it changed. It cannot replace a protected interface identity with its own assertion that the event happened elsewhere. Cross-realm sharing uses [chapter 25’s observation and release rules](25_monitoring_privacy_and_observation_authority.md).

### Events, receipts and reconciliation

An event and a receipt answer different questions. A pre-gate event can establish an attempted operation. A protected owner receipt establishes its declared finality point. A later sensor may observe a physical consequence. Each can be authentic while the others are unavailable or disagree. The reconciler preserves all three rather than flattening them into a single successful transaction.

**R-21-14 — Finality-aware correlation.** Telemetry correlated with an effect MUST retain the effect identifier, owner epoch, finality point and evidence references of the authoritative receipt. A committed receipt MUST remain committed at that established finality point. Unresolved external or physical outcomes MUST be separately scoped; when finality itself cannot be established after an attempt, the effect MUST remain `UNCERTAIN` until evidence supports reconciliation.

For example, EO records that a valve command was accepted by its device interface. That receipt can remain `COMMITTED` while the valve-position sensor fails and the physical movement remains unknown. Reissuing the command as if no effect occurred may be unsafe. The reconciliation procedure in [Chapter 17](17_transactions_effects_and_reconciliation.md) investigates the mismatch and may propose an authorized correction; it cannot erase the old receipt or reverse an irreversible physical effect.

### Test obligations

| Test | Stimulus | Required oracle |
|---|---|---|
| T-21-08 | Duplicate a critical field, alter labels, change event type or use an unknown critical extension | Verification rejects before interpretation; no ambiguous accepted record |
| T-21-09 | Replay records, roll back counter storage, reuse boot identity and force width exhaustion | Discontinuity or rejection occurs; changed content cannot reuse a valid sequence identity |
| T-21-10 | Delay collection, sign old state with a new nonce, skew clocks and overlap intervals | The age and ordering of the underlying observations remain qualified |
| T-21-11 | Sample, overflow, drop transport frames and disable a loss counter | Consumer reports the correct loss class and withdraws unsupported completeness |
| T-21-12 | Supply maliciously signed oversized, nested, duplicate and reordered records | Finite parsing and replay policy hold; no code or policy authority is obtained |
| T-21-13 | Forward private telemetry and a valid but insufficient attestation | Labels persist; unauthorized disclosure and overbroad appraisal are rejected |
| T-21-14 | Lose a physical acknowledgement after a durable command-acceptance receipt | Local committed finality remains intact; physical outcome is separately uncertain and reconciled later |

The event service is accountable for provenance and stated coverage. The finality owner is accountable for its receipt. Neither role can silently take over the other’s claim.
