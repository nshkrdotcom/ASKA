# ASKA v5 — Persistence and externally visible effects

## Contract-visible durability

The machine distinguishes proposal, authorized prepare, durable local commit, remote acceptance, and an irreversible physical effect. An Accord receipt must record the strongest completion fact the enforcement path can actually prove. A successful network send cannot be reported as a completed financial settlement; a volatile queue acknowledgment cannot be reported as durable storage. All effects retain plane, object, actor, contract, and Steles reference bindings.

---

## Detailed technical contract

**Requirements:** R01–R03, R05–R08, R10, R12, R17, R20, R21.

Persistent owners keep documents, identities, application records, AI context, and operation receipts after workers retire. A global filesystem or inherited runtime heap supplies no ownership authority. Each durable object has an explicit owner.

## Object ownership

A persistent object record identifies an owning realm/service, stable object identifier, version, confidentiality categories, integrity assertions, schema, encryption-key generation, and authorized methods. Once the owner commits a version, it cannot mutate that version. An object's name in a user's workspace is a scoped reference, not a globally traversable pathname.

Persistent owners expose narrow methods such as `read_version`, `append_measurement`, or `replace_document_if_version`. Each method checks caller grant, object/version, parameters, current policy, flow restrictions, lifetime, operation identity, and resource cost. A read handle does not imply write, delegation, deletion, or administrative access.

Deployments split owners by consequence and tenancy. A service holding every user's plaintext and every update credential would recreate a broad compromise domain. Sharding can limit that reach, but a shared implementation or administrator remains a common-cause dependency. High-consequence owners occupy P2 domains and use separately controlled storage/key custody where required.

The reference owner separates request execution by confidentiality compartment. A worker processing objects with categories `C` receives only inputs allowed by that confinement; multi-object operations join the required categories. A service that decrypts several compartments in one execution context inherits their join. To return a result under narrower categories, that service needs an explicit trusted release contract. Copying one input's old label cannot authorize the release. Owners may share opaque encrypted storage and protected dispatch metadata under a separate threat model that denies ordinary workers plaintext access across compartments.

## Request execution and durable commit

Persistent object services must parse requests, validate application data, and compute candidate state transitions in fresh request cells. Each cell receives only the immutable versions and method grants admitted for that operation. It has private scratch memory and no raw storage queue or authority over another request. Reusing physical resources requires the drain, reference-retirement, sanitation, and generation checks in [13](13_memory_ownership_and_lifecycle.md). A long-lived heap shared by request deserializers does not satisfy this contract.

A separate commit controller owns durable versions, journals, deduplication records, and protected policy metadata. It accepts a bounded sealed proposal binding the request, input versions, candidate output, labels, method, and allowance. It independently checks authority, current policy, versions, ownership, and commit accounting. It does not deserialize arbitrary application formats in its control heap or accept a worker-supplied pointer as durable state.

An accepted transition implementation or an independent checker must establish the application-specific relation between inputs and candidate output. Mechanical commit checks cannot make a malicious worker's permitted result correct. The controller's fixed-format decoder, storage drivers, allocator, recovery logic, and update root remain trusted within their disclosed scope; their spatial and temporal safety need separate evidence. Request-cell isolation does not establish that evidence.

After sealed output passes into protected ownership, the worker can retire independently of journal completion if no private references remain. Durable commit, receipt production, and retirement have separate states. After a crash or timeout, recovery must follow the rules for each state. Cell teardown follows the revoke/drain/sanitation state machine; durable commit has separate storage-atomicity and recovery assumptions.

## Reference transaction

```text
PROPOSED -> VALIDATED -> PREPARED -> COMMITTED -> RECEIPTED
                 |          |
                 v          v
               DENIED     ABORTED
```

1. A worker submits an immutable request and operation identifier through an admitted endpoint. The owner authenticates the bounded envelope and resolves its grants. A fresh confined request cell performs application syntax checks.
2. The request cell validates application method semantics and computes a private candidate version from its admitted inputs. The commit controller checks input versions, categories, budget, current receiver policy, and any required transition evidence. It reserves resources without exposing the candidate.
3. At commit, the controller serializes conflicting object writes, policy changes, operation deduplication, and budget consumption. It rechecks the policy version and affected object generations inside that order. A stale preliminary allow cannot authorize a write after withdrawal.
4. The controller records the new version, operation result, consumed allowance, and required recovery metadata in the defined durability domain. It publishes visibility only when the storage protocol establishes its declared commit guarantee.
5. The owner returns a receipt binding operation identifier, request commitment, resulting version, outcome, and durability class. It returns the recorded result for an identical retry and denies reuse of the identifier with different parameters.

An implementation must identify its journal, atomic-write primitive, flush ordering, and failure assumptions. Adding a record to a hash chain does not persist it. A media controller that acknowledges before protected persistence can violate the contract even if all signatures are valid.

## Crash behavior

If a crash precedes commit, the owner has published no candidate. Recovery discards the prepared private state or safely completes it under current rules. After commit, recovery must preserve the committed outcome and deduplication record. If recovery cannot determine which outcome occurred, it reports uncertainty and blocks unsafe replay rather than guessing.

The owner declares its durability domain: one protected device, replicated storage within a realm, or independently administered replicas. A single compromised signer can defeat integrity even when replicas hold the records; replication alone does not establish Byzantine integrity. A chosen replication protocol must state replica failure bounds, consistency, quorum, and partition assumptions. The architecture specifies no universal consensus ledger.

Rollback protection covers object versions, grants, counters, leases, and deduplication state. Restoring an old encrypted snapshot with old authority can revive consumed rights. Recovery must restore data into a newly admitted generation and reconcile committed operation history before enabling effects. Backup credentials are separate from policy expansion and application-update credentials.

[Twizzler](https://www.usenix.org/conference/atc20/presentation/bittman) is a data-centric persistent-object comparison. Its object access and persistence ideas do not by themselves establish ASKA's physical segregation, distributed authority, or crash/effect protocol.

## Device and irreversible effects

Device services own physical devices and expose constrained operations. A command grant identifies the device, allowed state transition, parameter bounds, sequence/operation identity, and applicable safety interlocks. Device guards deny ordinary cells access to raw command queues.

Actuator movement, printing, payment settlement, and external messages may become irreversible before a local transaction can record success. Their services must define an effect point and one of these behaviors:

| Effect strategy | Required behavior |
|---|---|
| Idempotent command | Repetition under the same operation identity produces no additional effect |
| Device-side deduplication | The device or trusted adapter durably remembers consumed operations |
| Prepare/commit support | The external participant participates in a specified commit protocol |
| Observable uncertain effect | Service reports uncertainty and requires reconciliation before retry |

A compensating transaction can repair some business outcomes. It cannot erase an emitted secret or reverse every physical action. Rolling back an in-memory journal cannot undo a print job or settled payment. Exactly-once behavior across crashes depends on the external device and the selected strategy; there is no generic guarantee.

The device service must never execute parser output directly as a privileged command. A separate method adapter checks a narrow schema and independent authority. A valid signature on “setpoint 500” does not make that value safe for a particular machine.

## Output and peripheral owners

Display, printing, audio, clipboard, screen capture, backup, diagnostic bundles, and removable storage have distinct effect owners and grants. Read access to a document is insufficient to invoke any of them. A print grant binds the immutable rendered job, printer identity, copy count, labels, and output policy; the physical release point precedes a success receipt. A printer may already have disclosed information when its service reports an uncertain outcome. The service must not report that outcome as a safe rollback.

An encounter-domain worker parses import media without firmware-install or native-memory privilege. Device identity and valid signatures do not establish content safety. Export approval covers metadata as well as document bytes. The same information-flow rules govern backup restoration and maintenance, including during emergencies. [19](19_cross_domain_security_and_release.md) gives the path register and release transaction.

## Keys, deletion, and retention

Key custodians scope object keys to one owner or a smaller collection. No universal machine master silently reads all realms. The authority graph enumerates every key-wrapping and recovery path. A recovery operator can obtain only the access explicitly established by the recovery contract.

On deletion, the owner retires object authority, prevents new reads, resolves existing loans, and executes the declared storage-erasure policy. It cannot recall prior exports. Retained audit or legal records, if any, remain explicit protected objects under separate ownership; they are not hidden exceptions to deletion.

Storage services must preserve confidentiality and integrity through compression, indexing, snapshots, and garbage collection. Indexes can reveal object existence and search terms. Their placement and labels must follow the source data and observer model.

## Open work and tests

Model two writers, a policy withdrawal, crash before/after durable commit, duplicate operation delivery, and stale snapshot restoration. Include a device that performs an effect but loses its acknowledgment. Observe both stored state and external effects; owner logs alone are insufficient.

Required research includes formally specified durability boundaries on future memory technologies, per-owner encrypted storage without universal recovery power, bounded persistent deduplication, cross-owner transactions, and the cost of many granular state owners. A realization that provides only volatile mailbox delivery must mark R08 unestablished.
