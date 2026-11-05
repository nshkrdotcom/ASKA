# ASKA v6 — Boot, key custody, recovery and continuity

**Status:** proposed root and recovery contract. The choice of devices, cryptographic suites, protected state and physical service mechanisms remains a realization-specific evidence gate.

## 1. Roots are finite and scoped

ASKA’s protections ultimately depend on finite roots: immutable or protected boot code, key stores, ownership and finality logic, physical wiring, manufacturing assumptions and authorized custodians. A root is trusted for a named function and scope. It is not a universal credential that can authorize every operation in every realm. The installation and recovery roots for a boundary, observer, watcher, Keystone and Steles have different consequences.

The authoritative reference binding is in [chapter 04](04_reference_machine_and_reachability.md). A local compute reset controller does not gain access to a guard’s keys. A watcher has a lifecycle outside its monitored observer’s authority. A BMC may perform specified management functions, but it cannot silently gain raw access to guard policy, protected bank contents or observer keys. Production debug and physical maintenance remain explicit interfaces, including their disabled states.

**R-30-01 — Complete root inventory.** A realization MUST identify every boot, installation, attestation, policy, recovery and physical-service root, its function, controlled components, custodians and defeating dependencies. It MUST enumerate fuses, mutable key stores, debug locks, reset ownership and recovery connectors. A root’s authority MUST remain confined to its admitted scope; shared administration MUST be disclosed in the failure graph.

An immutable root can still contain a defect. A protected mutable root can still be replaced by an authorized malicious update. A threshold root can still have correlated custodians. These are different accepted risks requiring different evidence. “Hardware rooted” describes the location of a trust decision, not a proof that its implementation is correct or its human governance legitimate.

## 2. Boot sequence and initial admission

The boot process begins with a known verification root and protected continuity state. It authenticates the next image, checks its target and security floor, establishes fresh component lifetimes, and initializes only the resources admitted for that component. Guards establish ownership tables before untrusted workloads can issue memory, DMA, mailbox or output operations. Observation can start early enough to support the specified boot evidence, but its absence cannot be concealed as successful collection.

**R-30-02 — Authenticated and constrained boot.** Boot admission MUST validate the image and configuration against the local root, target, version floor and policy before enabling their consequences. It MUST establish fresh boot/component epochs and retain required monotonic state. Measurement and signature verification MUST NOT by themselves grant application, device or cross-realm rights. Failure MUST enter a declared recovery or restricted state rather than an unrestricted fallback.

Measured boot records what was loaded. Verified boot enforces an acceptance decision. A particular implementation may provide both, but their outputs must not be confused. A correctly measured vulnerable image remains vulnerable; an authenticated image may still be incompatible with persistent state. An untrusted operating system cannot bootstrap authority by reporting that it successfully booted itself.

A physically replaced module requires enrollment under the intended owner and profile. It must not inherit the removed component’s live grants merely because it occupies the same connector. Its device generation, key bindings and observation relationships are established anew, with old references retired under the lifecycle rules.

## 3. Key custody and cryptographic separation

**R-30-03 — Purpose-separated key use.** Keys for boot verification, update signing, attestation, policy admission, transport sessions, stored objects, witness commitments and recovery MUST have distinct declared uses and protected access paths. Key possession MUST NOT imply authorization beyond that use. Recovery or escrow policies MUST identify eligible custodians, objects and conditions, and MUST NOT promise reconstruction of absent keys or erasure of already released plaintext.

| Key or protected secret | Authorized use | Critical separation |
|---|---|---|
| Boot/update verification anchor | Validate a component image and permitted root transition | Cannot grant access to arbitrary data or another component’s installer |
| Release signing key | Endorse an exact artifact and scope | Outside AESDS producer and ordinary build worker authority |
| Attestation key | Authenticate measured claims for a component | Does not act as a grant issuer or universal device credential |
| Policy-admission key | Authorize specified local policy transitions | Bounded by resource owner and receiver conditions |
| Session key | Protect an admitted communication session | Session identity, direction, epoch and replay state remain bound |
| Object encryption key | Protect a named object or key hierarchy | Release and recovery need separate authority |
| Witness key | Authenticate commitments and corrections | Does not decrypt evidence or rewrite historical receipts |
| Recovery key or threshold | Admit a defined restoration operation | Cannot silently reset security floors, receipt history or realm ownership |

A key hierarchy may derive subordinate keys with domain separation, but the derivation path and compromise scope must be explicit. Cryptographic agility includes algorithm identifiers, migration, key retirement and compatibility tests. Quantum communication, unconventional key storage, PUFs and multiparty techniques may be evaluated as candidates; none is assumed necessary for basic boot or recovery conformance.

Custody also includes people and procedures. A lost custodian, a revoked institution, a failed key device and an unavailable quorum are operational states. The system can preserve confidentiality while becoming unavailable. It must report that result rather than invent a master override. Digital succession or escrow workflows refer to [chapter 51](51_family_care_professional_and_personal_authority.md) and require concrete keys and admitted conditions.

## 4. Attestation and STN admission

**R-30-04 — Qualified attestation admission.** Attestation MUST identify the attester, verifier, relying party, measurement scope, reference values, appraisal policy, freshness basis and channel/session binding. An accepting realm MUST make its own admission decision. A valid attestation MUST NOT be interpreted as complete runtime observation, safe application behavior, legal legitimacy or permission to cross a resource boundary.

[RFC 9334, IETF, January 2023, §§7 and 10](https://www.rfc-editor.org/rfc/rfc9334.html) provides the relevant role and freshness distinctions. [DMTF SPDM 1.4.1, 26 June 2026](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf) is a published device protocol reference, with negotiated measurement capabilities. Those sources support appraisal mechanisms, not automatic acceptance of any measured device.

An STN can establish governance profiles and eligible roots, while an ATN supplies authenticated connectivity and MCN channels carry admitted traffic. None automatically gives a remote realm installation rights. A peer may accept a limited session with reduced evidence, refuse a high-consequence operation, or require fresh claims. It must not claim stronger assurance than the available appraisal supports.

Attestation itself can disclose software versions, device identities and user context. Source release and receiver policy therefore apply before sensitive evidence is transmitted. A failed appraisal does not authorize unrestricted forensic access to the attester.

## 5. Protected continuity state

**R-30-05 — Monotonic security state.** The realization MUST protect the continuity state needed for version floors, revocations, boot epochs, owner generations, event sequences, replay consumption and effect finality against rollback and reuse. It MUST specify widths, exhaustion, power-failure persistence and loss behavior. If a required value cannot be established, dependent operations MUST be restricted or qualified; resetting the clock or restoring a backup MUST NOT silently revive old authority.

Not all state needs the same persistence mechanism, but each claim must name one. A secure element counter, append-only owner journal and remote checkpoint have different availability and compromise dependencies. The implementation fixes which transitions are durable before a receipt is emitted, how torn writes are detected, and what happens when the state store wears out or becomes unreadable.

Time is also qualified. A nonce can establish a recent exchange without proving that the measured value was freshly acquired. An unreliable wall clock cannot safely support every expiry decision. A profile can rely on bounded offline validity and protected epochs, but it must state how much uncertainty is accepted and what stops when that bound is exceeded.

[TUF 1.0.36, §5.3](https://theupdateframework.github.io/specification/v1.0.36/) provides a concrete root-continuity procedure. ASKA’s broader continuity state also includes live object, grant and effect history; replacing an update root does not authorize rewinding those histories.

## 6. Recovery that preserves boundaries

**R-30-06 — Scoped recoverable restoration.** Recovery MUST be available through a declared mechanism outside the failed candidate’s control and MUST be tested under interrupted boot, installation and state writes. It MUST restore only admitted components and compatible state, retire compromised lifetimes, preserve revocation/security floors and receipt history, and close maintenance access before ordinary service resumes. Missing keys, media or trustworthy finality evidence MUST remain explicit limitations.

| Failure | Possible authorized recovery | Outcome that must not be fabricated |
|---|---|---|
| Broken application image | Select compatible retained code/object version | Reversal of external effects already committed |
| Broken observer | Reinstall through independent root; reconcile buffered evidence | Complete visibility during the outage |
| Compromised signing key | Scoped revocation and admitted root transition | Retroactive truth of reports signed during compromise |
| Lost object key | Use an existing authorized escrow or declare inaccessible | Plaintext reconstructed from legal authority alone |
| Corrupted finality journal | Compare independent records and preserve uncertainty | Automatic no-effect conclusion followed by blind retry |
| Destroyed hardware/media | Replace and re-enroll from available protected state | Recovery of information never backed up or no longer present |

A golden image must still satisfy current policy and compatible state requirements. If every permitted image is below a current security floor, the owner needs an explicitly reviewed recovery decision; the installer cannot silently disable the floor. Replacing hardware may restore service while losing evidence. That distinction appears in the recovery receipt and assurance dossier.

[NIST SP 800-193, May 2018, §§3–4](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-193.pdf) supplies a protect/detect/recover framework. It does not establish ASKA’s particular power-failure behavior or the recoverability of destroyed media. Those remain concrete test obligations.

## 7. Continuity under partition and common failure

**R-30-07 — Declared continuity envelope.** Each deployment MUST state its minimum local services, allowed offline duration, safety dependencies, evidence buffering, recovery prerequisites and common power/site/carrier failures. Loss of remote management, MSM, SAI or oversight MUST NOT automatically remove local mandatory enforcement. Conversely, unavailable required roots or evidence MUST not be hidden by continuing with an unrestricted fallback.

RP-A shares facilities that can stop compute and monitoring together. RP-B can separate more power and appliance dependencies, while still sharing civil infrastructure. The continuity claim follows those actual dependencies. An industrial controller may need local safety operation during an upstream outage; a nonessential update may wait. Medical or process-control behavior requires the device-specific safety contract of [chapter 26](26_protective_response_and_containment.md), not a generic shutdown rule.

## 8. Conformance campaign

| Test | Stimulus | Required oracle |
|---|---|---|
| T-30-01 | Enumerate fuses, roots, shared signers, BMC, debug and reset routes | Actual paths and custodians match the declared scoped inventory |
| T-30-02 | Boot wrong-target, downgraded, mismatched-state or authenticated malicious images | Admission and confinement match the package class; no unrestricted fallback |
| T-30-03 | Cross-use keys and request recovery without existing key material | Key-use separation holds; unavailable plaintext remains unavailable |
| T-30-04 | Replay attestation, omit measurements or present a valid result to another realm/session | Freshness, scope and independent admission reject unsupported acceptance |
| T-30-05 | Roll back storage/time, exhaust counters and interrupt durable state writes | Old grants and receipts do not revive; dependent uncertainty is explicit |
| T-30-06 | Disable normal installer and interrupt recovery at each stage | Independent restoration works within scope or reports the exact unrecoverable condition |
| T-30-07 | Lose upstream, oversight, power or a declared common dependency | Minimum services and lost claims match the profile; safety behavior remains within its validated contract |

The final recovery state is a concrete combination of restored service, retained authority, available evidence and unresolved loss. A truthful account of that combination is stronger than an unqualified claim that the system has returned to a secure state.
