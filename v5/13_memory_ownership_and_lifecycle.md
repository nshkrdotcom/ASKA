# ASKA v5 — Memory ownership and lifecycle

## Plane and contract bindings

Ownership records also include `plane_id`, `contract_digest`, `grant_generation`, confidentiality and integrity categories, and authorized transfer interfaces. Any transfer between unlike planes is a **release/import transaction**, not simply a change in a memory pointer or address space. Changing the object or cell generation invalidates grants whose bindings no longer match. A stale DMA descriptor cannot inherit the identity or plane membership of a replacement allocation.

---

## Detailed technical contract

**Requirements:** R03, R05, R07, R12, R17, R21, R23.

The controller binds memory authority to a physical owner and an explicit object lifetime. It must preserve the identity and restrictions of the authorized bytes throughout each operation. Checking a handle before copying does not stop a concurrent writer from changing those bytes.

## Ownership records

The controller keeps protected metadata for each allocation's owner realm/domain/generation, allocation identifier/generation, physical extent, mapping version, confidentiality restriction, state, live bindings, and outstanding engine/device transactions. Ordinary software cannot write this metadata or fabricate a requester context.

The transaction path must retain each request's original owner and generation through completion, including delayed effects. An implementation can carry that context on transactions, retain it in a protected request table, or prove complete quiescence before reuse. It cannot relabel an old completion using the current occupant's identity.

## Three exchange operations

| Operation | Ownership rule | Completion |
|---|---|---|
| Coherent snapshot copy | Pin source owner/mapping/label; exclude writers and drain before copying into protected output storage | Source rights resume after the stable copy completes or a safe abort |
| Exclusive transfer | Revoke all old access, drain transactions, then install a new owner | Old owner cannot access data until an explicit return transfer |
| Immutable loan | Remove all writers and retain read-only lifetime references | Reclaim only after every reader/engine reference is gone |

All three require a stable source binding. Copying changing source bytes can produce a stable result that represents no coherent source version. If an application needs only independently classified stream chunks, it must declare that weaker consistency contract rather than report a coherent snapshot.

Native physical islands can exchange a copy through a guarded link. A controller can transfer a local bank or engine when reassignment exposes no foreign address path. It is not mandatory for a 1 KiB message. Large numerical objects may use batches, streaming, or an owned memory service under the same restrictions.

## Transfer transitions

```text
OWNED -> BOUND -> REVOKING -> DRAINED -> TRANSFERRED
                    |                     |
                    v                     v
                QUARANTINED          RECLAIM_PENDING
                                          |
                                          v
                                      SAFE_TO_REUSE
```

The controller serializes binding acquisition with owner changes, mapping replacement, reclassification, and reallocation. During revocation the controller blocks new writer admissions, invalidates aliases, and requests CPU/device completion. It distinguishes dirty cache writebacks that finish previously admitted work from new writes that revocation forbids. In-flight DMA, cached aliases, and delayed writebacks must all reach the declared drain condition. Drain succeeds only when the protected interface guarantees no unresolved old effect can mutate the transferred extent.

The transfer commit changes ownership after that guarantee holds. The linearization point does not imply instantaneous distributed revocation. After reset, a missing acknowledgment, or ambiguous completion, the controller quarantines the resource. It releases quarantine only when isolation plus a stronger drain or permanent fencing resolves the uncertainty.

On abort, the controller invalidates partial copies or cryptographic output, ends engine access, and restores rights under the still-held source binding only where restoration is safe. The controller releases the binding last. If ownership or data representation is uncertain, it does not restore access to maintain apparent progress.

## Allocations, records, and streams

A transfer allocation can serve one message or a sealed batch manifest. The manifest binds its generation, slices, destinations, operations, confinement, and session contracts. Each independent message has its own transport sequence and local lifecycle. The sender retains local slots from sequence allocation through engine completion and bounded retransmission retention. A local slot does not acknowledge receiver progress.

The controller pins an allocation while any pending or active child can read its bytes. On cancellation, it blocks new child work, resolves in-flight accesses, and disposes of retained state before reclaim. It cannot recall emitted children. The emission guard checks policy and expiry for every emission, including later children of an admitted batch.

Streaming a single application object additionally needs an object/version identifier, authenticated total length, chunk offsets/indices, bounded assembly, integrity commitment, and publication transaction. Partial chunks stay quarantined. [20](20_admission_transport_and_protected_delivery.md) defines the transport contract; receiver publication and durable storage are separate commits.

## Release bindings and removable objects

An approved disclosure pins an immutable output version, its category metadata, destination, and representation through final emission. A descriptor that can change after approval cannot bind the approved bytes. The release enforcer holds a protected binding or its own coherent copy; reclassification and ownership changes serialize with that binding. On cancellation, the controller resolves device reads before releasing that binding.

A removable medium remains an external recipient even when no live network connects it. Export writes only through its device service under the crossing contract in [19](19_cross_domain_security_and_release.md). Reimport does not revive saved capabilities, retired generations, or release allowances. The selected output representation and threat model must include filesystem metadata, filenames, unused blocks, device firmware commands, and residual storage.

## Cell retirement and reuse

```text
AVAILABLE -> RESERVED -> INITIALIZED -> RUNNING
    ^                                   |
    |                                   v
SANITIZED <- REFERENCES_RETIRED <- DRAINED <- QUIESCING
```

The controller reserves an available resource, initializes the admitted cell, and starts it in `RUNNING`. To retire it, the controller enters `QUIESCING` and closes new work and input. It reaches `DRAINED` only after resolving cells, memory requests, DMA, interrupts, device commands, output engines, and transfer bindings. It then invalidates old endpoint references, session bindings, and handles to reach `REFERENCES_RETIRED`. Finally, it sanitizes registers, scratch memory, caches, local queues, device-local state, and retained plaintext. Only after `SANITIZED` may it make the resource available and activate a new generation.

The controller must never silently reuse a generation after wrap or uncertain recovery. It must persist the anti-rollback state needed to prevent reuse, or retire the identifier and establish a fresh namespace. Cryptographic erasure works only if encryption covered every relevant copy, no actor can recover the retired keys, and sanitation clears any plaintext caches. Incrementing a generation does not erase data.

The controller may reuse physical resources between requests. A fresh cell does not require newly fabricated hardware. The reuse protocol must establish the same declared observation boundary. A dedicated high-assurance resource may forbid borrowing across particular trust classes altogether.

## Locking and deadlock

The reference acquisition order is lifecycle admission, allocation binding, then bounded engine/queue reservation. A task cannot retain a global allocation lock while waiting indefinitely for a remote recipient. Reserve bounded destination capacity or fail before taking an irreversible step. Control and drain acknowledgments use reserved resources so data saturation cannot prevent cleanup.

Immutable sharing can retain resources indefinitely if a malicious reader never releases them. The controller therefore bounds loan lifetimes and enforces revocation. If it cannot stop an engine safely, it must keep the allocation unavailable. Report the resulting loss of availability. It does not justify reusing uncertain data.

## Evidence and unresolved mechanisms

[Elasticlave](https://www.usenix.org/system/files/sec22-yu-jason.pdf) is a comparison for exclusive access and sharing. An ASKA comparison must check its mechanisms against physical reassignment, device writers, and source-binding requirements. Elasticlave alone does not implement the complete contract.

Tests interleave CPU aliases, DMA, delayed writebacks, mapping changes, teardown, and reset at every transition. The independent oracle compares authenticated bytes with source history and observes effects on a reused allocation. A broken variant retaining one writer must fail even when the final authentication tag is valid.

Required research includes controller-level drain semantics, reference reclamation across heterogeneous engines, physical-bank reassignment, sanitation of analog/accelerator state, and a refinement argument from real transactions to this state machine. An unexplained atomic `revoke_all()` cannot establish that those mechanisms work.
