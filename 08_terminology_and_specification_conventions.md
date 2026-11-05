# ASKA v6 — Terminology and specification conventions

## 1. Normative language and scope

**MUST** denotes a design obligation, **MUST NOT** a prohibition, **SHOULD** an important recommendation whose deviation needs a documented rationale, and **MAY** a permitted optional choice. These terms specify the proposed architecture. They do not assert that a component exists, has been fabricated or has passed a test. Their conventional requirements-language basis is [BCP 14 / RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.html) and its uppercase clarification [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174.html).

A requirement's canonical definition is in its owner chapter. Other chapters apply it through references and refinements. A profile can declare an unsupported property, but cannot redefine a mandatory physical property as an equally strong logical one. Optional mechanisms become obligations only within the profile that selects them.

“Secure,” “independent,” “trusted” and “out of band” are incomplete claims unless their attacker, property, boundary and assumptions are stated. “Native” concerns the target ownership/effect model; “compatible” concerns a service or legacy environment confined behind a boundary. Neither word is a measured performance claim.

## 2. Machine term registry

| Term | Canonical meaning | Owner |
|---|---|---|
| IES | Physically assigned execution and writable-memory domain for a trust scope | [09](09_ies_cells_resources_and_scheduling.md) |
| Cell | Bounded execution lifetime within an IES | [09](09_ies_cells_resources_and_scheduling.md) |
| Subdomain | Narrower assigned authority/resource scope; not automatically independent hardware | [09](09_ies_cells_resources_and_scheduling.md) |
| MG | Mandatory memory ownership and access guard | [12](12_memory_cache_and_revocation.md) |
| DG | Device/DMA guard outside untrusted descriptors | [13](13_dma_devices_and_accelerators.md) |
| BG | Protected mailbox/handoff boundary | [15](15_object_mailboxes_and_handoff.md) |
| PO | Persistent object owner with typed state transitions | [16](16_persistent_objects_storage_and_hese_dar.md) |
| EO | Owner of a particular consequential finality point | [17](17_transactions_effects_and_reconciliation.md) |
| EG/RG | Egress/receive guard governing emission or protected publication | [45](45_packet_records_delivery_and_egress.md) |
| DMNoC | Decentralized Mesh Network-on-Chip architectural carriage candidate | [14](14_dmnoc_and_internal_communications.md) |
| SRBM | Secure Resource Borrowing Mechanism with lease, reclaim and sanitation | [09](09_ies_cells_resources_and_scheduling.md) |
| HESE-DAR | Hardware-Enforced Secure Encrypted Enclave for Data at Rest candidate | [16](16_persistent_objects_storage_and_hese_dar.md) |
| Immutable sharing | A loan under which every relevant writer is excluded | [15](15_object_mailboxes_and_handoff.md) |
| Exclusive handoff | Acknowledged ownership movement with no overlapping write authority | [15](15_object_mailboxes_and_handoff.md) |
| Finality point | The protected transition establishing a specifically named consequence | [05](05_unified_execution_data_and_effect_contract.md) |
| Reconciliation | Linking intent, commit and later outcome evidence without rewriting receipts | [17](17_transactions_effects_and_reconciliation.md) |

## 3. Security and AI registry

| Term | Meaning and limit | Owner |
|---|---|---|
| TE | Trusted exporter for a declared interface and evidence schema; not universal truth | [24](24_security_event_provenance_and_telemetry.md) |
| LSM | Local Security Mesh receiving permitted local observation | [20](20_master_and_local_security_meshes.md) |
| MSM | Master Security Mesh distributing scoped artifacts and aggregating authorized posture | [20](20_master_and_local_security_meshes.md) |
| WM-L | Independently rooted watcher of a specified LSM and associated paths | [22](22_independent_watchers_and_meta_monitoring.md) |
| WM-M | Independently rooted watcher of MSM distribution/management | [22](22_independent_watchers_and_meta_monitoring.md) |
| OV | Independent oversight receiver for watcher evidence | [04](04_reference_machine_and_reachability.md) |
| SAI | Security analysis AI producing evidence assessments and proposals | [25](25_security_analysis_ai_and_false_alarm_control.md) |
| UAI | User companion AI for interaction, planning and bounded task orchestration | [37](37_ai_native_operating_environment.md) |
| AESDS | Automated Evolutionary Software Development System for candidate generation and controlled evaluation | [28](28_aesds_iama_and_autonomous_evolution.md) |
| IAMA | Isomorphic Architecture Monitoring and Adaptation research candidate for legacy-system analysis | [28](28_aesds_iama_and_autonomous_evolution.md) |
| DTMS | Dynamic Trust Management System supplying bounded risk/trust evidence, not authority | [25](25_security_analysis_ai_and_false_alarm_control.md) |
| ADFAF/Cerberus | Secondary-signal analysis ideas requiring defined features and calibrated tests | [25](25_security_analysis_ai_and_false_alarm_control.md) |
| Passive tap | Observation that does not initiate the monitored transaction | [21](21_passive_observation_sensors_and_coverage.md) |
| Active snapshot | Explicitly authorized acquisition/stabilization of state | [21](21_passive_observation_sensors_and_coverage.md) |
| Standing protective grant | Preinstalled bounded authority for a specified protective template | [26](26_protective_response_and_containment.md) |
| Data diode | Physically one-way channel at the declared interface, without implied content safety | [23](23_security_mesh_fabrics_and_one_way_links.md) |

## 4. Authority, purpose and evidence registry

| Term | Canonical meaning | Owner |
|---|---|---|
| Claim | Typed evidence offered to an authority decision | [32](32_claim_contract_grant_receipt_schemas.md) |
| Contract | Immutable admitted terms and obligations for a scoped action | [32](32_claim_contract_grant_receipt_schemas.md) |
| Grant | Installed attenuated machine authority derived from a contract | [32](32_claim_contract_grant_receipt_schemas.md) |
| Receipt | Qualified evidence of a particular stage or outcome | [32](32_claim_contract_grant_receipt_schemas.md) |
| PACT | Negotiation/admission protocol; agreement alone is not installation | [33](33_pact_protocol_and_state_machines.md) |
| Realm | Independently scoped authority/policy context, not necessarily a country or subnet | [35](35_governance_profiles_conflicts_and_institutions.md) |
| Keystone | Trusted local intent presentation and input/key-use boundary | [36](36_keystone_trusted_user_interaction.md) |
| Sanctum | Personal, intimate, family and care purpose context | [40](40_societal_planes_and_endpoint_separation.md) |
| Polis | Civic and public-institutional purpose context | [40](40_societal_planes_and_endpoint_separation.md) |
| Agora | Commercial, enterprise and contractual purpose context | [40](40_societal_planes_and_endpoint_separation.md) |
| Wilder | Untrusted encounter and external/legacy context | [40](40_societal_planes_and_endpoint_separation.md) |
| Steles | Privacy-scoped witness/accountability role; distinct from watcher meshes | [47](47_steles_witness_receipts_and_notice.md) |
| STN | Sovereign Trust Network: trust governance and selected continuity relationships | [41](41_stn_atn_mcn_and_purpose_network_roles.md) |
| ATN | Authenticated Trust Network: authenticated carriage/admission arrangements | [41](41_stn_atn_mcn_and_purpose_network_roles.md) |
| MCN | Multi-Channel Network: several declared carriage channels | [41](41_stn_atn_mcn_and_purpose_network_roles.md) |
| DTG | Dynamic Trust Gateway terminating and mediating a particular crossing | [43](43_dynamic_trust_gateways_and_crossings.md) |
| MDATS | Multi-Dimensional Audit Trail System candidate combining digital and physical evidence | [48](48_media_provenance_and_physical_evidence.md) |
| SHVS | Secure Hyper-Virtualization System collaboration/compatibility candidate | [38](38_native_apps_toolchains_and_interoperability.md) |
| ZKEE | Zero-Knowledge Execution Environment research objective, requiring a selected proof/privacy model | [38](38_native_apps_toolchains_and_interoperability.md) |

## 5. Identity and time namespaces

An object reference is `(realm_id, owner_id, object_id, generation)`. A cell reference includes `cell_id` and `cell_epoch`; a grant includes `grant_id` and `grant_epoch`. `boot_epoch`, `policy_epoch` and `observer_epoch` distinguish reset, policy and evidence lifetimes. A namespace owner is explicit; identical local integers in different realms are not the same identity.

Manifests state field widths, canonical encoding, exhaustion behavior, persistence and wrap prevention. Counter wrap cannot silently create an old identity. If a protected counter is lost, the affected scope is retired or re-enrolled under a non-repeating identity. Random identifiers reduce collisions only under declared entropy and collision handling; they do not replace authorization.

A time interval includes its clock basis and uncertainty. A remote timestamp without a trusted clock relation cannot establish local ordering. Protected counters can establish local sequence without proving wall-clock time. `unknown`, `not_observed`, `not_applicable` and `false` are different typed values. Missing evidence cannot be silently coerced to success or inactivity.

## 6. State and schema ownership

Common effect states are `PROPOSED`, `PREPARED`, `COMMITTED`, `RECONCILED`, `DENIED`, `ABORTED` and `UNCERTAIN`, defined in [Chapter 05](05_unified_execution_data_and_effect_contract.md). PACT states, governed by [Chapter 33](33_pact_protocol_and_state_machines.md), describe negotiation and installation lifecycle and do not replace effect states. Assurance status, sensor confidence and delivery status are separate fields.

A schema version identifies an encoding contract, not an architecture history. Unknown critical fields, duplicate map keys, ambiguous integer representations and unrecognized enum values are rejected under the selected encoding profile. Algorithms and cryptographic examples must specify exact input bytes. An illustrative object with a placeholder signature is not an interoperable test vector.

## 7. Identifiers and dependencies

Requirements use `R-NN-XX`, acceptance oracles use `T-NN-XX`, architectural decisions use `D-XX`, end-to-end traces use `C-XX`, and finite executable demonstrations use `M-XX`. `NN` is the canonical owner chapter. The ownership index in [Chapter 61](61_requirement_decision_evidence_traceability.md) resolves requirement/test IDs to their chapter definitions and identifies evidence dependencies. The definition and acceptance oracle occur only in the owning chapter. A referenced ID must resolve to a definition.

“Depends on” means a claim fails or becomes unestablished when its prerequisite fails. “Uses” means a functional relationship that may permit degraded alternatives. “Observes” names a visibility boundary. “Authorizes” means a particular installed effect right, never an arrow drawn for explanatory convenience. Diagrams distinguish these edge types and refer to the same physical interface register as the prose.

## Cross-register identifiers

`R-NN-XX` identifies a normative requirement owned by Chapter NN; `T-NN-XX` identifies its acceptance obligation. `INV-XX` identifies a formal proof obligation in Chapter 55, not a proved theorem. `D-XX` identifies a current architectural decision and `H-XX` a falsifiable hypothesis in Chapter 60. `C-XX` identifies a complete conceptual incident or transaction in Chapter 54. Source prefixes H, F, P, S and A identify entries in Chapter 62; every citation must still resolve to an actual URL. These namespaces are disjoint, and none of their identifiers is executable authority.

Protocol object types, PACT states, effect states, evaluation dispositions and security event families are separate enums. A receipt may record a denied evaluation, an established local commit and a separately uncertain downstream effect without merging those state machines. Unknown critical values fail admission under the applicable schema; prose aliases never select a more permissive operation.

## Requirement wording and testability

Normative statements identify one responsible enforcing boundary, one checkable consequence and the assumptions under which it holds. A security claim needs a positive authorized control and an adversarial falsifier; a documentation obligation is normative only when the document or manifest is itself the protected artifact. Keep rationale and comparative literature outside the requirement sentence. The [NASA requirements checklist](https://www.nasa.gov/reference/appendix-c-how-to-write-a-good-requirement/) distinguishes necessary, testable requirements from aspirations.

Use one term per technical concept and define its scope at first use. Prefer a direct actor–action sentence, explicit field or state name, and a short counterexample over a string of synonyms or generic exclusions. Put common claims once at the owning boundary and cross-reference them elsewhere; do not duplicate a test oracle in the traceability index. The [NASA Kennedy technical-documentation style guide](https://standards.nasa.gov/sites/default/files/standards/KSC/F/0/ksc-df-107_rev_f_07082017.pdf) and the [UK Government functional-standards writing guide](https://www.gov.uk/government/publications/handbook-for-standard-managers/functional-standards-writing-style-guide) likewise prefer short direct sentences, explicit responsibility and one idea per requirement. This follows [IBM's consistency guidance](https://www.ibm.com/docs/en/technical-content?topic=standards-style), [the RFC Editor's requirement to preserve technical meaning](https://www.rfc-editor.org/rfc/rfc7322.html), and [Microsoft's guidance on precise, concise terminology](https://learn.microsoft.com/en-us/style-guide/word-choice/use-simple-words-concise-sentences).

Use uppercase `MUST`, `MUST NOT`, `SHOULD` and `MAY` only with the [BCP 14 interpretation](https://www.rfc-editor.org/rfc/rfc8174.html). A numerical bound is either part of a named implementation profile or an explicit open parameter; a sample value is never a hidden universal limit. Source links identify the exact publication and the proposition used. Unknown evidence remains unknown; labels such as *verified*, *independent* and *secure* always name a property and apparatus.

## Normative requirements and acceptance obligations

**R-08-01 — Canonical vocabulary.** All components and profiles MUST use the canonical meanings and separate authority, effect, delivery and assurance states.

**Acceptance T-08-01:** Feed an effect outcome as a PACT state or treat a watcher as Steles; reject the type mismatch.

**R-08-02 — Lifetime-qualified identities.** Protected references MUST include their owner namespace and non-reusable lifetime identity.

**Acceptance T-08-02:** Reuse local IDs across realms and reset generations; stale or cross-namespace requests must not alias live objects.

**R-08-03 — Explicit time uncertainty.** Time-dependent authority MUST bind a declared clock/counter basis and distinguish unknown from valid.

**Acceptance T-08-03:** Remove clock continuity and inject old timestamps; no expired authority is extended by ambiguity.

**R-08-04 — Unambiguous schema.** Critical objects MUST reject ambiguous encodings, duplicate critical keys and unknown critical semantics.

**Acceptance T-08-04:** Use duplicate keys, alternate integer encodings and unsupported operation enums; require deterministic rejection.

**R-08-05 — Resolvable requirements.** Every normative requirement and acceptance identifier MUST have one canonical definition and a traceability entry.

**Acceptance T-08-05:** Resolve every requirement/test reference, reject duplicates and report any missing enforcer, assumption or oracle.

**R-08-06 — Typed dependency edges.** Architecture manifests MUST distinguish authorization, observation, data, management and physical-failure dependencies.

**Acceptance T-08-06:** Compare diagrams and interface registers; an unlabeled alternate management path fails the claim.

