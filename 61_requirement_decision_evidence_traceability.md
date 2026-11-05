# ASKA v6 — Requirement, decision and evidence traceability

## 1. Canonical ownership

The normative definition of each `R-NN-XX` and its `T-NN-XX` acceptance oracle is in **Chapter NN**. This index resolves identifiers to their owner without copying those definitions. The architecture decisions reside in [Chapter 60](60_research_program_and_architectural_decisions.md), top-level requirements in [Chapter 02](02_requirements_and_threat_model.md), threat/assurance assumptions in [Chapter 03](03_assurance_trust_and_failure_domains.md), and external literature in [Chapter 62](62_prior_art_sources_and_evidence_register.md). Requirement IDs are obligations, not completed test results.

All realization-level requirements have evidence status `SV` (*specified; implementation unvalidated*) here. The finite tests in [Chapter 56](56_conformance_tests_and_vectors.md) support only the published small state model. They do not establish hardware isolation, formal correctness of the full architecture, production cryptographic implementations or independent operation of institutions. Unknown, untested and disproved must remain different statuses in a deployment dossier.

## 2. Claim-to-enforcer and proof map

The proof obligations in [Chapter 55](55_formal_properties_and_state_models.md) are the shortest statement of the cross-chapter safety argument. They are not machine-checked theorems. A deployed claim must identify the **concrete** corresponding action and root, not just repeat the named invariant.

| Property | Primary enforcing boundary | Owning requirements and evidence | Required negative control |
|---|---|---|---|
| Non-expansion of grants | Qualified semantic evaluator and owner-local canonical grant verifier | [06](06_authority_calculus_and_nonexpansion.md), [31](31_accord_system_and_machine_authorization.md), [32](32_claim_contract_grant_receipt_schemas.md); `INV-01`, `INV-02` | Compiler inserts a recipient, budget or operation absent from the admitted contract |
| Fresh memory/object ownership | Protected bank/device guard and allocation generation | [04](04_reference_machine_and_reachability.md), [09](09_ies_cells_resources_and_scheduling.md), [12](12_memory_cache_and_revocation.md), [14](14_dmnoc_and_internal_communications.md); `INV-03`, `INV-04` | Delayed DMA or stale writeback after ownership transfer |
| Transfer and exact-output release | Source exporter and final-byte/path guard | [07](07_information_flow_and_release.md), [15](15_object_mailboxes_and_handoff.md), [45](45_packet_records_delivery_and_egress.md); `INV-05` | Modify recipient or output bytes after authorization |
| Bilateral receive admission | Receiving owner and quarantine/publish gate | [07](07_information_flow_and_release.md), [23](23_security_mesh_fabrics_and_one_way_links.md), [43](43_dynamic_trust_gateways_and_crossings.md), [45](45_packet_records_delivery_and_egress.md); `INV-06`, `INV-12` | Authenticate record but fail policy; no publication or replay-window poisoning |
| Scoped defensive effects | Local effect owner and time/cumulative budget | [05](05_unified_execution_data_and_effect_contract.md), [26](26_protective_response_and_containment.md); `INV-07`, `INV-08` | A malicious observer proposes a target outside its installed ceiling |
| Durable singular effect | Persistent effect owner, consumption log and receipts | [05](05_unified_execution_data_and_effect_contract.md), [16](16_persistent_objects_storage_and_hese_dar.md), [17](17_transactions_effects_and_reconciliation.md); `INV-01`, `INV-09` | Crash between emission and receipt, followed by retry |
| Independent installation and evidence roots | Physical path/installer inventory plus external evidence tap | [03](03_assurance_trust_and_failure_domains.md), [20](20_master_and_local_security_meshes.md), [22](22_independent_watchers_and_meta_monitoring.md), [27](27_software_update_and_supply_chain_safety.md); `INV-10` (update scope); root independence from [03](03_assurance_trust_and_failure_domains.md) | One compromised reset/debug/key path controls both alleged independent roots |
| Privacy of observations and decisions | Source/observer release gates and query budgets | [07](07_information_flow_and_release.md), [29](29_monitoring_privacy_and_observation_authority.md), [34](34_identity_relationships_delegation_and_revocation.md); `INV-05`, `INV-11` | Adaptive one-bit queries or selective freeze leak a restricted relation |
| Conditional useful service | Protected scheduling/resource admission and safety controller | [09](09_ies_cells_resources_and_scheduling.md), [26](26_protective_response_and_containment.md), [58](58_performance_cost_power_and_availability.md); conditional progress in [55 §6](55_formal_properties_and_state_models.md) | False alerts, fragmentation or shared power eliminate the promised workload |

`INV-XX` labels are those of [Chapter 55](55_formal_properties_and_state_models.md); exact predicates and refinements remain there. A diagram, publication, signature or monitor report cannot replace physical enforcement. An accepted positive control must accompany each attack or fault case.

## 3. Requirement and acceptance ownership index

The table covers 465 canonical requirement IDs and 465 associated acceptance IDs across 62 chapters. Counts identify entries, not independent trust barriers, verified claims or a prescribed number of tests per implementation. A deployment may run many fixtures against one requirement or one adversarial campaign against several requirements. It records each supported and unsupported consequence explicitly.

### Security model and contracts

Primary decision scope: D-01, D-02, D-04, D-06–D-08. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 01](01_system_architecture.md) | `R-01-01`–`R-01-06` (6) | `T-01-01`–`T-01-06` | System trust, useful work and no universal control |
| [Chapter 02](02_requirements_and_threat_model.md) | `R-02-01`–`R-02-50` (50) | `T-02-01`–`T-02-50` | Threat assumptions and top-level protective properties |
| [Chapter 03](03_assurance_trust_and_failure_domains.md) | `R-03-01`–`R-03-06` (6) | `T-03-01`–`T-03-06` | Attacker, roots and failure/cut-set analysis |
| [Chapter 04](04_reference_machine_and_reachability.md) | `R-04-01`–`R-04-08` (8) | `T-04-01`–`T-04-08` | Reference guards, ports, reset and interface inventory |
| [Chapter 05](05_unified_execution_data_and_effect_contract.md) | `R-05-01`–`R-05-07` (7) | `T-05-01`–`T-05-07` | Unified effect admission, finality and receipts |
| [Chapter 06](06_authority_calculus_and_nonexpansion.md) | `R-06-01`–`R-06-07` (7) | `T-06-01`–`T-06-07` | Grant non-expansion and authority derivation |
| [Chapter 07](07_information_flow_and_release.md) | `R-07-01`–`R-07-07` (7) | `T-07-01`–`T-07-07` | Source policy, release, exact output and receiver admission |
| [Chapter 08](08_terminology_and_specification_conventions.md) | `R-08-01`–`R-08-06` (6) | `T-08-01`–`T-08-06` | Terms, states, identifiers and schema rules |

### Owned machine and state

Primary decision scope: D-01–D-04, D-15, D-18. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 09](09_ies_cells_resources_and_scheduling.md) | `R-09-01`–`R-09-06` (6) | `T-09-01`–`T-09-06` | Ownership, cells, borrowing and resource reuse |
| [Chapter 10](10_processor_isa_and_execution_semantics.md) | `R-10-01`–`R-10-05` (5) | `T-10-01`–`T-10-05` | ISA/ABI privilege and execution semantics |
| [Chapter 11](11_heterogeneous_compute_chiplets_and_packaging.md) | `R-11-01`–`R-11-06` (6) | `T-11-01`–`T-11-06` | Chiplet boundaries and accelerator interconnect |
| [Chapter 12](12_memory_cache_and_revocation.md) | `R-12-01`–`R-12-06` (6) | `T-12-01`–`T-12-06` | Protected memory lifecycle and scrub/quarantine |
| [Chapter 13](13_dma_devices_and_accelerators.md) | `R-13-01`–`R-13-06` (6) | `T-13-01`–`T-13-06` | Device/DMA ownership, peer paths and accelerator admission |
| [Chapter 14](14_dmnoc_and_internal_communications.md) | `R-14-01`–`R-14-06` (6) | `T-14-01`–`T-14-06` | Guarded network-on-chip transport and internal path admission |
| [Chapter 15](15_object_mailboxes_and_handoff.md) | `R-15-01`–`R-15-06` (6) | `T-15-01`–`T-15-06` | Guarded inter-domain movement and exact binding |
| [Chapter 16](16_persistent_objects_storage_and_hese_dar.md) | `R-16-01`–`R-16-07` (7) | `T-16-01`–`T-16-07` | Persistent object owners, storage, key isolation and recovery |
| [Chapter 17](17_transactions_effects_and_reconciliation.md) | `R-17-01`–`R-17-06` (6) | `T-17-01`–`T-17-06` | Transactions, partial outcomes and reconciliation |
| [Chapter 18](18_physical_side_channels_and_temporal_protection.md) | `R-18-01`–`R-18-06` (6) | `T-18-01`–`T-18-06` | Physical and timing side channels, scheduling and isolation limits |
| [Chapter 19](19_substrate_and_unconventional_compute_research.md) | `R-19-03`–`R-19-05` (3) | `T-19-03`–`T-19-05` | Experimental compute and sensing substrates |

### Optional observation and response

Primary decision scope: D-09–D-14, D-18. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 20](20_master_and_local_security_meshes.md) | `R-20-01`–`R-20-07` (7) | `T-20-01`–`T-20-07` | Observer configuration and evidence limits |
| [Chapter 21](21_passive_observation_sensors_and_coverage.md) | `R-21-01`–`R-21-07` (7) | `T-21-01`–`T-21-07` | Passive versus active sensor coverage |
| [Chapter 22](22_independent_watchers_and_meta_monitoring.md) | `R-22-01`–`R-22-07` (7) | `T-22-01`–`T-22-07` | Watcher origin and independence |
| [Chapter 23](23_security_mesh_fabrics_and_one_way_links.md) | `R-23-01`–`R-23-07` (7) | `T-23-01`–`T-23-07` | One-way links, alternate paths and receiver admission |
| [Chapter 24](24_security_event_provenance_and_telemetry.md) | `R-24-01`–`R-24-07` (7) | `T-24-01`–`T-24-07` | Security-event provenance and protected telemetry |
| [Chapter 25](25_security_analysis_ai_and_false_alarm_control.md) | `R-25-01`–`R-25-07` (7) | `T-25-01`–`T-25-07` | Optional security analysis and false-alarm control |
| [Chapter 26](26_protective_response_and_containment.md) | `R-26-01`–`R-26-07` (7) | `T-26-01`–`T-26-07` | Local protective actions, safety and budgets |
| [Chapter 27](27_software_update_and_supply_chain_safety.md) | `R-27-01`–`R-27-08` (8) | `T-27-01`–`T-27-08` | Updates, roots and package admission |
| [Chapter 28](28_aesds_iama_and_autonomous_evolution.md) | `R-28-01`–`R-28-07` (7) | `T-28-01`–`T-28-07` | Optional synthesis and engineering containment |
| [Chapter 29](29_monitoring_privacy_and_observation_authority.md) | `R-29-01`–`R-29-07` (7) | `T-29-01`–`T-29-07` | Observation privacy, consent and release |
| [Chapter 30](30_boot_key_custody_recovery_and_continuity.md) | `R-30-01`–`R-30-07` (7) | `T-30-01`–`T-30-07` | Boot, custody and recovery isolation |

### Authority, people and agents

Primary decision scope: D-06–D-08, D-13–D-17. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 31](31_accord_system_and_machine_authorization.md) | `R-31-01`–`R-31-09` (9) | `T-31-01`–`T-31-09` | Accord evaluation, local grant checking and TCB |
| [Chapter 32](32_claim_contract_grant_receipt_schemas.md) | `R-32-01`–`R-32-10` (10) | `T-32-01`–`T-32-10` | Claim/contract/grant/receipt object contracts |
| [Chapter 33](33_pact_protocol_and_state_machines.md) | `R-33-01`–`R-33-07` (7) | `T-33-01`–`T-33-07` | PACT negotiation, installation and abort states |
| [Chapter 34](34_identity_relationships_delegation_and_revocation.md) | `R-34-01`–`R-34-07` (7) | `T-34-01`–`T-34-07` | Identity, delegated authority and revocation |
| [Chapter 35](35_governance_profiles_conflicts_and_institutions.md) | `R-35-01`–`R-35-07` (7) | `T-35-01`–`T-35-07` | Qualified governance and unresolved conflicts |
| [Chapter 36](36_keystone_trusted_user_interaction.md) | `R-36-01`–`R-36-08` (8) | `T-36-01`–`T-36-08` | Trusted user display, approval and intent |
| [Chapter 37](37_ai_native_operating_environment.md) | `R-37-01`–`R-37-07` (7) | `T-37-01`–`T-37-07` | Optional AI environment and tool boundaries |
| [Chapter 38](38_native_apps_toolchains_and_interoperability.md) | `R-38-01`–`R-38-09` (9) | `T-38-01`–`T-38-09` | Application and tooling confinement |
| [Chapter 39](39_agents_delegated_workflows_and_effect_approval.md) | `R-39-01`–`R-39-07` (7) | `T-39-01`–`T-39-07` | Agent effects, standing grants and supervision |

### Network and purpose crossings

Primary decision scope: D-05, D-07, D-10, D-17. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 40](40_societal_planes_and_endpoint_separation.md) | `R-40-01`–`R-40-07` (7) | `T-40-01`–`T-40-07` | Purpose endpoints and encounter separation |
| [Chapter 41](41_stn_atn_mcn_and_purpose_network_roles.md) | `R-41-01`–`R-41-06` (6) | `T-41-01`–`T-41-06` | Network-purpose roles and continuity |
| [Chapter 42](42_physical_transit_topology_and_routing.md) | `R-42-01`–`R-42-06` (6) | `T-42-01`–`T-42-06` | Transit and path assurance limits |
| [Chapter 43](43_dynamic_trust_gateways_and_crossings.md) | `R-43-01`–`R-43-06` (6) | `T-43-01`–`T-43-06` | Qualified crossings and trust gateways |
| [Chapter 44](44_admission_identity_and_sessions.md) | `R-44-01`–`R-44-08` (8) | `T-44-01`–`T-44-08` | Endpoint and session states |
| [Chapter 45](45_packet_records_delivery_and_egress.md) | `R-45-01`–`R-45-10` (10) | `T-45-01`–`T-45-10` | Authenticated records, replay and exact emission |
| [Chapter 46](46_system_wide_release_and_output_channels.md) | `R-46-01`–`R-46-06` (6) | `T-46-01`–`T-46-06` | System-wide output and release-channel coverage |

### Domain profiles and oversight

Primary decision scope: D-06, D-08, D-15, D-16. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 47](47_steles_witness_receipts_and_notice.md) | `R-47-01`–`R-47-07` (7) | `T-47-01`–`T-47-07` | Privacy-scoped witness and notice |
| [Chapter 48](48_media_provenance_and_physical_evidence.md) | `R-48-01`–`R-48-07` (7) | `T-48-01`–`T-48-07` | Optional physical media provenance research |
| [Chapter 49](49_legal_process_rights_and_emergencies.md) | `R-49-01`–`R-49-07` (7) | `T-49-01`–`T-49-07` | Legal process limited to admitted local effects |
| [Chapter 50](50_civic_services_elections_and_public_accountability.md) | `R-50-01`–`R-50-08` (8) | `T-50-01`–`T-50-08` | Civic/election profiles, including alerts |
| [Chapter 51](51_family_care_professional_and_personal_authority.md) | `R-51-01`–`R-51-07` (7) | `T-51-01`–`T-51-07` | Care, guardianship and professional duty |
| [Chapter 52](52_commerce_enterprise_and_institutional_workflows.md) | `R-52-01`–`R-52-07` (7) | `T-52-01`–`T-52-07` | Commerce, payment and settlement distinctions |
| [Chapter 53](53_community_realm_governance_and_disputes.md) | `R-53-01`–`R-53-07` (7) | `T-53-01`–`T-53-07` | Community governance, federation and disputes |

### Evaluation and conformance

Primary decision scope: D-01–D-18 as applicable. The rightmost column states the subject of the owning chapter, not a substitute acceptance oracle.

| Owner | Canonical requirement IDs | Acceptance IDs | Ownership scope |
|---|---|---|---|
| [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md) | `R-54-01`–`R-54-06` (6) | `T-54-01`–`T-54-06` | End-to-end positive/negative case traces |
| [Chapter 55](55_formal_properties_and_state_models.md) | `R-55-01`–`R-55-07` (7) | `T-55-01`–`T-55-07` | Formal state and refinement obligations |
| [Chapter 56](56_conformance_tests_and_vectors.md) | `R-56-01`–`R-56-07` (7) | `T-56-01`–`T-56-07` | Conformance and finite executed fixtures |
| [Chapter 57](57_reference_realizations_and_legacy_interoperability.md) | `R-57-01`–`R-57-06` (6) | `T-57-01`–`T-57-06` | Reference realizations and legacy comparison |
| [Chapter 58](58_performance_cost_power_and_availability.md) | `R-58-01`–`R-58-07` (7) | `T-58-01`–`T-58-07` | Performance, operator cost and availability |
| [Chapter 59](59_assurance_claims_profiles_and_manifests.md) | `R-59-01`–`R-59-07` (7) | `T-59-01`–`T-59-07` | Assurance claims, manifests and profile selection |
| [Chapter 60](60_research_program_and_architectural_decisions.md) | `R-60-01`–`R-60-07` (7) | `T-60-01`–`T-60-07` | Decisions, hypotheses and gated demonstrations |
| [Chapter 61](61_requirement_decision_evidence_traceability.md) | `R-61-01`–`R-61-05` (5) | `T-61-01`–`T-61-05` | Canonical ownership and change impact |
| [Chapter 62](62_prior_art_sources_and_evidence_register.md) | `R-62-01`–`R-62-05` (5) | `T-62-01`–`T-62-05` | Primary publications, scope limits and comparison claims |


## 4. Evidence dossier required for a deployed claim

An implementation dossier has one record for each **applicable** `R-NN-XX`; an excluded requirement needs the profile applicability rule and the affected assurance ceiling. A record must contain:

| Field | Meaning |
|---|---|
| `requirement_id`, `test_ids`, `claim_profile` | Links to canonical text and exact positive/negative controls |
| `operation`, `object`, `finality`, `enforcer` | The checkable consequence and the component controlling it |
| `attacker`, `assumptions`, `roots`, `paths` | Threat powers; physical, policy, boot, reset, debug and observation dependencies |
| `artifact_digests`, `method`, `configuration` | Reproducible proof model, source code, RTL, lab setup or physical inspection |
| `result`, `status`, `unknowns`, `counterexamples` | Actual observations, non-observations, failure evidence and confidence scope |
| `decision_ids`, `source_ids`, `dependencies` | Decision rationale, prior-art comparison and links to dependent claims |
| `custodian`, `reviewer`, `date`, `revalidation_trigger` | Independent review responsibility and changes that void the recorded inference |

Evidence levels are distinct: **specified** (architecture and oracle); **finite model** (named bounds and assumptions); **component measured** (instrumented boundary); **integration measured** (all claimed paths under realistic work and attack); and **operationally observed** (named sites, staff and duration). None entails the next level. A failure may narrow a claim, never silently promote it. For example, a clean role-separation proof cannot attest the actual DMA wiring; a diode continuity measurement cannot validate its payload schema.

A change to compiler grammar, local grant verifier, device generation encoding, policy profile, port wiring, key custodians, exporter, watcher root or human-approval format requires impact analysis across this index. The changed evidence is invalid for dependent claims until qualified again. Claimed observation independence must account for the physical and organizational common causes identified in [Chapter 03](03_assurance_trust_and_failure_domains.md); named extra processes alone add no assurance.

## Normative requirements and acceptance obligations

**R-61-01 — Unique requirement ownership.** Each `R-NN-XX` and its acceptance oracle MUST have one authoritative owning chapter and an entry in this index; references MUST resolve to that definition.

**Acceptance T-61-01:** Compare each chapter's definitions with the index; duplicate owners, missing IDs or unresolved tests fail the document check.

**R-61-02 — Concrete realization evidence.** Each deployed claim MUST identify its actual enforcer, assumptions, admissible positive control and a negative test capable of finding the claimed violation. A nominal actor or source citation is not an enforcer.

**Acceptance T-61-02:** Remove a DMA gate, change an approval digest or corrupt the grant compiler; the dossier must expose the failed guard or withdraw the affected claim.

**R-61-03 — Honest evidence status.** Requirements and proposed acceptance tests MUST NOT be labeled implemented or passed without artifacts bound to the actual configuration, scope and observation method.

**Acceptance T-61-03:** Present finite-model results as a claim that physical DMA or diode paths are secure; reject the unsupported promotion.

**R-61-04 — Complete change impact.** A change to a requirement, source, policy root, interface, schema or physical assumption MUST identify affected decisions, claims, traces, tests and evidence.

**Acceptance T-61-04:** Modify a source-release rule or watcher installer; check dependent results for revalidation and withdrawal.

**R-61-05 — No orphaned guarantees.** Every advertised machine property MUST map to canonical requirements and tests or be identified as a research hypothesis with unestablished status.

**Acceptance T-61-05:** Flag a claim of automatic recovery, private telemetry or physical independence lacking a guard, a mapped oracle or an explicit unvalidated profile.
