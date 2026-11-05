# ASKA v6 — Terminology and specification conventions

## Normative language and scope

**MUST** denotes a design obligation, **MUST NOT** a prohibition, **SHOULD** an important recommendation whose deviation needs a documented rationale, and **MAY** a permitted optional choice. These terms specify the proposed architecture. They do not assert that a component exists, has been fabricated or has passed a test. Their conventional requirements-language basis is [BCP 14 / RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.html) and its uppercase clarification [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174.html).

A requirement's canonical definition is in its owner chapter. Other chapters apply it through references and refinements. A profile can declare an unsupported property, but cannot redefine a mandatory physical property as an equally strong logical one. Optional mechanisms become obligations only within the profile that selects them.

“Secure,” “independent,” “trusted” and “out of band” are incomplete claims unless their attacker, property, boundary and assumptions are stated. “Native” concerns the target ownership/effect model; “compatible” concerns a service or legacy environment confined behind a boundary. Neither word is a measured performance claim.

## Machine term registry

| Term | Canonical meaning | Owner |
|---|---|---|
| IES | Physically assigned execution and writable-memory domain for a trust scope | [09](09_ies_cells_resources_and_scheduling.md) |
| Cell | Bounded execution lifetime within an IES | [09](09_ies_cells_resources_and_scheduling.md) |
| Subdomain | Narrower assigned authority/resource scope; not automatically independent hardware | [09](09_ies_cells_resources_and_scheduling.md) |
| MG | Mandatory memory ownership and access guard | [12](12_memory_cache_and_revocation.md) |
| DG | Device/DMA guard outside untrusted descriptors | [13](13_dma_devices_and_accelerators.md) |
| BG | Protected mailbox/handoff boundary | [15](15_object_mailboxes_and_handoff.md) |
| PO | Persistent object owner with typed state transitions | [16](16_persistent_objects_and_storage_recovery.md) |
| EO | Owner of a particular consequential finality point | [17](17_transactions_effects_and_reconciliation.md) |
| EG/RG | Egress/receive guard governing emission or protected publication | [38](38_packet_records_delivery_and_egress.md) |
| DMNoC | Decentralized Mesh Network-on-Chip architectural carriage candidate | [14](14_dmnoc_and_internal_communications.md) |
| Immutable sharing | A loan under which every relevant writer is excluded | [15](15_object_mailboxes_and_handoff.md) |
| Exclusive handoff | Acknowledged ownership movement with no overlapping write authority | [15](15_object_mailboxes_and_handoff.md) |
| Finality point | The protected transition establishing a specifically named consequence | [05](05_unified_execution_data_and_effect_contract.md) |
| Reconciliation | Linking intent, commit and later outcome evidence without rewriting receipts | [17](17_transactions_effects_and_reconciliation.md) |

## Security and AI registry

| Term | Meaning and limit | Owner |
|---|---|---|
| TE | Trusted exporter for a declared interface and evidence schema; not universal truth | [21](21_security_fabrics_telemetry_and_provenance.md) |
| LSM | Local Security Mesh receiving permitted local observation | [19](19_security_observation_and_local_meshes.md) |
| MSM | Master Security Mesh distributing scoped artifacts and aggregating authorized posture | [19](19_security_observation_and_local_meshes.md) |
| WM-L | Independently rooted watcher of a specified LSM and associated paths | [20](20_independent_watchers_and_meta_monitoring.md) |
| WM-M | Independently rooted watcher of MSM distribution/management | [20](20_independent_watchers_and_meta_monitoring.md) |
| OV | Independent oversight receiver for watcher evidence | [04](04_reference_machine_and_reachability.md) |
| SAI | Security analysis AI producing evidence assessments and proposals | [22](22_security_analysis_ai_and_false_alarm_control.md) |
| UAI | User companion AI for interaction, planning and bounded task orchestration | [32](32_ai_environment_agents_and_effect_approval.md) |
| AESDS | Automated Evolutionary Software Development System for candidate generation and controlled evaluation | [24](24_software_update_generation_and_supply_chain.md) |
| IAMA | Isomorphic Architecture Monitoring and Adaptation research candidate for legacy-system analysis | [24](24_software_update_generation_and_supply_chain.md) |
| Passive tap | Observation that does not initiate the monitored transaction | [19](19_security_observation_and_local_meshes.md) |
| Active snapshot | Explicitly authorized acquisition/stabilization of state | [19](19_security_observation_and_local_meshes.md) |
| Standing protective grant | Preinstalled bounded authority for a specified protective template | [23](23_protective_response_and_containment.md) |
| Data diode | Physically one-way channel at the declared interface, without implied content safety | [21](21_security_fabrics_telemetry_and_provenance.md) |

## Authority, purpose and evidence registry

| Term | Canonical meaning | Owner |
|---|---|---|
| Claim | Typed evidence offered to an authority decision | [28](28_authority_schemas_and_pact_protocol.md) |
| Contract | Immutable admitted terms and obligations for a scoped action | [28](28_authority_schemas_and_pact_protocol.md) |
| Grant | Installed attenuated machine authority derived from a contract | [28](28_authority_schemas_and_pact_protocol.md) |
| Receipt | Qualified evidence of a particular stage or outcome | [28](28_authority_schemas_and_pact_protocol.md) |
| PACT | Negotiation/admission protocol; agreement alone is not installation | [28](28_authority_schemas_and_pact_protocol.md) |
| Realm | Independently scoped authority/policy context, not necessarily a country or subnet | [30](30_governance_profiles_conflicts_and_institutions.md) |
| Keystone | Trusted local intent presentation and input/key-use boundary | [31](31_keystone_trusted_user_interaction.md) |
| Sanctum | Personal, intimate, family and care purpose context | [34](34_purpose_planes_and_network_roles.md) |
| Polis | Civic and public-institutional purpose context | [34](34_purpose_planes_and_network_roles.md) |
| Agora | Commercial, enterprise and contractual purpose context | [34](34_purpose_planes_and_network_roles.md) |
| Wilder | Untrusted encounter and external/legacy context | [34](34_purpose_planes_and_network_roles.md) |
| Steles | Privacy-scoped witness/accountability role; distinct from watcher meshes | [40](40_witnesses_media_provenance_and_notice.md) |
| STN | Sovereign Trust Network: trust governance and selected continuity relationships | [34](34_purpose_planes_and_network_roles.md) |
| ATN | Authenticated Trust Network: authenticated carriage/admission arrangements | [34](34_purpose_planes_and_network_roles.md) |
| MCN | Multi-Channel Network: several declared carriage channels | [34](34_purpose_planes_and_network_roles.md) |
| DTG | Dynamic Trust Gateway terminating and mediating a particular crossing | [36](36_dynamic_trust_gateways_and_crossings.md) |

## Identity and time namespaces

An object reference is `(realm_id, owner_id, object_id, generation)`. A cell reference includes `cell_id` and `cell_epoch`; a grant includes `grant_id` and `grant_epoch`. `boot_epoch`, `policy_epoch` and `observer_epoch` distinguish reset, policy and evidence lifetimes. A namespace owner is explicit; identical local integers in different realms are not the same identity.

Manifests state field widths, canonical encoding, exhaustion behavior, persistence and wrap prevention. Counter wrap cannot silently create an old identity. If a protected counter is lost, the affected scope is retired or re-enrolled under a non-repeating identity. Random identifiers reduce collisions only under declared entropy and collision handling; they do not replace authorization.

A time interval includes its clock basis and uncertainty. A remote timestamp without a trusted clock relation cannot establish local ordering. Protected counters can establish local sequence without proving wall-clock time. `unknown`, `not_observed`, `not_applicable` and `false` are different typed values. Missing evidence cannot be silently coerced to success or inactivity.

## State and schema ownership

Common effect states are `PROPOSED`, `PREPARED`, `COMMITTED`, `RECONCILED`, `DENIED`, `ABORTED` and `UNCERTAIN`, defined in [Chapter 05](05_unified_execution_data_and_effect_contract.md). PACT states, governed by [Chapter 28](28_authority_schemas_and_pact_protocol.md), describe negotiation and installation lifecycle and do not replace effect states. Assurance status, sensor confidence and delivery status are separate fields.

A schema version identifies an encoding contract, not an architecture history. Unknown critical fields, duplicate map keys, ambiguous integer representations and unrecognized enum values are rejected under the selected encoding profile. Algorithms and cryptographic examples must specify exact input bytes. An illustrative object with a placeholder signature is not an interoperable test vector.

## Identifiers and dependencies

Requirements use `R-NN-XX`, acceptance oracles use `T-NN-XX`, architectural decisions use `D-XX`, end-to-end traces use `C-XX`, and finite executable demonstrations use `M-XX`. `NN` is the canonical owner chapter. Definitions and acceptance oracles reside in the owning chapter; evidence status belongs to its specific realization dossier in [Chapter 50](50_assurance_claims_profiles_and_manifests.md). Every referenced identifier must resolve.

“Depends on” means a claim fails or becomes unestablished when its prerequisite fails. “Uses” means a functional relationship that may permit degraded alternatives. “Observes” names a visibility boundary. “Authorizes” means a particular installed effect right, never an arrow drawn for explanatory convenience. Diagrams distinguish these edge types and refer to the same physical interface register as the prose.

## Required behavior and test oracles

**R-08-01 — Canonical vocabulary.** All components and profiles MUST use the canonical meanings and separate authority, effect, delivery and assurance states.

**Acceptance T-08-01:** Feed an effect outcome as a PACT state or treat a watcher as Steles; reject the type mismatch.

**R-08-02 — Lifetime-qualified identities.** Protected references MUST include their owner namespace and non-reusable lifetime identity.

**Acceptance T-08-02:** Reuse local IDs across realms and reset generations; stale or cross-namespace requests must not alias live objects.

**R-08-03 — Explicit time uncertainty.** Time-dependent authority MUST bind a declared clock/counter basis and distinguish unknown from valid.

**Acceptance T-08-03:** Remove clock continuity and inject old timestamps; no expired authority is extended by ambiguity.

**R-08-04 — Unambiguous schema.** Critical objects MUST reject ambiguous encodings, duplicate critical keys and unknown critical semantics.

**Acceptance T-08-04:** Use duplicate keys, alternate integer encodings and unsupported operation enums; require deterministic rejection.

**R-08-06 — Typed dependency edges.** Architecture manifests MUST distinguish authorization, observation, data, management and physical-failure dependencies.

**Acceptance T-08-06:** Compare diagrams and interface registers; an unlabeled alternate management path fails the claim.
