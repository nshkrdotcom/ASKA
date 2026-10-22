# ASKA v4 — Execution and instruction semantics

[Start](0300_architecture_and_reading_map.md) · [Previous](0303_physical_substrate_and_frontier.md) · [Next](0305_memory_ownership_and_lifecycle.md)

**Requirements:** R01, R02, R03, R07, R12, R15, R17, R19, R20.

Native software runs through an object/effect execution contract. It receives bounded values, local memory, and explicitly delegated operation handles. Persistent state and external devices belong to other domains. The contract defines what every execution engine must enforce before an ISA is selected.

## Cell admission

A cell descriptor is installed by the island's protected controller:

```text
cell_id, cell_generation, owner_realm
artifact_digest, execution_contract_revision
physical_resource_set, isolation_profile
input_object_versions, confinement_categories
local_region_limits, execution_fuel, elapsed_deadline
operation_handles, output_schemas, output_byte_limits
parent_budget_reservation, lifecycle_policy
```

The caller can propose this descriptor but cannot install it. Admission intersects the artifact's declared effects, task authority, realm policy, and available resources. Child cells receive only attenuated rights and reserved shares of their parent's budget. A parent can cancel a child only if it holds that lifecycle right; parenthood grants no automatic read access.

A native cell has no inherited host credential, global object namespace, raw physical address capability, or universal system-call interface. It can invoke only installed endpoints. A local library can provide familiar conveniences, but it cannot recover authority omitted from the descriptor.

## Required execution semantics

| Operation family | Meaning and enforcement |
|---|---|
| Local compute | Arithmetic, control flow, and bounded local data access; no implicit external effects |
| Region allocation | Allocate within a protected local limit; return a bounded reference or a defined fault |
| Object read | Read an admitted immutable version; reject wrong generation or extent |
| Build output | Write an unpublished object carrying the cell's confinement |
| Prepare effect | Form a typed request using an installed object/operation handle |
| Submit effect | Send through a protected endpoint; recipient checks current authority independently |
| Spawn | Request a child with attenuated handles and explicit resource reservation |
| Yield/finish/abort | End or suspend computation under controller-defined ownership and sanitation rules |

These names are semantic operations, not invented binary opcodes. [0308](0308_native_applications_and_development.md) gives developer-facing contracts. [0306](0306_persistence_and_effects.md) defines when submission becomes a durable or physical effect.

## Memory safety inside the cell

The reference worker model uses region lifetimes. Admitted inputs are immutable; local scratch regions remain allocated until the cell ends; outputs remain unpublished until sealed. The initial worker language does not expose arbitrary free/reallocate within a region. This reduces request-lifetime aliasing without claiming that whole-cell reset solves every temporal-safety problem.

Bounds, reference provenance, and region liveness must be checked or established by an accepted compiler/verifier argument. Persistent services and engines that need fine-grained allocation require a separate temporal-safety mechanism. A malicious cell can retain any bit pattern it likes, but its references cannot survive retirement as usable authority.

A fault halts the offending cell and begins protected cancellation. Cleanup does not depend on the workload running an exception handler correctly. Unpublished output is discarded. Effects committed before the fault remain committed and are reported through operation receipts; cell abort cannot undo a payment or actuator movement.

## ISA study

Three implementations must be compared before freezing a native binary contract:

1. **Existing ISA with capabilities.** CHERI-like references express bounds and provenance while external guards retain physical ownership. Evaluate privilege, debug, speculative behavior, tag storage, temporal safety, and the cost of unused general-purpose mechanisms. [CHERI specification](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-987.pdf).
2. **New object instruction architecture.** Local references identify region, bounds, rights, and generation; external actions use effect handles rather than integer addresses. The research must specify traps, concurrency, calls, exceptions, vector access, and compiler refinement. It has no assumed performance or ready compiler.
3. **Spatial/dataflow execution.** Compile bounded graphs into an owned region with guarded edge endpoints. Dynamic graph changes are separately admitted configuration artifacts. Compare interaction latency, recursion, locality, configuration time, and sanitization against sequential execution.

Instruction-level information-flow architectures such as [HyperFlow](https://www.cs.cornell.edu/andru/papers/hyperflow/) show that data and timing policy can be part of a processor design. Their results do not cover an arbitrary ASKA memory/device/network composition. An engine can offer stronger fine-grained tracking than the reference cell-confinement rule if its implementation and interfaces preserve the required labels.

**Selected:** the semantic contract and region-based worker discipline. **Unselected:** binary ISA and microarchitecture. **Required result:** implementations refine the same authority, fault, output, and lifetime behavior. A new ISA is justified if it materially simplifies that refinement or supports properties impractical in existing cores.

## Scheduling and resource termination

Cells receive bounded memory, execution fuel, elapsed time, queue occupancy, and output allowance. Fuel counts defined execution steps; it is not a claim of constant real-time service. The elapsed deadline is enforced independently of workload cooperation. Blocking sends reserve no unbounded downstream chain.

Exclusive ownership can span several hardware engines for a large task. Reusing an engine for a new cell requires the lifecycle transition in [0305](0305_memory_ownership_and_lifecycle.md). Shared scheduling within one declared trust domain is permitted. A P0 shared-core prototype cannot claim the physical or timing properties of P1 execution.

The scheduler can choose among already authorized placements. It cannot read private objects, change confinement, broaden grants, or move a computation onto a weaker physical profile to recover capacity. If no admissible placement exists, admission waits under a bound or denies the task.

## External observations are effects

A cell's output authority covers its selected device surface, not all uses of that device. Viewing an object does not install printing, clipboard, recording, removable-media, or network-export handles. A worker that reads restricted inputs cannot return unrestricted status, timing choices, or generated code through a lower-category channel merely because the payload type is small. Such observations follow the selected flow profile in [0318](0318_cross_domain_security_and_information_release.md).

A network or peripheral controller can be fully malicious. The cell's guards must still mediate its resource accesses. A newly discovered endpoint stays untrusted until an independent local installation authorizes a bounded contract.

## Device and accelerator work

An accelerator receives an explicit input/output contract, owned memory, and bounded command queues. Device firmware is untrusted unless the claimed computation depends on it. Its external guard enforces DMA extent, source identity, generations, and allowed output endpoints. Accelerator-local scratch, weights, caches, and pending transactions belong in retirement.

Model and test a compute engine that submits arbitrary requests, even if a memory-safe language would normally prevent them. P1 physical and endpoint boundaries must contain those requests. Internal instruction-level safety may fail with a malicious core, but it must not be the only defense protecting another island.

**Open questions:** cost of region-only programming for interactive workloads; evidence required to accept a compiler-generated bounds proof; exception and vector semantics for a minimal ISA; and preemption of accelerators that lack a reliable stop interface.
