# ASKA 4.0 — Research Architecture

**22 October 2026**

ASKA proposes a computing and networking architecture whose boundaries remain effective after a component is compromised. Its execution domains own physical compute and private memory. Explicit authority governs objects and effects, physical networks separate purposes, and independent authorities govern security domains. An AI-first operating environment connects these services to user tasks.

Start with the [architecture and reading map](01_architecture_and_reading_map.md).

## Architecture

The selected organization is a spatial object machine. Small execution domains own their compute and writable memory for an admitted lifetime. They exchange bounded objects through protected interfaces. Persistent services own durable state and independently authorize operations. Native cross-trust execution requires physical resource ownership; high-consequence policy and recovery functions use independently rooted domains.

Purpose-specific physical fabrics constrain connectivity. Source release controls and destination effect checks constrain what may cross them. Network membership and authentication confer no implicit operation or disclosure rights. The same rules apply to peripherals, printing, displays, removable storage, management, and recovery paths.

The AI environment supports interaction, context retrieval, application construction, and orchestration. Isolated planners and builders propose work; protected interaction, admission, and effect services enforce its authority. A compromised planner cannot create consent or approve its own deployment.

The architecture defines required semantics without selecting a binary ISA, fabrication process, interconnect, or production packet encoding. Candidate mechanisms include existing capability processors, new object instructions, spatial/dataflow engines, advanced integration, and optical links. Each is evaluated against the same requirements.

This is an unvalidated research architecture. No complete ASKA hardware, protocol implementation, performance result, or security proof is claimed. The documents identify selected designs, assumptions, external demonstrations, open research, and intermediate realizations.

## Documents

| Documents | Contents |
|---|---|
| [01 — Overview](01_architecture_and_reading_map.md) · [02 — Requirements](02_requirements_and_threat_model.md) · [03 — Decisions](03_architectural_candidates_and_decisions.md) | Organization, threat model, requirements, and competing designs |
| [04 — Physical substrate](04_physical_substrate_and_frontier.md) · [05 — Execution](05_execution_and_instruction_semantics.md) · [06 — Memory](06_memory_ownership_and_lifecycle.md) | Physical profiles, processor semantics, ownership, and safe reuse |
| [07 — Persistence](07_persistence_and_effects.md) · [08 — Information flow](08_authority_and_information_flow.md) | Durable effects, scoped grants, confinement, and release |
| [09 — Applications](09_native_applications_and_development.md) · [10 — AI environment](10_ai_environment_and_trusted_interaction.md) | Component contracts, development, user interaction, and isolated agents |
| [11 — Purpose networks](11_purpose_networks_and_gateways.md) | Physical topology and gateways |
| [12 — Cross-domain security](12_cross_domain_security_and_information_release.md) | Insider threats, adversarial bridges, information release, and observation limits |
| [13 — Delivery](13_admission_and_delivery.md) | Admission, replay, and publication |
| [14 — Governance](14_governance_updates_and_recovery.md) · [15 — Failure cases](15_compromise_and_failure_cases.md) | Independent management, updates, recovery, and adversarial scenarios |
| [16 — Validation](16_validation_and_cost_models.md) · [17 — Research program](17_research_and_realizations.md) | Models, experiments, cost comparisons, and long-term dependencies |
| [18 — Traceability](18_traceability_and_evolution.md) · [19 — Sources](19_sources_and_evidence.md) | Requirement-to-design mapping and primary-source evidence |

## Earlier versions

Historical documentation is preserved in [v1](v1/ARCHIVE_NOTICE.md), [v2](v2/README.md), and [v3](v3/README.md). The root documents describe ASKA 4.0.

## License and contributions

Original documentation and diagrams are licensed under [Creative Commons Attribution 4.0 International](LICENSE), except where separate terms are identified. Third-party material retains its own terms. Suggested attribution: **Paul Lowndes and ASKA contributors, ASKA 4.0**, with this repository and the commit used. The copyright license does not grant patent rights.

Contributions can include counterexample traces, corrected assumptions, source comparisons, and reproducible models or measurements. Identify the document and requirement being tested, distinguish proposals from observed results, and include the conditions needed to reproduce any result. Original documentation contributions use the repository's CC BY 4.0 license; identify separately licensed material.
