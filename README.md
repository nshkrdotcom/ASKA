# ASKA 4.0 — Research Architecture

**22 October 2026**

ASKA proposes a computing and networking architecture whose boundaries remain effective after a component is compromised. It combines physically owned execution resources, private memory, explicit object and effect authority, networks separated by purpose, independently governed security domains, and an AI-first operating environment.

Start with the [architecture and reading map](0300_architecture_and_reading_map.md).

## Architecture

The selected organization is a spatial object machine. Small execution domains own their compute and writable memory for an admitted lifetime. They exchange bounded objects through protected interfaces. Persistent services own durable state and independently authorize operations. Native cross-trust execution requires physical resource ownership; high-consequence policy and recovery functions use independently rooted domains.

Purpose-specific physical fabrics constrain connectivity. Source release controls and destination effect checks constrain what may cross them. Network membership and authentication confer no implicit operation or disclosure rights. The same rules apply to peripherals, printing, displays, removable storage, management, and recovery paths.

The AI environment supports interaction, context retrieval, application construction, and orchestration. Isolated planners and builders propose work; protected interaction, admission, and effect services enforce its authority. A compromised planner cannot create consent or approve its own deployment.

The architecture defines required semantics without selecting a binary ISA, fabrication process, interconnect, or production packet encoding. Existing capability processors, new object instructions, spatial/dataflow engines, advanced integration, and optical links are candidates evaluated against the same requirements.

This is an unvalidated research architecture. No complete ASKA hardware, protocol implementation, performance result, or security proof is claimed. The documents separate selected designs, assumptions, demonstrated external work, open research, and intermediate realizations.

## Documents

| Documents | Contents |
|---|---|
| [0300 — Overview](0300_architecture_and_reading_map.md) · [0301 — Requirements](0301_requirements_and_threat_model.md) · [0302 — Decisions](0302_architectural_candidates_and_decisions.md) | Organization, threat model, requirements, and competing designs |
| [0303 — Physical substrate](0303_physical_substrate_and_frontier.md) · [0304 — Execution](0304_execution_and_instruction_semantics.md) · [0305 — Memory](0305_memory_ownership_and_lifecycle.md) | Physical profiles, processor semantics, ownership, and safe reuse |
| [0306 — Persistence](0306_persistence_and_effects.md) · [0307 — Information flow](0307_authority_and_information_flow.md) | Durable effects, scoped grants, confinement, and release |
| [0308 — Applications](0308_native_applications_and_development.md) · [0309 — AI environment](0309_ai_environment_and_trusted_interaction.md) | Component contracts, development, user interaction, and isolated agents |
| [0310 — Purpose networks](0310_purpose_networks_and_gateways.md) · [0311 — Delivery](0311_admission_and_delivery.md) | Physical topology, gateways, admission, replay, and publication |
| [0312 — Governance](0312_governance_updates_and_recovery.md) · [0313 — Failure cases](0313_compromise_and_failure_cases.md) | Independent management, updates, recovery, and adversarial scenarios |
| [0314 — Validation](0314_validation_and_cost_models.md) · [0315 — Research program](0315_research_and_realizations.md) | Models, experiments, cost comparisons, and long-term dependencies |
| [0316 — Traceability](0316_traceability_and_evolution.md) · [0317 — Sources](0317_sources_and_evidence.md) | Requirement-to-design mapping and primary-source evidence |
| [0318 — Cross-domain security](0318_cross_domain_security_and_information_release.md) | Insider threats, adversarial bridges, information release, and observation limits |

## Earlier versions

Historical documentation is preserved in [v1](v1/ARCHIVE_NOTICE.md), [v2](v2/README.md), and [v3](v3/README.md). The root documents describe ASKA 4.0.

## License and contributions

Original documentation and diagrams are licensed under [Creative Commons Attribution 4.0 International](LICENSE), except where separate terms are identified. Third-party material retains its own terms. Suggested attribution: **Paul Lowndes and ASKA contributors, ASKA 4.0**, with this repository and the commit used. The copyright license does not grant patent rights.

Contributions can include counterexample traces, corrected assumptions, source comparisons, and reproducible models or measurements. Identify the document and requirement being tested, distinguish proposals from observed results, and include the conditions needed to reproduce any result. Original documentation contributions use the repository's CC BY 4.0 license; identify separately licensed material.
