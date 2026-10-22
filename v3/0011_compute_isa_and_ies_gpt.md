# ASKA v3 — Compute, ISA, and the IES

[Start](0010_architecture_and_reading_map_gpt.md) · [Next](0012_authority_and_information_flow_gpt.md)

An **Isolated Execution Stack (IES)** is a security domain with protected allocations of compute, memory, device access, and communication authority. It can occupy part of a compute chiplet, a whole chiplet, or cooperating resources across chiplets. Physical die boundaries and IES boundaries need not coincide.

## Existing ISA, explicit extension

The native target is **RV64 with CHERI capabilities and a pure-capability software ABI**. This combines an existing base instruction set with capability protection and reuses its arithmetic, vector-processing, and compiler infrastructure.

CHERI capabilities carry protected bounds and permissions for references. Their validity tag protects capability provenance; it is not a confidentiality classification attached to every derived byte. [Cambridge CHERI FAQ](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html).

The implementation manifest must select the RV64 base extensions, privileged architecture, CHERI specification revision, capability encoding, compiler/runtime ABI, and memory-tag storage rules. Implementations need these details to interoperate; a “CHERI enabled” label does not specify them. The [CHERI-RISC-V project](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-risc-v.html) describes an evolving specification; v3 does not assert a universally deployed server standard.

Required native behavior:

1. Memory dereferences require appropriate valid capabilities; an integer cast cannot create new authority.
2. Delegation cannot increase bounds or permissions beyond the delegator's rights.
3. Calls across compartments use controlled entry and explicit argument capabilities.
4. Root memory authority is unavailable to ordinary IES workloads and their kernels outside their assigned regions.
5. DMA and non-capability bus masters pass separate object and ownership checks.
6. Freed or transferred allocations cannot remain usable through stale references. The allocator and revocation protocol must establish when reuse is safe.

Temporal safety also requires an allocator and revocation scheme, tested with references retained through free and reuse. CHERIoT provides a small-system comparison with its own memory-management design. A server RV64 runtime needs a separately evaluated implementation. [CHERIoT memory management](https://cheriot.org/book/memory.html).

The X730 is an application-class processor to compare against the native compute requirements. Its CHERI Alliance record describes a 64-bit, in-order, dual-issue core with an MMU and a Cornucopia Reloaded-derived PTE mechanism for revocation. That mechanism uses software sweeping and quarantine; its stated page-tracking assumptions exclude virtual aliases. It does not establish revocation across arbitrary DMA or every ASKA ownership path. [X730 certification record](https://cheri-alliance.org/cheri-enabled/x730/).

Endpoint, admission, and gate prototypes are independent deliverables. Native RV64 capability compute remains the target, subject to a workload cost study covering pointer footprint, cache and memory traffic, tag storage and ECC integration, allocator/revocation costs, software ports, and device interfaces. A compatibility result cannot be reported as native intra-IES capability protection.

Bounds enforcement leaves logic errors, excessive valid authority, incorrect compartment design, and malicious computation within granted rights. The design therefore makes no claim about a fixed percentage of vulnerabilities removed. Porting reviews must cover subobject layout, representable bounds, compiler transformations, and integer/pointer interfaces.

## Where Linux, runtimes, and large jobs fit

An IES can contain an OS and its application runtimes. A database can receive dedicated compute and memory plus bounded network queues. An accelerator service can receive device submission authority. An analysis service can receive confidential inputs without receiving a public-output capability.

| Execution profile | Intended use | Assurance boundary |
|---|---|---|
| Native capability IES | Rebuilt workloads, runtimes, and selected OS components | Capability compartments plus external memory/device enforcement |
| Compatibility IES | Existing x86, Arm, or non-capability RISC-V software on a suitable separate platform/profile | External isolation of the whole compatibility domain; internal memory corruption remains possible |
| Accelerator IES | GPU, FPGA, or other non-CHERI compute | Device firmware or wrapper enforces assigned memory and queue scope; internal compute correctness is separate |
| Management IES | Policy installation, lifecycle, session control | Narrow privileged interfaces and protected keys; separately reviewed code |

The compatibility profile supports migration while providing weaker protection inside the domain. Rebuilding a large stack may involve assembly, JITs, garbage collectors, plugins, drivers, and ABI changes. Source compatibility must be measured for each stack, including any work needed to run PyTorch or Kubernetes on the selected capability server.

A Linux kernel inside an IES may administer its assigned resources. If it is compromised, it can generally compromise applications sharing its authority unless they have independently enforced subcompartments. Confidentiality from that guest kernel requires another boundary. Confidentiality from an outside host kernel requires the IES memory/device boundary. Reports must identify which kernel the attacker controls.

## seL4's role

seL4 is a capability microkernel and can support Linux virtual machines. A Linux guest can retain its application stack rather than rebuilding it as native seL4 services, so application size alone does not rule out seL4 supervision. [Official usage guidance](https://sel4.systems/About/how-to-use.html).

seL4 can host isolated management services or supervise VMs where the platform support and required proofs are available. It is optional. A small dedicated monitor may be preferable if its interfaces and assurance better fit the selected hardware.

The high-volume path is:

```text
workload -> protected submission queue -> ownership controller
         -> crypto/packet engines -> physical transmit interface
```

Management services install bounded tables that local datapaths enforce. The common record path can therefore run without a management-core syscall, a general-purpose policy interpreter, or seL4 IPC at every hop. Exceptions, renewals, and policy changes use the control path as needed.

A VM supervisor still schedules work, handles faults and interrupts, and virtualizes devices. Direct execution of guest instructions does not remove those costs. Proofs for an existing seL4 configuration do not automatically cover a CHERI port, a DPU, a VMM, or new drivers. [seL4 proof assumptions](https://sel4.systems/Verification/assumptions.html).

## IES subdivision and scheduling

A parent may create a child only by delegating an authorized subset of memory, operations, and budgets. Creation does not imply permission to inspect child data. Read, suspend, reset, destroy, and reallocate are distinct rights.

Use application subcompartments for parsers, plugins, and narrow tool interfaces when an in-process compromise would otherwise expose excessive authority. Use separate IES instances for mutually distrusting kernels, tenants, or devices. Dedicated cores are optional; shared-core scheduling needs explicit context sanitation and a stated timing model.

Each live IES has a protected identifier and generation, immutable root policy references, assigned resources, and bounded queues. Software supplies handles; the queue's protected caller context supplies identity. A writable field called `source_ies` never establishes the caller.

## What the compute chiplet must export

The boundary adapter exports requester identity, IES generation, allocation identity/version where applicable, access type, and completion identity. It must preserve origin context for cache writebacks and retries. An implementation can carry that context in transaction fields or protected adapter state, but must preserve its meaning across interfaces.

The design trusts the compute core and local enforcement to implement capability semantics. An external gate cannot supply those semantics for an arbitrary malicious core. A distrusted accelerator instead operates under a separate contract enforced at its external boundary. [0013](0013_memory_ownership_and_lifecycle_gpt.md) defines the memory effects that both paths must respect.
