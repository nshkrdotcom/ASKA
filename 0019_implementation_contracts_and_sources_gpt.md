# ASKA — Implementation contracts and sources

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0018_performance_and_validation_gpt.md)

Implementation manifests select the components and parameters needed to meet this architecture's requirements. An implementation that omits a requirement must identify the different protection profile it provides.

## Architectural commitments

| Area | Required direction | Implementation choice still to resolve |
|---|---|---|
| Native compute | RV64 with CHERI extensions and pure-capability software | Exact specification revisions, core, ABI, vector extensions, OS/runtime |
| IES isolation | Protected resource boundaries independent of ordinary host control | Core sharing, cache partitions, memory-region sizing |
| Management | Small isolated services with role-scoped installation | seL4, dedicated monitor, or another supported isolated runtime |
| Package | Compute, memory/I/O, and root functions with protected boundary adapters | Die count, process nodes, UCIe mode, packaging, memory topology |
| Memory handoff | Coherent copy for 1 KiB messages; batch ownership with acknowledged revocation/drain | Revocation machinery, ownership granule, coherence protocol, measured crossover |
| Information flow | Realm categories and confined request domains | Category administration, worker startup strategy, later finer tracking |
| Admission | Authenticated online bilateral scope installation | Canonical control encoding, trust federation, attestation profile |
| Endpoint transport | Protected record creation and quarantine-to-object delivery | Existing-transport alternative versus dedicated record engine |
| Replay | Consume authenticated denials; allow in-range authenticated forward jumps; recheck policy at publication commit | Window sizing, scheduler fairness, recovery costs |
| Transit | Explicit transport profiles and mandatory local egress checks | SCION integration details; independent review of native construction |

The design reuses a general-purpose ISA and permits local trust roots. Software porting, revocation latency, and attack coverage must be established for each implementation; no universal porting percentage, single-cycle global revocation, or complete attack prevention is assumed.

## Minimum interface contracts

The protected operations below define interfaces for a future SDK. Callers pass bounded handles, and implementations identify callers through enforced context.

| Interface | Input | Required result |
|---|---|---|
| `allocate_transfer_buffer` | Size, owner, confinement, budget | Dedicated allocation handle and generation with enforced ownership |
| `submit_message` / `submit_batch` | Message extent or sealed child-slice manifest, destination/operation/session | Coherent snapshot or pinned exclusive allocation; explicit per-child lifetime and bounded local credits |
| `ownership_commit` | Protected completion set | Engine access only after all required writers are resolved |
| `emit_record` | Stable allocation and resolved grants | Fresh authenticated record; serialized expiry/withdrawal check before emission |
| `install_receive_contract` | Receiver-authorized admission transaction | Immutable mapping and fresh directional session; source credentials cannot broaden policy |
| `consume_authenticated` | Verified record and current session | Exactly one consumed mark or duplicate rejection under the session arbiter |
| `publish_object` | Consumed record, destination reservation, current policy | Restriction and budget committed before visibility |
| `authorize_egress` | Actual ingress, proposed egress, native record | Physical transmit enabled only for a locally verified grant and unchanged record |
| `retire_context` | IES or session generation | New work blocked and old references invalidated before reuse |

Each interface must bound its queues, define failure and reset behavior, check roles, and expose an observation hook for testing. Logging through that hook must preserve the payload's confidentiality restriction.

## Manifest required for an implementation

An implementation identifies its supported profiles and supplies:

1. CPU/ISA/ABI and compiler/runtime versions, including temporal-safety and capability-tag behavior.
2. Memory, cache, DMA, requester-identity, and completion paths, including ownership/reuse generations.
3. The complete trusted hardware/firmware/software set and every authority able to update it.
4. Packet/control encodings, cryptographic suites, key schedule, test vectors, usage limits, and failure policy.
5. Admission credentials, category mappings, lease clock assumptions, and reset/rollback behavior.
6. Physical port inventory, raw and management transmit paths, debug policy, and reset wiring.
7. Capacity bounds, schedulers, resource reservations, and measured useful service under overload.
8. Reproducible model/proof/measurement artifacts with explicit scope and unresolved assumptions.

The native grant encoding and control transaction can be modeled now, but remain candidate specifications until the manifest requirements are met. They have not received deployment cryptography or platform certification review.

## Technical sources

The references support individual mechanisms and comparisons. The complete ASKA composition still needs implementation, proof, and measurement. Because web documentation changes, implementation work must cite exact revisions or archived copies.

| Source | Use and boundary |
|---|---|
| [Cambridge CHERI FAQ](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html) | Capability bounds, permissions, provenance, and compartmentalization. A capability tag is not a payload confidentiality label. |
| [CHERI-RISC-V](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-risc-v.html) · [RISC-V CHERI specification snapshot](https://riscv.github.io/riscv-cheri/snapshot/riscv-cheri-full/) | ISA-extension references. The exact revision and implementation support need pinning. |
| [X730 certification record](https://cheri-alliance.org/cheri-enabled/x730/) | Application-class implementation and a concrete CPU revocation comparison; DMA and platform composition require separate evidence. |
| [CHERIoT memory management](https://cheriot.org/book/memory.html) | Concrete small-system allocator, capability, and memory-lifetime comparison; distinct from a server runtime. |
| [seL4 usage guidance](https://sel4.systems/About/how-to-use.html) · [Proof assumptions](https://sel4.systems/Verification/assumptions.html) | Supervisor/VM organization and assurance scope. New ports and drivers need their own evidence. |
| [UCIe specifications](https://www.uciexpress.org/specifications) | Die-to-die integration family. ASKA ownership and policy context require additional adapter semantics. |
| [SCION header specification](https://docs.scion.org/en/latest/protocols/scion-header.html) | Existing path-aware carriage and hop fields; separate from receiver's application consent. |
| [RFC 8446 — TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446.html) | Protected admission channel. Local authorization remains independent. |
| [RFC 9334 — RATS](https://www.rfc-editor.org/rfc/rfc9334.html) | Attestation roles and appraisal architecture. Measurements inform a relying party's decision. |
| [RFC 5116 — AEAD](https://www.rfc-editor.org/rfc/rfc5116.html) | Authenticated encryption interface and nonce discipline. Custom framing and key derivation still require review. |
| [RFC 4303 — ESP](https://www.rfc-editor.org/rfc/rfc4303.html) | Established sequence and replay-window processing. ASKA explicitly defines its authenticated-denial behavior. |
| [Intel TDX documentation](https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html) | Confidential-VM and protected-I/O architecture references; product/configuration qualification remains necessary. |
| [BlueField modes](https://networking-docs.nvidia.com/bsp/latest/modes-of-operation) | Concrete management separation modes. DPU firmware and selected configuration remain part of trust. |

Further primary comparisons for implementation review:

| Work | Question to compare |
|---|---|
| [M³, ASPLOS 2016](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) | How are computation, communication, and external enforcement separated? |
| [Elasticlave, USENIX Security 2022](https://www.usenix.org/system/files/sec22-yu-jason.pdf) | Which sharing/exclusive-access operations can satisfy the selected stable-buffer contract? |
| [DStar, NSDI 2008](https://www.scs.stanford.edu/~nickolai/papers/zeldovich-dstar.pdf) | How do bilateral flow restrictions, category meanings, and trusted exporters compare? |
| [Fabric, SOSP 2009](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.html) | How do distributed confidential/integrity policies compose across trusted runtimes? |
| [ICING, CoNEXT 2011](https://www.cs.utexas.edu/icing/papers/icing-conext11.pdf) | What path-consent and packet-binding properties can an existing design supply? |
| [EPIC, USENIX Security 2020](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf) | Which protocol level meets the chosen authentication/traversal property, including replay-suppression dependencies? |
| [COLIBRI, CoNEXT 2021](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf) | Which reservation, policing, and management assumptions preserve useful bandwidth? |
| [TVA, SIGCOMM 2005](https://conferences.sigcomm.org/sigcomm/2005/paper-YanWet.pdf) | Where must receiver-oriented admission and resource control act to preserve useful service? |
| [Time Protection, EuroSys 2019](https://trustworthy.systems/publications/abstracts/Ge_YCH_19.abstract) | What additional resource controls are needed when timing observations enter the threat model? |

The papers identify systems to compare; their artifacts have not been reproduced or their full texts freshly audited for this draft. Before relying on a particular behavior, inspect and record the relevant passages.

## Mechanism comparison record

Keep a comparison entry for each implemented mechanism: the relevant primary-source passage, threat model, trusted components, ordering, resource costs, and the exact ASKA contract it supports or fails to support. The entry must show the relationship between mechanisms; a citation alone establishes neither equivalence nor a new contribution. In particular, compare denial consumption with established replay processing, confinement sets with distributed information-flow systems, ownership with exclusive sharing and revocation, and native grants with EPIC/COLIBRI and other path protocols. Record uninspected behavior as unresolved.

## Unresolved decisions that block implementation approval

The following require explicit resolution before claiming an integrated protected platform:

- Which CPU, cache, allocator, and revocation design jointly satisfy native capability lifetime and buffer-transfer semantics?
- Which fabric adapters preserve requester/generation context through every writeback, retry, response, and reset?
- Which control encoding and exporter-based key schedule bind the admission transcript without ambiguity?
- Can the native token construction's key delegation, expiry, replay exposure, and scope binding survive independent review?
- Which physical server/DPU combination provides the claimed protected placement, and which paths still need an encrypted bridge?
- Can the chosen replay-window and scheduler rules sustain useful workloads during loss, abort-created gaps, forged-session floods, and bounded recovery without broad policy exceptions?

Resolve these questions with implementation evidence before approving an integrated platform.
