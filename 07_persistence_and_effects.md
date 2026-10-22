# ASKA v4 — Persistent state and external effects

[Start](01_architecture_and_reading_map.md) · [Previous](06_memory_ownership_and_lifecycle.md) · [Next](08_authority_and_information_flow.md)

**Requirements:** R01–R03, R05–R08, R10, R12, R17, R20, R21.

Information persists beyond ephemeral computations. Documents, identities, application records, AI context, and operation receipts outlive workers. They belong to explicit state owners rather than a global filesystem or an inherited runtime heap.

## Object ownership

A persistent object record identifies an owning realm/service, stable object identifier, version, confidentiality categories, integrity assertions, schema, encryption-key generation, and authorized methods. A version is immutable once committed. An object's name in a user's workspace is a scoped reference, not a globally traversable pathname.

Persistent owners expose narrow methods such as `read_version`, `append_measurement`, or `replace_document_if_version`. Each method checks caller grant, object/version, parameters, current policy, flow restrictions, lifetime, operation identity, and resource cost. A read handle does not imply write, delegation, deletion, or administrative access.

Owners are split by consequence and tenancy. A service holding every user's plaintext and every update credential would recreate a broad compromise domain. Sharding can limit that reach, but a shared implementation or administrator remains a common-cause dependency. High-consequence owners occupy P2 domains and use separately controlled storage/key custody where required.

The reference owner separates request execution by confidentiality compartment. A worker processing objects with categories `C` receives only inputs allowed by that confinement; multi-object operations join the required categories. A service that decrypts several compartments in one execution context inherits their join. Returning a narrower result then requires an explicit trusted release contract, not simply copying one object's old label. Opaque encrypted storage and protected dispatch metadata can be shared under their own threat model without giving an ordinary worker plaintext access across compartments.

## Request execution and durable commit

Persistent object services must parse requests, validate application data, and compute candidate state transitions in fresh request cells. Each cell receives only the immutable versions and method grants admitted for that operation. It has private scratch memory and no raw storage queue or authority over another request. Reusing physical resources requires the drain, reference-retirement, sanitation, and generation checks in [06](06_memory_ownership_and_lifecycle.md). A long-lived heap shared by request deserializers does not satisfy this contract.

A separate commit controller owns durable versions, journals, deduplication records, and protected policy metadata. It accepts a bounded sealed proposal binding the request, input versions, candidate output, labels, method, and allowance. It independently checks authority, current policy, versions, ownership, and commit accounting. It does not deserialize arbitrary application formats in its control heap or accept a worker-supplied pointer as durable state.

Application-specific transition correctness still needs an accepted implementation or a checked relation between inputs and candidate output. Mechanical commit checks cannot make a malicious worker's permitted result correct. The controller's fixed-format decoder, storage drivers, allocator, recovery logic, and update root remain trusted within their disclosed scope; their spatial and temporal safety need separate evidence. Request-cell isolation does not establish that evidence.

After sealed output passes into protected ownership, the worker can retire independently of journal completion if no private references remain. Durable commit, receipt production, and retirement have separate states. A crash or timeout follows their stated recovery rules. Cell teardown follows the revoke/drain/sanitation state machine; durable commit has separate storage-atomicity and recovery assumptions.

## Reference transaction

```text
PROPOSED -> VALIDATED -> PREPARED -> COMMITTED -> RECEIPTED
                 |          |
                 v          v
               DENIED     ABORTED
```

1. A worker submits an immutable request and operation identifier through an admitted endpoint. The owner authenticates the bounded envelope and resolves its grants. A fresh confined request cell performs application syntax checks.
2. The request cell validates application method semantics and computes a private candidate version from its admitted inputs. The commit controller checks input versions, categories, budget, current receiver policy, and any required transition evidence. It reserves resources without exposing the candidate.
3. At commit, serialize conflicting object writes, policy changes, operation deduplication, and budget consumption. Recheck the policy version and affected object generations inside that order. A stale preliminary allow cannot authorize a write after withdrawal.
4. Record the new version, operation result, consumed allowance, and required recovery metadata in the defined durability domain. Publish visibility only when the storage protocol establishes its declared commit guarantee.
5. Return a receipt binding operation identifier, request commitment, resulting version, outcome, and durability class. Repeated identical operations return the recorded result. Reusing an identifier with different parameters is denied.

An implementation must identify its journal, atomic-write primitive, flush ordering, and failure assumptions. A record is not durable merely because it belongs to a hash chain. A media controller that acknowledges before protected persistence can violate the contract even if all signatures are valid.

## Crash behavior

Before commit, a crash leaves no published candidate; recovery discards or safely completes prepared private state under current rules. After commit, recovery must preserve the committed outcome and deduplication record. If recovery cannot determine which outcome occurred, it reports uncertainty and blocks unsafe replay rather than guessing.

Durability domains are explicit: one protected device, replicated storage within a realm, or independently administered replicas. A single compromised signer can defeat integrity even when records are replicated; replication alone does not establish Byzantine integrity. A chosen replication protocol must state replica failure bounds, consistency, quorum, and partition assumptions. The architecture specifies no universal consensus ledger.

Rollback protection covers object versions, grants, counters, leases, and deduplication state. Old encrypted snapshots remain dangerous if restored with old authority. Restore data into a newly admitted generation and reconcile committed operation history before enabling effects. Backup credentials are separate from policy expansion and application-update credentials.

[Twizzler](https://www.usenix.org/conference/atc20/presentation/bittman) is a data-centric persistent-object comparison. Its object access and persistence ideas do not by themselves establish ASKA's physical segregation, distributed authority, or crash/effect protocol.

## Device and irreversible effects

Device services own physical devices and expose constrained operations. A command grant identifies the device, allowed state transition, parameter bounds, sequence/operation identity, and applicable safety interlocks. Raw device command queues are unavailable to ordinary cells.

Actuator movement, printing, payment settlement, and external messages may become irreversible before a local transaction can record success. Their services must define an effect point and one of these behaviors:

| Effect strategy | Required behavior |
|---|---|
| Idempotent command | Repetition under the same operation identity produces no additional effect |
| Device-side deduplication | The device or trusted adapter durably remembers consumed operations |
| Prepare/commit support | The external participant participates in a specified commit protocol |
| Observable uncertain effect | Service reports uncertainty and requires reconciliation before retry |

Compensation can repair some business outcomes but does not erase an emitted secret or reverse every physical action. Exactly-once behavior across crashes depends on the external device and the selected strategy; there is no generic guarantee.

A parser's output is never directly a privileged device command. A separate method adapter checks a narrow schema and independent authority. A valid signature on “setpoint 500” does not make that value safe for a particular machine.

## Output and peripheral owners

Display, printing, audio, clipboard, screen capture, backup, diagnostic bundles, and removable storage have distinct effect owners and grants. Read access to a document is insufficient to invoke any of them. A print grant binds the immutable rendered job, printer identity, copy count, labels, and output policy; the physical release point precedes a success receipt. A print with an uncertain outcome can already have disclosed information. Reporting a safe rollback would be incorrect.

Import media is parsed in an encounter domain with no firmware-install or native-memory privilege. Device identity and valid signatures do not establish content safety. Export approval covers metadata as well as document bytes. The same information-flow rules govern backup restoration and maintenance, including during emergencies. [12](12_cross_domain_security_and_information_release.md) gives the path register and release transaction.

## Keys, deletion, and retention

Object keys are scoped to an owner or smaller collection, not one universal machine master with silent read access to all realms. Key wrapping and recovery paths are enumerated authority edges. A recovery operator can obtain only the access explicitly established by the recovery contract.

Deletion retires object authority, prevents new reads, resolves existing loans, and executes the declared storage-erasure policy. It cannot recall prior exports. Retained audit or legal records, if any, remain explicit protected objects under separate ownership; they are not hidden exceptions to deletion.

Confidentiality and integrity survive storage compression, indexing, snapshots, and garbage collection. Indexes can reveal object existence and search terms. Their placement and labels must follow the source data and observer model.

## Open work and tests

Model two writers, a policy withdrawal, crash before/after durable commit, duplicate operation delivery, and stale snapshot restoration. Include a device that performs an effect but loses its acknowledgment. Observe both stored state and external effects; owner logs alone are insufficient.

Required research includes formally specified durability boundaries on future memory technologies, per-owner encrypted storage without universal recovery power, bounded persistent deduplication, cross-owner transactions, and the cost of many granular state owners. A realization that provides only volatile mailbox delivery must mark R08 unestablished.
