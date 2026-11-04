# ASKA v5 — Terminology, namespace, and registry

## 1. ASKA language

| Term | Exact meaning |
|---|---|
| **ASKA Accord Suite** | Proposal for authority-centered computing, negotiation, enforcement and accounting |
| **PACT** | Protocol for Authority, Consent, and Transactions: negotiation and admission messages |
| **CLAIM** | Scoped evidentiary assertion with issuer, provenance, validity and revocation semantics |
| **CONTRACT** | Immutable admitted or denied decision object for a particular operation and obligations |
| **GRANT** | Narrow machine-installable capability derived from an admitted contract |
| **RECEIPT** | Signed lifecycle and effect outcome statement, with explicit uncertainty where needed |
| **IDENT** | Contextual identity, credentials, status, selective disclosure and attestation |
| **RELATE** | Typed roles, relationships, guardianship, fiduciary and delegation semantics |
| **LEGAL** | Recognized legal requests, applicability, review, technical availability and notice |
| **CIVIC** | Public-service and election/eligibility transaction profile semantics |
| **PROFILE** | Signed governance, interoperability, cryptographic and assurance manifest |
| **WITNESS** | Steles record/commitment and private or public qualified verification procedures |
| **Keystone** | Protected local user-interaction root, policy/key custody and recovery-entry restrictions |
| **Sanctum** | Personal, familial and intimate sphere; a physically protected active plane |
| **Polis** | Civic, state and public institutional sphere; a physically protected active plane |
| **Agora** | Commercial and enterprise sphere; a physically protected active plane |
| **Wilder** | Open/legacy/untrusted encounter sphere with dedicated quarantine ingress |
| **Steles** | Independent fifth witness/audit plane, not an ordinary application transport plane |
| **4 + 1 endpoint** | Four independent active societal communication roles plus out-of-band witness |
| **Realm** | Scope of object ownership, policy, institutional or administrative control |
| **IES** | Isolated Execution Stack: independent resource/authority domain with protected hardware boundaries |
| **Cell** | Isolated bounded execution lifetime within an IES |
| **Persistent owner** | Controller for durable object versions, authorized operations and commit history |
| **Effect handler** | Final trusted gate for external or irreversible actions |
| **Release** | Source-authorized operation that changes destination visibility, scope or representation |
| **DTG** | Dynamic Trust Gateway, a narrow mediated crossing between purpose fabrics |
| **ATN** | Authenticated Trust Network, an admitted purpose-scoped collaboration fabric, not a global social plane |
| **STN** | Sovereign Trust Network, an independently rooted high-consequence key/policy/recovery fabric |
| **Control plane** | Rich claims, contract negotiation, signatures, profile and grant installation messages |
| **Data plane** | Compact authenticated records or channels bound to installed admitted contract semantics |
| **Object generation** | Protected version that prevents stale references from acquiring new occupant authority |
| **Revocation epoch** | Monotonic protected status scope that makes older grants invalid when updated |
| **Confinement category** | Information-flow restriction tracked separately from resource access |
| **Independent receipt** | Outcome evidence from the component that performed or observed the claimed effect |
| **Assurance profile** | Declared threat/resources/physical/observation scope supported by evidence |

## 2. Standard enum spellings

For schema examples in this docset, spell plane identifiers lowercase exactly: `sanctum`, `polis`, `agora`, `wilder`, `steles`. Use uppercase outcome identifiers: `ALLOW`, `ALLOW_WITH_OBLIGATIONS`, `DENY`, `SUSPEND`, `ESCALATE`, `UNAVAILABLE`; use corresponding machine-readable lowercase wire spellings in a versioned schema registry. `PENDING`, `ADMITTED`, `INSTALLED`, `REVOKED`, `RECEIPTED`, and `UNCERTAIN` are state terms. Real binary encodings and code-point assignments remain dependent on a reviewed canonical wire revision.

## 3. Reserved clarifications

- **Signature is not legal validity.** A signed order proves attributed issuance, not unlimited technical permission.
- **Encryption is not isolation.** A tunnel does not prove physical disjointness or recipient confinement.
- **Witness is not surveillance.** A signed log does not justify unrestricted plaintext collection.
- **Identity is not authority.** A recognized credential still needs action-specific contract admission.
- **Consent is not compulsion.** A user's acknowledgment under a mandatory duty is a distinct legal basis.
- **Application approval is not effect commit.** The owner must independently prove what actually happened.
- **Native physical profile is not a VM.** Shared physical resources must be analyzed and disclosed rather than implied disjoint.
- **AI is not the sovereignty root.** It proposes and explains; enforcers and authorized actors decide.

## 4. Registry policy

New method, evidence, event, proof, encoding and module identifiers require explicit namespace stewardship, known-critical-field behavior, backwards compatibility review, security analysis and adversarial test coverage. Private extensions may exist only when they cannot collide with future public identifiers or silently change fundamental authority semantics.
