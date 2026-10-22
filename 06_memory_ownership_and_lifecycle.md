# ASKA v4 — Memory, ownership, and lifecycle

[Start](01_architecture_and_reading_map.md) · [Previous](05_execution_and_instruction_semantics.md) · [Next](07_persistence_and_effects.md)

**Requirements:** R03, R05, R07, R12, R17, R21, R23.

Memory authority follows physical ownership and explicit object lifetimes. The controller must preserve the identity and restriction of the bytes being authorized throughout the operation. A handle check before a racing copy is insufficient.

## Ownership records

Each allocation has protected metadata for its owner realm/domain/generation, allocation identifier/generation, physical extent, mapping version, confidentiality restriction, state, live bindings, and outstanding engine/device transactions. Ordinary software cannot write this metadata or fabricate a requester context.

Requests and delayed effects must remain associated with their original owner and generation until completion. An implementation can carry that context on transactions, retain it in a protected request table, or prove complete quiescence before reuse. It cannot relabel an old completion using the current occupant's identity.

## Three exchange operations

| Operation | Ownership rule | Completion |
|---|---|---|
| Coherent snapshot copy | Pin source owner/mapping/label; exclude writers and drain before copying into protected output storage | Source rights resume after the stable copy completes or a safe abort |
| Exclusive transfer | Revoke all old access, drain transactions, then install a new owner | Old owner cannot access data until an explicit return transfer |
| Immutable loan | Remove all writers and retain read-only lifetime references | Reclaim only after every reader/engine reference is gone |

All three require a stable source binding. Copying changing source bytes can produce a stable result that represents no coherent source version. If an application needs only independently classified stream chunks, it must declare that weaker consistency contract rather than report a coherent snapshot.

Native physical islands can exchange a copy through a guarded link. Local ownership transfer is useful when a bank or engine can be reassigned without exposing a foreign address path. It is not mandatory for a 1 KiB message. Large numerical objects may use batches, streaming, or an owned memory service under the same restrictions.

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

Binding acquisition serializes with owner changes, mapping replacement, reclassification, and reallocation. During revocation the controller blocks new writer admissions, invalidates aliases, and requests CPU/device completion. Dirty writebacks needed to finish previously admitted work are distinguished from new writes. Drain succeeds only when the protected interface guarantees no unresolved old effect can mutate the transferred extent.

The transfer commit changes ownership after that guarantee holds. The linearization point does not imply instantaneous distributed revocation. Reset, missing acknowledgment, or ambiguous completion leaves the resource quarantined until isolation and a stronger drain or permanent fencing resolves the uncertainty.

Abort invalidates partial copies or cryptographic output, ends engine access, and restores rights under the still-held source binding where restoration is safe. The controller releases the binding last. If ownership or data representation is uncertain, it does not restore access to maintain apparent progress.

## Allocations, records, and streams

A transfer allocation can serve one message or a sealed batch manifest. The manifest binds its generation, slices, destinations, operations, confinement, and session contracts. Each independent message has its own transport sequence and local lifecycle. Local slots are held from sequence allocation through engine completion and bounded retransmission retention; they are not receiver acknowledgments.

An allocation remains pinned while any pending or active child can read its bytes. Cancellation blocks new child work, resolves in-flight accesses, and disposes of retained state before reclaim. Already emitted children cannot be recalled. Policy and expiry are checked for each emission, not only once when the batch begins.

Streaming a single application object additionally needs an object/version identifier, authenticated total length, chunk offsets/indices, bounded assembly, integrity commitment, and publication transaction. Partial chunks stay quarantined. [13](13_admission_and_delivery.md) defines the transport contract; receiver publication and durable storage are separate commits.

## Release bindings and removable objects

An approved disclosure pins an immutable output version, its category metadata, destination, and representation through final emission. A descriptor that can change after approval cannot bind the approved bytes. The release enforcer holds a protected binding or its own coherent copy; reclassification and ownership changes serialize with that binding. Cancellation resolves device reads before releasing it.

A removable medium remains an external recipient even when no live network connects it. Export writes only through its device service under the crossing contract in [12](12_cross_domain_security_and_information_release.md). Reimport does not revive saved capabilities, retired generations, or release allowances. Filesystem metadata, filenames, unused blocks, device firmware commands, and residual storage are included in the selected output representation and threat model.

## Cell retirement and reuse

```text
AVAILABLE -> RESERVED -> INITIALIZED -> RUNNING
    ^                                   |
    |                                   v
SANITIZED <- REFERENCES_RETIRED <- DRAINED <- QUIESCING
```

Quiescing closes new work and input. Drain resolves cells, memory requests, DMA, interrupts, device commands, output engines, and transfer bindings. Retirement invalidates old endpoint references, session bindings, and handles. Sanitation covers registers, scratch memory, caches, local queues, device-local state, and retained plaintext. Only then may the controller activate a new generation.

Generations are never silently reused after wrap or uncertain recovery. Persist sufficient anti-rollback state or retire the identifier and establish a fresh namespace. Cryptographic erasure is an option only when every relevant copy was encrypted, keys are inaccessible afterward, and plaintext caches are handled. Incrementing a generation does not erase data.

Resources can be reused physically between requests; a fresh cell need not mean newly fabricated hardware. The reuse protocol must establish the same declared observation boundary. A dedicated high-assurance resource may forbid borrowing across particular trust classes altogether.

## Locking and deadlock

The reference acquisition order is lifecycle admission, allocation binding, then bounded engine/queue reservation. A task cannot retain a global allocation lock while waiting indefinitely for a remote recipient. Reserve bounded destination capacity or fail before taking an irreversible step. Control and drain acknowledgments use reserved resources so data saturation cannot prevent cleanup.

Immutable sharing can retain resources indefinitely if a malicious reader never releases them. Loans therefore have bounded lifetimes and controller-enforced revocation; when an engine cannot be stopped safely, the allocation remains unavailable. Report the resulting loss of availability. It does not justify reusing uncertain data.

## Evidence and unresolved mechanisms

[Elasticlave](https://www.usenix.org/system/files/sec22-yu-jason.pdf) is a comparison for exclusive access and sharing. Its mechanisms must be checked against physical reassignment, device writers, and ASKA's source-binding requirements rather than treated as a complete implementation.

Tests interleave CPU aliases, DMA, delayed writebacks, mapping changes, teardown, and reset at every transition. The independent oracle compares authenticated bytes with source history and observes effects on a reused allocation. A broken variant retaining one writer must fail even when the final authentication tag is valid.

Required research includes controller-level drain semantics, reference reclamation across heterogeneous engines, physical-bank reassignment, sanitation of analog/accelerator state, and a refinement argument from real transactions to this state machine. An unexplained atomic `revoke_all()` cannot establish that those mechanisms work.
