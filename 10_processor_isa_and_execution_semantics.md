# ASKA v6 — Processor ISA and execution semantics

## An unselected instruction set with a fixed architectural contract

ASKA does not select one universal processor instruction set. RV64 with CHERI capabilities, a minimal object-oriented instruction set, and a spatial or dataflow engine are candidates. An early laboratory realization may use RV64 with CHERI to explore toolchain and memory-authority questions, but that choice does not define every conforming physical realization. The invariant is that execution cannot manufacture authority to another IES, evade a consequence guard or reinterpret stale state as a current object.

The machine description separates instruction semantics, protection semantics and implementation evidence. An instruction set specifies what an operation means. A protection implementation establishes where checks occur and which state an attacker can modify. A compiler, runtime, kernel and device integration must preserve those meanings together. Successful execution on an emulator establishes neither manufactured-chip behavior nor resistance to fault injection.

**R-10-01 — Declared execution profile.** Every admitted executable MUST identify its ISA or execution language, semantic revision, ABI, required protection features and trusted runtime dependencies. The loader MUST reject incompatible or missing features rather than silently substitute weaker behavior.

| Candidate | Useful design direction | Required qualification |
|---|---|---|
| RV64 with CHERI | General-purpose compilation with bounded, permission-bearing references | Exact capability ABI, temporal revocation, exceptions, DMA integration and privilege confinement |
| Minimal object ISA | Small protected operation surface with explicit object and effect handles | Expressiveness, compiler refinement, precise traps, bounded resource accounting and compatibility costs |
| Spatial/dataflow engine | Placement and explicit communication expose resource ownership | Token identity, state retention, backpressure, revocation, error semantics and placement enforcement |

These candidates may coexist in different IESs. Their communication contract is the canonical object protocol, not a shared native pointer representation. A capability valid on one core is not automatically a transferable capability on another architecture.

## Privilege and protected operations

A guest kernel may require supervisor operations to schedule its local threads, handle traps and maintain local page tables. Those privileges remain inside its allocation. It cannot rewrite MG ownership records, impersonate a DG requester, install EG release policy or modify observer keys. The protected service interface is deliberately narrower than a general machine-administration API.

A proposed operation includes a caller binding, object reference, operation kind, operand bounds, applicable grant and expected epochs. An operation either completes its specified local effect, returns a defined denial, or records uncertainty if an effect may have escaped without trustworthy completion evidence. A trap cannot turn a partially emitted packet into an uneventful instruction retry. External effects therefore belong to owner protocols, even when an ISA supplies efficient enqueue instructions.

**R-10-02 — Confined privilege.** Supervisor, hypervisor, firmware and debug privileges visible to a workload MUST remain unable to modify another domain’s ownership or the enforcing guard’s authority state. Every privileged operation that can affect a boundary MUST have a declared authorized caller and failure behavior.

Object operations may include reading a bounded immutable object, allocating a private region, submitting a mailbox record, proposing a persistent update and requesting an effect. Their semantics must state whether they copy data, borrow a reference or transfer ownership. A generic “send” instruction that implicitly chooses among those meanings would make revocation and failure analysis ambiguous. Fast paths can optimize an established contract but cannot elide its checks.

## Capability semantics and their limits

The [Cambridge CHERI description](https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/cheri-faq.html) explains bounded references with permissions, protected validity tags and monotonic authority reduction. These mechanisms are relevant to spatial memory safety and compartment interfaces. A validity tag does not mean that the referenced data is secret, truthful or approved for release. Nor does the presence of CHERI alone establish complete temporal revocation throughout caches and devices.

ASKA requires object identity to remain distinct from address representation. The tuple `(realm_id, owner_id, object_id, generation)` is the protocol identity; an implementation may associate it with native capabilities, protected table entries or engine tokens. Conversions to integer addresses cannot preserve authority unless the declared architecture explicitly protects and validates that conversion. Deserialization of an untrusted byte string must never recreate a hardware capability merely because the string resembles one.

**R-10-03 — Nonforgeable and attenuated references.** A reference accepted by a protected operation MUST derive from authorized installation or attenuation and MUST bind its current object generation and permitted operation. Capability tags, object handles and engine tokens MUST have explicitly different meanings where their guarantees differ.

Region-based allocation is a useful candidate for short-lived cells: all private allocations die with the region, limiting the need for arbitrary deallocation within the cell. It still requires cleanup of retained references and delayed transactions before reuse. A more general allocator can be admitted, but its temporal-safety argument must include every reference-bearing store, queue and foreign-function interface. Control-flow integrity, shadow stacks and protected return mechanisms may reduce control-transfer attacks; they do not replace data-authority checks or supply passive visibility into private processor state.

Execute-only code regions are another optional execution-profile candidate. Their qualification must cover instruction fetch, data loads, aliases, DMA, debug, crash dumps and privileged remapping on the selected architecture. A protected return stack similarly requires admitted writers and race-safe call, return, exception and context-switch behavior. These mechanisms can harden a component inside one IES, but do not establish a separate physical failure domain. A profile change that relaxes a selected hardening property requires the ordinary scoped update and admission process; detector confidence or scheduling pressure cannot silently remove it.

## Precise execution, concurrency and faults

The execution profile defines integer overflow, alignment, floating-point modes, atomics, memory ordering, trap precision and cancellation points. Undefined language behavior is not acceptable as an undocumented route to additional machine authority. A compiler may assume source-language rules for application correctness, but the guard must remain safe against arbitrary machine instructions from the admitted IES.

A cell’s concurrency model is declared at admission. Single-threaded bounded workers simplify local reasoning; multiple threads require explicit synchronization and cancellation semantics. Cross-IES synchronization uses messages or protected ownership transitions. A hardware atomic operation on a foreign writable bank is not admitted merely because it is efficient. An acceleration interface inspired by global-address-space systems must expose authorized object operations and cannot introduce ambient remote load/store reachability.

**R-10-04 — Precise semantic boundary.** Each execution profile MUST specify exceptions, concurrency, cancellation and externally visible partial effects. Fault handling MUST preserve authority and MUST NOT repeat a potentially irreversible effect without owner-level deduplication or reconciliation.

Transient faults, speculative execution and microarchitectural leakage need separate evidence. An architectural model that commits only permitted loads does not by itself prove that speculative activity leaves no observable trace. The physical and temporal assumptions are recorded under [side-channel protection](18_physical_side_channels_and_temporal_protection.md). If a candidate requires disabling a feature, the deployed configuration and its verification become part of the profile rather than an informal tuning recommendation.

## Toolchain and compatibility contract

The build artifact includes source provenance where available, compiler and linker versions, target-feature settings, dependency digests, relocation rules and imported protected interfaces. Generated code, handwritten assembly and foreign libraries have equal obligations at the machine boundary. A build agent can propose a new artifact; only an admitted installation process can replace the active artifact or its grants.

Compiler validation has several layers. Source-to-intermediate reasoning checks application-level transformations; intermediate-to-machine refinement checks preserved operations; executable inspection checks the imported boundary surface; adversarial machine-code tests check that the hardware boundary survives arbitrary instructions. None of these can be replaced by a claim that the source language is memory safe. Conversely, legacy native code can be useful inside a constrained IES without being granted the stronger semantic assurance of a verified program.

**R-10-05 — Traceable compilation and loading.** The loader MUST bind the executable to its declared semantics and dependency set. Compatibility translation, JIT compilation and generated code MUST execute under explicit bounded authority and MUST NOT alter protection state or create new release rights as a side effect of translation.

A legacy virtual machine can receive a block-storage object, a rendered display surface and bounded network services. Emulated devices must remain inside the guest’s assigned domain or behind the same DG/BG/EG contracts as native devices. A compatibility shim that silently maps an arbitrary host pointer into the guest violates the boundary even if the guest appears functional. Dynamic binary translation must also account for retained code caches and invalidate old authority-bearing state when epochs change.

## Refinement example and decision gate

Suppose a minimal-object engine offers `propose_append(handle, version, payload)`. Its specification says that the engine produces a proposal to a PO; it does not say that the instruction durably appends. A compiler may fuse payload construction and enqueueing only if the source version remains stable and the PO still performs its final authorization and durability checks. On a trap after enqueueing, the runtime queries the effect identifier. It does not execute a new append with a new identifier merely to hide the trap from the application.

The ISA decision should compare proof obligations, resource overhead, failure containment, code availability and workload suitability. Instruction count, transistor count or simulation throughput alone cannot settle it. A small custom processor may simplify the protected interface while increasing compiler and verification effort. A capable commodity core may provide mature tools while introducing shared microarchitectural state and a larger trusted implementation. These are explicit tradeoffs, not a ranking by novelty.

**R-10-06 — Evidence-based ISA selection.** Any selection of an ISA for a deployment MUST document the workloads, protection obligations, compatibility costs, residual risks and evidence used. An unvalidated candidate MUST remain labeled as a candidate; performance simulations and formal models MUST be distinguished from measured implementation behavior.

Acceptance specifications are:

- **T-10-01:** Load an artifact requiring an unavailable protection feature or wrong semantic revision. Admission must fail before execution, with a precise incompatibility record.
- **T-10-02:** Run adversarial supervisor code that rewrites local mappings, executes privileged instructions and invokes debug interfaces. External ownership and guard state must remain unchanged.
- **T-10-03:** Forge serialized handles, widen bounds and replay a prior-generation reference. Each attempt must fail at the protected operation without transferring authority.
- **T-10-04:** Inject a trap immediately before and after an effect enqueue. The resulting receipt must distinguish no enqueue, established local enqueue and unresolved outcome; no untracked retry may occur.
- **T-10-05:** Replace a runtime dependency or reuse a JIT cache after a grant-epoch change. The loader or runtime must reject the mismatch or invalidate the stale state.
- **T-10-06:** Review a candidate deployment dossier. It passes only if every claimed property has a named semantic obligation and appropriate evidence; an emulator result presented as manufactured-silicon proof is a failing counterexample.
