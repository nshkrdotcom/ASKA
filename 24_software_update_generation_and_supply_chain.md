# ASKA v6 — Software updates, generated artifacts and supply-chain safety

## The signed producer is inside the threat model

An update can be authentic and dangerous. Its producer may be malicious, its tests incomplete, its parser faulty, its model poisoned, or its device assumptions wrong. A correctly signed driver can crash every workload that loads it. A signed observer rule can hide an attack or exhaust the observer. A valid guard bitstream can invalidate the very boundary intended to contain other faults. Authentic distribution is therefore one requirement among several.

ASKA separates the production of an artifact from the authority to install it. The receiver admits a particular artifact for a particular target and consequence class. Its decision includes current compatibility, review, test evidence, rollout budget, recovery readiness and local policy. The MSM is a distributor; its one-way link does not confer a right to activate everything it carries.

## Roles and package classes

**R-24-01 — Separate consequential roles.** The update process MUST identify producer, reviewer, test-oracle owner, release-authorization signer, distributor, installer and recovery custodian. AESDS and other producer agents MUST NOT approve, issue a release-authorizing signature for, or install their own candidate, or change the protected oracle that accepts it. A separately scoped producer-origin or build-provenance signature MAY authenticate evidence, but MUST confer no release or installation authority. Required independent roles MUST have independently protected credentials and effective administration; multiple names or keys under one defeating authority MUST be disclosed as a shared dependency.

| Package class | Examples | Admission consequence |
|---|---|---|
| `DATA_RULE` | Detection patterns or bounded policy data | Parser and resource limits; semantic effect review where decisions change |
| `MODEL_WEIGHT` | SAI or UAI model and inference configuration | Behavioral evaluation, privacy and tool/action scope |
| `APPLICATION` | Native worker or compatibility application | Confined execution, capability manifest and application rollback |
| `GUARD_FIRMWARE` | MG/DG/BG/PO/EO/EG/RG control implementation | Boundary assurance, quiescence, independent recovery and strong review |
| `OBSERVER_FIRMWARE` | TE, LSM, MSM or watcher implementation | Coverage continuity, root separation and protected retained evidence |
| `BOOT_ROOT` | Boot verifier or trust-anchor policy | Root-transition authority and recoverability, not ordinary content approval |
| `HARDWARE_CONFIG` | FPGA bitstream, routing or hardware policy tables | Actual physical reachability and boundary behavior revalidation |

**R-24-02 — Classify effective authority.** Every package MUST declare its actual executable, interpretive and policy effects, dependencies and required privileges. Classification MUST follow those effects rather than filename, signature role or marketing label. Data that drives an interpreter, model that controls proposals, or configuration that changes a guard boundary MUST receive the review appropriate to its effective consequence.

A driver confined to a disposable IES can still deny that IES’s service. It must not inherit a path to rewrite other guards or observe unrelated banks. A guard update has a larger trust consequence because its failure may defeat those boundaries. The distinction supports containment of ordinary bad updates while keeping the cost of updating high-assurance components explicit.

## Manifest and receiving sequence

The manifest binds artifact digest and length, package type, producer identity, source and build provenance, target component/generation, compatible interface/schema versions, dependency graph, installer operation, independent approvals, security version floor, test dossier, rollout cohort, expiry, recovery artifact and expected observation coverage. It also states which persistent data schemas change and whether an old image can safely read the new state.

**R-24-03 — Receiver-controlled validation.** Before activation, the installer MUST validate artifact identity, bounded encoding, target, dependency compatibility, signature and approval scope, security floors, freshness, local authority and recovery prerequisites. It MUST reject unknown critical fields and unauthorized root changes. Transport receipt, provenance verification or a successful build MUST NOT substitute for activation admission.

The sequence is transfer into quarantine, verify, stage, prepare the target lifecycle, activate at a declared finality point, record the receipt, observe the bounded cohort, then consider expansion. A crash between these stages leaves a recoverable record of what became active or a qualified uncertainty requiring reconciliation. Repeated delivery of identical bytes does not create multiple independent installations.

[TUF 1.0.36, modified 5 August 2026, §§1.4 and 5](https://theupdateframework.github.io/specification/v1.0.36/) specifies trusted metadata and rollback/freeze defenses while excluding application installation and semantic safety from its scope. [in-toto, Torres-Arias et al., USENIX Security 2019, §§2–3](https://www.usenix.org/system/files/sec19-torres-arias.pdf) provides step and artifact-flow evidence under an explicit key-compromise model. ASKA requires both credible provenance and local consequence admission; neither evidence system proves a maliciously authorized program safe.

## Bounded rollout and a hostile release

**R-24-04 — Independent rollout cohorts.** Updates MUST begin in a bounded cohort chosen by failure domain and consequence, with measurable expansion and stop criteria. The rollout MUST reserve sufficient unaffected enforcement, observation and recovery capability to evaluate or recover the cohort. A canary that shares the same disabling update root, power dependency or sole management path with the whole fleet MUST NOT be counted as independent protection.

For an application update, the initial cohort can be a limited set of disposable workers with controlled access to copied test data and preapproved effects. For an observer update, at least the applicable watcher and receiver evidence must remain outside the update’s writable authority. For a guard or boot-root update, the assurance case must identify the protected mechanism that can regain control if the candidate cannot run. “The new image will repair itself” is not that mechanism.

A malicious producer can optimize for the canary and fail later, use a delayed trigger, behave differently for a customer identity, or exploit a rare state transition. Tests therefore include delayed activation, resource stress, clock/epoch changes, offline operation, malformed input, device differences and recovery under interrupted activation. Cohorts reduce exposure; they do not eliminate intentional evasion.

**R-24-05 — Correctly signed malicious artifact.** The conformance campaign MUST include artifacts signed by an otherwise authorized producer that deliberately crash, hide evidence, exhaust resources, leak data, expand scope or corrupt persistent state. The oracle MUST demonstrate the claimed containment boundary and lost capabilities without assuming malware detection succeeds. For high-consequence package classes, missing independent review or recovery evidence MUST prevent activation.

A bad local observer image may remove useful detection. The protected owner still enforces its installed grants. A bad MSM package may be sent everywhere; local receivers still have separate authority and rollout conditions. A bad guard image can defeat its boundary once admitted, so its acceptance has a different evidential burden. The documentation must state that residual risk rather than claim every signed update is safely confined by the component it replaces.

## Recovery and parser safety

**R-24-06 — Recoverable activation.** Each installer MUST provide a tested recovery path outside the candidate’s control, survive interruption at every durable transition, and preserve monotonic security and receipt state. Recovery MUST not reactivate revoked keys, expired grants or prohibited vulnerable versions. A known-good image MUST be accompanied by compatible state and current authorization; “golden” is not a permanent exemption from security floors.

Rollback of code and rollback of data are different. A candidate may migrate a durable object into a schema the old code cannot interpret. A recovery design can use versioned objects, a separately validated reverse migration or a forward repair, but it cannot pretend the old state reappears automatically. External effects that occurred during the rollout remain recorded and require separate reconciliation.

[NIST SP 800-193, May 2018, §4.1.2](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-193.pdf) makes interrupted-update recoverability an explicit firmware concern. The specific ASKA recovery controller, storage format and power-failure behavior still require tests.

**R-24-07 — Bounded package interpretation.** Package, rule, model and manifest parsers MUST execute with bounded input sizes, recursion, memory, time and output effects appropriate to their class. Parsing and validation MUST be separated from activation. Malformed input and validation failure MUST leave active policy and recovery state unchanged except for a bounded, truthful rejection record.

The software used to verify signatures, decompress archives, parse models and interpret rules belongs in the actual trust and attack surface. A parser exploit on a one-way input is still an exploit. Unknown model operators, dependency cycles, decompression expansion and path traversal must be covered by the class-specific conformance dossier. Recovery must remain reachable when the normal parser is unusable.

## Technical configuration composition and simulation

A configuration-composition task starts from immutable baseline and trust-root configuration (TRC) versions, a proposed change and an exact target. Its task record identifies the source owners, component and object/device generations, permitted input objects, applicable schemas, validation and conflict-rule versions, resource budget and required reviewers. A retrieved TRC is authenticated configuration evidence within its issuer scope; its presence does not grant the composer access to unrelated roots or install the proposal.

An authorized validation stage checks input authenticity, issuer scope, schemas, compatibility and applicable restrictions. Composition merges the fixed inputs under deterministic, admitted rules and records the provenance of each resulting setting. Duplicate assignments, incompatible constraints, unknown critical fields and ambiguous precedence receive explicit dispositions. A configured resolution rule can select a result within its authority; a trust score, consensus result or AI preference cannot invent precedence. A conflict lacking an authorized resolution remains nonactivatable. Contested institutional authority follows [chapter 30](30_governance_profiles_conflicts_and_institutions.md), rather than being settled by a technical simulator.

Approved templates and [AESDS engineering agents](24_software_update_generation_and_supply_chain.md) can generate candidate configurations; an IAMA model can contribute qualified legacy-compatibility evidence. The producer and release-authorization roles remain separate. A protected configuration owner stores immutable candidate versions with exact artifact digest, target, baseline references, template/tool identities, resolved-conflict record and change lineage. Editing the candidate creates a new version; review and simulation evidence for another digest cannot authorize it. Configuration retention, export and recovery use the protected-object contract in [chapter 16](16_persistent_objects_and_storage_recovery.md).

Technical simulation runs the exact candidate version in a bounded, isolated fixture. Its impact study compares affected permissions, data paths, resource reservations, observer coverage, response budgets and recovery behavior where applicable. Reports identify model and fixture versions, inputs, assumptions, tested scenarios, uncertainty and uncovered requirements. Authorized MSM context may inform the study, but does not supply unrestricted production data or live effect rights. A favorable model result cannot satisfy a required behavior outside that model's coverage. The trusted review process binds its decision to the candidate, target and qualified evidence; where human approval is required, Keystone presents the material authority changes and limits.

The receiving owner still checks the current baseline, epochs, grant state, exact reviewed digest and other activation prerequisites. A changed baseline requires authorized recomposition or revalidation of affected obligations, not an implicit rebase using stale approval. Activation remains the separate protected transition described above, with its own receipt and recovery conditions. Simulation produces evidence and no new machine authority.

**R-24-08 — Bound configuration composition and simulation.** Configuration composition MUST bind immutable baseline/TRC versions, the proposed change, target identity/generation and authorized validation/merge rules. It MUST produce a protected, versioned candidate with deterministic conflict disposition; unresolved conflicts MUST block activation. Simulation and impact evidence MUST bind the exact candidate digest, model/fixture versions, assumptions, resource bounds, coverage limits and independent review. Templates, AESDS and simulation MUST NOT create rights, replace release authorization or change protected acceptance oracles. The receiving owner MUST recheck the current baseline, grant/policy/target epochs and applicable activation conditions at finality; a relevant change MUST invalidate the affected prior acceptance.

## Current standards and evidence scope

[NIST SP 800-218, SSDF 1.1, final February 2022](https://csrc.nist.gov/pubs/sp/800/218/final) supplies reviewed development practices, including independent design review, release preservation and executable-code testing. [SSDF 1.2, SP 800-218 Revision 1](https://csrc.nist.gov/pubs/sp/800/218/r1/ipd) is designated an initial public draft dated 17 December 2025 on the checked NIST page; it is not presented as final here.

[SLSA v1.2 build requirements](https://slsa.dev/spec/v1.2/build-requirements) are marked Approved and distinguish producer and build-platform duties, provenance integrity and build isolation. [Reproducible Builds’ definition](https://reproducible-builds.org/docs/definition/) concerns identical specified artifacts from stated source, environment and instructions. Reproducible malicious source remains malicious, and a repeated compromised toolchain can reproduce the same defect.

Protocol version pinning also matters. [DMTF advisory DMTF-2026-0003, 3 July 2026](https://github.com/DMTF/libspdm/security/advisories/GHSA-chjj-xvqx-c8w4) identifies a FINISH transcript omission affecting SPDM 1.4.0 and names 1.4.1 as patched. The [published SPDM 1.4.1 specification](https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.4.1.pdf), dated 26 June 2026, supersedes 1.4.0. Pinning the corrected specification does not prove an implementation follows it or is free of other faults.

## Conformance campaign

| Test | Stimulus | Required oracle |
|---|---|---|
| T-24-01 | Producer signs scoped origin evidence, then attempts release authorization, oracle modification, installation and recovery-key access | Origin evidence remains nonauthorizing; consequential self-approval and key access fail; shared administration is disclosed |
| T-24-02 | Relabel executable rules, models or bitstreams as harmless data | Effective consequence classification selects the required admission controls |
| T-24-03 | Replay metadata, alter target/dependencies, use expired approvals or request root expansion | Receiver rejects; active artifact and authority remain unchanged |
| T-24-04 | Fail a cohort and its common management dependency | Expansion stops; unaffected recovery and observation remain sufficient under declared assumptions |
| T-24-05 | Install a correctly signed malicious candidate in the authorized test scope | Boundary containment and lost functions match the package class; high-consequence admission gates hold |
| T-24-06 | Interrupt every durable write/activation step and attempt stale-image recovery | Current floors, key revocations, object compatibility and receipts survive or produce explicit unrecoverable status |
| T-24-07 | Fuzz manifest, archive, rule and model parsers with bounded and over-limit inputs | No unbounded resource use, partial activation or corruption of protected recovery state |
| T-24-08 | Compose from a stale baseline, substitute the candidate after simulation, introduce contradictory policy without an admitted resolution, and present a favorable simulation missing a required behavior; then submit an unchanged, fully authorized current candidate | The first four cases cannot activate or acquire rights; the positive case activates only the exact reviewed digest after current owner checks and records its scoped outcome |

A release dossier records what was tested, by whom, against which artifact, and which risks remain. It must never replace an absent result with a signature over the producer’s intention.

## None

### Native software synthesis as a first-class function

The Automated Evolutionary Software Development System (AESDS) supports requirements analysis, software synthesis, adaptation, testing and candidate preparation. It can generate native applications and proposed changes to runtime services, security analysis, gateways and platform components. Its purpose extends beyond anomaly detection: users and institutions can delegate useful application development, repair and optimization within explicit resource, data and effect contracts.

A user-facing UAI can help formulate the goal. AESDS engineering agents translate the admitted goal into candidate artifacts. SAI can contribute released incident hypotheses and security evidence. These are separate roles. A shared language-model architecture or common user interface does not justify sharing production credentials, private context or control over acceptance tests.

**R-24-09 — Complete bounded engineering workflow.** AESDS MUST bind each engineering task to an admitted goal, source/data scope, resource budget, permitted tools, candidate outputs and acceptance criteria. The workflow MUST distinguish proposal, synthesis, build, test, independent evaluation, release and installation. UAI, SAI and AESDS roles MUST retain separate authority even when the workflow is automatically orchestrated.

An admitted goal may authorize many iterations without repeated approval: create a document parser, repair a native application, optimize a queue implementation or evaluate a detection candidate. The goal does not authorize reading arbitrary production objects, sending external messages, purchasing infrastructure or installing a privileged artifact unless the corresponding effects were also admitted. The same authority calculus applies to code written by a person and code written by an agent.

### Isolated build and test environments

AESDS workers execute in bounded cells with explicit copies or immutable inputs. Builds use declared source revisions, dependency digests, toolchain identities and build instructions. Test fixtures reproduce the relevant interfaces and lifecycles rather than exposing uncontrolled production devices. A sandbox for a gateway, STN service or guard candidate models that component’s authority separately from the authority of the test orchestrator.

**R-24-10 — Contained engineering execution.** Build, test and simulation workers MUST receive only the objects, device emulators, network destinations and resource grants needed for the task. Production keys, release-authorization signer credentials, arbitrary bank access and live actuator authority MUST remain outside their domain. Results MUST identify the fixture, target model and differences from the production environment; sandbox success MUST NOT be represented as production validation.

A legacy compatibility system can run inside an IES for analysis, but its kernel remains untrusted relative to the enclosing owners. Fuzzing may intentionally produce arbitrary code execution in that system. The experiment succeeds only if the intended crash or compromise remains within the test scope and useful positive cases still work. A test that merely prevents the target from running does not validate its containment or functionality.

Test environments need their own cleanup lifecycle. Revocation, outstanding DMA, queued messages, temporary objects and model context must be retired before reuse. Otherwise one candidate can contaminate another’s results or extract data from an earlier test. The output package is quarantined until its provenance and permitted content have been checked.

### IAMA and structural legacy models

Isomorphic Architecture Monitoring and Adaptation (IAMA) is a candidate technique for constructing a structural representation of a legacy system and using it to investigate possible vulnerabilities and adaptations. The model can represent component boundaries, dependency graphs, protocol states, privilege relationships, resource lifecycles and observable behavior. “Isomorphic” must identify the particular relation being claimed; it does not mean the model reproduces every physical or semantic property of the target.

**R-24-11 — Explicit IAMA correspondence.** An IAMA study MUST specify the mapping between legacy elements and model elements, the preserved properties, abstraction losses and admissible input data. It MUST preserve necessary structural correspondence without importing sensitive production contents by default. Predictive conclusions MUST be treated as hypotheses until independently tested on held-out target behavior; structural similarity alone MUST NOT establish vulnerability presence, absence or transfer.

An input diode limits reverse propagation from the analysis side but does not sanitize the incoming legacy data. Logs can contain private documents, credentials, prompt injection or deliberately misleading topology. An intake owner validates format, minimizes content and creates model inputs with provenance and labels. A synthetic workload can preserve a control-flow or object-lifetime pattern while replacing sensitive values, but the study must test whether the substitution removed the very behavior of interest.

A digital twin is one possible implementation. Its fidelity is measured against specified properties and time periods. It can help explore a migration sequence or generate attacks against a protocol state machine. It cannot predict every future failure merely because it ingests many logs. Unobserved device state, environmental conditions and missing traffic remain unobserved. Model disagreement should guide new experiments rather than be hidden by tuning the model to match only known examples.

### Independent oracles and evidence

**R-24-12 — Producer cannot grade itself.** The protected acceptance oracle, required test set, pass criteria and independent review policy MUST be outside AESDS producer authority. Agents MAY propose additional tests and explain failures, but MUST NOT delete failing cases, replace expected outcomes, self-label success, authorize release or install their own candidate. A scoped origin or build-provenance signature MAY identify producer evidence; it MUST NOT serve as independent approval or release authorization. Any authorized change to an oracle MUST be a separately reviewed artifact with its own provenance and applicability interval.

The oracle must test the actual contract. A generator can learn to satisfy a superficial test without implementing the intended property. Required evidence therefore includes negative cases, positive useful work, adversarial boundary tests and a deliberately weakened implementation that the oracle should reject. Where formal models are used, the dossier identifies assumptions and abstraction limits and links the model property to the implemented interface. Passing a finite model does not establish timing, electrical isolation or analog side-channel protection.

[NIST SSDF 1.1, February 2022, tasks PW.2.1 and PW.8.1–PW.8.2](https://csrc.nist.gov/pubs/sp/800/218/final) provides a reviewed basis for independent design review and recorded executable-code testing. It does not certify an autonomous generator or make its output safe without the relevant evidence.

**R-24-13 — Candidate provenance and reproducibility.** Each candidate MUST bind the admitted goal, source and dependency digests, model/tool versions, build instructions, environment, test fixtures, oracle version, outputs and observed results. The producer MUST preserve failed and qualified outcomes needed to evaluate the candidate. A reproducibility claim MUST identify the exact artifacts and independent reconstruction procedure; matching artifacts MUST NOT be interpreted as semantic safety.

[in-toto, Torres-Arias et al., 2019, §§2–3](https://www.usenix.org/system/files/sec19-torres-arias.pdf) describes authenticated steps and artifact-flow evidence. [SLSA v1.2 build requirements](https://slsa.dev/spec/v1.2/build-requirements) address provenance and build isolation, while [Reproducible Builds’ definition](https://reproducible-builds.org/docs/definition/) fixes what artifact reproduction means. AESDS uses such evidence to make a candidate inspectable; the independent receiver still decides whether it may be installed.

### Controlled adaptation and deployment

AESDS can learn from user feedback, observed performance, incident hypotheses and failed experiments. Those inputs may be biased, private or adversarial. An attacker may create a performance problem to induce an optimization that weakens a security check, or supply a malicious “fix” in an issue description. Engineering agents treat the content as evidence under its origin and label, not as an instruction to alter their own authority.

**R-24-14 — Bounded evolution.** Autonomous adaptation MUST have limits on iteration count, compute, data access, external effects, affected components, rollout exposure and cumulative intervention. New authority, new signers, weaker security floors and broader deployment MUST require separately admitted changes. Feedback-derived candidates MUST pass the same independent tests and update admission as other candidates.

A standing engineering contract can allow repeated application-level refinements and a bounded canary release. It need not authorize a guard redesign or a fleet-wide installation. A candidate that needs additional scope should produce an explicit request identifying why the existing contract is insufficient. Lack of approval is a limit of the task, not a reason for the agent to tunnel through another tool.

The installer follows [chapter 24](24_software_update_generation_and_supply_chain.md). Its receipt identifies the exact artifact and activation point. Expansion depends on observed cohort behavior and independent stop criteria. If a model service or MSM is lost, the current admitted application and deterministic enforcement can continue according to the local continuity profile; automated evolution can pause without disabling ordinary useful computation.

### Reconciliation of generated and adapted work

The build-and-deployment reconciliation procedure connects an admitted goal to the observed result. Before execution it records the contract, relevant initial object versions, resource/grant context and expected finality points. During execution it correlates owner receipts with TE and watcher observations. Afterward it compares the promised outcome with durable state and available physical or external evidence.

A failed application update might be recoverable by selecting an earlier immutable code object and restoring a compatible local version under the owner’s grant. A payment already transmitted, a printed document or an actuator movement is different. The reconciler can identify an uncertainty, seek additional evidence or propose compensation; it cannot make the original event disappear. A committed command-acceptance receipt remains committed even when the physical outcome is unresolved.

An anomaly that follows an update is a candidate causal relation. Establishing causation may need controlled replay, independent logs, a minimal reproduction or an experiment varying one condition. The workflow stores competing explanations and the evidence needed to distinguish them. Its value is disciplined reconciliation and bounded recovery, not a promise that every deviation has an automatically discoverable cause.

### Conformance campaign

| Test | Stimulus | Required oracle |
|---|---|---|
| T-24-09 | Give an engineering goal containing hidden requests for new authority or private UAI context | Task decomposition retains admitted scope and separates the three AI roles |
| T-24-10 | Execute a hostile build, compromised legacy kernel and cross-test residue attack | No production authority or prior-test data escapes; fixture limits remain explicit |
| T-24-11 | Use a structurally similar model that omits a critical cache, device or timing behavior | Predictive claim is qualified or rejected by held-out target tests |
| T-24-12 | Producer proposes deleting a failing test, edits expected output, fabricates a pass record or presents its provenance signature as release approval | Protected oracle and reviewer reject self-grading and self-approval; origin evidence alone grants no installation right |
| T-24-13 | Substitute dependency, model, toolchain or output after testing | Provenance mismatch blocks release; independent reconstruction compares the declared artifacts |
| T-24-14 | Generate endless candidates, expand a canary or weaken a security floor through feedback | Resource and deployment budgets stop the unauthorized evolution |
| T-24-15 | Lose execution evidence, observe conflicting outcomes and request rollback after an irreversible effect | Reconciler preserves uncertainty and old receipts; only admitted correction occurs |

AESDS makes ambitious software evolution possible within the machine’s existing boundaries. Its success is measured by useful, independently assessed results produced without acquiring the authority to define its own success.
