# ASKA v6 — Native applications, toolchains and interoperability

A native ASKA application is a declared graph of bounded components and explicit consequences. It may offer a conventional graphical interface, a conversational interface, a document workflow, a continuous service or a specialized scientific instrument. The architecture should make useful applications practical without requiring every developer to implement security policy, cryptography and resource lifecycle management independently. The enforcing owners and trusted toolchain supply those facilities through small, reviewable interfaces.

An application package contains component artifacts, manifests, interface schemas, data and effect flows, dependencies, resource bounds, provenance, update policy and requested authority. Installing code does not grant every permission it requests. Deployment binds approved components to local owners and installed grants after independent admission. A developer's library named “security monitor” is not thereby an independently rooted LSM or watcher.

## 38.1 Component interface and application graph

A component manifest names its principal, purpose, input and output types, expected labels, callable effects, persistent state, resource budgets, lifetime, cancellation behavior and failure semantics. It identifies whether the component is a persistent service or a fresh worker and whether it receives copied input, immutable shared objects or exclusive ownership. No manifest may rely on ambient writable memory shared across distrusting IESs.

| Interface family | Intended operation | Mandatory boundary |
|---|---|---|
| `object.read` | Obtain an admitted object view or copy | Source owner, generation and read grant |
| `region.allocate` | Obtain bounded writable working memory | IES ownership, quota and lifecycle |
| `output.create` / `output.seal` | Build and seal an output object | Label propagation, immutability and object generation |
| `effect.prepare` / `effect.submit` | Propose and request a consequence | Effect owner, grant, budget and named finality |
| `task.spawn` / `task.finish` | Start or retire a bounded worker | Attenuated authority, resource reservation and cleanup |
| `status.query` / `effect.reconcile` | Obtain scoped evidence of progress or outcome | Authorized visibility and authenticated effect identity |

These names define semantic families, not a committed binary ABI. A realization must publish concrete encodings, error classes, bounds and concurrency behavior. Unknown critical fields and ambiguous encodings are rejected rather than ignored at consequence boundaries.

**R-38-01 — Explicit application graph.** Native applications MUST declare component interfaces, data and effect edges, ownership, labels, resources and failure behavior. Code installation MUST NOT itself install requested authority, and graph validation MUST reject undeclared consequence paths.

Graph checks should detect an output sent to the wrong owner, a declassifier reachable by unauthorized callers, a worker given a broader grant than its parent, and a supposedly one-way workflow with an undocumented reverse edge. Graph validation does not establish arbitrary semantic correctness of a component; the claim must identify what the checker actually verifies.

## 38.2 Toolchain, evidence and developer experience

The toolchain should provide typed schemas, local emulators, explicit owner stubs, bounded resource instrumentation, reusable trusted presentation templates and negative test fixtures. Development views can explain why an operation was denied without exposing hidden protected evidence. Tutorials should demonstrate the actual separation between a proposed effect and an admitted one rather than teach a convenience bypass that later becomes a production dependency.

A candidate runtime family can compose small OS libraries, driver interfaces, allocators and schedulers into a workload-specific library OS, unikernel or run-to-completion cell. Typed call gates and compiler-checked ownership annotations can support finer compartments inside an IES. Such compartments retain the declared shared processor, cache, reset and installer dependencies; their names do not establish physical independence. A build manifest pins the selected libraries, hardening mechanisms, ABI, allocator, scheduler and resource assumptions. An optimizer may compare configurations by image size, memory use, startup cost, communication overhead, failure containment and recovery behavior, but cannot exchange a mandatory security property for a higher aggregate score. Changing runtime components, adding instrumentation or switching a live compartment configuration enters the scoped update process and preserves lifetime, grant, label and effect bindings. A syscall shim or compiler transformation is a compatibility candidate whose admitted calls and weaker legacy assumptions remain explicit. No effortless porting, performance gain or complete equivalence is assumed.

Authenticated immutable code, library or function objects may be deduplicated across admitted consumers using a pinned deterministic-linking contract, while each consumer retains separate grants, writable state, relocation records, lifetime bindings and update dependencies. A shared content hash establishes neither effect authority nor a performance advantage; the selected physical and observation profile still governs shared-code placement and cache exposure.

**R-38-02 — Reproducible and scoped development.** Build and deployment evidence MUST bind source or input artifacts, toolchain versions, dependency identities, manifest, produced artifact digests and checker results. Debugging and profiling MUST use separately admitted observation scope and MUST NOT acquire unrestricted access to other cells or roots.

A formal checker is useful only with an explicit trusted computing base and property statement. A build can prove that a component obeys a restricted interface language while leaving its mathematical result, supply-chain inputs and physical implementation unverified. Reproducibility helps detect divergence; it is not a guarantee that the common result is benign. Compiler or library updates require compatibility analysis and the same independent admission discipline as application updates.

A small greeting application illustrates the model without prescribing a universal module count. An input worker receives an admitted name, a formatter produces a sealed local text object, and a renderer receives authority to display it in a defined region. A public greeting would require an additional release decision if the name is protected. Physical placement may combine compatible components inside one IES while preserving all boundaries claimed by the profile.

## 38.3 Documents, services and large jobs

A document application separates acquisition, parsing, validation, rendering, analysis, saving and export. Parsers handle hostile formats in constrained workers. A renderer receives a bounded surface or sealed display object, not ambient display ownership. Analysis can read an admitted document while its summaries remain confined. Saving through the persistent object owner establishes the declared durability boundary; export is a separate effect with source release and destination acceptance.

**R-38-03 — Useful work without implicit release.** Application stages MUST preserve the distinction between reading, transforming, displaying locally, persisting and exporting. A successful parse, local save or analysis MUST NOT imply authority for a later release or external action.

Persistent services need explicit session boundaries and private state ownership. Fresh workers are useful for untrusted parsers and one-shot transformations, but creating a new physical IES per function call is neither assumed nor required. Large simulations, training jobs and media pipelines may use coarse bounded tasks and shared immutable input objects. Their scheduling, checkpoints and restart semantics must preserve labels, budgets and owner generations.

Canceling a job must distinguish reclaimable computation from already committed effects. A checkpoint can be reused only when its identity, labels, code and grant context remain applicable. A job scheduler's ability to move computation does not confer authority to copy protected data to a new physical or institutional recipient.

## 38.4 Collaboration and legacy interoperability

The Secure Hyper-Virtualization System (SHVS) names a collaboration and compatibility candidate, not a source of ambient virtualization authority. A shared workspace is a collection of participant-specific views and effects. A collaboration context records each participant's role, source permissions, recipient restrictions, active grant generations and revocation status. A meeting transcript, shared simulation or group document does not become readable by every future member merely because it belongs to a group. Analytics over participation require an independent privacy and release policy.

**R-38-04 — Participant-specific collaboration.** Shared applications MUST enforce each participant's current permissions and preserve individual source restrictions in derived outputs. Membership changes and revocation MUST affect future access and finality without pretending to retract information already delivered.

Legacy systems enter through explicit adapters. The adapter validates foreign encodings, maps identifiers, translates authorized operations and reports where the legacy endpoint cannot enforce an ASKA obligation. A legacy bearer token must not be passed through merely because it is convenient; its audience and effect scope must match the admitted adapter contract. A browser page, shell process or remote desktop is a foreign computation context, not a trusted policy authority.

**R-38-05 — Honest adapter guarantees.** Every interoperability adapter MUST declare its translation, token custody, label treatment, effect boundary, downgrade behavior and unenforceable remote obligations. Failure to provide a required guarantee MUST cause denial, suspension or a newly admitted weaker contract rather than a silent downgrade.

The [Model Context Protocol tools specification, version 2025-06-18](https://modelcontextprotocol.io/specification/2025-06-18/server/tools) describes structured tool interfaces, while its [security guidance for the 2025-11-25 documentation path](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices) addresses hazards such as confused deputies and token passthrough. These provide adapter considerations; they do not establish ASKA confinement, trusted display or physical finality.

IAMA can build a behavioral model of a permitted legacy workflow and compare generated replacements against observed traces. It must not claim exhaustive equivalence from finite observations. Authorized shadow execution must avoid duplicating real payments, messages or actuator commands. The wider deployment treatment is in [Reference realizations and legacy interoperability](57_reference_realizations_and_legacy_interoperability.md).

### Native remote-UI session service

A native remote-UI service admits a session bound to the remote principal, client endpoint, authenticated channel, purpose, current epochs, resource budget and permitted applications. It allocates a dedicated session execution domain with confined input-decoder and renderer workers, private per-session state and bounded surfaces. Mutually distrusting native sessions use the required physically owned IES resources; child cells or an admitted split do not inherit foreign writable state. The session owner and final display/input guards remain outside the authority of compromised decoder or renderer code. Input sanitization is a bounded parsing stage, not proof that the resulting request is permitted.

**R-38-09 — Scoped native remote interaction.** Native remote-UI services MUST isolate session decoding, rendering and private state; separately admit display, input, clipboard, file, audio and device-redirection effects; and enforce source release and destination acceptance for each direction. Session authentication MUST NOT imply those rights or trusted local presence. Revocation, disconnect, reconnection and retirement MUST preserve current authority, lifetime closure and established effect evidence. Compatibility adapters MUST declare weaker endpoint guarantees.

Viewing a permitted window does not authorize clipboard extraction, file transfer, microphone capture, printing, camera access or device forwarding. Each channel binds exact objects or permitted representations, direction, recipient, labels and cumulative limits. Remote display is a disclosure to the client; encryption does not remove that recipient boundary. Device redirection exposes bounded object operations through the device owner rather than raw DMA or a general local device handle. Incoming events bind origin, session, target surface, focus, freshness and rate; receiving a remote key event cannot synthesize an unrelated confirmation.

[Session admission](44_admission_identity_and_sessions.md) owns authentication and any required step-up procedure. [Keystone](36_keystone_trusted_user_interaction.md) distinguishes remote approval, authenticated client control and local physical presence. A policy requiring local presence cannot be satisfied by relabeling a remote session. Risk evidence can request an already admitted restriction, challenge or suspension; it cannot create new grants. Session health and lifecycle telemetry follow the observation contract and do not imply recording all pixels or keystrokes.

Disconnect behavior is admitted in advance: stop new remote effects, suspend or expire the scoped grants, drain or fence queued input and scanout, and retain unresolved effects for reconciliation. An explicitly permitted unattended task can continue only within its surviving standing authority. Retirement sanitizes session state before reuse. Reconnection revalidates endpoint, epochs, grants and pending outcomes; it does not revive stale input or silently resend an uncertain action. A committed disclosure or payment remains committed at its named boundary even if the UI disappears, and any unknown downstream outcome remains separately scoped. Legacy remote-desktop adapters must expose their weaker input, display, retention and finality controls under R-38-05.

## 38.5 Privacy-preserving computation and specialized applications

Research, health, commerce and civic analysis may benefit from computation across independently owned data. The contract must first state which outputs are allowed and which adversaries it addresses. A Zero-Knowledge Execution Environment (ZKEE) is a research objective requiring a selected statement, proof system and leakage model; the name does not establish a privacy guarantee. Multiparty computation, homomorphic encryption, zero-knowledge proofs, differential privacy and trusted execution environments solve different portions of that problem. They are optional mechanisms with explicit assumptions, not interchangeable privacy labels.

Multiparty computation requires a corruption and collusion model, authenticated participation, output definition, abort behavior and composition analysis. [Damgård, Pastro, Smart and Zakarias (2011; CRYPTO 2012)](https://pure.au.dk/portal/en/publications/multiparty-computation-from-somewhat-homomorphic-encryption/) provide a concrete preprocessing-based protocol for arithmetic circuits with an explicit active-adversary corruption bound; its assumptions do not authorize a particular output. Homomorphic encryption changes who can compute on ciphertext but does not make the decrypted output harmless. A zero-knowledge proof can establish a precisely encoded statement while revealing public inputs and metadata; it does not establish that a sensor measured the world honestly or that the selected statement was socially appropriate. Differential privacy requires a defined privacy unit, adjacency relation, mechanism and composition budget. A trusted execution environment retains hardware, firmware, attestation and side-channel assumptions.

**R-38-06 — Mechanism-specific privacy claims.** Privacy-computation applications MUST state their adversary model, permitted output, leakage, collusion or trusted hardware assumptions, composition budget where applicable, and failure behavior. They MUST NOT treat cryptographic validity or an attestation as proof that the result is authorized, accurate or free of identifying inference.

[NIST SP 800-226](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-226.pdf) explains how differential-privacy guarantees depend on definitions, parameters and system assumptions. [NIST IR 8214A](https://nvlpubs.nist.gov/nistpubs/ir/2020/NIST.IR.8214A.pdf) treats threshold schemes as a family with differing adversaries and operational properties. Neither supplies a blanket proof for an ASKA multi-institution application.

A useful example is a research enclave that computes a bounded aggregate across laboratories. Each source owner admits its input and the exact analysis purpose. The computation publishes only an approved aggregate through an exporter with a query budget. Researchers can inspect method provenance and uncertainty without obtaining all raw records. Repeated queries, errors and timing remain part of the leakage analysis; secure arithmetic alone does not close them.

## 38.6 Evolution and conformance

An application can use AI-generated code, domain-specific languages, conventional binaries or specialized accelerators, provided its realization meets the declared boundaries. Experimental quantum or unconventional computation must identify data-loading costs, hardware assumptions and algorithm-specific evidence. No application may depend on an unestablished claim of instant quantum computation, perfect behavioral equivalence or universal proprietary non-clonability.

**R-38-07 — Independent application evolution.** Application and adapter updates MUST preserve contract compatibility or obtain new admission, with rollback and containment behavior defined for persistent objects and outstanding effects. A generator or optimizer MUST NOT broaden the application's authority while improving its implementation.

**R-38-08 — Falsifiable application conformance.** An application claiming conformance MUST supply positive and negative vectors for its declared interfaces, label flows, lifetime transitions, budgets and effects, plus a manifest of unimplemented or weaker guarantees. Passing a user-interface demonstration MUST NOT substitute for those boundary checks.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-38-01 | Add an undeclared network or actuator edge to a component; deployment or execution rejects it. |
| T-38-02 | Run a debugger with one-cell observation scope; another cell's memory, keys and private traces remain inaccessible. |
| T-38-03 | Open, summarize and save a protected document; export still fails without a separate admitted release. |
| T-38-04 | Remove a participant during a collaborative task; subsequent access uses current grant generations while existing disclosures remain honestly recorded. |
| T-38-05 | Connect an endpoint unable to enforce required retention or idempotency; the adapter exposes the gap and does not silently claim compliance. |
| T-38-06 | Exhaust an aggregate query budget or violate a declared collusion assumption; the system blocks further authorized release or reports invalid assurance. |
| T-38-07 | Update a parser while effects and checkpoints exist; incompatible state cannot be resumed under stale authority. |
| T-38-08 | Exercise malformed schemas, stale handles, duplicate effects and revoked output grants; the package's claimed boundaries have explicit passing evidence or remain unvalidated. |
| T-38-09 | Complete an admitted remote view and scoped input operation while clipboard, file, audio and device redirection remain denied without their own grants. Compromise the decoder/renderer, replay stale input, attempt protected-region writes and substitute remote authentication for required local presence; each forbidden effect must fail. Revoke or disconnect during queued input and after a local commit: no new ungranted effect occurs, reconnection cannot replay retired authority, and committed evidence plus separately unresolved outcomes remain truthful. |
