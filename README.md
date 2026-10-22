# ASKA 3.0 — Research Architecture

**22 October 2026**

ASKA proposes a computer and network architecture that enforces authority across compute, memory, devices, and communication. Its Isolated Execution Stacks (IESs) contain workloads within hardware-enforced resource boundaries. Protected endpoints and forwarding gates check operations independently of ordinary host kernels, drivers, and route controllers.

Start with the [architecture and reading map](0010_architecture_and_reading_map_gpt.md).

## Architecture

The native compute target is 64-bit RISC-V with CHERI capability extensions in a multi-chiplet package. Dedicated engines handle the common packet path; isolated services manage policy, admission, and lifecycle. seL4 is an optional management kernel or VM supervisor.

The endpoint and gate experiments can run on existing platforms before native capability compute is integrated. Those experiments test external confinement; they do not establish capability protection inside ordinary application domains.

The message profile uses coherent protected copying for payloads up to 1 KiB. A separate bulk path transfers an allocation across a batch of independent child records. Online admission installs bounded authority under each realm's policy. Receivers consume authenticated sequences even when delivery is denied, then recheck current policy at the publication commit. Transport profiles distinguish endpoint overlays, SCION integration, and an experimental native fabric.

This is a research specification. ASKA has no implemented protocol, fabricated silicon, measured performance, or completed security proof. The next work is to model receive ordering and memory ownership, compare existing transit protocols, and measure compute and data-path costs. The documents distinguish requirements, experimental parameters, calculations, and unresolved implementation choices.

## Documents

| Document | Contents |
|---|---|
| [0010 — Architecture and reading map](0010_architecture_and_reading_map_gpt.md) | System decisions, threat model, and reading order |
| [0011 — Compute, ISA, and IES](0011_compute_isa_and_ies_gpt.md) | Native compute, compatibility, capabilities, and seL4 |
| [0012 — Authority and information flow](0012_authority_and_information_flow_gpt.md) | Grants, categories, confinement, and controlled release |
| [0013 — Memory ownership and lifecycle](0013_memory_ownership_and_lifecycle_gpt.md) | Message and batch lifetime, credits, revocation, DMA, and reuse |
| [0014 — Identity and online admission](0014_identity_and_online_admission_gpt.md) | Discovery, bilateral admission, keys, leases, and recovery |
| [0015 — Transport and protected transit](0015_transport_and_protected_transit_gpt.md) | Forwarding profiles, protocol comparisons, grants, and physical egress |
| [0016 — Records and receive processing](0016_records_and_receive_processing_gpt.md) | Wire format, replay, policy commit, quarantine, and publication |
| [0017 — Chiplets and hardware integration](0017_chiplets_and_hardware_integration_gpt.md) | Package organization, protected I/O, firmware, debug, and reset |
| [0018 — Performance and validation](0018_performance_and_validation_gpt.md) | Cost studies, models, attack campaigns, and validation criteria |
| [0019 — Implementation contracts and sources](0019_implementation_contracts_and_sources_gpt.md) | Interfaces, implementation evidence, and technical references |

## Earlier versions

The previous documents are preserved in [v2](v2/README.md). The original material remains in [ASKA_v1](ASKA_v1/ARCHIVE_NOTICE.md). Both are historical archives; the root documents describe the current architecture.

## License and contributions

Original documentation and diagrams are licensed under [Creative Commons Attribution 4.0 International](LICENSE), except where separate terms are identified. Third-party material retains its own terms. Suggested attribution: **Paul Lowndes and ASKA contributors, ASKA 3.0**, with this repository and the commit used. The copyright license does not grant patent rights.

Contributions can include counterexample traces, corrected assumptions, source comparisons, and reproducible models or measurements. Identify the document and property being tested, distinguish proposals from observed results, and include the conditions needed to reproduce any result. Original documentation contributions use the repository's CC BY 4.0 license; identify separately licensed material.
