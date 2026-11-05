# ASKA v6 — Protected storage, media integrity and cryptographic services

**Status:** integrated target for key custody and forensic evidence; advanced authenticity and physical techniques are research candidates, not established guarantees. Read together with [14](14_persistence_and_effects.md), [15](15_authority_and_information_flow.md), [21](21_steles_witness_and_notice.md) and [36](36_passive_hardware_observation_and_provenance.md).

## 1. Secure encrypted persistent objects

Hardware-enforced secure encrypted storage (HESE-DAR) is a deployment profile for persistent objects whose confidentiality, integrity, ownership and key release are checked outside ordinary workload kernel authority. Encryption alone does not implement that profile: a kernel that holds decrypted plaintext, a device controller with unrestricted DMA, or an update signer that can rewrite the key-release guard may compromise the boundary. At rest, in transit, in use, during backup, during deletion and during legitimate release are distinct access states.

A protected storage owner binds object ID, generation, confidentiality/integrity categories, key policy reference, permitted methods, append/replace semantics, durable commit identifier, rollback epoch, retention/erasure terms, and authorized recipients. The source must not derive a public release right from decrypt permission. A storage controller's firmware and persistent journal belong in the dependency register. Device acknowledgments are not necessarily durable commits; flush/order contracts and recovery replay are specified in [14](14_persistence_and_effects.md).

## 2. Key roles and independent custody

Key roles include object encryption, local boot/attestation, protected policy installation, session establishment, witness signing, update signing, recovery and realm governance. They MUST use domain separation and distinct authorization scopes. A single convenient root that can decrypt every personal, commercial, civic and witness object violates the native independence claim. A high-consequence profile defines an independent key custody and recovery function with physically bounded access paths through the Sovereign Trust Network where available.

Rotation must preserve a defined recovery and deletion state. `KEY_REVOKED`, `SESSION_EXPIRED`, `OBJECT_UNAVAILABLE`, `CRYPTO_ERASE_PENDING`, and `ERASE_VERIFIED_WITH_SCOPE` are not synonymous. A key may be backed up, cached or disclosed; cryptographic erasure does not make a legitimate prior recipient forget plaintext. A legal or institutional order cannot conjure unavailable keys or change the installed cipher policy without the applicable technical authorities and governance process.

## 3. Encrypted storage versus observation

A security mesh can inspect selected storage-controller events, protected owner receipts and integrity commitments without inheriting read access to plaintext. An independently rooted watcher may verify that a storage policy register changed, or that an object owner rejected an unauthorized read, from a protected event export. It cannot infer every file-level operation from flash-write patterns. A content snapshot or forensic image is a separate, explicitly authorized transfer, with immutable copy provenance, restricted retention, and a protected destination. Persistent plaintext dumps must not be silently enabled as 'security telemetry'.

For a compromised host kernel, test that it cannot command the protected store to decrypt arbitrary objects or write another realm's key slot. For a compromised controller, test DMA confinement, integrity verification, rollback defense and transaction outcome uncertainty. For compromised storage observers, test that they cannot write object extents or obtain broader key access than their separately granted forensic contracts.

## 4. Protected forensic evidence

Forensic records are durable objects with origin, acquisition method, original data sensitivity, time uncertainty, source object generation, chain-of-custody events, hashes over canonical representations, tamper-evident signing and witness references. A hash proves equality to previously committed bytes, not that acquisition was complete, that an image represents physical reality, or that an observer told the truth. Whenever a sensor has gaps, the evidence record carries completeness and loss metadata. Steles may witness a small commitment without holding the confidential evidence itself.

Retention, emergency preservation, destruction, appeal, lawfulness and notice are governed by the recipient's applicable Accord profile. A forensic preservation hold cannot override an independent realm without a valid order/grant and surviving enforcement, nor can an automatic cleaner delete protected incident evidence merely because a classifier labels it benign. All operator access to evidence is separately granted and receipted.

## 5. Media capture, authenticity and privacy

A raster-content provenance profile may bind capture device attestation, authenticated timestamp/clock uncertainty, capture setting, canonical content digest, disclosed sensor context and protected signing state. Spatiotemporal metadata—motion, environmental readings, coarse location, lighting or other physically observed signals—may improve *evidence correlation* under calibrated conditions. It does not prove that a scene was not staged, that sensors were truthful, or that no synthetic manipulation occurred before signing.

Selective privacy treatment, including consent-based biometric blurring, is a separate transformation contract. It must define whose consent or lawful basis applies, what is blurred, revocation timing, residual re-identification risk, dataset access, and whether an original unblurred copy exists. A public opt-in ledger of biometric templates can itself create correlation and revocation risks; no globally readable biometric registry is a default design component. Media transforms preserve confidentiality labels and require independently enforced exact-output release.

## 6. Cryptographic and privacy options

Modern authenticated encryption and approved post-quantum/hybrid key-establishment or signing suites may be selected by implementation profiles with algorithm and transcript binding. A primitive's approval does not establish application authority, side-channel resistance or correct nonce handling. Quantum key distribution is an optional optical/link research integration only if it improves an explicit threat/cost model; it is not a requirement for cryptographic strength and does not replace endpoint authentication or trusted keys.

Zero-knowledge proofs, private set intersection, multiparty computation, homomorphic encryption, federated learning and confidential computing are candidates for purpose-bound data collaboration. A zero-knowledge proof establishes a specified statement under soundness assumptions, not arbitrary truth of a physical observation. Multiparty protocols must identify malicious participant thresholds, data leakage, liveness and recovery costs. These mechanisms never bypass source-disclosure or recipient-effect authority.

## 7. Physical evidence and speculative technologies

Optional physical audit artifacts, such as uniquely manufactured microstructures linked to signed digital commitments, may supply an additional tamper-evidence channel in specialized civic or high-assurance workflows. Their security depends on reproducible measurement, clone resistance, custody and auditability. They are not a replacement for public verifiability, secret-ballot protections or independently observed counts.

Claims that quantum entanglement can form a general passive, nondestructive, remote memory-integrity oracle, or that physical spatiotemporal digests prove truth, are outside the established architecture. Such ideas may be researched as explicitly unvalidated hypotheses under [45](45_research_frontier_and_independent_validation.md), but no release decision, audit statement or system safety requirement may rely on them without evidence.

## 8. Acceptance and cost

Benchmark protected reads/writes, key rotation, recovery, snapshot acquisition, retention/erase operations, attestation startup, secure-storage energy, journal amplification and forensic export overhead. Negative tests include a malicious kernel, a malicious NVMe device, replayed journal, compromised update signer, forged capture metadata, denied forensic request and sensor report lacking a trustworthy time basis. Positive tests must complete authorized real work and produce accurate durability and confidentiality-labeled receipts.
