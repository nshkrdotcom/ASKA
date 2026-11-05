# ASKA v6 — Media provenance and physical evidence

**Status:** proposed architectural requirements. Acceptance oracles specify evidence to obtain; no ASKA implementation or validation result is asserted.

Media evidence combines several claims that must be assessed separately: who controlled a capture device, what bytes it produced, which transformations followed, how the artifact was held, and whether the depicted event corresponds to the physical world. Cryptographic provenance can authenticate signed statements and bind them to an artifact. It cannot, by itself, establish that a camera faced the claimed scene, that a sensor was calibrated, that a person consented to recording, or that an institution's interpretation is correct.

ASKA supports ordinary signed media, derived-artifact provenance, sensor-rich capture and experimental physical evidence media. These are distinct profiles with different costs and assumptions. None is a universal prerequisite for communication. A deployment may accept conventional photographs or documents while labeling their provenance limits. A research mechanism must not be marketed as irrefutable evidence merely because its internal algorithm is proprietary or difficult to inspect.

## 48.1 Capture and transformation records

A capture record identifies the artifact digest, media type, capture device and key epoch, sensor configuration, firmware or processing version, time interval and time-source quality, calibration references, environmental claims, processing steps, relevant consent or other authority references, and custody events. Each field distinguishes directly measured values, externally asserted facts and derived estimates. Optional location and identity metadata require particular care because they can expose bystanders or sensitive relationships.

**R-48-01 — Typed provenance claims.** A media record MUST distinguish artifact integrity, signer identity, capture assertions, calibration, transformations, custody and claims about the depicted world. Verification MUST report which claims were checked and MUST NOT promote a valid signature into a general truth judgment.

A transformation record identifies the parent artifact, transformation identity and version, parameters, responsible owner, source authorization, resulting digest and residual disclosures. Cropping, color correction, format conversion, compression, blurring, synthetic augmentation and summarization can preserve different aspects of an original. The provenance graph must say what changed rather than use a single “authentic” flag.

The [C2PA Technical Specification 2.3](https://spec.c2pa.org/specifications/specifications/2.3/specs/C2PA_Specification.html) provides mechanisms for signed provenance assertions and asset bindings. Its scope and validation model do not make a value judgment about every asserted fact. An ASKA adapter can preserve such records while applying its own source-release, receiver-acceptance and disclosure policies.

## 48.2 Capture authority and privacy-preserving derivatives

Capture is itself an observation operation. Ownership of a camera does not settle whether it may record every person, room, conversation or screen visible to it. A profile must define the applicable basis, scope, retention and export rules. Voluntary opt-in can be required for a particular service or feature, while another context may use a separately applicable basis. The machine must identify the actual basis instead of claiming consent that was never obtained.

**R-48-02 — Authorized capture and transformation.** Recording, privacy transformation and publication MUST have separately applicable authority where their scopes differ. A privacy feature presented as voluntary MUST require the relevant opt-in, and the resulting artifact MUST retain provenance linking the authorized transformation to the protected source without unnecessarily exposing that source.

Privacy blurring should be treated as a controlled derivation, not proof of anonymity. Face obscuration can leave voice, gait, clothing, tattoos, location, timing, social context and other linkage signals. A transformation may preserve a journalist's evidentiary purpose while reducing one identifying channel, but its residual leakage must be stated and tested against the intended audience. A reversible privacy transform must identify who can recover the concealed material and under what key custody; an irreversible transform must state which information it actually destroys. The original remains protected under its own policy; a link to it must not become a public retrieval capability.

A reviewer might receive an encrypted original under a specific matter while the public receives only a redacted derivative and a proof that a qualified transformer produced it. The two recipients do not share authority. The public artifact's provenance should not expose the subject's hidden identity or the original's private storage locator. If the transformation is later challenged, review follows an admitted process rather than automatic public unmasking.

## 48.3 Spatiotemporal sensor evidence as research

A sensor-rich capture candidate can bind a media artifact to synchronized measurements of light, motion, sound, device state and selected environmental signals. Proposed extensions include temperature, pressure, electromagnetic conditions or other instruments relevant to a scientific deployment. Each additional sensor must justify its resolution, calibration, noise, synchronization, physical placement, power and privacy costs. A list of exotic measurements is not evidence that a practical camera can obtain them accurately or that they identify a unique event.

The research hypothesis is that independently measured, difficult-to-reproduce correlations may help detect some forms of replay or substituted capture. The hypothesis must be separated from an unestablished claim of a “provably non-isomorphic” digest. A deterministic digest cannot contain more distinguishing evidence than its inputs support; a uniqueness claim requires a defined event space, adversary, measurement process, error model and collision criterion. Undisclosed algorithm details do not provide a reviewable proof.

**R-48-03 — Falsifiable sensor-binding claims.** Sensor-based authenticity mechanisms MUST specify their measured variables, entropy and dependence assumptions, calibration and synchronization bounds, adversary capabilities, collision or matching criteria, and false-accept and false-reject evaluation method. They MUST NOT claim an irrefutable physical-world link without independently reviewable evidence for that exact claim.

Tests should include playback of an authentic scene on a display, substitution of previously captured sensor streams, correlated sensor spoofing, clock manipulation, malicious firmware, environmental reconstruction, compromised enrollment and mixtures of genuine and fabricated measurements. A quick challenge check can be useful if it binds an unpredictable challenge to a timely physical response under declared latency and relay assumptions. It is ineffective if the device can sign an arbitrary response or an attacker can relay a genuine sensor interaction within the accepted window.

The threat model should include an honest capture of a staged event. Provenance may correctly establish what the device recorded while the event itself is deliberately misleading. Scientific or legal interpretation therefore still needs contextual evidence, qualified review and uncertainty assessment. A trust score may summarize evidence quality for triage, but cannot become the truth predicate or automatically create authority.

## 48.4 Physical microstructures and durable artifacts

The Multi-Dimensional Audit Trail System (MDATS) is a candidate combining digital and physical evidence. Experimental physical evidence media can encode or commit to a receipt in a measured microstructure or other persistent material artifact. An implementation must state whether the artifact stores recoverable data, a signed commitment, an unclonability candidate, a tamper-evident structure or some combination. These are different claims. Ordinary durable printing may already meet a requirement to preserve a readable record, while a microstructure research profile addresses a narrower authenticity or custody question.

The lifecycle includes fabrication, enrollment measurement, binding to a digital receipt, issuance, transport, custody, verification, aging, damage, revocation and retirement. Enrollment is a trust boundary: if an adversary enrolls a clone or the wrong receipt, later measurements may faithfully authenticate the wrong association. A verifier must know its measurement resolution, acceptable variation and calibration status. Temperature, humidity, wear, contamination and instrument differences can change matching behavior.

**R-48-04 — Physical artifact qualification.** A physical evidence profile MUST publish its fabrication and enrollment assumptions, measurement method, tolerance, aging and damage behavior, custody requirements, clone and substitution adversaries, and binding to the digital record. A prototype MUST remain a research candidate until those claims have reproducible evidence.

An artifact's physical resistance does not guarantee secrecy. If its pattern reveals a person's vote, medical event or identity, making the artifact difficult to copy can worsen rather than solve the privacy problem. Election artifacts require the ballot-secrecy constraints in [Civic services and elections](50_civic_services_elections_and_public_accountability.md). A proof of eligibility and a vote choice must not be joined into a voter-linkable permanent object under a secrecy-preserving profile.

## 48.5 Verification, storage and fallback

Verification returns a structured result: matched or unmatched artifact binding, validated or unvalidated signatures, capture and calibration evidence, transformation chain, custody gaps, known compromises and explicit uncertainty. A mismatch need not mean fraud; it can result from legitimate transformation, damaged media or unavailable evidence. A valid chain need not mean the subject consented or the content is accurate. The receiving institution determines what evidentiary weight its qualified procedure assigns.

**R-48-05 — Qualified verification results.** Verifiers MUST preserve negative, incomplete and uncertain outcomes and identify the evidence supporting each conclusion. They MUST NOT replace missing calibration, custody or capture evidence with an unqualified authenticity score.

Encrypted storage and the persistent object service can protect artifact bytes and access histories under their respective assumptions. Binding a media record to HESE-DAR custody or DTMS evidence does not strengthen the underlying physical claim beyond the evidence actually provided. A trust service can report a device's status, but cannot prove that a particular scene was unstaged. A storage owner can attest that bytes were preserved, but cannot prove the camera originally captured them honestly.

Fallback to conventional cryptographic provenance must be explicit. If a specialized sensor or physical verifier is unavailable, a contract can permit a weaker evidence class, or the receiver can reject the artifact. It must not report a conventional signature as successful completion of a physical challenge that never occurred.

**R-48-06 — Explicit evidence downgrade.** Storage, transport and verification adapters MUST retain the provenance class and unresolved limitations. Fallback from physical or sensor-rich evidence to conventional signatures MUST require an admitted compatible policy or a newly accepted weaker contract.

## 48.6 Cryptographic privacy and operational example

A zero-knowledge proof may demonstrate that an admitted verification computation accepted a committed record. It does not prove the honesty of the original sensor or eliminate leakage through public inputs. Multiparty computation may distribute a verification task under a defined collusion model. Differential privacy may protect aggregate analytics about a collection; it is not a replacement for protecting an individual original. Trusted execution can restrict some software attackers while retaining hardware and side-channel assumptions. Each mechanism must be evaluated for its actual role.

**R-48-07 — Evidence privacy composition.** Privacy mechanisms used with media MUST state what information they hide, from whom, under which composition and trust assumptions, and what remains public. Proof validity MUST NOT be treated as authority to disclose the underlying artifact or as proof that its physical premises were true.

Consider a field scientist documenting an instrument reading. The capture device signs an image and calibrated sensor record with a time interval. A reviewer checks device status, calibration and custody. A privacy transformer removes bystanders' identifying regions under an admitted rule and produces a derivative with a linked transformation record. The public receives the derivative and selected provenance; qualified reviewers retain a path to inspect the original. If a proposed microstructure is issued, its enrollment binds the specific receipt, and later verification reports its measured match and tolerance. No stage claims that the signature alone proves the scientific conclusion.

**R-48-08 — Research evidence discipline.** Every claimed physical authenticity improvement MUST identify a baseline, test population, adversarial trials, error metrics, environmental conditions and independent replication status. Simulation, a patent-style description or an unpublished proprietary assertion MUST NOT be reported as a validated implementation result.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-48-01 | Verify a signed staged or synthetic scene; the result confirms only supported provenance claims and does not certify world truth. |
| T-48-02 | Produce a blurred derivative; source retrieval remains restricted and tests evaluate remaining voice, gait, context and linkage disclosures. |
| T-48-03 | Replay or splice authenticated sensor streams and manipulate time; acceptance follows the declared challenge and collision model, with measured error rates. |
| T-48-04 | Test clones, enrollment substitution, aging and damaged artifacts across calibrated instruments; results support or defeat the exact physical claim. |
| T-48-05 | Remove calibration or custody evidence while keeping a valid signature; verification remains explicitly incomplete. |
| T-48-06 | Disable the specialized verifier; conventional fallback cannot inherit the unavailable physical-evidence assurance label. |
| T-48-07 | Present a valid proof of a verification computation; the prover still cannot export the protected original without release authority. |
| T-48-08 | Compare a claimed improvement against its declared baseline and replication record; absent measurements remain labeled unvalidated. |
