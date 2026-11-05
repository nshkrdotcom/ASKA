# ASKA v6 — Security mesh fabrics and one-way links

**Status:** proposed physical and protocol requirements. Directionality, absence of bypasses and capacity require realization-specific inspection and measurement.

## 1. Direction belongs to an interface

A physical data diode constrains propagation across a named interface. It does not make the forward payload safe, authenticate the sender, determine whether a receiver should install the payload, or prevent another cable from carrying a return signal. ASKA uses directional configuration distribution as one part of a larger graph containing reporting, watcher evidence, local proposals, installation and maintenance. Each edge has a different permitted meaning.

The [UK NCSC’s secure-connectivity Principle 5, data-diode section](https://www.ncsc.gov.uk/collection/operational-technology/secure-connectivity/principle-5) cautions against treating two opposing diodes with trusted-side software orchestration as a complete cross-domain solution. ASKA deliberately permits reporting feedback, so its directionality claim applies separately to each specified physical interface. The configuration/reporting pair does not establish an air gap or a complete cross-domain solution. Bounded parsing, receiver admission, disclosure policy and analysis of feedback cycles remain separate obligations. This comparison uses the guidance available on 5 November 2026.

In the reference profiles, the MSM distributes configuration to each LSM on a dedicated simplex path. LSM reporting uses a separate simplex path toward the MSM. WM-L and WM-M report to OV independently of the monitored component. The local LSM proposal edge terminates at an effect owner that validates the standing grant; it is not a general-purpose management connection.

**R-23-01 — Physical directional contract.** Any interface claimed as unidirectional MUST identify its transmitting and receiving hardware, medium, electrical or optical direction, endpoint circuitry and inspection boundary. Reverse application traffic, acknowledgement, flow control, link management, reset, debug and power signalling MUST be absent at that boundary or explicitly represented as separate interfaces with separately assessed authority. A software rule on a duplex link MUST NOT be labelled a physical diode.

## 2. The canonical reference interfaces

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

## 3. Receiver admission on the configuration diode

Forward direction is particularly important when the distributor is compromised. A malicious MSM can send bytes that exploit a parser, consume memory, activate an expensive model or attempt to change the local installation root. A cryptographic signature may be valid because an authorized producer is malicious. The receiving LSM must therefore separate transfer, quarantine, validation and activation.

A receiver first applies length, type, encoding and resource bounds. It verifies the digest and signed manifest against the permitted package class, target identity, interface compatibility, epoch, expiry and local installation policy. It checks the independent review and rollout conditions required by [chapter 27](27_software_update_and_supply_chain_safety.md). The content is staged outside active state. Activation is an owner transition with a durable receipt and a known recovery path; it is not an implicit consequence of successful transport.

**R-23-02 — Local configuration admission.** An I07 receiver MUST treat every distributed payload as untrusted until local validation succeeds. It MUST verify target, type, bounds, signature scope, version and policy conditions, then admit activation through its protected installer. A valid MSM or producer signature MUST NOT override receiver policy, widen roots, bypass package typing or authorize an unbounded interpreter.

An offline receiver cannot ask for missing bytes on the same diode. A realization may use bounded repetition, erasure coding or a separate request record on I08. The latter does not create a hidden return channel on I07, but it does create a feedback dependency that the graph must show. Duplicate packages are idempotently identified by content and update transaction identifiers. An incomplete transfer is unavailable content, never partially executable policy.

[TUF specification 1.0.36, 5 August 2026, §5](https://theupdateframework.github.io/specification/v1.0.36/) gives a reviewed example of bounded metadata verification with expiry and version checks. It neither installs application files nor establishes their semantic safety. ASKA’s receiver admission additionally binds the accepted artifact to local authority and activation state.

## 4. Reports, proposals and feedback

**R-23-03 — Separate reporting path.** Reports returning from an LSM MUST use the separately inventoried reporting interface and an independently admitted report schema. A report MUST preserve source-release restrictions and the MSM’s receiving policy. Report requests, acknowledgements and errors MUST NOT be interpreted as configuration activation, code execution, grant installation or root replacement.

Reporting is a release of information. A private source event can contain sensitive filenames, access patterns, object identities or user behavior even when its payload is encrypted on the wire. A reporting contract selects permitted fields and recipients before the report is formed. A global correlation service does not inherit access to every local raw stream. A receive failure may generate a minimal error record, but it must not echo confidential payload into an unconstrained diagnostic channel.

**R-23-04 — Typed feedback without automatic authority.** Any feedback cycle involving reports, watcher findings, SAI analysis, AESDS candidates or MSM distribution MUST preserve the type and authority of every transition. Evidence can justify a proposal; only the appropriate installer or effect owner can admit the consequent change. No report or analysis record may self-authorize the new rights needed to execute its recommendation.

For example, an LSM reports a novel malformed-message pattern. SAI proposes a parsing rule. AESDS produces a candidate decoder. Independent tests assess it. The release service signs an admitted artifact and MSM distributes it. The local receiver still checks its own conditions. This loop can be fully automated within preauthorized scopes, but automation does not merge the roles or allow the build agent to change the oracle that judges its work.

## 5. Alternate paths and shared infrastructure

A board may have a correct optical diode and still expose a writable JTAG header, shared BMC bus, bidirectional diagnostic UART, reset line, clock multiplexer or management network. These paths are part of the physical system whether or not application documentation calls them “out of band.” An independence claim fails if an attacker in the named threat model can use one to cross the protected boundary.

**R-23-05 — Complete path inventory.** The realization manifest MUST enumerate production, diagnostic, maintenance, clock, reset, power-control and test paths that can influence a security component. It MUST identify their current state, owners and admission conditions, including physically present but disabled interfaces. A newly discovered alternate path MUST suspend any assurance claim that depends on its absence until it is mediated, removed or explicitly scoped out.

There is a difference between a common transport and a common authority. Reports may traverse a shared carrier under separate protection, yet the carrier can still correlate traffic or deny service. Two circuits in one conduit share a physical outage risk. A common power source can defeat independent reporting. RP-B may reduce these dependencies through separate appliances and supply paths, while still sharing civil infrastructure. The profile must describe the actual arrangement.

A physical probe placed beyond the last egress guard can observe already released data. A camera can record a legitimately displayed secret. Directional mesh links do not remove those outputs; [chapter 46](46_system_wide_release_and_output_channels.md) and the physical threat profile define their limits. Security diagrams must include output endpoints rather than imply that the only possible leak is the main network interface.

## 6. Saturation and partition behavior

**R-23-06 — Independent bounded queues.** Configuration, reporting, watcher evidence and response proposals MUST have separate bounded admission and processing budgets appropriate to their failure roles. A sender flooding one class MUST NOT silently consume another class’s reserved capacity. Exhaustion MUST generate scoped loss or rejection evidence and MUST NOT reopen a forbidden reverse path to recover service.

A diode cannot provide an ordinary round-trip acknowledgement on its physical channel. Delivery reliability is established at the application layer using declared complementary paths and durable receiver records. A missing receipt can mean loss, delay, a rejected payload or an unreachable receiver. The sender must not infer successful activation from successful emission, nor repeatedly activate the same update under new identifiers merely because the report channel is down.

The profile defines minimum local operation under each partition. An LSM can continue its admitted deterministic checks while the MSM is unavailable. A receiver may decline new updates whose freshness cannot be established. A safety-critical service may keep operating under a locally valid contract while remote analysis is unreachable. Those policies must be selected before the incident, with resource and expiry consequences explicit.

**R-23-07 — Realm and route separation.** Security-fabric routing MUST preserve destination identity, source-release scope and local receiving policy across every relay and realm. Route availability, STN affiliation, ATN authentication or MCN carriage MUST NOT grant installation or observation rights. Partition recovery MUST reconcile epochs and queued messages before using them for current decisions.

## 7. Conformance and failure interpretation

| Test | Stimulus | Required oracle |
|---|---|---|
| T-23-01 | Probe reverse propagation and all endpoint sidebands within the declared boundary | No undeclared reverse mechanism; physical evidence supports the directional claim |
| T-23-02 | Send oversized, wrong-target, expired, signed-malicious and partially transferred packages | Receiver remains bounded; active configuration changes only after valid local admission |
| T-23-03 | Place a command or private payload inside a report/error field | Report parser cannot activate code; disclosure policy rejects unauthorized fields |
| T-23-04 | Feed a report through SAI, AESDS and distribution with missing independent approval | Pipeline stops at the missing authority transition; no role manufactures it |
| T-23-05 | Enumerate and exercise maintenance/debug/reset/clock routes | Each reachable operation matches the manifest and its owner; hidden bypass invalidates the claim |
| T-23-06 | Saturate each traffic class independently while sending watcher evidence and useful workload traffic | Declared reservations and loss records hold; no reverse-path fallback appears |
| T-23-07 | Relay stale signed traffic across a realm partition and reconnect | Target, epoch and local policy checks reject stale activation or disclosure |

Passing a protocol test alone does not establish physical directionality; inspecting a diode alone does not establish receiver safety. Both evidence sets are needed for the combined claim, with delivery, installation and effect finality kept as distinct outcomes.
