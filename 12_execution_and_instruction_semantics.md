# ASKA v5 — Execution and instruction semantics

## Accord-driven cell admission

Every native execution descriptor binds an **Accord contract digest**, a specific installed **grant set**, an execution-domain and allocation generation, and exact allowed source and effect endpoints. A typed plan produced by AI or any application is only a proposal; the external checker installs grants after admission. A field written by the worker cannot create new authority. Work in Sanctum, Polis, Agora, and Wilder runs in independently configured islands or resource partitions according to the deployment physical assurance profile.

---

## Detailed technical contract

**Requirements:** R01, R02, R03, R07, R12, R15, R17, R19, R20.

Admission gives native software bounded values, local memory, and explicitly delegated operation handles. The object/effect contract defines what the software may do with them. Persistent state and external devices belong to other domains. The contract defines the obligations every execution engine must enforce before ISA selection.

## Cell admission

The island's protected controller installs a cell descriptor:

```text
cell_id, cell_generation, owner_realm
artifact_digest, execution_contract_revision
physical_resource_set, isolation_profile
input_object_versions, confinement_categories
local_region_limits, execution_fuel, elapsed_deadline
operation_handles, output_schemas, output_byte_limits
parent_budget_reservation, lifecycle_policy
```

The caller can propose this descriptor but cannot install it. Admission installs only the intersection of the artifact's declared effects, task authority, realm policy, and available resources. The descriptor binds code and semantics through `artifact_digest` and `execution_contract_revision`, placement through `physical_resource_set` and `isolation_profile`, and inputs through versions and confinement categories. Its limits and parent reservation bound local work; its handles and schemas bound external effects and output. The lifecycle policy governs retirement. Child cells receive only attenuated rights and reserved shares of their parent's budget. A parent can cancel a child only if it holds that lifecycle right; parenthood grants no automatic read access.

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

These operation names define semantics; their binary encodings remain unspecified. [16](16_native_applications_and_development.md) gives developer-facing contracts. [14](14_persistence_and_effects.md) defines when submission becomes a durable or physical effect.

## Memory safety inside the cell

The reference worker model uses region lifetimes. Workers cannot mutate admitted inputs. The controller retains local scratch regions until the cell ends, and the output path publishes no object before the worker seals it. The initial worker language does not expose arbitrary free/reallocate within a region. This reduces request-lifetime aliasing. Whole-cell reset does not solve every temporal-safety problem.

The implementation must check bounds, reference provenance, and region liveness, or establish them through an accepted compiler/verifier argument. Persistent services and engines that need fine-grained allocation require a separate temporal-safety mechanism. A malicious cell can retain any bit pattern it likes, but its references cannot survive retirement as usable authority.

On a fault, the protected controller halts the offending cell and starts cancellation. Cleanup cannot depend on the workload's exception handler. The output path discards unpublished objects; effect owners retain earlier commits and report them through operation receipts. Cell abort cannot undo a payment or actuator movement.

## ISA study

The ISA study must compare three implementations before the project freezes a native binary contract:

1. **Existing ISA with capabilities.** CHERI-like references express bounds and provenance while external guards retain physical ownership. Evaluate privilege, debug, speculative behavior, tag storage, temporal safety, and the cost of unused general-purpose mechanisms. [CHERI specification](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-987.pdf).
2. **New object instruction architecture.** Local references identify region, bounds, rights, and generation; external actions use effect handles rather than integer addresses. The research must specify traps, concurrency, calls, exceptions, vector access, and compiler refinement. It has no assumed performance or ready compiler.
3. **Spatial/dataflow execution.** Compile bounded graphs into an owned region with guarded edge endpoints. The configuration guard separately admits each dynamic graph change as an artifact. Compare interaction latency, recursion, locality, configuration time, and sanitization against sequential execution.

Instruction-level information-flow architectures such as [HyperFlow](https://www.cs.cornell.edu/andru/papers/hyperflow/) show that data and timing policy can be part of a processor design. Their results do not cover an arbitrary ASKA memory/device/network composition. An engine can offer stronger fine-grained tracking than the reference cell-confinement rule if its implementation and interfaces preserve the required labels.

**Selected:** the semantic contract and region-based worker discipline. **Unselected:** binary ISA and microarchitecture. **Required result:** implementations refine the same authority, fault, output, and lifetime behavior. A new ISA must justify its cost by simplifying that refinement or supporting properties that existing cores cannot practically provide. The compiler argument must connect generated instructions to the contract's authority, faults, outputs, and lifetimes; a source-level bounds proof alone does not establish that connection.

## Scheduling and resource termination

Admission assigns each cell finite memory, execution fuel, elapsed time, queue occupancy, and output allowance. Fuel counts defined execution steps. It does not guarantee constant real-time service. The protected controller enforces the elapsed deadline without relying on workload cooperation. Blocking sends reserve no unbounded downstream chain.

Exclusive ownership can span several hardware engines for a large task. Reusing an engine for a new cell requires the lifecycle transition in [13](13_memory_ownership_and_lifecycle.md). A scheduler may share resources within one declared trust domain. A P0 shared-core prototype cannot claim the physical or timing properties of P1 execution.

The scheduler can choose among already authorized placements. It cannot read private objects, change confinement, broaden grants, or move a computation onto a weaker physical profile to recover capacity. If no admissible placement exists, admission waits under a bound or denies the task.

## External observations are effects

A cell's output authority covers its selected device surface, not all uses of that device. Viewing an object does not install printing, clipboard, recording, removable-media, or network-export handles. A worker that reads restricted inputs cannot return unrestricted status, timing choices, or generated code through a lower-category channel merely because the payload type is small. Such observations follow the selected flow profile in [19](19_cross_domain_security_and_release.md).

The controller threat model includes fully malicious network and peripheral controllers. The cell's guards must still mediate its resource accesses. A newly discovered endpoint stays untrusted until an independent local installation authorizes a bounded contract.

## Device and accelerator work

An accelerator receives an explicit input/output contract, owned memory, and bounded command queues. The authority boundary treats device firmware as untrusted. A claim about the device's computed result must separately declare any reliance on that firmware. Its external guard enforces DMA extent, source identity, generations, and allowed output endpoints. The retirement controller must account for accelerator-local scratch, weights, caches, and pending transactions.

Model and test a compute engine that submits arbitrary requests, even if a memory-safe language would normally prevent them. P1 physical and endpoint boundaries must contain those requests. A malicious core can defeat its own instruction-level safety. External guards must still protect other islands.

**Open questions:** cost of region-only programming for interactive workloads; evidence required to accept a compiler-generated bounds proof; exception and vector semantics for a minimal ISA; and preemption of accelerators that lack a reliable stop interface.
