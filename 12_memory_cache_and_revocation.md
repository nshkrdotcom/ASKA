# ASKA v6 — Memory, cache and revocation

## Ownership is enforced on every path

Writable memory belongs to one IES at a time unless an explicitly admitted mechanism supplies stronger semantics. Coherent caches may operate inside that ownership domain. Distrusting IESs do not obtain ambient shared writable memory. The allowed cross-domain patterns are copying, immutable sharing and acknowledged exclusive ownership transfer. A physical address alone never authorizes any of them.

The MG’s protected record binds a physical extent to `(realm_id, owner_id, object_id, generation)`, owning IES, current cell epoch where applicable, permitted access, confidentiality and integrity labels, mapping epoch, lifecycle state and outstanding transaction contexts. The record also identifies relevant CPU caches, device translation caches, fabric queues and persistence paths. Ownership checks must cover delayed writebacks as well as newly issued reads and writes.

**R-12-01 — Protected ownership binding.** Every memory transaction capable of reaching a protected extent MUST carry or derive a protected current requester and ownership context. The MG MUST reject stale generations, unauthorized aliases and transactions whose identity cannot be established without trusting attacker-controlled metadata.

A transaction tag may be a hardware capability-validity bit, integrity check, error-correcting code, encryption authenticator, object-class marker or routing identity. Those meanings are different. An integrity-protected memory line is not automatically a confidentiality-labeled object; an ECC-correctable error is not evidence of benign provenance. The manifest must identify which metadata survives each cache, bridge, serializer and device path.

## Cache coherence within the boundary

A coherent IES can use private and shared internal caches according to its declared microarchitecture. The protection argument must show that a local privilege change cannot expand the IES’s physical allocation. Coherence directories, snoop filters, victim buffers and prefetch mechanisms belong in the dependency inventory if they can retain data or issue requests beyond the visible core pipeline.

A trusted exporter attached to a memory-controller interface observes traffic at that interface. It does not see a load satisfied by a private cache unless the architecture exports that event separately. This is a visibility limit, not permission for the observer to perform arbitrary active reads. Passive observation, authorized snapshot acquisition and enforcement are distinct operations.

**R-12-02 — Complete cache and alias scope.** A memory-isolation claim MUST enumerate all caches, aliases and transaction sources within its scope. A controller-level observation claim MUST identify events hidden by caches or device-local storage and MUST NOT represent missing observations as proof that no access occurred.

Alias control includes shared physical pages mapped under different virtual addresses, device-visible translations, coherent accelerators and debugging access. Read-only mappings are insufficient for immutable sharing if another alias remains writable. A source snapshot is stable only when all relevant writers have been stopped or when the underlying immutable object version makes mutation impossible.

## Three transfer modes

| Mode | Authority during use | Required completion condition |
|---|---|---|
| Copy | Source retains its object; destination receives a separate object | Stable source binding and complete destination publication |
| Immutable sharing | Multiple readers, no writer under the admitted generation | All writable aliases excluded for the sharing lifetime |
| Exclusive transfer | One current owner; former owner loses access | Old access drained, aliases invalidated, acknowledgements verified and new generation published |

A copy operation binds source owner, mapping, object generation and class for the entire drain-and-copy interval. If the implementation temporarily removes source write permission, it restores the permitted source state while that binding remains held, and only then releases the binding. Otherwise an attacker could change the mapping or class between the final byte read and restoration. Destination publication is a separate finality point, governed by its own label, capacity and authorization checks.

**R-12-03 — Stable transfer source.** Copy and snapshot acquisition MUST bind the exact source identity, mapping, generation and class until all relevant writers have drained and the copy is complete. Permission restoration MUST occur while that binding remains held. Immutable sharing MUST exclude every writer covered by the claim.

[Elasticlave, sections 4.1–4.2](https://www.usenix.org/system/files/sec22-yu-jason.pdf) distinguishes a static permission ceiling and transfer of an exclusive access lock from transfer of object ownership. That distinction is useful here. ASKA’s physical reassignment additionally requires a closure argument for delayed transactions, retained data and device state. A software lock transfer alone is not evidence of that closure.

## Revocation and reuse protocol

Revocation begins by denying new operations under the old grant or ownership epoch. It then identifies already admitted operations and either completes them under their existing contract or cancels and fences them. Cache invalidation, device-translation invalidation and queue drain need acknowledgements from the actual enforcing components. An acknowledgement from a compromised guest driver is insufficient when that driver is in the attacker model.

The resource moves through `BOUND`, `REVOKING`, `DRAINING`, `SANITIZING` and then `FREE` or `REBOUND`. Failure to establish any required step enters `QUARANTINED`. The new owner is not published while the old context remains capable of reaching the extent. A timed-out acknowledgement may justify a reset or physical disconnection under an installed grant, but time passing alone does not prove that a delayed write is impossible.

**R-12-04 — Revocation before reassignment.** Reassignment MUST close old authority, drain or fence outstanding operations, invalidate all relevant translations and caches, and complete the selected sanitization procedure before installing the new owner. Missing evidence MUST prevent reuse under a stronger claim.

Generations are freshness identifiers, not erasure mechanisms. The manifest declares their width, exhaustion behavior, rollback protection and persistent storage. Wrapping a generation while old authority may exist is forbidden. Rebooting a controller must not revive handles from a previous boot epoch. Recovery from a backup creates fresh bindings and reconciles consumed budgets rather than restoring a past authority universe.

[CHERIoT’s memory-management design](https://cheriot.org/book/memory.html) gives a concrete temporal-safety example involving allocation quotas, revocation filtering and quarantine with scanning. Such a mechanism can inform a selected processor profile. It does not automatically cover arbitrary DMA, accelerator memory or a server’s coherence fabric; those paths require their own closure evidence.

## Sanitization and retained state

The sanitization method depends on the threat and the medium. A live cross-principal reassignment may require overwriting accessible plaintext, clearing protected metadata and ensuring that no stale cache copy can return. Encryption-key destruction may be useful for retained encrypted media, but it does not erase plaintext already exposed to another component. Reset is accepted only for the state the reset contract actually clears.

A physical inspection threat can require a different procedure from protection against a new software owner. The profile therefore states which attacker can inspect which residues, what remanence interval is assumed and what evidence supports the procedure. Sanitization failure is a first-class resource outcome, not a routine log message followed by reuse.

**R-12-05 — Scoped sanitization evidence.** Every reassignment procedure MUST state the retained state it clears, the attacker it addresses and the verifying component. A generation change, reset command or key-deletion acknowledgement MUST NOT be treated as universal evidence of data destruction.

Allocator fragmentation and quota pressure cannot override these rules. Under exhaustion, the owner rejects or delays new allocations; it does not recycle quarantined pages. Allocation quotas must count pinned immutable objects, in-flight copies, device buffers and retained ciphertext where those consume the relevant resource. A malicious holder of a small handle must not pin an unbounded physical extent without an admitted account.

## Ordering, concurrency and example

Protected locks follow a declared order: lifecycle ownership before mapping/binding state before bounded engine-local state. The owner must not wait for an unbounded remote delivery while holding a global allocation lock. A copy may use per-object bindings and reserved destination capacity so unrelated objects remain available. Reconfiguration cannot acquire locks in the reverse order and deadlock the revocation path.

Consider bank extent E assigned to a Wilder cell. The cell queues a DMA write, then requests that E be transferred to a Sanctum worker. The MG stops new Wilder access; the DG invalidates the device’s translation and obtains a drain or fence acknowledgement; the MG clears retained contents and metadata; only then does it publish E with a fresh Sanctum generation. If the device never acknowledges and cannot be safely fenced, E remains quarantined. The availability cost is explicit and preferable to an unsupported confidentiality claim.

**R-12-06 — Bounded memory lifecycle coordination.** Allocation, transfer and revocation MUST use a declared lock order and bounded local work. The implementation MUST account for pinned and quarantined capacity and MUST preserve progress of unrelated admitted objects under the stated scheduling assumptions.

Acceptance specifications are:

- **T-12-01:** Inject a delayed old-owner writeback after an ownership change request. It must be drained before publication or rejected; it must never alter the new owner’s data.
- **T-12-02:** Exercise a cache-resident access and a device-local access invisible to the memory tap. The observation report must state its coverage limit rather than assert complete access history.
- **T-12-03:** Race source remapping, class changes and permission restoration against a copy. The published bytes and identity must belong to one stable admitted source binding, or the operation must fail.
- **T-12-04:** Withhold one translation-invalidation acknowledgement. Reassignment must stop in quarantine, including across controller reboot and attempted generation reuse.
- **T-12-05:** Seed every claimed retained-state location with a distinguishable pattern, perform sanitization and attempt recovery with the declared attacker’s interfaces. Any recovery defeats that sanitization claim.
- **T-12-06:** Saturate pinned objects while concurrent revocations and unrelated allocations run. No lock cycle may occur, quotas must include retained capacity, and the declared unrelated-service bound must hold.
