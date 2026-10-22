# ASKA — Memory ownership and lifecycle

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0012_authority_and_information_flow_gpt.md) · [Next](0014_identity_and_online_admission_gpt.md)

The 1 KiB message profile copies a coherent snapshot into protected engine storage. A separate bulk path transfers exclusive control of dedicated buffers to the network engine. The transfer completes only after old writers are blocked and outstanding writes are resolved. The controller must confirm that every CPU and device writer has stopped; a local capability or coherence update cannot establish that alone.

## Protected allocation records

Every transferable allocation has a protected record:

```text
allocation_id, allocation_generation
physical_extent, extent_length, mapping_generation
owner_ies, owner_ies_generation
confinement_label, access_rights
state, outstanding_transactions, active_transfer
```

The controller resolves handles through this record. A descriptor cannot substitute a physical address or classification. Initial transferable buffers occupy dedicated page-aligned extents; unrelated objects cannot share their ownership granule. Application subranges remain bounded by capabilities, but the transfer protocol operates on the complete dedicated allocation.

Separate generations identify IES reuse, allocation reuse, and mapping replacement. Enforcement must check generations wherever stale access could take effect. Separate operations must sanitize data, drain devices, and revoke cache aliases.

## Allocation, record, and credit lifetime

The two submission operations have different lifetimes:

| Operation | Source binding | Engine-held data | Completion |
|---|---|---|---|
| `submit_message` | Held through coherent copy or safe abort | One protected snapshot, at most 1024 payload bytes | Source access resumes after copying; snapshot storage is reclaimed after engine use ends |
| `submit_batch` | Whole dedicated allocation pinned through reclaim | A sealed manifest of non-overlapping slices, each 1–1024 bytes | Allocation returns only after every child record is locally terminal and all engine accesses finish |

A batch manifest binds the allocation and mapping generations, restriction, each slice's offset and length, destination, operation, and session. Bounds and overlap checks precede ownership commit. The manifest cannot change afterward. Each child is an independent application message with its own authenticated endpoint record and sequence value. The allocation contains no unrelated objects.

For each child, local state is `PENDING -> SEQUENCED -> RECORD_READY -> TRANSMITTING -> RETAINED -> TERMINAL`, with cancellation paths to `TERMINAL`. `RETAINED` holds identical ciphertext for a bounded retransmission interval and may be skipped when retention is disabled. A sequence is allocated only when a child enters `SEQUENCED`; allocation burns it even if that child later aborts. Records must not be re-encrypted with changed bytes under that sequence.

The 32-record limit in [0016](0016_records_and_receive_processing_gpt.md) counts local record slots from sequence allocation through terminal cleanup, including retained retransmissions. A manifest may have more pending children than available slots, within its separately configured manifest bound. The engine returns a local credit after the slot reaches its terminal state and its accesses finish. This records local completion, not receiver acknowledgment or delivery. Pending children wait without owning sequence values.

A child becomes terminal after successful local emission and the configured retention interval, or after cancellation/error cleanup. A batch can partially emit; cancellation blocks remaining children and waits for in-flight access and retained data to drain before reclamation. A withdrawal after some children emit cannot undo them. Expiry and policy are checked for every child's emission. No allocation is reclaimed while any child still references its bytes.

The current wire format supports independent messages. It has no object identifier, offset, or reassembly transaction for segmented-object delivery. An atomic bulk object requires a separately specified segmentation profile with authenticated object identity, total length, offsets, bounded assembly, partial-failure handling, and publication semantics. Until then, the bulk path is a local batching/ownership experiment over independent messages.

Both operations must exclude writers and drain earlier writes to satisfy coherent-snapshot semantics. Copy adds payload traffic but releases source access earlier. Transfer can avoid that copy but holds the allocation longer. The crossover size is a measurement question.

## Ownership state machine

```text
WORKLOAD_WRITABLE
    -> REVOKING
    -> ENGINE_EXCLUSIVE
    -> CHILD_RECORDS_ACTIVE
    -> RECLAIMING
    -> WORKLOAD_WRITABLE or RETIRED
```

1. **Offer.** The workload submits an allocation handle, extent, destination, and operation. The controller identifies the caller from its queue context, verifies ownership, and pins the allocation's mapping, label, and generations.
2. **Block new writers.** Mark the allocation `REVOKING`. Memory-side enforcement denies new writes from its former owners and devices. New aliases and remappings are forbidden while the pin remains held.
3. **Invalidate and drain.** Invalidate CPU writable translations and relevant cached permissions. Resolve dirty cache lines under their original owner/generation. Stop or fence assigned DMA writers and wait for protected completion acknowledgments. A software driver's assertion that a device is idle is insufficient.
4. **Commit exclusive access.** After all required acknowledgments and outstanding writes resolve, atomically install the engine as the exclusive accessor. The former owner retains a handle that cannot dereference the buffer. The bytes and their restriction are now stable.
5. **Authorize and protect each child.** Check current source grants, receiver-accepted scope, category flow, and budgets. Allocate a sequence when a child obtains a local record slot and form its authenticated record. The engine may read the buffer directly or encrypt in place while it has exclusive ownership.
6. **Emit each child.** Serialize the final expiry/withdrawal check with first-byte transmission authorization. Bound the decision-to-first-byte delay. A withdrawal that wins the order blocks transmission; one that follows cannot recall an emitted prefix.
7. **Reclaim the allocation.** Wait for all children to become terminal and finish all engine reads and transmissions, invalidate engine access, and sanitize or restore the agreed buffer representation before restoring workload rights. Release the allocation pin only after those actions complete.

The ownership commit defines when exclusive engine access takes effect. The preceding invalidations can span many cycles. Report their full latency, including remote acknowledgments and cache/device drain.

## Failure and concurrency

Only one transfer can pin an allocation. Lifecycle operations use a fixed acquisition order: IES lifecycle admission, allocation ownership, then queue reservations. Operations must not wait for network delivery while holding a global lifecycle lock. Reservations are bounded and cancellable.

An abort before exclusive commit resolves pending invalidations and restores rights under the still-held binding. An abort after exclusive commit first stops engine access and disposes of partial cryptographic output. It then reclaims the buffer. No path restores writes while an engine can still authenticate or transmit those bytes.

Drain timeout places the allocation in `RETIRED` quarantine. It is not reassigned until the offending device is isolated and outstanding transactions are proven resolved or permanently fenced. The allocation remains unavailable while ownership is uncertain.

CPU cache controllers must distinguish maintenance traffic needed to finish old writes from new workload writes. Late completions carry their original context or match protected outstanding-request state. They cannot acquire a new occupant's authority merely by arriving after reuse.

## Copy and immutable sharing

| Mechanism | Use | Required property |
|---|---|---|
| Exclusive transfer | Dedicated packet or tensor buffers | Old access revoked and writes drained before engine access |
| Protected copy | Small messages, retained source ownership, incompatible memory granules | Source binding and writer exclusion held through a coherent copy |
| Immutable sharing | Read-only fan-out or long-lived inputs | No remaining writer for the entire shared lifetime; reference-counted reclamation |

The copy path has its own measured costs. It freezes all writers before copying into engine storage that ordinary software and untrusted DMA cannot access. Source writes can resume after copying while the snapshot remains protected. A copy made during mutation may remain stable afterward without representing any coherent source version.

Ownership transfer eliminates one payload copy when the memory topology and crypto engine permit direct access. It still pays for cache traffic, acknowledgments, ownership metadata, encryption, and destination storage. Host/device bounce buffers can reintroduce copies.

## Capability transfer and DMA

Revocation must cover every copy of a pointer. Native capability references must encounter a revoked object generation, allocator revocation, or an equivalent checked mechanism before reuse. Page-level enforcement can block an entire transfer allocation while finer capability cleanup proceeds, provided no alternate access bypasses it.

Devices receive bounded mappings to assigned allocations. ATS, translation caches, peer-to-peer paths, device-local memory, and management apertures need explicit treatment. Capability-tag protection must prevent a non-capability accelerator from manufacturing authority through data writes. Network payloads also arrive as ordinary bytes. Creating local authority from them requires a separately authorized object-import operation.

## Whole-IES teardown

```text
ACTIVE -> QUIESCING -> DRAINED -> SANITIZED -> RETIRED
                                              -> new generation ACTIVE
```

Quiescing blocks new submissions and input. Resolve buffer pins, queued output, DMA, interrupts, cached references, and device state. Invalidate session references to the retiring generation. Clear registers and accessible memory or make retained state cryptographically and physically inaccessible to the next occupant. Only then activate the next generation.

A lower-confidentiality worker cannot inherit a previous worker's cache-visible data, queue descriptors, allocation handles, or device scratch state. Persistent data remains attached to its original protected owner and policy; it does not become public during reboot.

Migration is excluded from the first profile. Adding it requires single-active ownership of execution, allocations, keys, sequence spaces, and shared allowances. Copying a VM image and its counters into two live machines is not a valid migration protocol.

## Required evidence

Exercise retained CPU aliases, dirty cache lines, racing DMA, delayed completions, remapping, device reset, and teardown during every transfer phase. An independent observer must establish that engine-authenticated bytes equal the post-drain snapshot. Same-category tearing is a snapshot-integrity failure even if the destination was permitted.
