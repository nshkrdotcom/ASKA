# ASKA v6 — Information flow and release

## Observation boundary

Information-flow protection specifies which differences in protected state may affect which observers. The observer set can include object values, published outputs, result categories, packet sizes, traffic existence, timing, termination, resource use, screen pixels, power and electromagnetic signals. A proof about explicit values does not cover every one of these channels.

Each conformance profile declares an observation function `Obs_A(trace)` for attacker A, allowed releases and excluded physical channels. For two initial states equivalent in A's authorized view, noninterference requires equivalent observations under the stated scheduler and release model. With explicit declassification, the comparison also fixes the admitted release events; otherwise authorized disclosures would trivially violate the property. This is a formal obligation, not a claim that a complete ASKA noninterference theorem exists.

The [time-protection study](https://trustworthy.systems/publications/full_text/Ge_YCH_19.pdf) provides a concrete comparison for partitioning and flushing shared microarchitectural state, with hardware-specific limitations. ASKA must measure its own observation boundary; isolation of writable memory alone does not establish timing confidentiality.

The flow model builds on [Denning's lattice](https://doi.org/10.1145/360051.360056), [Bell–LaPadula confidentiality](https://lukemuehlhauser.com/wp-content/uploads/Bell-LaPadula-Secure-computer-systems-mathematical-foundations.pdf), [Biba integrity](https://www.cerias.purdue.edu/apps/reports_and_papers/view/2834/), [HiStar](https://static.usenix.org/event/osdi06/tech/zeldovich.html) and [Flume](https://doi.org/10.1145/1294261.1294293). [Robust declassification](https://www.cs.cornell.edu/andru/papers/robdecl-jcs/) specifically addresses attacker influence on release. ASKA must separately demonstrate its output-boundary implementation and release authority.

## Labels and partial orders

A confidentiality label is `C = (realm, compartments, recipients, purpose, retention)`. An integrity label records `(source_class, transformations, evidence_confidence)` without treating confidence as a universal authority rank. A label references the policies defining its interpretation. Realm-local orders may be incomparable; crossing realms requires explicit policy mapping rather than comparing arbitrary numeric trust scores.

For the simple closed model, information from several inputs accumulates all confidentiality restrictions and cannot acquire stronger integrity merely through computation. Purpose restrictions combine conjunctively. Recipient sets intersect where all owners must agree. Retention must satisfy applicable deletion and preservation rules; contradictory obligations enter the governance conflict procedure rather than being resolved by blindly taking a minimum or maximum timestamp.

Labels attach to objects, snapshots, messages, surface content, model context, generated code, telemetry and receipts. References also carry confidentiality: the existence of a record can reveal a diagnosis, membership or business relationship even if its payload is encrypted. Hashes of small predictable values are not inherently confidential commitments.

## Flow, endorsement and release

Ordinary flow preserves restrictions and does not increase integrity. **Declassification** authorizes a bounded reduction of confidentiality restrictions. **Endorsement** authorizes use of selected low-integrity data under a stronger integrity policy after an explicitly trusted validation. These are different operations and may require different approvers.

A parser can validate syntax without endorsing the truth of an invoice. A signature can authenticate the supplier without establishing that the goods arrived. A security analyzer can produce a hypothesis without converting it into trustworthy permission to freeze an unrelated service. Each transition must identify what its validator actually establishes.

[FLAM](https://www.cs.cornell.edu/andru/papers/flam/flam-csf15.pdf) analyzes how delegation and changes to trust can themselves affect information security. ASKA treats policy changes and authorization responses as outputs for this reason. [DStar](https://usenix.org/events/nsdi08/tech/full_papers/zeldovich/zeldovich.pdf) supplies a distributed comparison; trusting an exporter for a category is a substantive decision about remote enforcement, not a consequence of connectivity.

## Exact-output release contract

A release record binds:

| Field | Purpose |
|---|---|
| Source snapshot and generation | Fix the information and lifetime being considered |
| Source label and release authority | Establish the source's right and applicable restrictions |
| Transform identity and configuration | Identify the trusted computation, if any |
| Exact output digest or validated output contract | Prevent substitution after approval |
| Recipient identity and receiving policy | Keep source release distinct from destination acceptance |
| Representation, channel and physical path | Cover printing, display, network and non-network output |
| Quantity, frequency and cumulative budget | Bound repeated-query and multi-output leakage |
| Expiry, policy epoch and revocation dependencies | Establish currentness at finality |
| Notice, retention and witness obligations | Bind accountability without unnecessary disclosure |

Two modes are permitted. In **fixed-output mode**, the approved output bytes or pixels are stable before finality and the guard verifies their commitment. In **verified-transform mode**, an independently trusted transform receives a fixed input scope and can emit only under its declared semantic contract and budget. A model assertion that its summary is safe does not make the model a verified declassifier.

The release guard must bind bytes to destination and operation together. Approving a report does not authorize sending the same report to every endpoint. Approving one rendering does not authorize a higher-resolution source image, hidden metadata or a print spool containing the original document.

## Transformation continuity

| Transformation | Restrictions that must survive | Specific adversarial test |
|---|---|---|
| Copy/serialization | Source restrictions, recipient and generation | Substitute labels or an aliased buffer after validation |
| Compilation | Dependence of code/constants on secret inputs | Encode a secret in generated source, diagnostics or binary metadata |
| AI inference | Context, model state, retrieval and output restrictions | Leak context through tool arguments, embeddings or answer timing |
| Graphics rendering | Pixel region, hidden layers, surface lifetime | Readback, oversized stride, trusted-layer overlay |
| Compression/encryption | Original release obligation despite altered bytes | Use ciphertext generation as unauthorized export |
| Telemetry/logging | Activity confidentiality, minimum fields and retention | Smuggle plaintext into an error string or event payload |
| Backup/snapshot | Recipient key scope, retention and rollback protection | Restore deleted rights or expose a stale plaintext copy |
| Trusted redaction | Declared redaction semantics and residual inference | Recover blurred identifiers or correlate repeated views |

Integrity also follows transformations. A content digest establishes equality to committed bytes, not faithful transcription, accurate classification, honest capture or freedom from manipulated context.

## Cross-realm and human limits

A source may release to a recipient whose post-receipt confinement is supported by an accepted profile and evidence. It must name that dependence. If the recipient is unrestricted or malicious within granted rights, ASKA cannot make the recipient forget plaintext, prevent manual transcription or guarantee all future use. Contractual duties, notice and evidence can aid accountability without providing an impossible technical guarantee.

Human-readable display is disclosure to the person observing it. A protected UI prevents unauthorized digital overlays and input substitution under its model; it does not prevent persuasion, a camera outside the device, or coercion. Stronger physical profiles may control room access or peripherals, but must specify those controls explicitly.

An authorized legal disclosure does not globally relabel the source object as public. Only the admitted extract, recipient and purpose change. Likewise, a public civic notice does not release the confidential evidence used to produce it.

## Repetition, timing and availability

A one-bit answer repeated over many selected queries can disclose an entire secret. A per-request output schema is therefore insufficient. Release owners track cumulative query families, privacy budgets where supported, recipients and time horizons. Differential privacy requires a selected mechanism, composition rule and justified parameters; merely adding noise or naming a technique is not a guarantee.

Timing protection may require isolated resources, deterministic scheduling, padded responses and bounded queues. Padding to an arbitrary constant is ineffective if hidden work exceeds that bound or if dropped responses reveal the same secret. Profiles must state whether termination and resource exhaustion are visible and permitted. Reserved security traffic can itself reveal sensitive activity; aggregation or scheduled reporting trades timeliness against leakage.

False containment is also observable. A security rule that freezes only when a particular private activity occurs may disclose that activity through service availability. The standing grant and telemetry policy must consider this channel, especially for Sanctum operations.

## Example: restricted analysis without public forwarding

A service receives an authorized restricted dataset into quarantine. Its receiver checks the exact source mapping and installs a scoped compute grant. The worker produces an aggregate and a verbose diagnostic. Both inherit restrictions. A dedicated release transform validates the permitted aggregate schema and cumulative output budget. The source authorizes that exact output for a named Agora recipient; the recipient independently accepts publication.

The worker then attempts to send the verbose diagnostic to a public Wilder endpoint. Its ordinary read and compute grants cannot satisfy the release guard, so emission is denied. If the allowed aggregate itself encodes a secret because the trusted transform was malicious or too permissive, that is a failure of the semantic release assumption. The test must show this distinction rather than crediting successful packet authentication as successful confidentiality.

## Required behavior and test oracles

**R-07-01 — Declared observations.** Every confidentiality claim MUST state the observer function, allowed releases and unmodeled channels.

**Acceptance T-07-01:** Compare two secret-differing executions across values, errors, timing and resource use; report exactly which observations are tested.

**R-07-02 — Restriction continuity.** Restrictions MUST survive every copy, transform, generated artifact and output path unless a specific release authorizes a change.

**Acceptance T-07-02:** Pass a restricted value through rendering, compilation, AI output and logging; unauthorized destinations must remain denied.

**R-07-03 — Independent release and acceptance.** A crossing MUST have source release and independent recipient acceptance bound to the same operation.

**Acceptance T-07-03:** Use a valid release with absent receiver permission, then the reverse; both cases deny publication.

**R-07-04 — Exact output binding.** Release finality MUST bind the approved snapshot, output, destination, representation and live scope.

**Acceptance T-07-04:** Swap bytes, destination, format and hidden metadata after approval; reject or emit only the authorized commitment.

**R-07-05 — Trusted declassification.** A declassifier or endorser MUST have explicit semantic scope and separate admission from untrusted analysis.

**Acceptance T-07-05:** Compromise ordinary analyzer and make a false safety assertion; it cannot relabel or endorse its own result.

**R-07-06 — Cumulative disclosure bounds.** Release policy MUST account for repeated requests and visible side effects within its claimed observation scope.

**Acceptance T-07-06:** Reconstruct a secret through adaptive one-bit queries or selective freezes; enforce the declared aggregate ceiling or fail the claim.

**R-07-07 — Recipient and human limits.** Claims MUST state residual exposure after authorized release to an unconstrained recipient or human.

**Acceptance T-07-07:** Permit an authorized screen/report and record that photographing or malicious reuse is outside digital forgetting guarantees.
