# ASKA v5 — Requirements traceability, decisions, and evidence obligations

## 1. Stable requirements

This document maps the system requirements R01–R24 and Accord additions A01–A16 to technical chapters and external evidence. A requirement is **target semantics**; `established` means a specific implementation has supplied reproducible proof or tests within an explicit observer model. Unsupported mechanisms cannot be declared satisfied simply because a simulation omits them.

| Requirements | Primary design locations | Core demonstration obligation |
|---|---|---|
| R01, R06, R19, R20, A01–A04, A13 | [03](03_authority_calculus_and_conflicts.md), [04](04_accord_objects_and_schemas.md), [05](05_pact_negotiation_and_states.md), [14](14_persistence_and_effects.md) | No implicit rights; effect/receipt phases distinct |
| R02, R03, R15, R17 | [11](11_physical_substrate_and_hardware.md), [12](12_execution_and_instruction_semantics.md), [16](16_native_applications_and_development.md) | Malicious independent cell cannot reach foreign memory/effects |
| R04, R11, R12, A05, A11, A14, A15 | [10](10_societal_planes_and_keystone.md), [18](18_network_fabrics_and_gateways.md), [24](24_deployment_reference_designs.md) | Actual physical resources, flooding and common-cause graph |
| R05, R21–R24 | [13](13_memory_ownership_and_lifecycle.md), [15](15_authority_and_information_flow.md), [19](19_cross_domain_security_and_release.md) | No label laundering, arbitrary bridge or output substitution |
| R07, R08 | [13](13_memory_ownership_and_lifecycle.md), [14](14_persistence_and_effects.md), [20](20_admission_transport_and_protected_delivery.md) | Reuse, revocation, replay, crash and receipt finality |
| R09, A06 | [17](17_ai_environment_and_trusted_interaction.md), [33](33_formal_properties_and_model_sketch.md) | AI fully compromised; approvals and effects still bounded |
| R10, A07–A10, A12, A16 | [06](06_identity_relationships_and_delegation.md) through [09](09_civic_services_and_elections.md), [21](21_steles_witness_and_notice.md), [22](22_governance_updates_and_recovery.md) | Role/quorum/notice/appeal and no root expansion |
| R13, R16, R18 | [23](23_compromise_and_failure_cases.md), [25](25_validation_and_cost_models.md), [27](27_conformance_tests_and_vectors.md), [30](30_sources_and_evidence.md) | Full malicious application path and attributable observations |
| R14 | [26](26_architectural_tradeoffs_and_decisions.md), [28](28_research_program_and_realizations.md) | Every change lists affected IDs, tests and open evidence |

## 2. Decision log

Decisions D01–D09 governing the native spatial object machine, physical purpose fabrics, isolated AI, governed changes and independent release are in [26](26_architectural_tradeoffs_and_decisions.md). D10–D15 cover the societal planes, Accord semantics, Keystone/Steles distinction, active-plane physical reference architecture, lawful-process limitations and AI authority. These are selected architecture positions; their implementation is tested rather than presumed.

A change entry MUST contain: decision identifier, triggering counterexample, alternative designs, affected requirement IDs, changed threat assumptions, concrete cost/benefit, responsible reviewer, and evidence required before claims can change. A new path or management override cannot bypass review because it is called “operational.”

## 3. Physical/common-cause register

Every independent component gets a separate row for: fabrication, packaging, crypto root, key custodians, boot/update signing, recovery, power, timing, reset, cooling, interconnect, DMA, physical port, optical/radio link, community provider and upstream facility. Count minimal shared-failure sets rather than multiplying unsupported independent probabilities. A regional outage may impact physically independent endpoint paths simultaneously if they share the same metro conduit or exchange.

## 4. Evidence categories

- **Specification:** a published required behavior, protocol, or draft.
- **Model:** an executable abstraction that depends on explicit axioms.
- **Proof:** a mechanically or manually reviewed demonstration over defined states and trusted components.
- **Measured prototype:** results with exact hardware/firmware/configuration and raw workload.
- **Informative prior art:** external systems with different threat models or guarantees.
- **Research hypothesis:** a proposed property not yet established in an ASKA realization.

No evidence category substitutes for another. The existence of a cryptographic standard does not prove system-level secure key custody, and proof of a microkernel does not automatically cover an ASKA NIC, display, firmware update chain or physical side channels.

## 5. Mandatory review questions

Does a new convenience service share a root, data store or authority across planes? Can AI approval wording vary without changing the contract digest? Did an authenticated network admit a new disclosure? Does a fallback path use Wilder resources for established civic sessions? Can a device or media export bypass source release checks? Can one firmware signer or recovery custodian defeat multiple roots? Can an attacker produce a false completion receipt after crash? Can independent reviewers reconstruct a contested institutional action from minimal protected evidence?
