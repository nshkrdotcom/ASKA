# ASKA v6 — Persistent objects and storage recovery

## Persistent state has an owner

A persistent object owner (PO) is the narrow authority for a durable object namespace. It controls accepted operations, version transitions, retention, encryption-key scope and the meaning of durable commitment. Applications propose changes through bounded interfaces. They do not obtain raw write access to another owner’s journal, index, key store or backing device merely because they can read an object.

The PO record includes object identity and generation, current committed version, label, permitted operation schemas, grant and policy epochs, retention constraints, durability profile, key references, deduplication state and recovery lineage. Derived indexes, embeddings, caches and summaries remain objects with their own labels and retention. Deleting the primary document does not automatically remove every derived disclosure.

**R-16-01 — Owned persistent namespace.** Every durable object and security-relevant derivative MUST have an identified owner, version, label and retention contract. Raw storage access MUST NOT bypass the PO’s object-level authorization, and read authority MUST NOT imply mutation, backup, export or key-recovery authority.

## Request execution and commit-controller separation

**R-16-02 — Confined requests and separate commit authority.** Native persistent object services MUST parse application requests, validate application data and compute candidate transitions in fresh confined request cells with private scratch state. Each cell MUST receive only the immutable committed input versions and method grants admitted for that operation, without raw protected-storage queues or authority over another request. A separate commit controller MUST accept only bounded sealed proposals and independently validate their authority, current policy, input versions and generations, ownership, labels and commit accounting. Arbitrary application deserialization and worker-supplied raw pointers MUST NOT enter the controller’s durable control state.

Freshness applies to the execution lifetime and its authority, not necessarily to newly manufactured hardware. Reusing the physical cell requires the retirement, drain, sanitization and generation transition in [Memory, cache and revocation](12_memory_cache_and_revocation.md). A long-lived heap shared by successive request deserializers does not satisfy this contract. Committed versions remain immutable inputs; an update creates a candidate successor, and the worker cannot mutate a version that another admitted request is reading.

The sealed proposal binds the request commitment, method, exact input-version and object-generation tuples, candidate output commitment, resulting labels, grant and allowance references, and effect identity. The controller owns protected versions, journals, deduplication records and policy metadata. It checks these bindings again inside the commit order, including concurrent withdrawal and allowance consumption. Its fixed-format decoder, allocator, storage drivers, recovery logic and update authority remain explicitly trusted and require separate safety evidence. Separating the worker does not prove this trusted code safe or make every permitted candidate semantically correct. An accepted transition implementation or independently qualified checker must establish the application-specific relation between admitted inputs and candidate output.

Request confinement follows confidentiality compartments. A worker processing several admitted inputs inherits the join of their confidentiality requirements under the declared partial order; a service that decrypts several compartments in one context inherits that same combination. Producing a result with narrower confidentiality requires an explicit trusted release contract. Copying a convenient input label cannot authorize the result. Opaque encrypted storage or protected dispatch metadata may be shared under a declared boundary that prevents ordinary request workers from obtaining other compartments’ plaintext.

After the candidate passes into protected immutable ownership, the worker may retire before journal completion only when no private references remain. Request retirement, durable commitment and receipt production retain separate state and recovery obligations. A compatibility service with a persistent application-parser heap must declare this weaker execution boundary and cannot claim native request-cell conformance.

## Storage encryption and recovery contract

An encrypted-storage domain combines resource guards with protected keys and storage metadata. Its contract combines guarded object access, encryption of retained data, protected key custody, authenticated metadata, rollback handling and declared physical exposure limits. The implementation must identify where plaintext exists and which components can access it.

Keys are scoped by owner, object group, purpose and lifetime as required by the selected profile. A recovery capability is separate from ordinary use and from exporting a key. There is no implicit universal recovery key held by a hub, AI system or Keystone. Recovery ceremonies can involve multiple independently authorized parties, but threshold participation must not erase the rights of object principals or make every historical backup current again.

**R-16-03 — Explicit encrypted-storage boundary.** An encrypted-storage realization MUST declare its plaintext locations, encryption and authentication profile, key custodians, recovery authority and rollback assumptions. A hardware encryption feature or successful attestation MUST NOT be represented as proof of complete storage confidentiality or correct object policy.

A storage controller can be outside the plaintext boundary if it receives authenticated ciphertext and lacks usable keys. It can still deny service, replay old sectors or reveal access patterns. Those threats require separate controls and assumptions. Conversely, a device that decrypts internally is part of the plaintext trust boundary even if the host sees only an encrypted link.

## Version transition and durable finality

An update proposal binds the expected object version, exact candidate value or delta, applicable grant, effect identifier and idempotency key. Preparation validates the schema, authority, capacity and expected-version predicate. Commitment atomically establishes the new version together with its authorization debit, deduplication record and receipt under the selected durability contract. A compare-and-replace failure does not silently merge an unrelated concurrent value.

The durability profile defines what survives: controller crash, host reboot, power loss, loss of one replica or another declared failure. An append into a volatile queue is not durable commitment. A flush request is not a completed flush. A device completion is trusted only to the extent the device and its power-loss behavior are qualified. Replication acknowledgement must identify whether it means reception, stable storage or quorum agreement.

**R-16-04 — Named durable commit.** A PO MUST name its durable finality point and its survival assumptions. Object version, deduplication state, grant consumption and commit evidence MUST be recoverably consistent at that point. It MUST NOT report durability from a weaker queue or transport acknowledgement.

The common effect states apply without claiming universal distributed atomicity. If the local durable commit is established and remote replication is unresolved, the local receipt remains `COMMITTED`; the remote durability outcome is a separately scoped obligation. If a crash prevents the owner from establishing whether local finality occurred, that attempt is `UNCERTAIN` until recovery evidence resolves it. Reconciliation appends evidence and never rewrites the original chronology.

## Observation, devices and privacy

A trusted exporter on a storage command interface can report commands, completions, selected metadata and declared payload digests. It does not automatically observe plaintext hidden by encryption, internal flash translation, device caches or garbage collection. A passive SSD or NVMe-class interface tap therefore cannot prove a complete logical read history or that every physical remnant was erased. Active inspection is a separate authorized operation and may change timing, power and confidentiality properties.

**R-16-05 — Honest storage observation.** Storage telemetry MUST identify its observed interface, visibility, sampling and loss behavior. Hidden device state, encrypted contents and unobserved internal activity MUST remain explicit limits. Diagnostic capture MUST have its own recipient, retention and release authority.

An audit trail should retain sufficient information to establish ordering and outcome without unnecessarily copying object contents. Digests, object identifiers and timing can themselves be sensitive. Steles may witness a commitment under an admitted release policy; witnessing does not make the stored content public or give a witness permission to reconstruct it. Error logs are also output objects, so a failed parser must not leak a confidential payload through its diagnostic text.

## Erasure, backup and restoration

Sanitization has both operational and physical scope. [NIST SP 800-88 Revision 2, section 3.2](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-88r2.pdf) explains that cryptographic erase depends on cryptographic and key-management preconditions. ASKA accordingly treats key destruction as a scoped procedure whose assurance depends on all usable copies, wrapping paths and plaintext residues. A deletion receipt from one key slot does not prove destruction of backups or exported keys.

**R-16-06 — Scoped erasure and retention.** Erasure MUST identify the objects, derivatives, key material and retained copies in scope, the chosen sanitization method and its evidence. Expired retention MUST stop future authorized use, while incomplete deletion or inaccessible replicas MUST remain recorded rather than be reported as universally erased.

Backups preserve content and recovery information under a separate grant. Restoration authenticates the backup and its lineage, but must not restore expired grants, spent one-use budgets or old object generations as current authority. The restored owner reconciles with available durable counters and witnesses and creates fresh bindings. If offline operation prevents establishing current revocation state, it follows the admitted stale-state policy or remains unavailable; it does not assume that an old signed snapshot is current.

Recovery can reconstruct data from redundant fragments, independently held shares or authorized exports. It must distinguish recovery of bytes from recovery of rights. A service that can reconstruct a ciphertext object may still lack authority to decrypt or publish it. Likewise, emergency access needs a separate admitted basis and cannot be inferred from the label “recovery.”

## Example and acceptance obligations

A community record owner accepts an append to a local ledger. The request cell validates the input and proposes an exact entry against version V. The commit controller checks the current grant, records the new version and idempotency state, and completes the declared power-loss-safe write. A remote mirror link then fails. The local receipt remains committed with its local durability scope; remote replication is pending or uncertain. After restart, resubmitting the same idempotency key returns the established outcome rather than creating another entry. A restored month-old backup cannot reset the append counter or reactivate the grant.

**R-16-07 — Safe persistent recovery.** Recovery MUST reconstruct object versions and effect outcomes without reviving retired generations, consumed rights or expired policy. Unresolved durability or replica state MUST be exposed explicitly, and repeated requests MUST use the recovered idempotency contract.

Acceptance specifications are:

- **T-16-01:** Attempt direct backing-device mutation and read-authorized backup/export operations without their separate grants. The PO boundary must prevent the unauthorized effects.
- **T-16-02:** Run two successive requests from disjoint confidentiality compartments with canaries in parser scratch state, then reuse the physical cell. The second request must not recover the first request’s scratch state, grants or writable references. Submit sealed proposals containing a changed input generation, a raw worker pointer, an undeclared lower output label and a budget already consumed by a competing request. The commit controller must reject each invalid proposal without publishing a new version; retirement or crash of the worker must not corrupt an already protected candidate or independently committed version.
- **T-16-03:** Trace plaintext and key access through the selected storage arrangement. Any undocumented component able to recover plaintext or usable keys defeats the stated encrypted storage boundary.
- **T-16-04:** Cut power at each update stage. Recovery must expose a consistent prior or new committed version, or a justified uncertain outcome, never a new value with missing consumption/deduplication state.
- **T-16-05:** Compare exported events with cache-resident and internally buffered device activity. Reports must retain the declared visibility limits and account for missing event ranges.
- **T-16-06:** Erase an object while retaining a derivative, wrapped key or offline replica. The evidence must identify the remaining copy; a universal-erasure claim must fail.
- **T-16-07:** Restore an authenticated old backup after grant revocation and a successful one-use effect. The old grant and consumed right must not become usable, and a duplicate request must not create a second durable effect.
