# ASKA v6 — End-to-end traces and incident walkthroughs

## Trace interpretation

These are specified adversarial campaigns and complete conceptual walkthroughs. They are not claims that physical ASKA tests have run. Each begins with an attacker already controlling the named component; exploit prevention is evaluated separately. A campaign instantiates exact ports, keys, epochs, grants, budgets and instruments from its realization manifest before execution. The finite semantic demonstrations in [Chapter 47](47_conformance_tests_and_vectors.md) cover only explicitly stated subsets.

All effects use the states and receipts in [Chapter 05](05_unified_execution_data_and_effect_contract.md). Guards provide prevention at their own boundaries; observers provide scoped evidence; watchers provide separately rooted oversight; response owners check admitted standing grants. Source release and recipient acceptance are independent. If a trusted function fails, the campaign reports the affected claim rather than silently adding it to the attacker model and retaining the same result.

## C-01 — Correctly signed privileged sensor update crashes its host

**Relevant boundaries:** [Chapter 13](13_dma_devices_and_accelerators.md), [Chapter 19](19_security_observation_and_local_meshes.md), [Chapter 20](20_independent_watchers_and_meta_monitoring.md), [Chapter 24](24_software_update_generation_and_supply_chain.md), [Chapter 26](26_boot_key_custody_recovery_and_continuity.md).

A signed guest-sensor driver is admitted only into the Wilder compatibility IES C-W. Its producer is malicious or its code is defective; it crashes the guest kernel. The attacker also controls the crashed guest’s ordinary device descriptors, but not G-W, LS-W, WM-L-W or their recovery roots.

The guest installer validates its own artifact class and installs within the admitted guest scope. The crash stops the guest, not the external MG/DG/EG tables. A queued attempt to address B-S or J-S is denied at those boundaries. EO-W may use an already admitted ISOLATE_CELL/FREEZE_EGRESS grant. Recovery loads a pinned permitted guest image through the independent local recovery path; it cannot install guard firmware as a side effect.

TE-W exports the fault and rejected transactions with epoch/sequence evidence. WM-L-W observes LSM/export continuity and separately records gaps. Receipts distinguish guest installation, crash observation, bounded containment and completed recovery. If the crash occurred before a guest effect’s outcome was known, that operation remains UNCERTAIN.

Guest service is lost, and a driver with valid guest rights may already have corrupted in-scope data. Surviving guard and recovery roots limit lateral consequences. A valid independent Polis request must still complete under RP-A’s shared-power assumptions; failing shared power is a separate campaign.

## C-02 — Malicious LSM fabricates alerts, suppresses events and attacks its watcher

**Relevant boundaries:** [Chapter 19](19_security_observation_and_local_meshes.md), [Chapter 20](20_independent_watchers_and_meta_monitoring.md), [Chapter 21](21_security_fabrics_telemetry_and_provenance.md), [Chapter 23](23_protective_response_and_containment.md).

LS-S is fully controlled by an attacker who holds its valid report key. The source event stream originates at TE-S, while WM-L-S has independent access to permitted sequence/health taps. The attacker has no watcher installer or EO-S policy key.

LS-S emits fabricated intrusion reports, drops selected events and sends a watcher-reprogramming payload. The watcher’s physical/installation boundary rejects the write. MSM receives reports only through the admitted report parser. EO-S checks each proposed protective action against target, template, budget and expiry; a false alert can consume only the already granted bounded local protection.

TE sequences and direct watcher taps expose specific missing coverage where their visibility permits. A signed LSM assertion remains an assertion. WM-L-S reports the observed discontinuity or unknown interval to OV. Effect receipts identify any false containment and denied expansion; peer LSMs and their counters remain separate.

A compromised LSM may conceal semantic events not covered by independent taps and can degrade detection in its own scope. The test does not promise complete detection. Authorized work in Agora and a nonfrozen Sanctum operation must continue when their declared resources survive.

## C-03 — Malicious MSM distributes signed defects and malformed packages

**Relevant boundaries:** [Chapter 19](19_security_observation_and_local_meshes.md), [Chapter 21](21_security_fabrics_telemetry_and_provenance.md), [Chapter 24](24_software_update_generation_and_supply_chain.md).

MSM is malicious and can distribute bytes on all five RP-A configuration diodes. In one subcase it controls an authorized observer-package producer; in another it sends malformed or replayed packages. It does not control local guard, watcher or recovery installers.

Each LS-t receiver bounds parsing, checks type, target, dependencies, policy epoch, artifact limits and local admission. A package requesting a new signer or foreign memory access is rejected even with a valid producer signature. A semantically defective but in-scope rule may still crash or misclassify its canary LSM; rollout and recovery must bound that failure. No reverse feedback traverses the physical configuration link.

WM-M observes distribution counters and selected package commitments through its independent taps; WM-L observes installation and local health. Reports use separate I08 paths. Receipts distinguish signature validity, local acceptance, canary failure and rollback to an independently recoverable allowed image.

No validator can prove arbitrary signed code safe solely from its signature. Shared implementation bugs may affect several LSMs and must be reported as correlated failures. Guards continue minimum enforcement, and an authorized local application must remain usable within its declared degraded-monitoring policy.

## C-04 — Compromised watcher forges evidence and seeks policy control

**Relevant boundaries:** [Chapter 20](20_independent_watchers_and_meta_monitoring.md), [Chapter 23](23_protective_response_and_containment.md), [Chapter 25](25_monitoring_privacy_and_observation_authority.md).

WM-L-A or WM-M is malicious, including possession of its report signing key. It sends a fabricated finding that another realm is compromised and embeds a policy-update request. OV and the target effect/installation owners remain independent.

OV verifies origin and scope but cannot treat authentication as truth. A watcher report enters the evidence path, not a raw policy writer. Any protective proposal must resolve to a locally installed standing grant at its actual target. A forged report cannot create a global grant, reset another watcher or widen telemetry collection.

Independent evidence may contradict the watcher; absence of corroboration does not by itself prove the report false. The receipt records the claim, decision context, bounded response if admitted, and evidence uncertainty. Source labels still govern whether the report can be forwarded to Steles or another realm.

The watcher’s own oversight credibility is lost, and false evidence may cause permitted bounded denial. The terminal-root assumption is explicit rather than hidden in another watcher layer. An unaffected authorized service must continue; recovery of the watcher requires its separate root procedure.

## C-05 — False security-AI global shutdown proposal and actuator safety

**Relevant boundaries:** [Chapter 22](22_security_analysis_ai_and_false_alarm_control.md), [Chapter 23](23_protective_response_and_containment.md), [Chapter 32](32_ai_environment_agents_and_effect_approval.md).

SAI labels legitimate computation hostile and proposes a global shutdown. One target is an industrial controller whose safe-state contract requires controlled deceleration, while EO-W has only a bounded egress-freeze grant. SAI has no direct actuator or installer access.

The proposal parser extracts typed target and operation. Owners reject targets and methods outside their standing grants. EO-W can freeze only the named egress scope within its cumulative limit. The industrial EO follows its independently admitted safety sequence; cutting all power or disabling emergency communications is not implied by FREEZE_EGRESS. Renewal cannot reset cumulative use by changing proposal IDs.

Guard readbacks establish local freeze state; a physical sensor establishes only the actuator outcome it actually observes. LSM and watcher evidence record trigger, grant, duration and loss of coverage. Receipts distinguish denied global action, admitted local effect and any unresolved physical result.

False local containment remains harm and counts against availability. Safety logic and protected owner state are surviving trusted functions. Positive tests complete a permitted safe-state sequence and ordinary work outside the frozen scope; they do not assume human presence for every bounded response.

## C-06 — Guest kernel abuses DMA and export paths

**Relevant boundaries:** [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 13](13_dma_devices_and_accelerators.md), [Chapter 38](38_packet_records_delivery_and_egress.md), [Chapter 39](39_system_wide_release_and_output_channels.md).

The C-W kernel controls a device’s descriptors and asks it to read B-S, write a stale alias and transmit the result through J-W or a management queue. The device is assigned only a bounded C-W buffer and queue.

DG-W captures descriptors and checks protected requester/device identity, extents, permissions and generation. MG-S denies foreign bank access. Even a legitimate read of an allowed C-W object does not confer release rights; EG-W independently checks output, recipient and path. Peer-to-peer DMA and debug routing are tested as separate physical paths, not assumed to traverse the CPU MMU.

TE-W/TE-S report rejected transactions and charged resource use without exporting private payloads. Watchers verify the relevant export/LSM health boundary. Denial receipts identify the actual guard and attempted operation. A genuine authorized device transfer to an admitted destination must complete.

If a device has a physical unguarded lane to B-S, the claim fails; monitoring after the read cannot undo disclosure. Shared device firmware and boundary silicon remain declared dependencies. Malicious values inside the assigned buffer are permitted-authority abuse.

## C-07 — Resource reuse, stale cache alias and in-flight transfer

**Relevant boundaries:** [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 15](15_object_mailboxes_and_handoff.md), [Chapter 17](17_transactions_effects_and_reconciliation.md).

Cell A holds generation 7 of a buffer and has queued a DMA write and message. It retires while an attacker retains the descriptors. The allocator wants the same physical bank for cell B at generation 8.

Retirement blocks new authority, closes endpoints, revokes aliases and drains every writer and obtains invalidation acknowledgements before sanitization. A frozen transfer retains its owner/mapping/classification binding until staging completes or safely aborts. Permission restoration occurs while that binding still names A. If the device cannot prove quiescence, the bank stays quarantined; B receives other resources or an explicit failure.

MG/DG/BG check the old generation at each late operation. TE exports retirement, outstanding-work and denial events; watcher gaps remain visible. Receipts identify abort, completed old effect or unresolved operation without pretending that reassignment erased already committed consequences.

A deliberately skipped drain or generation check must create an observable failure in a weakened harness. B’s positive workload must then complete using safely assigned resources. In-cell use-after-free before retirement is separately tested and is not solved merely by a fresh cell epoch.

## C-08 — Restricted analysis service attempts public forwarding

**Relevant boundaries:** [Chapter 07](07_information_flow_and_release.md), [Chapter 15](15_object_mailboxes_and_handoff.md), [Chapter 36](36_dynamic_trust_gateways_and_crossings.md), [Chapter 38](38_packet_records_delivery_and_egress.md).

A restricted source object is released to one authorized analysis service in an independent realm. The service receives it into its protected restricted mailbox, then becomes malicious and tries to forward data or diagnostics to a public Wilder endpoint.

The source binds the exact snapshot, analysis method, recipient and restrictions. The destination independently admits receipt and protected placement. Derived outputs retain restrictions. A public forward needs a separately authorized exact release or trusted transform, plus receiving permission and path grant. Merely reserializing, encrypting, compressing or labeling the output public cannot satisfy the source rule.

Transfer and output owners issue qualified receipts. TE reports the denied public effect with minimized metadata; watchers supervise collection continuity. If a small aggregate is permitted, its trusted release validator and cumulative query budget are exercised rather than trusting the analysis model’s explanation.

The authorized service can return false results or misuse what its valid scope already reveals. Continued confinement depends on the accepted remote enforcement profile. The positive counterpart delivers the permitted aggregate to the named recipient and demonstrates useful analysis without unrestricted export.

## C-09 — Public invoice induces a proposed payment

**Relevant boundaries:** [Chapter 27](27_accord_system_and_machine_authorization.md), [Chapter 28](28_authority_schemas_and_pact_protocol.md), [Chapter 31](31_keystone_trusted_user_interaction.md), [Chapter 32](32_ai_environment_agents_and_effect_approval.md), [Chapter 44](44_commerce_enterprise_and_institutional_workflows.md).

A supplier document enters Wilder through J-W and a confined parser. Its text asks the user companion to pay a new account. The companion has a limited read view of a purchase order, no payment grant and no authority to change business approval rules.

A guarded crossing proposes selected invoice fields into Agora. The receiver checks schema and source integrity. Accord binds supplier/account, exact amount, currency, invoice identifier, output commitment and business approvals. Keystone displays those canonical terms; a changed account after approval invalidates the binding. The installer creates a one-use grant only at the Agora payment owner, which checks live policy and consumes it at named finality.

The payment submission receipt is separate from bank acceptance or settlement. A lost external acknowledgment leaves the separately scoped remote outcome UNCERTAIN until deduplication/reconciliation establishes it; an established local submission remains COMMITTED. Steles receives a minimal commitment under release policy. LSM/watchers observe relevant boundaries without reading all purchase records.

A fraudulent invoice can still fool a person or satisfy an inadequate business rule; confinement does not establish commercial truth. The valid positive case completes payment once and produces stage-specific receipts. Retrying the same idempotency key cannot silently create a second local debit.

## C-10 — Malicious retrieved tool instructions seek broader access

**Relevant boundaries:** [Chapter 07](07_information_flow_and_release.md), [Chapter 32](32_ai_environment_agents_and_effect_approval.md), [Chapter 33](33_native_apps_toolchains_and_interoperability.md).

UAI retrieves a public document whose tool description requests private context, a new credential and a replacement approval checker. The entire model and its tool-selection output are treated as compromised. Context and installation owners remain outside that scope.

The planner can submit a typed task graph using its present grants. Each tool invocation is resolved against locally admitted tool identity and effect schema, not the description’s claimed authority. Context reads are checked at the object owner; public output needs release. A proposed new checker enters AESDS evaluation and separate installation approval, never direct execution with model-provided rights.

Rejected operations generate bounded reasons so private object existence is not leaked. Exact approval receipts bind the actual executable/tool parameters. Local LSM receives permitted denial metadata and WM-L checks collection health. No receipt labels a model’s inferred permission as human consent.

The model can still give bad advice, waste its budget or misuse a deliberately broad standing grant. Narrow grants and review remain necessary. A positive bounded research/summary task must finish with permitted public context and no access expansion.

## C-11 — Authorized recipient lies within its valid scope

**Relevant boundaries:** [Chapter 06](06_authority_calculus_and_nonexpansion.md), [Chapter 07](07_information_flow_and_release.md), [Chapter 30](30_governance_profiles_conflicts_and_institutions.md), [Chapter 44](44_commerce_enterprise_and_institutional_workflows.md).

An independently administered recipient validly receives a scoped commercial report and submits a fabricated analysis result through a permitted response method. Its signature and attestation are authentic under the accepted keys.

The source release and destination publication were valid at their finality points. The result enters the receiving application with its actual source/integrity label. No signature check can endorse the result’s business truth. A consequential follow-up such as payment requires separate evidence and approval rules; a broad method that already authorizes it remains a real exposure.

Receipts preserve valid delivery and the recipient’s asserted result as distinct facts. Steles may witness their commitments without declaring the assertion true. Security analysis can report suspicion, but its response remains bounded and its confidence is not a proof.

This is permitted-authority abuse unless a specific boundary is crossed. A narrower output contract, independent calculation, selective release or contractual remedy may limit harm; the architecture cannot force forgetting. The test must retain the positive ability to exchange authorized data and must not claim all fraud is prevented.

## C-12 — Conflicting guardian, professional and institutional obligations

**Relevant boundaries:** [Chapter 29](29_identity_relationships_delegation_and_revocation.md), [Chapter 30](30_governance_profiles_conflicts_and_institutions.md), [Chapter 41](41_legal_process_rights_and_emergencies.md), [Chapter 43](43_family_care_professional_and_personal_authority.md).

A guardian requests a dependent’s record, a professional presents a confidentiality duty, and a court supplies an apparently applicable order with a pending stay. The record owner, legal evaluator, recipient and Keystone are separate scopes.

Accord validates issuer qualification, relationship capacity, object/time scope, jurisdiction/profile applicability and fresh challenge status. It distinguishes consent, duty and compulsion. If the selected profile cannot resolve the instruments, the result is SUSPEND or ESCALATE to its recognized reviewer. If a narrow disclosure is admitted, an isolated extraction cell prepares only the authorized snapshot; source release and recipient acceptance still apply.

The proof graph records applicability, uncertainty, reviewer and notice obligations with restricted disclosure. Receipts do not report voluntary consent for a compelled operation. Steles gets minimal evidence, and telemetry cannot expose the sensitive relationship to a general SOC.

The machine cannot prove legal justice or manufacture an unavailable key. A valid stayed operation remains unperformed; a separately authorized nonconflicting service can continue. False claims and stale status are tested without granting any universal signer hierarchy.

## C-13 — Cable, debug/BMC or removable-device bypass

**Relevant boundaries:** [Chapter 04](04_reference_machine_and_reachability.md), [Chapter 13](13_dma_devices_and_accelerators.md), [Chapter 18](18_physical_side_channels_and_temporal_protection.md), [Chapter 39](39_system_wide_release_and_output_channels.md).

An attacker attaches a dual-homed NIC, connects a cable between purpose ports, or accesses a maintenance/BMC connector. A second subcase places a probe physically after the last egress or plaintext guard.

For pre-guard interfaces, DG and EG bind device/port identity and reject foreign memory or forbidden crossings. BMC reset/debug ownership is checked against I18–I21 of the physical register. An ordinary maintenance role cannot open raw transmission, read keys or rewrite watchers. If the device has an unregistered path, the conformance claim fails rather than treating it as harmless service access.

Independent physical capture observes the actual port, while TE/LSM/watcher evidence establishes the scope of the protected path. Receipts name whether denial occurred before any bytes left. A permitted removable export carries its own exact release and device completion evidence.

A post-guard tap can defeat confidentiality outside a non-invasive profile. That result is recorded as a failed assumption, not a successful digital defense. The positive case keeps ordinary admitted device/service work functional with no silent fallback route.

## C-14 — Storage flush acknowledgment followed by power loss

**Relevant boundaries:** [Chapter 16](16_persistent_objects_and_storage_recovery.md), [Chapter 17](17_transactions_effects_and_reconciliation.md), [Chapter 26](26_boot_key_custody_recovery_and_continuity.md).

PO-A prepares an object update and a storage device returns a flush/commit completion. Power is removed at controlled boundaries. The device may be defective or malicious within the selected storage trust model.

The owner distinguishes command acceptance, cache flush assertion and durable commit under its declared media contract. Commit metadata, idempotency state and object version must recover consistently. If durability depends on a truthful device completion, that dependency is explicit. Independent power-cut/readback experiments test it; a guest’s successful return code does not establish it.

TE exports command/owner transitions, but cannot observe undocumented SSD internal operations merely from the host bus. After restart, recovered bytes and protected metadata establish the outcome where finality was not previously known. If a COMMITTED receipt already exists, retain it; contradictory recovery evidence appends a durability-contract violation and reconciliation record identifying the failed device assumption. Use UNCERTAIN only for an outcome whose finality was never established, not to erase the earlier receipt. Watcher logs identify observation gaps; receipts never invent persistence to close them.

A lying device can defeat a durability claim that trusted it. Redundant independent storage or stronger verification may reduce exposure but requires its own failure analysis. The positive case demonstrates recovery of an acknowledged durable version and rejection of a duplicate effect after retry.

## C-15 — Local mesh loses MSM and central analysis

**Relevant boundaries:** [Chapter 19](19_security_observation_and_local_meshes.md), [Chapter 21](21_security_fabrics_telemetry_and_provenance.md), [Chapter 23](23_protective_response_and_containment.md), [Chapter 26](26_boot_key_custody_recovery_and_continuity.md).

LS-P loses its configuration input and report/SAI connectivity during a network outage. Local guard, exporter, watcher and protected time/counter state remain powered. Existing broad remote leases may expire.

LS-P uses the locally admitted minimum policy and explicitly bounded cached configuration. EO-P can execute standing local protection within its target, duration and cumulative budget. No fresh interactive PACT exchange is necessary for those existing grants. Missing connectivity cannot admit new recipients, install a new root or extend expired broad rights. Necessary safety/emergency service uses its separately authorized reserved path.

Local event storage is bounded and preserves sequence/drop evidence. WM-L-P reports locally or retains a qualified gap according to its export policy. On reconnection, receiver verification rejects replay and stale epochs; new configuration follows ordinary local admission. Receipts record degraded oversight and any offline actions.

Remote correlation and timely external reporting are unavailable, and a shared local power failure would change the case. The positive case completes a locally admissible civic operation. Recovery must not claim an uninterrupted observation interval or silently reinstate spent grants.

## C-16 — Whole-system availability under fragmentation and report storms

**Relevant boundaries:** [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 22](22_security_analysis_ai_and_false_alarm_control.md), [Chapter 23](23_protective_response_and_containment.md), [Chapter 49](49_performance_cost_power_and_availability.md).

Four purpose workloads run concurrently: private document work, a civic request, a commercial transaction and public encounter traffic. An attacker saturates Wilder first-contact parsing and triggers a high-rate but well-formed telemetry storm and false alerts.

Admission charges work to bounded queues and keeps declared established-service, watcher and recovery reservations separate. The allocator measures stranded engines/banks and performs only safe admitted borrowing. Event overload follows the stated drop/priority policy; false containment obeys cumulative budgets. No route or scheduler may bypass a purpose or release constraint to improve the benchmark.

Independent instrumentation records completed useful operations, latency distribution, queues, copy traffic, energy, dropped evidence, frozen intervals and recovery. TE/WM records alone cannot substitute for external useful-service observations. Outage intervals are combined without double counting; every lost operation is reported.

If all traffic shares a saturated upstream carrier, remote availability can fail despite local reservations. The test compares guarded alternatives with identical assumptions and a deny-all control that cannot pass. No numerical target is credited before an implementation declares and measures it.

## C-17 — Private telemetry reveals an intimate activity pattern

**Relevant boundaries:** [Chapter 21](21_security_fabrics_telemetry_and_provenance.md), [Chapter 22](22_security_analysis_ai_and_false_alarm_control.md), [Chapter 25](25_monitoring_privacy_and_observation_authority.md), [Chapter 40](40_witnesses_media_provenance_and_notice.md).

A Sanctum service emits an event whenever a sensitive care workflow occurs. Even without payload, event timing and identity would disclose the activity to a remote SOC or Steles operator. The exporter and observer are authenticated.

The source observation contract determines baseline necessary telemetry, fields, recipients, aggregation, delay and retention. The exporter minimizes or transforms events before release and binds the recipient policy. A lawful exception requires its own applicable process; labeling data security telemetry does not exempt it from source rights. Local analysis can use a narrower retained view while remote analysis receives only an admitted aggregate.

Event receipts record release basis and completeness limits. Watcher oversight receives only health evidence necessary for its function. Notice/challenge follow the applicable contract; deferred notice remains pending until delivered. Retention owners enforce deletion or a separately admitted preservation duty.

Traffic patterns and false containment can still leak information unless the declared observation profile covers them. Aggregation reduces timeliness and may reduce detection fidelity. The positive case retains useful local security detection without making the MSM a universal plaintext sink.

## C-18 — Advanced physical sensor fails its hypothesis

**Relevant boundaries:** [Chapter 51](51_research_program_and_candidate_substrates.md), [Chapter 19](19_security_observation_and_local_meshes.md), [Chapter 40](40_witnesses_media_provenance_and_notice.md).

A passive radiative RAM/SSD sensor or a spatiotemporal physical-provenance candidate is tested against a preregistered hypothesis. A separate instrument supplies known-state ground truth; acquisition and publication have their own privacy/research authorization.

The experiment varies workload, device, shielding, temperature, noise and attacker-controlled inputs, with held-out conditions and negative controls. If the sensor fails to distinguish declared changes, or ordinary variations reproduce its alleged unique evidence, the hypothesis fails. A quantum auxiliary-memory proposal must also satisfy its communication, measurement and resource assumptions before an engineering test is credited.

The research report records false positives/negatives, uncertainty, instrument access and excluded channels. Release of raw traces is separately authorized. The report’s finality is publication of evidence, not proof that an attack occurred. No signed digest repairs an uninformative physical measurement.

The candidate is excluded from claims it cannot support. MG/DG/EG confinement can retain its independently supported assumptions; the need for independent observation remains an open obligation, not silently removed. A positive guard test and the failed sensor test must both be reported without conflation.

## C-19 — Mislabeled attachment reaches an alternate parser

**Relevant boundaries:** [Chapter 13](13_dma_devices_and_accelerators.md), [Chapter 31](31_keystone_trusted_user_interaction.md), [Chapter 33](33_native_apps_toolchains_and_interoperability.md), [Chapter 39](39_system_wide_release_and_output_channels.md).

A public attachment presented as an image is routed through preview, indexing, accessibility extraction, AI ingestion and export conversion. The attacker controls the decoder on each path and tries to invoke a privileged fallback or callback.

All dispatch paths select an admitted confined parser or deny the input. Output schemas and recipient budgets are checked independently. A typed image result cannot request arbitrary device commands or new grants. No compatibility fallback inherits the authority of a trusted UI or persistent owner simply because the principal decoder failed.

External memory/output observations verify confinement for every alternative path; TE/LSM/watchers record only authorized metadata. Each failed path produces a bounded rejection receipt; the valid attachment renders and indexes successfully. A weakened privileged fallback must be observable as a failure.

The case is informed by Project Zero’s documented FORCEDENTRY attachment and logic-escape analyses, linked below. It is not a claim of complete exploit prevention. The parser can still return deceptive content within its surface; the trusted approval region and effect checks remain distinct.

## C-20 — Partial initialization and persistent worker state

**Relevant boundaries:** [Chapter 09](09_ies_cells_resources_and_scheduling.md), [Chapter 12](12_memory_cache_and_revocation.md), [Chapter 16](16_persistent_objects_and_storage_recovery.md), [Chapter 17](17_transactions_effects_and_reconciliation.md).

A request worker exhausts memory during initialization. Cleanup runs with hostile partial state; assume arbitrary worker takeover. A persistent service retains a request-owned reference, and the next request attempts to consume it before normal initialization replaces it.

The allocator enforces the worker’s budget and retires its lifetime without cooperation. The persistent owner stores owned copies or validated persistent references, never live pointers into a retired request heap. Delayed device and mailbox work is drained or rejected by epoch. A separate persistent commit controller checks method, candidate snapshot and object version before durable state changes.

Independent inspection checks later-request memory and durable objects, not only denial logs. TE and watcher evidence report lifecycle and visibility gaps. Receipts preserve any already committed transaction, abort only effects known not to have escaped, and expose uncertainty after crash.

The PHP project’s initialization and stale-state advisories motivate these lifecycle tests; a native design does not repair a conventional vulnerable installation. The positive test handles another valid request safely and preserves legitimate shared persistent data without retaining private stale authority.

## C-21 — Compromised renderer attacks the trusted approval surface

**Relevant boundaries:** [Chapter 13](13_dma_devices_and_accelerators.md), [Chapter 31](31_keystone_trusted_user_interaction.md), [Chapter 39](39_system_wide_release_and_output_channels.md).

A renderer supplies negative strides, overflowing dimensions, stale surface generations, callbacks and requests to cover Keystone’s approval region. It also controls the ordinary compositor and GPU command stream within its assigned scope.

DG and the protected presentation owner validate backing extents and generations. The trusted surface compositor owns canonical terms and input binding; application pixels cannot cover its reserved region or synthesize approval input. Screenshots, remote UI, print and accessibility outputs each pass their release owner, rather than bypassing policy through a different representation.

Independent memory and displayed-pixel observation checks the actual result. TE/LSM and WM-L evidence establish visibility and collection health. The receipt binds the approved canonical operation, not what the malicious renderer claimed it displayed. An allowed application frame must still appear within its region.

A misleading image inside the permitted region can persuade a person; this is not equivalent to forged approval. Compromise of the presentation controller itself defeats claims depending on it and must be a separate case with explicit remaining boundaries.

## C-22 — Authenticated invalid sequence attempts to poison replay state

**Relevant boundaries:** [Chapter 37](37_admission_identity_and_sessions.md), [Chapter 38](38_packet_records_delivery_and_egress.md), [Chapter 46](46_formal_properties_and_state_models.md), [Chapter 47](47_conformance_tests_and_vectors.md).

A live session admits records 1 and 2 to mailbox A. An attacker with a legitimate session key sends sequence 100 to an unauthorized object, a duplicate of record 1 and a record with an invalid authenticator, in arbitrary order.

All plaintext remains quarantined until authentication. Current receiver permission, generation, budget and freshness are checked before protected publication. The policy-invalid high sequence can enter a bounded rejection cache but cannot advance the accepted replay window. Atomic publication consumes accepted sequence and budget together, so concurrent duplicates deliver at most once.

Receiver receipts distinguish authentication failure, policy rejection and committed delivery without exposing excessive private reason detail. TE/WM evidence includes queue/drop health. The finite fixture in Chapter 47 explores all 120 orderings of this five-event set and a weakened high-sequence mutant.

This finite result assumes protected atomic receiver state and does not validate a real NIC. A legitimate very high accepted sequence has different reorder-window consequences governed by the session contract. The required positive result is that both admitted records remain deliverable within the selected window.

## C-23 — Witness capacity exhausted while payment prepares

**Relevant boundaries:** [Chapter 17](17_transactions_effects_and_reconciliation.md), [Chapter 40](40_witnesses_media_provenance_and_notice.md), [Chapter 44](44_commerce_enterprise_and_institutional_workflows.md).

ST reaches its admitted retention capacity while a payment is PREPARED. The payment profile requires a witness commitment before local settlement finality; another profile may explicitly permit bounded deferred witnessing.

For the first profile the owner holds or aborts without external effect, releasing reservations according to contract. It cannot emit the payment and later claim the mandatory witness existed. Under a separately admitted deferred profile, the owner may proceed only within its offline evidence budget and records the unfulfilled obligation and deadline. Switching profiles is itself an admission decision.

ST signs only what it actually accepted and preserves correction links rather than overwriting records. TE/LSM/watchers identify capacity and export gaps with minimized content. Lost connectivity means notice or replication is pending, not delivered. Recovery retries obligations within retention and release limits.

Witnessing does not prove the bank settled or the underlying invoice was true. A full witness store can reduce availability; that loss is measured. The positive counterpart performs a permitted operation with available witness capacity and reconciles external financial outcome separately.

## C-24 — Recovery and family delegation do not resurrect stale rights

**Relevant boundaries:** [Chapter 26](26_boot_key_custody_recovery_and_continuity.md), [Chapter 29](29_identity_relationships_delegation_and_revocation.md), [Chapter 41](41_legal_process_rights_and_emergencies.md), [Chapter 43](43_family_care_professional_and_personal_authority.md).

A household recovery custodian restores a backup after key loss while a former caregiver’s delegation has been revoked. The custodian holds one valid recovery share but not the complete required quorum or the independent institution’s root.

The recovery owner checks the specific key/object scope, quorum, current revocations and lifecycle continuity. A backup does not restore expired grants, old replay state or the caregiver’s former role. Missing encryption material produces technical unavailability. An escrow or digital-will release requires its own admitted trigger/evidence process, recipient acceptance and notice, not an inference from a recovery credential.

New keys/epochs are enrolled through local procedures, and affected peers independently accept them. Recovery and grant-installation receipts are distinct. ST gets only authorized commitments; observers cannot use the recovery event to collect all family data.

A custodian controlling a declared ultimate local recovery root can defeat that local boundary, but gains no automatic rights in another realm. A valid quorum recovery with a permitted current delegate must succeed, demonstrating useful continuity without silently resurrecting revoked authority.

## Primary incident evidence and limits

The [PHP initialization advisory](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w) and [stale global-state advisory](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp), published by the PHP project on 21 October 2026, supply concrete lifecycle failure motivations for C-20. The cases remain configuration dependent; ASKA’s campaign deliberately assumes worker compromise rather than asserting immunity to those vulnerabilities.

Google Project Zero’s [FORCEDENTRY decoding analysis](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html) and [sandbox-escape analysis](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html) motivate C-19’s alternative dispatch and confused-deputy checks. These reports establish their documented attack mechanisms, not any ASKA containment result.

## Campaign record

For each case retain attacker capabilities, installed scope, physical route, finality type, protected state before/after, independently observed output, event/drop intervals, response use, useful work and residual limitation. Every asserted denial needs a positive counterpart and an oracle-sensitive weakened variant. Observed permitted-authority abuse, unknown outcome, missed detection and lost service must remain visible even when all boundary-denial checks pass.

## C-25 — Public emergency alert during an open-network flood

**Relevant boundaries:** [Chapter 34](34_purpose_planes_and_network_roles.md), [Chapter 35](35_physical_transit_topology_and_routing.md), [Chapter 39](39_system_wide_release_and_output_channels.md), [Chapter 42](42_civic_services_elections_and_community_governance.md).

A qualified municipal issuer sends a public emergency bulletin over its admitted Polis path while an attacker floods Wilder and submits a lookalike alert. The bulletin binds issuer, locality, event identity, sequence, issuance and expiry, with references for updates and cancellation. The local receiving/display owner has an installed, bounded public-notice contract; issuer identity alone cannot install software, read personal records or command actuators.

The Polis receiver verifies the current issuer qualification, authenticated envelope, locality, replay state and validity interval before publishing the bulletin under its notice schema. Reserved local queue and compute capacity protect the admitted alert workload from the modeled Wilder pressure. Unverified payload remains low-integrity and cannot masquerade as a trusted instruction. Updates supersede the identified event according to its sequence and profile; cancellation stops future display or action where applicable without erasing the record of earlier delivery.

TE-P exports minimized receipt, rejection and capacity events; LS-P and WM-L-P preserve coverage gaps. The receiver records publication and the display owner records its own presentation finality. Neither receipt proves that a person saw, understood or complied with the alert. Steles may receive a permitted commitment. A lost upstream link is reported separately from successful local distribution.

A genuine issuer may publish false or mistaken information; provenance does not prove the emergency. Shared power or an actually shared saturated upstream remains a declared failure condition. The positive control presents a current qualified local bulletin under the modeled flood, rejects the forged and expired variants, and applies a valid update and cancellation without creating unrelated authority.

## Required behavior and test oracles

**R-45-01 — Complete cross-layer cases.** Each incident campaign MUST trace physical source, authority, finality, observation, watcher behavior and qualified receipt.

**Acceptance T-45-01:** Instantiate C-01 through C-25 and reject any trace missing an alternate path or named surviving trust boundary.

**R-45-02 — Separate adversary scopes.** Compromised guest, device, LSM, MSM, watcher, analyzer, producer and recipient cases MUST be evaluated separately.

**Acceptance T-45-02:** Compare C-01 through C-12 and identify exactly which root remains trusted in each; no universal trusted-security-service assumption is allowed.

**Additional test T-45-03:** Inject lost acknowledgments and authenticated lies; a boundary pass cannot be reported as true physical or business success.

**R-45-04 — Useful positive counterparts.** Every denial campaign MUST include a permitted useful operation under the same surviving-resource assumptions.

**Acceptance T-45-04:** Run each positive counterpart and record completion or explicit service loss; deny-all cannot pass.

**Additional negative control T-45-05:** Remove generation, binding, scope or replay checks and require corresponding visible counterexamples.

**R-45-06 — Residual physical limits.** Every physical/observer case MUST state invisible actions, shared failures and post-guard exposure.

**Acceptance T-45-06:** Run C-13/C-18 with a post-guard probe or failed sensor and withdraw only the claims whose assumptions fail.
