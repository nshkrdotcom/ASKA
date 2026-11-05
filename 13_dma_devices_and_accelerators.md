# ASKA v6 — DMA, devices and accelerators

## A device is an independent transaction source

A device can affect memory, interrupts, storage, network output or the physical world without executing instructions on the workload’s CPU. Its protection boundary must therefore be explicit. The device guard (DG) binds an admitted physical endpoint or protected device context to an owner, current device epoch, permitted memory objects, command schema, interrupt destinations and effect ceilings. A driver’s assertion that a descriptor is safe is not sufficient when the driver or guest kernel is within the attacker model.

Device assignment covers every path the endpoint can use: programmed I/O, DMA, peer-to-peer transactions, coherent access, interrupts, command queues, firmware loading, management sidebands and reset controls. The selected bus technology does not make that list complete. The actual board and package reachability manifest establishes which paths exist and where they are mediated.

**R-13-01 — All-path device mediation.** Every device-originated path capable of reaching another protection domain or producing an external effect MUST cross an identified DG, memory guard or effect owner. Any unmediated path MUST be disabled, physically excluded or declared outside the admitted isolation claim.

The [RISC-V IOMMU introduction](https://docs.riscv.org/reference/iommu/v20260222/iommu_intro.html) describes first- and second-stage DMA translation and message-signaled interrupt redirection. These are useful building blocks. Their protection depends on the platform’s requester binding, configuration ownership and treatment of cached translations; the presence of an IOMMU block alone does not establish all-path mediation.

## Requester identity and protected mappings

A protected mapping record includes device identity, attachment location, device epoch, owner IES, object generation, permitted direction, extent bounds, maximum transfer, translation epoch and lifetime. The guard derives identity from a protected endpoint context. It must not trust a freely chosen requester field from an untrusted peripheral without an enforcement mechanism that binds that field to the physical or authenticated source.

The [IOPMP architecture text](https://github.com/riscv-non-isa/riscv-iopmp/blob/main/chapter2.adoc) uses requester identifiers in selecting memory-domain permissions and leaves aspects of requester association to integration. The reviewed text is a working specification source, not a claim of a qualified ASKA implementation. ASKA must separately establish the protected association between requester, port, owner and current epoch.

**R-13-02 — Bound device identity.** Device access decisions MUST use an identity and epoch protected against the admitted attacker. CPU and device mappings of the same protected object MUST remain consistent, and all mapping changes MUST invalidate or fence stale device translations before reuse.

ATS-like translation caches and process-address-space identifiers are acceleration mechanisms, not authorities in themselves. A descriptor that carries a familiar address-space identifier cannot select another principal’s context. The mapping owner must account for translation caches in endpoints, bridges and shared translation services. A device that cannot acknowledge invalidation can be confined to a bounce-buffer protocol or excluded from a profile requiring direct protected DMA.

[ACAI’s protected-I/O design](https://www.usenix.org/system/files/usenixsecurity24-sridhara.pdf) makes device identity, exclusive ownership and synchronized host/device mappings separate invariants. That separation is directly relevant to qualification. Its Arm CCA design and threat assumptions do not prove arbitrary accelerator correctness or ASKA’s physical-domain independence. ASKA uses these obligations as comparison points, not as a transferred implementation certificate.

[Composite Enclaves’ institutional abstract](https://www.syssec.ethz.ch/publications/2021-11-19-composite-enclaves-towards-disaggregated-trusted-execution-20-500-11850-517576/) identifies configurable hardware/software trust boundaries spanning compute and I/O. The primary full PDF was inaccessible, so no detailed threat-model or performance conclusion is imported. Its integration question remains relevant: which peripheral, driver and connection must become trusted for a selected service?

## Assignment, reset and revocation

Assignment proceeds through discovery, qualification, closed reset, firmware/configuration appraisal, owner binding, mapping installation and enabled service. Discovery grants no payload access. Qualification identifies firmware and hardware assumptions, supported isolation granularity, reset coverage and the path to recover or physically disconnect an unresponsive endpoint. The enabled state is reached only after the necessary grant and mapping epochs are installed.

Revocation first closes new commands and DMA admission. It then drains queued work, invalidates translations, fences peer-to-peer routes, establishes the disposition of interrupts and clears retained state. A device reset is accepted as a closure mechanism only to the extent its documented and tested semantics support that claim. Reset must not accidentally reset a different principal’s guard or observer.

**R-13-03 — Safe device reassignment.** Reassignment MUST retire old commands, mappings, interrupts and retained device state before installing a new owner. Failure to establish closure MUST quarantine the device and affected buffers. A reset acknowledgement MUST NOT substitute for evidence about state the reset does not clear.

Device firmware may retain keys, model weights, command history, scratchpad contents or diagnostic dumps. Those are resources subject to ownership and sanitization. A GPU partition or virtual function can be useful if its hardware boundary is qualified, but logical queue separation does not imply independent firmware, memory controllers, fault handling or reset. A PF administrator capable of reading VF memory remains a shared trust root and must be included in the profile.

## Accelerators and compatibility devices

An accelerator receives a task contract containing immutable input bindings, an output allocation, algorithm or artifact identity, precision requirements, bounded work and permitted effects. Its returned data is a candidate result until the receiving owner accepts it. Cryptographic authentication of the result identifies its origin; it does not establish mathematical or semantic correctness. A high-consequence application may require independent checking, redundant computation or a proof whose verifier is separately qualified.

FPGA qualification includes configuration ports, bitstream admission, reconfiguration region boundaries and routing resources. A partially reconfigured region must not overwrite static guard logic or connect to a forbidden bus master. The reconfiguration operation itself is an authority-bearing change with an explicit quiescence and admission protocol. An accelerator service cannot inherit permanent authority merely because its previous configuration was approved.

**R-13-04 — Bounded accelerator service.** Accelerator admission MUST bind executable/configuration identity, input and output objects, resource ceilings and all permitted effects. Virtualization or partial reconfiguration MUST preserve the declared boundary, and output correctness MUST be treated separately from device identity and transport integrity.

For a device without credible protected DMA, a compatibility bridge may copy data into a dedicated staging region and expose only bounded commands. The bridge becomes a trusted part of that service, with its own memory, parser and failure limits. Encrypting traffic between bridge and device can protect an exposed link under its cryptographic assumptions, but it does not conceal plaintext from a device authorized to process it. No bridge can make an untrusted printer forget a page it has printed.

## Interrupts, maintenance and physical effects

Interrupt delivery can leak activity or exhaust service even when memory writes are blocked. The DG therefore binds interrupt destinations and rates, masks stale epochs and reserves capacity for critical completion or isolation events. An interrupt is evidence to inspect state, not proof that a command completed. The effect owner checks its own protected completion record.

Management paths deserve equal scrutiny. A baseboard controller that can rewrite DG configuration or read protected memory defeats separation from that controller. Debug unlock, firmware recovery, crash dumping and manufacturing test require explicit authority, physical controls where appropriate, and receipts. Maintenance mode must state which assurance claims are suspended and how normal admission is restored.

**R-13-05 — Bounded auxiliary device paths.** Interrupts, debug, maintenance and firmware-recovery operations MUST have explicit targets, budgets and authorization. They MUST NOT create an implicit bypass to memory ownership, guard policy, observer keys or another domain’s reset state.

Physical actuators introduce another boundary. A motor-command register, door controller or radio transmitter may cross an irreversible or externally consequential point before software sees completion. The DG constrains which commands reach the device; an EO names the command-acceptance or emission finality point; independent sensors may later establish the physical outcome. An accepted command is not equivalent to successful movement, transmission or delivery.

**R-13-06 — Device-effect finality.** Every externally consequential device operation MUST identify its local finality point, idempotency behavior and available physical observation. Retries after an ambiguous attempt MUST use deduplication, safe idempotence or reconciliation; they MUST NOT presume exactly-once physical execution.

A brain-computer interface (BCI) is an optional device-service research case under these same rules. A sensing grant covers specified acquisition channels, sampling, local processing and recipients; it does not authorize stimulation or another actuator effect. A one-way acquisition link constrains that interface but does not establish sensor truth, remove firmware-management paths, sanitize forward data or validate a decoder’s inference. Raw signals, timing, derived features and learned model state retain observation and release restrictions. Collaborative or federated training needs the separate privacy accounting in [chapter29](29_monitoring_privacy_and_observation_authority.md). Any bidirectional or stimulating device requires a separately admitted command path, device-specific safety interlocks and qualified outcome evidence. A prototype must identify its clinical and physical limits; neither a successful neural decoder nor an authenticated device can establish consent, capacity or a general right to act for a person.

## Example and acceptance obligations

A laboratory system attaches an untrusted network accelerator to an Agora IES. The device gets an input ciphertext buffer and a bounded output buffer, but no direct path to Sanctum memory or the external transmitter. An authenticated result returns through the BG; the EG still decides whether its exact bytes may leave. During revocation, the device attempts a peer-to-peer write to another endpoint and sends a stale completion interrupt. Both must fail under the old epoch. If the device cannot be fenced, its staging region remains quarantined rather than becoming another cell’s memory.

Acceptance specifications are:

- **T-13-01:** Enumerate and exercise DMA, peer-to-peer, coherent and management paths from an adversarial endpoint. A forbidden access succeeding on any path defeats all-path isolation.
- **T-13-02:** Spoof requester fields and race CPU/device mapping changes. The guard must retain the protected identity and reject stale or inconsistent mappings.
- **T-13-03:** Reassign a device with queued writes and retained state. The new owner must observe neither old data nor old-owner writes; missing closure must block assignment.
- **T-13-04:** Load a changed FPGA region or submit a task exceeding an accelerator contract. The boundary must reject the change or task before forbidden access, and an authenticated wrong result must remain distinguishable from a verified result.
- **T-13-05:** Flood interrupts and exercise maintenance/debug controls while another domain runs. Rate bounds and access restrictions must hold, including declared reset separation.
- **T-13-06:** Interrupt power after an actuator accepts a command but before the receipt reaches the caller. The caller must preserve established local evidence and mark unresolved physical outcome separately; a blind duplicate command is a failure.
