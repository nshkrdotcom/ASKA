# ASKA v6 — Monitoring privacy and observation authority

**Status:** proposed observation and disclosure rules. Legal applicability, privacy mechanisms and technical access must be established for the selected deployment.

## 1. Observation is access to information

Security telemetry can reveal private information without containing a document’s plaintext. Object names, memory addresses, timing, contact patterns, device identities, program selection and the fact that a particular alarm fired may disclose a person’s activity. A protected observer therefore needs an observation contract. Its physical independence does not grant a right to collect everything it can measure.

ASKA distinguishes baseline telemetry admitted as part of a platform or service contract from exceptional forensic acquisition. Baseline collection can operate continuously without a fresh prompt for every event, provided its scope, purpose, recipients and retention were validly established. Exceptional access to content, snapshots or new recipients requires the corresponding authority. Neither a compelling security explanation nor a high threat score supplies missing rights.

**R-29-01 — Admitted observation scope.** Each telemetry source and acquisition owner MUST enforce an observation grant or baseline observation contract identifying event classes, object scopes, generations, fields, purposes, recipients, retention, collection budgets and applicable notice conditions. Collection outside that scope MUST be denied or minimized before release. A mesh, watcher or SAI role MUST NOT infer unlimited observation authority from its security function.

The enforcing point must be named. A policy document that asks an unrestricted monitor to behave responsibly is a weaker profile than a TE encoder that cannot export prohibited fields. A passive analog sensor may reveal information that is difficult to constrain by object. Its deployment therefore needs a physical privacy analysis and a candid statement of what is technically enforceable.

## 2. Purpose boundaries and local analysis

Sanctum, Polis, Agora and Wilder describe distinct purposes and authority contexts. Steles receives admitted witness material; Keystone presents trusted intent. The same incident can cross several of these boundaries, but it does not merge them. An enterprise security operator might receive a minimal Agora service-health report while lacking access to a person’s Sanctum documents or UAI memory.

**R-29-02 — Purpose-preserving collection.** Observation and derived analysis MUST preserve the confidentiality and integrity labels defined in [chapter 07](07_information_flow_and_release.md). Collection policy MUST distinguish Sanctum, Polis, Agora and Wilder contexts and avoid silently combining their identities or contents. UAI preferences and private context MUST not become SAI training or monitoring inputs without separately admitted use.

Local analysis is useful where the source can retain sensitive detail and release a narrower finding. For example, a local detector may report that a named service exceeded its admitted egress budget without exporting filenames, recipient identities or document contents. That report still needs a label because it can disclose usage patterns. The receiver must know the limited evidential meaning: a minimized report may support a budget intervention without supporting a detailed attribution of intent.

A shared device creates further complications. Household members, patients, employees and visiting users can have different relationships to the same hardware. The observation contract identifies which authority can approve which fields and what happens when interests conflict. The technical system enforces the admitted result; it does not determine legal legitimacy simply by selecting the most privileged local account.

## 3. Release to a SOC, another realm or a witness

**R-29-03 — Separate disclosure admission.** Sending telemetry, incident reports, evidence objects or derived models to another security service MUST satisfy independent source-release authority, receiver acceptance, current grants and label restrictions. Read or analysis authority MUST NOT imply export authority. Transport encryption, STN affiliation, authenticated identity and a receiver’s security title MUST NOT substitute for those conditions.

An external security operations center is a recipient, even if it manages the device. Its receiving contract defines permitted uses, storage region where relevant, retention, onward disclosure, response requests and audit obligations. A local SOC in another IES is also a distinct recipient where it crosses a purpose or object boundary. Physical proximity does not collapse the release rule.

A Steles witness normally needs a commitment, effect identifier and bounded receipt metadata rather than raw evidence. A public digest is not automatically private: a small or predictable payload may be guessed and hashed. Correlation identifiers can join events across realms. The release design may need randomized commitments, scoped identities or separate access-controlled evidence, with the exact scheme and leakage analysis declared rather than implied.

[RFC 9334, IETF, January 2023, §11](https://www.rfc-editor.org/rfc/rfc9334.html) recognizes that attestation evidence and its effects can reveal device or user information. In ASKA, that concern applies to the broader telemetry pipeline as well as attestation. A verifier’s need to appraise state does not grant unrestricted disclosure.

## 4. Data minimization, retention and forensic objects

**R-29-04 — Bounded retention and minimization.** Collection and storage owners MUST minimize telemetry fields and volume to the admitted purpose, enforce retention and access limits, and record transformations and deletion outcomes. Raw payload retention MUST be separately justified from aggregate security metrics. Deletion claims MUST distinguish local cryptographic erasure, storage reclamation, retained commitments, backups and copies already released to recipients.

A retention timer cannot reliably delete a copy held by an unconstrained recipient. The source can stop future access, revoke a session or destroy a locally held decryption key, but those steps do not prove that every prior recipient forgot the information. The deployment must distinguish enforceable technical constraints from contractual obligations and unsupported promises.

Forensic acquisition creates an evidence object with a new owner, label and custody history. Its record identifies the acquisition method, source generation, consistency interval, transformations, failures, recipients and retention. A memory snapshot may contain unrelated secrets, so the grant can restrict extents or mandate a protected extraction process. “Preserve evidence” is not permission to clone every bank indefinitely.

Minimization can reduce investigative value. The design must state that tradeoff: an aggregate count may reveal an anomaly but prevent later reconstruction of its precise cause. A profile can choose more detailed local retention for a bounded period, then release only what is separately authorized. It cannot retroactively reconstruct discarded plaintext by producing a warrant or a stronger model.

## 5. Notice, explanation and challenge

**R-29-05 — Visible and contestable observation.** The system MUST make the applicable observation scope, recipients, retention and material policy changes available through an appropriate trusted notice mechanism, subject to explicitly admitted legal or safety exceptions. A challenge MUST preserve the disputed record and allow an authorized correction or qualification without rewriting historical evidence. A monitoring operator MUST NOT suppress notice solely because disclosure of its actions is inconvenient.

Notice should be usable rather than a stream of repeated prompts. Keystone can present the baseline collection contract, significant recipient changes and consequential forensic requests. A person can inspect a report’s purpose and discover whether a response was actually committed or merely proposed. Where the profile permits delayed notice, the delay has a source, scope and expiry or review condition; it is not an unbounded secret-monitoring switch.

A correction may say that an event was wrongly attributed, a model inference was unsupported or a sensor was miscalibrated. It links to the original event and explains the evidential consequence. A false allegation should not remain an unquestioned current fact merely because its original signature was valid. Conversely, correction does not erase the historical fact that the report was made and may have caused a response.

## 6. Exceptional access and competing obligations

**R-29-06 — Qualified exceptional access.** A legal, safety or emergency request for additional observation MUST be evaluated under the applicable institutional profile and admitted by the technical owners controlling the requested resources. The request MUST specify target, purpose, scope, time, recipients and review/notice conditions. Legal authority MUST NOT be treated as possession of a missing key or an ability to recover data that no longer exists.

The system can preserve sealed evidence while a dispute is reviewed, subject to an authorized retention action. It can disclose a permitted subset to an eligible recipient. It can report that an object is technically inaccessible or that data was never collected. Those outcomes are distinct. SAI can organize relevant evidence but cannot decide the law, invent an emergency qualification or override a protected owner.

[Chapter 49](49_legal_process_rights_and_emergencies.md) owns legal-process semantics, while [chapters 31–35](31_accord_system_and_machine_authorization.md) define authority and conflict handling. This chapter binds their outcomes to concrete collection and release points. A broad statement that “security takes priority” is insufficient to resolve a particular clash between confidentiality, evidence preservation and physical safety.

## 7. Derived data and collaborative analysis

**R-29-07 — Derived-data leakage accounting.** Features, embeddings, gradients, model updates, summaries and pseudonymous identifiers derived from protected observations MUST retain applicable restrictions unless an admitted transformation supports a justified release. A privacy claim MUST identify its threat model, composition assumptions, measured or formal guarantee and residual leakage. Federated learning, aggregation, hashing or removal of direct names MUST NOT be treated as automatic anonymization.

Repeated low-detail queries can reveal more than one isolated query. An attacker may compare whether a target appears in an aggregate, correlate timestamps or use model outputs to infer participation. Release budgets therefore apply to sequences of requests and recipients, not only to each record individually. The evidence owner records the transformation version and the relevant composition state.

A collaborative threat campaign can still be useful: realms can share attack signatures, sanitized protocol traces, model evaluation results or committed incident summaries under explicit contracts. The receiver knows what was removed and cannot claim that the shared data proves more than its source contract permits. Participation remains bounded by each realm’s independent admission rather than by a universal security-mesh membership right.

## 8. Conformance campaign

| Test | Stimulus | Required oracle |
|---|---|---|
| T-29-01 | Observer requests extra fields, banks, event classes or retention beyond its contract | Collection/export owner denies or minimizes them at the declared boundary |
| T-29-02 | Correlate Sanctum and Agora identities or import private UAI context into SAI | Purpose and label restrictions prevent unauthorized combination |
| T-29-03 | Send permitted local observations to an unapproved SOC, realm or Steles payload store | Independent release/receive checks reject the crossing without leaking the rejected content |
| T-29-04 | Expire retention across active storage, backups and released copies | Local deletion result is truthful; unconstrained recipient copies are not falsely declared erased |
| T-29-05 | Change monitoring scope, suppress notice and challenge a false attribution | Required notice appears; correction qualifies the record while preserving history |
| T-29-06 | Present valid institutional evidence for an absent key or uncollected plaintext | Technical incapability is reported; no authority or data is fabricated |
| T-29-07 | Repeat aggregate queries and attempt inference through embeddings or model updates | Declared composition/release limits hold or the privacy claim is narrowed |

Privacy assurance depends on these enforcing points and their limits. Independent monitoring is valuable only when its own access and disclosure are governed as carefully as the workloads it observes.
