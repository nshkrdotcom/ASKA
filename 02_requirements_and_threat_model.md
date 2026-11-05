# ASKA v6 — Requirements and threat model

**Status:** proposed normative target. Requirements describe obligations; they do not certify an implemented machine.

## 1. Normative coverage

The requirements below define system-wide obligations. Subsystem chapters refine them into component interfaces and acceptance oracles; the complete canonical register of both global and subsystem requirements is [Chapter 61](61_requirement_decision_evidence_traceability.md). Its entries identify each owner, enforcer, assumption, test and evidence status. Requirements are design targets unless an attributable conformance record establishes otherwise.

The protected machine must remain useful under bounded adversarial conditions. Denying every operation is not evidence of successful service. A correct authority check can coexist with malicious permitted output, observer blindness, an unavailable remote service or an unmodeled physical channel. Those outcomes must be reported separately.

## 2. Adversary inventory

| Attacker granted at campaign start | Permitted attacks | Trusted boundary whose survival is being tested |
|---|---|---|
| Privileged guest/kernel | Arbitrary instructions, aliases, descriptors, retries, resource exhaustion | External identity, memory/device and effect guards |
| Device/accelerator controller | Malformed DMA, peer requests, interrupt floods, stale completions | Assignment, DG and physical output owners |
| Route/transport controller | Reorder, drop, replay, redirect, metadata observation | Mandatory egress, record integrity and independent receiver |
| Ordinary scoped administrator | Change its own admitted configuration; abuse legitimate rights | Other installation, recovery and realm roots |
| LSM | False alerts, suppressed records, malicious proposals and report payloads | Watcher paths, local EO, peers and MSM receive boundary |
| MSM | Defective signed packages, malformed distributions, report suppression | Local LSM admission, WM-M and separate channels |
| WM-L or WM-M | Fabricated oversight and attempts to change policy | Local roots and response owners outside watcher authority |
| Security AI | Poisoned conclusions, global shutdown proposal, covert report content | Standing-grant scope and release policy |
| User companion/build agent | Prompt injection, malicious tools/code, approval substitution | Context owner, K, independent reviewer and installer |
| Signed artifact producer | Correctly signed but unsafe code/rules/model | Separate acceptance, canary, guard and recovery boundaries |
| Authorized recipient/insider | Malicious in-scope use, outputs, media/photographic disclosure | Exact granted boundary; no claim of forced forgetting |
| Physical/management adversary | Cables, debug, BMC, reset, power or probes as selected | Precisely declared physical profile, with failures outside it explicit |

Compromising a protected guard is a different case from compromising the guest it contains. The campaign must then identify which outer boundaries survive and which local properties fail. A malicious fabrication or invasive probe is included only in a profile with corresponding evidence; omission from an initial model is not proof of resistance.

## 3. Safety, liveness and uncertainty

A consequential effect requires the common predicate in [Chapter 05](05_unified_execution_data_and_effect_contract.md). Safety is conditional on the named enforcement and observation assumptions. Liveness additionally requires admitted offered load, surviving resource capacity, scheduling fairness and an available path where remote work is necessary. Arbitrary permanent packet loss or total power loss defeats unconditional remote progress.

Missing observation is `unknown`, not proof that nothing happened. A guard denial establishes a particular rejected operation, not absence of all compromise. A signature establishes an authenticated assertion under key assumptions, not truthful data, lawful authority or safe execution. [Chapter 03](03_assurance_trust_and_failure_domains.md) owns these evidence distinctions.

## 4. Threat-profile exclusions

An implementation manifest names whether it covers malicious guest software, arbitrary bus transactions from an untrusted compute engine, malicious observer software, malicious privileged sensor firmware, a compromised signer, shared management failure, physical rewiring before the last guard, invasive probing after it, side channels and fabrication subversion. Every included case needs surviving trusted functions and an independent oracle.

For example, a cable attached to an intact guarded interface must not create authority. A probe wired directly to plaintext after the last guard can defeat confidentiality if invasive access is outside the profile. A shared package reset can invalidate supposedly independent watchdogs. The report describes these failures as limitations of its physical boundary, not successful containment.

## 5. Acceptance discipline

Each test includes a permitted positive case, the forbidden consequence, the attacker's starting rights, an observable oracle and a weakened variant that can demonstrate the oracle detects the failure. Hardware tests are specified here; this document does not assert their execution. Finite semantic demonstrations and their exact scope are recorded in [Chapter 56](56_conformance_tests_and_vectors.md). Detailed cross-layer cases appear in [Chapter 54](54_end_to_end_traces_and_incident_walkthroughs.md).

The global requirements below are intentionally stable in meaning across physical, civic, application and security subsystems. A domain-specific convenience cannot grant an exception. If a mechanism is unknown, its implementation status remains unestablished and the research program names the experiment required.

## Normative requirements and acceptance obligations

**R-02-01 — Complete mediation.** Every consequential memory, device, message, release and effect path MUST cross its required protected owner checks.

**Acceptance T-02-01:** Exercise alternate descriptors, helpers, management queues and physical ports; no unchecked consequence is permitted.

**R-02-02 — Granular applications.** Native applications MUST be decomposable into bounded components without requiring a broadly privileged shared runtime.

**Acceptance T-02-02:** Run a document workflow with separate hostile parser and persistent owner; unrelated objects remain inaccessible.

**R-02-03 — Physical cross-trust resources.** Native mutually distrusting execution MUST use assigned physical execution and writable-memory scope.

**Acceptance T-02-03:** Inspect allocation and wiring; a shared logical address-space partition cannot satisfy a physical-separation claim.

**R-02-04 — Declared physical-purpose separation.** Native physical-purpose claims MUST identify dedicated paths and distinguish all weaker shared-carrier profiles.

**Acceptance T-02-04:** Substitute a VLAN/shared controller and require explicit claim downgrade, not an unchanged physical-independence label.

**R-02-05 — Cross-representation continuity.** Restrictions MUST survive serialization, copying, rendering, compilation, AI processing and device transformations.

**Acceptance T-02-05:** Attempt to launder a restricted object into public logs, pixels, generated code and ciphertext; release remains required.

**R-02-06 — Independent receiver authority.** Protected receiving and publication MUST require the destination owner’s own live permission.

**Acceptance T-02-06:** Deliver a sender-valid message after destination withdrawal; protected publication is denied.

**R-02-07 — Temporal ownership.** All handles, aliases and in-flight operations MUST remain bound to live generations across reuse.

**Acceptance T-02-07:** Delay an old DMA/message/cache writeback through reuse; it cannot access the new occupant.

**R-02-08 — Crash-defined persistence.** Persistent operations MUST have owners, explicit durability contracts and truthful crash outcomes.

**Acceptance T-02-08:** Crash at prepare, flush and commit boundaries; recovery distinguishes durable state from acceptance or uncertainty.

**R-02-09 — Bounded native AI.** AI MUST support native interaction and orchestration while lacking any implicit ability to create consent, release or installation rights.

**Acceptance T-02-09:** Compromise the companion with tool instructions; valid narrow work can continue but broader context or effects are denied.

**R-02-10 — Scoped administration.** Policy, allocation, update, recovery and observation administration MUST have separate scoped rights.

**Acceptance T-02-10:** Compromise one role and enumerate attempted writes to other roots; only admitted scope is reachable.

**R-02-11 — Common-cause dependencies.** Independence claims MUST include firmware, keys, management, debug, package, clock/reset and facilities.

**Acceptance T-02-11:** Fail a shared dependency and withdraw every dependent claim together.

**R-02-12 — Bounded useful progress.** Controllers MUST bound adversarial work and preserve specified useful service under admitted load and surviving-resource assumptions.

**Acceptance T-02-12:** Flood first contact while running valid established work; measure completions, loss and starvation against declared bounds.

**R-02-13 — Separated security outcomes.** Results MUST distinguish prevention, containment, permitted-authority abuse, propagation and service loss.

**Acceptance T-02-13:** Authorize a malicious but in-scope result and classify it as abuse, not a boundary escape or a safe application.

**R-02-14 — Explicit realization gaps.** A realization MUST trace unsupported target requirements and MUST NOT silently redefine them to match a weaker implementation.

**Acceptance T-02-14:** Compare each claimed profile dimension to evidence; missing physical enforcement remains unestablished.

**R-02-15 — Native infrastructure independence.** Native service semantics MUST be expressible without mandatory ambient POSIX, global sockets, shared kernel or cloud authority.

**Acceptance T-02-15:** Run a native object/effect workflow without a legacy host; compatibility adapters remain optional confined clients.

**R-02-16 — Attributable claim scope.** Every evidence claim MUST identify an attributable artifact, observation model and status.

**Acceptance T-02-16:** Attempt to label a design diagram, patent title or vendor benchmark as an ASKA result; reject the promotion.

**R-02-17 — Spatial and temporal memory semantics.** Execution MUST define memory bounds, provenance and lifetime revocation, including relevant cache/device state.

**Acceptance T-02-17:** Test in-cell stale references separately from whole-cell reuse; a tag bit or reset alone is insufficient evidence.

**R-02-18 — Whole-application adversaries.** Conformance campaigns MUST test useful complete applications with malicious components and alternative paths.

**Acceptance T-02-18:** Compromise parser, renderer, route controller and worker; all import/output variants remain confined while authorized cases complete.

**R-02-19 — No authority from membership.** Location, attachment, network admission, institutional affiliation or device identity MUST NOT by itself grant operations.

**Acceptance T-02-19:** Attach an authenticated device or community node and attempt foreign data/effects; require independent grants.

**R-02-20 — Distinct operation rights.** Read, compute, store, release, transport and receive rights MUST remain independently scoped.

**Acceptance T-02-20:** Give read authority only, then request print, backup and transmission; all absent rights are denied.

**R-02-21 — All output channels.** Every modeled information/effect channel MUST appear in the path and release register.

**Acceptance T-02-21:** Test screen, print, media, debug, witness, telemetry and actuator paths, not only the network.

**R-02-22 — No unilateral forbidden bridge.** Ordinary users, workloads and scoped administrators MUST NOT create a forbidden crossing by adding routes or cables at guarded interfaces.

**Acceptance T-02-22:** Add a dual-homed peripheral or cable before the last guard; no new effect authority appears.

**R-02-23 — Exact approved release.** Independent release enforcement MUST bind approved output or a verified transform contract to destination, lifetime and cumulative limits.

**Acceptance T-02-23:** Substitute content or destination after approval and repeat outputs beyond budget; deny the attempts.

**R-02-24 — No intermediary authority union.** A parser, transformer, relay or gateway MUST NOT inherit both domains’ rights merely by participating.

**Acceptance T-02-24:** Compromise each crossing intermediary separately and attempt transparent arbitrary bridging; reject outside the one admitted crossing.

**R-02-25 — Claim is evidence.** A signed claim MUST remain evidence until an applicable contract and local grant derivation admit the effect.

**Acceptance T-02-25:** Present a signed institutional claim without admitted terms; no installed authority is created.

**R-02-26 — Complete contract context.** Contracts MUST bind profiles, purpose, recipient, exclusions, evidence and enforceable obligations.

**Acceptance T-02-26:** Remove a required profile, recipient or notice condition; compilation fails rather than broadens the operation.

**R-02-27 — Nonexpanding installed grants.** Compiled/delegated grants MUST be local, bounded and no broader than all required parent authority.

**Acceptance T-02-27:** Copy a grant or widen one field; protected use counts and scope remain unchanged.

**R-02-28 — Qualified receipts.** Receipts MUST distinguish attempts, protected commits, external acceptance and unknown outcomes.

**Acceptance T-02-28:** Lose an acknowledgment after possible execution; report uncertainty instead of fabricated failure or success.

**R-02-29 — Independent societal purposes.** Wilder activity MUST NOT create Sanctum, Polis or Agora effects without an admitted crossing.

**Acceptance T-02-29:** Compromise Wilder parser and NIC, then attempt private signing, ballot alteration and payment; independent owners deny.

**R-02-30 — Canonical intent approval.** Keystone approval MUST bind the actual canonical parameters installed at the effect owner.

**Acceptance T-02-30:** Substitute recipient, amount, release digest or profile between display and installation; approval binding fails.

**R-02-31 — Profile-scoped civic authority.** Civic and legal authority MUST be evaluated for applicability, scope, contest and recipient under a declared profile.

**Acceptance T-02-31:** Submit an authenticated overbroad request and require scoped denial, suspension or independently admitted extract.

**R-02-32 — Nonconjurable access.** A legal or administrative request MUST NOT be treated as manufacturing unavailable plaintext, keys or access beyond the machine’s admitted capabilities.

**Acceptance T-02-32:** Request an unavailable key or erased object; return a qualified UNAVAILABLE outcome without a hidden bypass.

**R-02-33 — Notice and challenge obligations.** Required notice, appeal, stays and suspension MUST be represented with owners and truthful delivery states.

**Acceptance T-02-33:** Lose connectivity or receive a valid stay before finality; do not claim delivered notice or bypass the stay.

**R-02-34 — Private witness evidence.** Steles MUST receive only admitted evidence and MUST preserve confidentiality and correction semantics.

**Acceptance T-02-34:** Request raw private logs using a witness credential; reject absent independent source authorization.

**R-02-35 — No silent assurance downgrade.** A weaker path, executor or recovery profile MUST be explicitly admitted where policy permits it.

**Acceptance T-02-35:** Attempt automatic cloud fallback during a private link outage; reject or require a distinct disclosed contract.

**R-02-36 — Context-bound relationships.** Family, care, professional and organizational delegation MUST be scoped to context, capacity and nondelegable exclusions.

**Acceptance T-02-36:** Present kinship or job title alone to access protected records; require appropriate applicable authority.

**R-02-37 — Bilateral disclosure and acceptance.** Source disclosure and recipient acceptance MUST be independently verifiable even when their identities share an issuer.

**Acceptance T-02-37:** Use a valid same-organization sender to force receiver publication; absence of receiver policy denies.

**R-02-38 — Public-service continuity.** Protected civic services MUST have declared reserved resources and local failure behavior under bounded encounter threats.

**Acceptance T-02-38:** Flood Wilder and verify reserved local civic work; separately report shared-upstream loss.

**R-02-39 — Carriage without civil power.** Community, regional and upstream carriers MUST NOT gain authority over source contracts or destination effects.

**Acceptance T-02-39:** Compromise a relay and splice path/recipient evidence; effects remain bound to independently admitted identity and purpose.

**R-02-40 — Reviewable scoped change.** System changes MUST have typed scope, reviewable provenance, currentness and independently recoverable installation boundaries.

**Acceptance T-02-40:** Compromise an application update role and attempt guard/watcher/root replacement; enforce artifact-class and root separation.

**R-02-41 — Distinct prevention and observation.** Mandatory guards, passive/active observation and watcher functions MUST have separate contracts and visibility limits.

**Acceptance T-02-41:** Remove observer input while exercising guards; record lost detection without falsely claiming the guard has disappeared or complete observation persists.

**R-02-42 — Observer adversary cases.** Each LSM, MSM, watcher and analyzer MUST be separately evaluated as fully malicious within its scope.

**Acceptance T-02-42:** Fabricate alerts, suppress evidence and attempt watcher reprogramming; neither new policy rights nor universal response become available.

**R-02-43 — Physical directional distribution.** The selected high-assurance MSM-to-LSM configuration edge MUST be physically one-way with separate admitted reports.

**Acceptance T-02-43:** Test reverse signaling and malicious allowed-direction packages; direction and receiver safety are assessed independently.

**R-02-44 — Evidence completeness limits.** Telemetry MUST identify protected source, sequence, loss, sampling, epochs and observation scope.

**Acceptance T-02-44:** Drop, replay and reorder signed events; receiver identifies gaps/uncertainty without treating silence as proof of inactivity.

**R-02-45 — Preauthorized bounded protection.** Automatic protective effects MUST use admitted standing grants with owner, target, expiry, budget, ordering and false-alarm limits.

**Acceptance T-02-45:** Ask for global shutdown from one false alert; only permitted local finite effects can occur, with bounded renewals.

**R-02-46 — Telemetry as private effect.** Baseline and exceptional observation MUST have source authorization, data minimization, recipient permission and retention rules.

**Acceptance T-02-46:** Encode intimate activity or plaintext in a report; reject fields and recipients outside the authorized observation contract.

**R-02-47 — Signed-defect containment.** Update safety MUST remain bounded when a correctly signed artifact is defective or its producer is malicious.

**Acceptance T-02-47:** Deploy a validly signed crashing rule in an isolated cohort; independent guards and recovery continue and blast radius is measured.

**R-02-48 — Separated AI roles.** User interaction, security analysis and code generation MUST be distinct scopes; generated code cannot approve its own tests or installation.

**Acceptance T-02-48:** Give a build agent a proposed patch and a forged passing test; separate oracle/reviewer/installer reject self-authorization.

**R-02-49 — Falsifiable research independence.** Optional physical/quantum/sensing hypotheses MUST have falsifiers and MUST NOT be required for unrelated baseline safety claims.

**Acceptance T-02-49:** Fail a passive or quantum sensor hypothesis and verify that independent guard claims retain only their own proven assumptions.

**R-02-50 — Costed availability.** Evaluation MUST account for fragmentation, copies, cache/tag costs, telemetry storms, energy, recovery and false containment.

**Acceptance T-02-50:** Run mixed useful workloads and attack storms with guards enabled; report all bottlenecks and service losses without substituting invented benchmark figures.

