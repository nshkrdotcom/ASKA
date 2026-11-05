# ASKA v6 — IES, cells, resources and scheduling

## Physical ownership before execution

An isolated execution stack (IES) is a physical compute and writable-memory ownership domain. A cell is a bounded execution lifetime within an IES. These are different units: restarting a cell does not prove that its IES caches, device queues or retained memory have been cleared, and creating a child cell does not create a new physical boundary. The selected machine manifest identifies which resources are exclusive, which are scheduled, which are immutable and which remain shared dependencies. The concrete arrangements in [the reference machine](04_reference_machine_and_reachability.md) are authoritative; this chapter defines their allocation contract.

The resource owner maintains a protected allocation record containing the resource identity, physical extent, current IES and cell binding, generation, allocation epoch, permitted operations, lifecycle state, quota account, sanitization method and outstanding-operation count. Applications receive bounded handles derived from installed grants. An address, utilization estimate, placement preference or favorable DTMS assessment cannot substitute for that authority. A resource-discovery service may answer range and capacity queries, but its answers neither reserve resources nor mint access to them. Discovery metadata itself can reveal workloads and therefore has a release policy.

**R-09-01 — Accountable physical allocation.** Every allocated compute unit, writable extent, device context and communication reservation MUST have one authoritative allocation record and an identified enforcing boundary. Allocation MUST reject overlapping exclusive owners, undeclared shared dependencies and generation reuse under outstanding authority.

An IES can contain general-purpose cores, bounded interpreters, accelerators or specialized pipelines. Physical ownership concerns the resources the implementation can actually exclude. Two software compartments on a shared processor may be useful cells, but they do not acquire independent reset, cache, power or firmware roots merely by receiving separate names. Likewise, a zone groups authorized participants; it is not a bypass around the guards between them.

## Cell descriptor and lifecycle

A cell descriptor binds an executable artifact digest and semantic revision to a resource set, initial input-object versions, confinement labels, attenuated handles, output schemas, instruction or work budget, memory quota, deadline policy and permitted effect requests. The descriptor distinguishes computations that can be suspended and resumed from those that must be abandoned on loss of continuity. A parent can provision a child without gaining access to every child input or output: the child’s principals and object owners independently authorize those flows.

The resource lifecycle is `FREE → RESERVED → BOUND → RUNNING → QUIESCING → SANITIZING → FREE`. An implementation may expose intermediate scheduler states, but only the resource owner changes ownership. Failure to establish quiescence enters `QUARANTINED`, which is neither free capacity nor a successful transfer. `RESERVED` sets aside capacity without granting execution. `BOUND` installs the exact cell and grant epochs. `QUIESCING` denies new work and waits for or cancels work already admitted. Sanitization completes only when the relevant memory, device and fabric owners have supplied the acknowledgements required by their contracts.

**R-09-02 — Bounded cell creation.** Cell admission MUST validate the complete descriptor, bind all initial authority to the current cell epoch and install independently enforceable resource and effect ceilings. Child admission MUST be an attenuation of the participating owners’ authority; parent creation authority MUST NOT imply child-data inspection or output release.

Scheduler cancellation is an allocation decision, not a claim that externally visible effects have disappeared. The cell’s requests continue to have the finality states defined in [the execution and effect contract](05_unified_execution_data_and_effect_contract.md). A suspended cell cannot resume with an expired grant merely because its register snapshot is authentic. Resumption revalidates object generations, resource assignments and effects still pending. Lost continuity invalidates the relevant handles and requires a new admission.

## Spatial partitioning and dynamic splitting

Dynamic splitting is allowed only at a supported hardware granularity. A large domain can be divided into smaller IESs when the manifest identifies separable compute, writable banks, interrupt destinations, reset controls and guard contexts. The transition first stops new work, drains outstanding operations, removes aliases, sanitizes transferred state and publishes new ownership generations. Changing an operating-system process identifier or a virtual channel number is not that transition.

Joining domains also requires authorization. It combines potential access, shared failure and leakage relationships, so it cannot be presented as a performance-only change. A proposed join identifies which previously separated objects would become reachable, what labels remain enforceable and which assurance claim is lost. If those terms cannot be admitted, the workload instead uses explicit mailboxes between the existing domains.

**R-09-03 — Controlled repartitioning.** Splitting, joining or migrating an IES MUST use a declared resource transition that closes old access before publishing new ownership. A missing drain, invalidate, reset or sanitization acknowledgement MUST quarantine the affected resource. Repartitioning MUST NOT silently weaken the admitted isolation or observation profile.

The architecture is compatible with a conventional guest operating system inside one IES. A compromised guest kernel may control its assigned scheduling and memory mappings, but it must not control the outer allocation record, neighboring banks, guard policy or observer root. Compatibility services such as file systems, graphics stacks and network libraries receive object interfaces with bounded authority. They do not receive an implicit machine-wide management role.

## Secure resource borrowing and bandwidth

The Secure Resource Borrowing Mechanism (SRBM) admits a temporary resource contract among lender, borrower and enforcing owner. The contract specifies the physical resource, borrower identity and epoch, permitted workload, maximum allocation, reservation interval, bandwidth or service quota, return deadline, revocation conditions, reclaim procedure, sanitization evidence and liability for incomplete return. Lending idle memory without reserving the access bandwidth can produce an allocation that is spatially valid but unusable. Lending compute without budgeting fabric and storage pressure can starve another admitted workload.

A borrow grant is installed only after the lender’s access has been closed where exclusivity is required. During the lease, a scheduling manager cannot reclaim the resource by reassigning a register while the borrower still has DMA in flight. On expiry, the owner stops new requests, drains or fences old operations, records uncertain effects, sanitizes and then makes the resource available. A borrower that cannot cooperate does not retain perpetual ownership; an independent guard or reset boundary must enforce the negotiated termination. If that boundary is unavailable, the resource remains quarantined and the promised reclaim bound is not satisfied.

**R-09-04 — Complete borrowing contract.** An SRBM grant MUST cover capacity, bandwidth, duration, revocation, reclaim and sanitization. The owner MUST enforce the borrower’s ceilings independently of borrower software and MUST NOT advertise returned capacity before the reclamation evidence is complete.

This contract deliberately distinguishes availability from revocability. [OctopOS, sections 4.2–4.6](https://ics.uci.edu/~ardalan/papers/Yao_MobiSys23.pdf) describes hardware mailbox delegation bounded by time or message count and protections against a resource manager resetting an active delegate. It provides a concrete comparison for protected allocation. ASKA must separately declare whether a particular lease allows immediate protective revocation, delayed termination or an irrevocable service interval; those choices cannot all be promised simultaneously.

## Scheduling and service guarantees

Scheduling policy chooses among requests already authorized. It may consider deadlines, energy, locality, fairness, reservation state and DTMS risk evidence. Increasing a workload’s priority cannot enlarge its readable object set. A risk alarm may activate an installed rate-limit or isolation template, but it cannot authorize a scheduler to copy another IES’s private state for analysis.

Reservations include all bottlenecks needed for the promised service: compute issue slots, memory-controller bandwidth, fabric buffers, cryptographic engines and the receiving owner’s queue. A stated deadline must define its clock, bounded drift, admission load and failure assumptions. If an external recipient is unavailable, the sender may obtain a local rejection or uncertain-outcome receipt; it cannot infer remote completion from a local scheduling guarantee. Overload policy specifies which work is rejected before admission and how already admitted critical work is protected.

**R-09-05 — Nonexpansive scheduling.** Scheduling and risk adaptation MUST preserve installed authority and declared resource reservations. A service guarantee MUST identify its dependencies and overload behavior. Best-effort work MUST NOT consume a reservation merely because both workloads share an interconnect or management processor.

[M3’s hardware/OS co-design](https://os.inf.tu-dresden.de/papers_ps/asmussen-m3-asplos16.pdf) demonstrates a useful separation between heterogeneous processing elements and hardware-mediated outward communication. It does not establish ASKA’s physical fault independence or service bounds. ASKA’s placement problem must therefore account for actual shared resources rather than treating a small kernel or a message interface as sufficient evidence for every isolation property.

## Operational example and acceptance obligations

Consider a document-analysis cell in Agora borrowing an accelerator from a local pool. The PO supplies an immutable document version; the DG reserves a bounded accelerator context; the BG reserves result-buffer capacity; the EG has no external release grant. The accelerator may return a candidate summary to the cell’s private output object. It cannot send that summary through a network device. If the deadline expires while a device write is pending, the cell stops accepting new work, the DG fences the device, and the target buffer remains unavailable until the old transaction context is closed. A utilization monitor may report the incident without receiving the document contents.

**R-09-06 — Explicit lifecycle evidence.** Allocation, admission, cancellation, reclaim and assurance downgrade MUST produce scoped records identifying the resource, owner epoch, cell epoch and unresolved obligations. Monitoring loss MUST follow the admitted downgrade or bounded-response policy rather than be reported as successful observation.

The following are acceptance specifications, not completed hardware tests:

- **T-09-01:** Attempt simultaneous exclusive allocation of one bank to two IESs and replay an old-generation allocation. The protected records and physical access observations must show at most one current owner; the stale request must be rejected.
- **T-09-02:** Create a child with an output readable only by a third principal. Parent inspection and a child request exceeding its descriptor must fail while an authorized child computation succeeds.
- **T-09-03:** Delay one cache or device drain acknowledgement during a split. New ownership must remain unpublished and the affected extent must remain quarantined.
- **T-09-04:** Exhaust borrowed bandwidth and let the lease expire with outstanding work. Excess work must be denied, return must await reclaim evidence, and no old borrower operation may alter the reassigned resource.
- **T-09-05:** Saturate best-effort traffic and submit a higher-risk scheduling recommendation. Reserved service must meet its declared bound under the stated assumptions, and no additional object access may become available.
- **T-09-06:** Remove an observer link during a running cell. The owner’s record must show the specified downgrade or response, with the visibility gap preserved and no invented completion evidence.
