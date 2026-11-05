# ASKA v6 — System-wide release and output channels

## Release is broader than network transmission

Information leaves an owner through network packets, display pixels, sound, printed pages, removable media, backups, logs, telemetry, model state, indexes, device commands and observable metadata. A complete release policy therefore begins with an output-path inventory. Blocking the primary network interface while leaving crash dumps or a display-capture service unrestricted does not establish confinement.

Every controlled output has an owner and a consequence boundary. The source object owner authorizes the information release; the effect owner controls the physical or logical output; the recipient or receiving owner independently accepts the result where applicable. These roles may share an implementation, in which case their common failure root is explicit. Read access alone grants none of the additional effects.

**R-46-01 — Complete release inventory.** A deployment MUST enumerate every in-scope path that can disclose protected information or create a corresponding external representation. Each path MUST have an enforcing owner, admitted release contract and stated physical or semantic limitations.

The inventory includes ordinary and exceptional operation: successful results, errors, debugging, recovery, maintenance, failover and emergency response. A diagnostic path used only during a crash can still disclose the most sensitive state. Its rarity is not a substitute for authorization.

## Output classes and enforcing contracts

| Output class | Enforcing boundary | Required binding |
|---|---|---|
| Network or radio | EG at the actual emission path | Exact representation, session/recipient, port, grant and budget |
| Display, audio or print | Renderer and output EO | Approved representation, audience/environment and capture policy |
| Clipboard or application handoff | BG/receiving owner | Source version, destination purpose, object label and transfer mode |
| Removable media or backup | PO plus media/export owner | Object set, encryption/key custody, retention and restoration policy |
| Logs and telemetry | TE/export owner | Event schema, recipients, sampling, payload policy and retention |
| Model state and derived indexes | Their persistent owners and EG/BG | Training/retrieval provenance, label, permitted derivative and recipient |
| Physical actuation | DG/EO at the command or actuation boundary | Command, target, operating limits, finality and observation |

This table is a role map, not proof that a particular device has been qualified. The selected physical manifest must show that an alternate DMA, management, radio or test path cannot bypass the relevant boundary within the claimed attacker model.

## Exact output and transformation

A release grant binds a source object version or an authorized transform, exact recipient or recipient set, purpose, representation, lifetime, negative restrictions, byte or query budget and finality point. Exact-output approval may use a sealed immutable representation whose commitment is checked at emission. A transformation grant instead defines a bounded relation between input and permitted output and the evidence required to accept that relation.

A program authorized to read a document cannot automatically send a summary anywhere it chooses. A source owner may authorize a particular summary, a restricted aggregate or a query interface with cumulative limits. The final owner checks that current grant and the actual output. Approval of a tool name or AI role does not authorize every future tool result.

**R-46-02 — Exact and current release authority.** Each output effect MUST bind the actual representation or qualified transform to current source authority, recipient, purpose, budget and negative restrictions. The final check MUST occur at the declared output boundary, and read or compute authority MUST NOT imply release.

The label attached to a derived object records source class, transformations and evidence confidence without pretending that those dimensions form one universal numeric trust score. A transform may reduce confidentiality under an admitted release rule while introducing semantic uncertainty. Integrity and confidentiality must be assessed separately.

## Rendering, perception and capture

Rendering is a release to an intended audience under a stated environment. Keystone’s trusted interaction path can bind a preview to a proposed effect, but cannot prove that every person near the screen is authorized or that no external camera exists. A deployment claiming controlled perception must state its physical access assumptions. The machine cannot retract a person’s knowledge after an authorized display.

Screenshots, screen sharing, clipboard export, accessibility services, remote desktop, audio recording and print spooling are separate paths. A renderer may produce pixels into a protected surface while a capture service needs its own authority to read and export that surface. An accessibility function can be essential while still requiring a clear recipient and scope. Its service role must not become unrestricted capture of every purpose plane.

**R-46-03 — Separate perception and capture rights.** Display, audio and print authorization MUST state their intended audience and environment. Capture, recording, clipboard and remote interaction MUST require their own applicable grants and MUST NOT inherit unrestricted rights from rendering or local accessibility access.

Partial output is still disclosure. A page printed before cancellation, an audio prefix played before revocation and a screen frame shown before lock all remain completed effects at their respective boundaries. Receipts preserve those facts. Cancellation closes future output under the contract; it does not relabel the prior output as nonexistent.

## Storage export, keys and derivatives

A backup or migration can disclose both object contents and authority-bearing metadata. Export must separate data needed for recovery from live grants, private keys and consumed budgets. A migration plan identifies destination acceptance, transport confidentiality, key wrapping, object generation changes and the source’s retained copies. Restoring an old snapshot must not restore old permissions or spent one-use authority.

Removable media has a custody and recipient problem in addition to encryption. The grant identifies the media or allowed recipient class, export representation and key access. An encrypted copy whose key is also placed on the same unrestricted medium may not satisfy the intended confidentiality contract. Key wrapping is itself an effect with a named recipient and purpose.

**R-46-04 — Authorized export and derivatives.** Backup, migration, removable-media and key-export operations MUST have explicit grants distinct from ordinary object use. Derived indexes, embeddings, caches and model state MUST retain applicable labels and release obligations rather than become unclassified by transformation.

An AI model or retrieval index can carry information learned from protected inputs. The deployment must define which derived artifacts are allowed to leave and what validation or privacy method supports that decision. It cannot declare all weights harmless because they are not literal copies of a source document. Where the necessary property is not established, the artifact remains confined or receives a narrower release.

## Telemetry, errors and query channels

Telemetry is a deliberate output of security-relevant information. The event contract identifies observation interface, event type, labels, payload digest, sampling and loss. Raw contents, high-resolution timing and identifiers may expose private activity. A TE exports only its installed schema and recipient scope; an LSM or watcher cannot expand that scope merely because additional data might help analysis.

Logs and error messages are also interfaces. A parser failure should not echo confidential input to a public console. Debug dumps, support bundles and forensic preservation need grants covering the exact object set, recipients, retention and access. A protective `PRESERVE_EVIDENCE` action may retain information under an existing contract; it does not authorize publication of that evidence.

**R-46-05 — Bounded observational release.** Telemetry, logs, diagnostics and forensic exports MUST have explicit schema, recipient, retention and payload limits. Query and error interfaces MUST enforce cumulative budgets where repeated authorized responses can disclose more than the admitted contract allows.

Repeated narrow queries can collectively reveal a sensitive fact. The owner can constrain query count, output precision, aggregation scope and correlation where its contract requires that protection. Those limits are part of authority consumption, not merely rate tuning. The guard must prevent a client from resetting the account by changing sessions, aliases or a superficial query identifier when the grant defines a shared budget.

## Metadata, covert channels and failure

Timing, length, ordering, destination choice and resource consumption can carry information. Complete prevention is not assumed. The [side-channel chapter](18_physical_side_channels_and_temporal_protection.md) defines how to state and test a limited observation claim. An output policy must distinguish intentional metadata release, mitigated channels and residual physical or semantic leakage. Padding or batching can reduce particular observations at a cost, but requires its own qualification.

A physically compromised output device may retain or reproduce what it legitimately received. A malicious authorized human or semantic approver can disclose information within or beyond the machine’s observable boundary. The architecture constrains machine effects and records evidence; it does not claim universal control of recipients after release. High-consequence contracts can require trusted devices, bounded environments or independent witnessing, with those assumptions visible.

**R-46-06 — Honest release limits and evidence.** Release claims MUST distinguish enforced machine boundaries from residual metadata, physical observation and recipient behavior. Receipts MUST identify the exact established output finality and retain uncertainty about delivery, perception or physical completion where those remain unobserved.

## Example and acceptance obligations

A user asks a UAI to prepare a confidential report for a named colleague. The UAI may read the permitted source objects and create a private draft. The source owner admits an exact export representation and recipient. The trusted interaction path shows that representation and destination. The EG sends the sealed report under its current release grant. A screen preview does not authorize a public screenshot; a successful network emission does not establish that the colleague read the report; a diagnostic failure does not authorize uploading the source documents to a support service.

Acceptance specifications are:

- **T-46-01:** Trace ordinary, error, maintenance and recovery outputs from every protected domain. Any in-scope path lacking an owner and release contract defeats completeness.
- **T-46-02:** Modify bytes, recipient, purpose or grant state after preview. The actual output boundary must reject the mismatch or preserve only the already established permitted prefix.
- **T-46-03:** Attempt capture, clipboard, accessibility export and printing with display-only authority. Unadmitted outputs must fail while the authorized display remains usable.
- **T-46-04:** Export an index, model, backup or wrapped key using only a source-read grant. The owner must require the separate derivative/export authority and preserve labels and restoration constraints.
- **T-46-05:** Repeatedly query a bounded aggregate through new sessions and trigger errors containing protected input. The cumulative grant ceiling must hold and diagnostics must remain within their payload policy.
- **T-46-06:** Emit a report, lose the recipient acknowledgement and observe a physical camera outside the controlled environment. Evidence must retain local emission and the declared delivery and physical-observation limits without claiming universal containment.
