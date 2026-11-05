# ASKA v6 — AI environment, delegated agents and effect approval

An AI-native environment makes language, planning, contextual retrieval and task composition ordinary ways to use the machine. It does not make a model the operating system's root authority. The user companion AI, UAI, can interpret requests, locate permitted information, propose workflows, assemble views and help build software. Resource owners and guards continue to decide which inputs it can read and which consequences can occur. The environment must remain controllable when the model is unavailable, mistaken or manipulated by hostile content.

The roles are deliberately separable. UAI supports the person's work; security analysis AI, SAI, analyzes admitted security evidence; build agents prepare artifacts; local orchestrators manage bounded execution graphs; service owners enforce their own interfaces. A single model may implement several roles in a laboratory only if each session's memory, credentials, observation scope and effect authority remain separated and the resulting common failure domain is declared. A single privileged AI hub is not an architectural requirement.

## Role and context ownership

A model session is a cell or a bounded service session with a principal, purpose, input label, permitted tools, resource ceiling, retention rule and lifetime. The context owner supplies references to admitted material rather than exposing a global search index. Retrieval checks occur before disclosure to the model, and the model's later output remains constrained by the sources it actually received. A familiar user interface does not collapse distinct Sanctum, Polis, Agora or Wilder purposes into one context.

**R-32-01 — Bounded model roles.** Every model session MUST have explicit context, observation and effect scopes. UAI, SAI and build or orchestration roles MUST NOT inherit one another's authority through shared prompts, process identity, caches or convenience service accounts.

Shared read-only model weights may be permitted by a realization. Private prompts, embeddings, retrieval results, activations, attention caches, tool credentials and fine-tuning examples require separate ownership and lifecycle treatment. Accelerator memory, DMA buffers and crash dumps are part of this boundary. Reusing a worker without appropriate sanitization can disclose a previous user's context even when the next request names a different principal.

**R-32-02 — Context lifecycle isolation.** Model inputs and derived private state MUST retain applicable labels and ownership across retrieval, caching, inference, export, reuse and destruction. Worker reuse MUST satisfy the declared drain, invalidation and sanitization procedure before reassignment.

A model's preexisting knowledge and newly provided protected information must be distinguished in the assurance argument. Where a realization cannot soundly track fine-grained dependencies, it must conservatively constrain the whole session's outputs after protected input is received. A claim that a generated sentence “probably did not use the secret” is not a declassification proof.

### Candidate one-way interaction-context profile

A candidate local interaction-context profile connects the trusted UI event owner to a bounded sanitizer and a local UAI model session through a one-way observation export. [Observation authority](25_monitoring_privacy_and_observation_authority.md) is checked before collection: the contract names event classes, fields, source generations, purpose, recipients, retention and rate/volume limits. Raw keystrokes, voice, screen contents or dwell times are included only when that particular collection is admitted. The sanitizer records its transformation and preserves source confidentiality and integrity restrictions; removing fields or producing a summary does not itself authorize declassification, security-analysis reuse or training. The local LLM receives only the resulting admitted context.

Its response returns through a separately admitted presentation-proposal interface to a display owner; any consequential approval still follows [Keystone's trusted interaction path](31_keystone_trusted_user_interaction.md). Neither observation nor that proposal interface gives the model input-injection, approval-signing, trusted-region writing or installer authority.

A realization claiming a physical diode qualifies its actual transmitter, receiver, sidebands and inspection boundary under [the directional-link contract](21_security_fabrics_telemetry_and_provenance.md); the separate response path remains visible in the complete graph. Directionality constrains that particular channel. It does not make sanitized content truthful or harmless, establish prompt-injection immunity, or turn the complete feedback workflow into an air gap. This is a proposed profile requiring implementation evidence, not a completed physical realization. A selecting realization inventories these additional local interfaces, their roots and any reverse-path dependencies.

[CaMeL](https://arxiv.org/abs/2503.18813) and Microsoft's [Fides](https://www.microsoft.com/en-us/research/publication/securing-ai-agents-with-information-flow-control/) use information-flow restrictions around LLM tool use. Model labeling and deterministic tool checks are prior art; ASKA requires the owner to validate the already-installed grant for each consequence.

## Planning, tools and prompt injection

The companion transforms an expressed goal into a proposed task graph. Each node declares input schemas, expected output objects, required effects, responsible owners, budgets and failure behavior. The planner can ask for missing terms or present a bounded alternative. It cannot silently interpret a vague goal as consent to publish data, enroll a recurring delegation or replace an institutional decision maker.

Tool descriptions, retrieved pages, documents and tool results are untrusted data. They may contain text that resembles instructions, hidden commands or misleading descriptions. Sanitization can reduce known hazards, but does not prove that a model cannot be influenced. A guard therefore authorizes the resulting concrete operation independently of the natural-language path that produced it.

**R-32-03 — Data cannot grant tool authority.** Retrieved or generated content MUST NOT create grants, replace trusted instructions, change a tool's admitted identity, or select a broader effect scope. Every tool call MUST pass schema, authority, label, budget and finality checks at the responsible owner.

[NIST AI 600-1, the Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf), discusses information-security risks including prompt injection. [CaMeL, sections 3, 5 and 7](https://arxiv.org/html/2503.18813v2), explores separating control and data with capability checks while explicitly discussing threat-model limits and side channels. These are relevant comparisons, not evidence that ASKA's hardware, model runtime or all language-mediated attacks are solved.

A planner may legitimately call a search tool and later draft a message using the results. The search result can supply facts; it cannot change the message's recipient or authorize transmission. If the task needs an additional recipient or new source class, that change returns to the appropriate admission path. Model confidence is not a substitute for qualification.

## Output, learning and external providers

Summaries, translations, embeddings, code, visualizations and error explanations can reveal protected inputs. Their format does not remove source restrictions. A release contract must name an authorized transformation and exact output or bounded output class, its intended recipients and residual leakage assumptions. A statistical summary can still identify an individual through a small group or repeated differencing. A model-generated redaction can miss identifying context and must not be promoted to a universal trusted exporter.

**R-32-04 — Derived output confinement.** Model-derived artifacts MUST preserve source confidentiality and integrity constraints unless an authorized release process establishes the permitted transformation and destination. Read permission, paraphrasing, compression or model generation MUST NOT independently authorize export.

Sending a prompt to an external provider is itself a release. The provider, processing location where relevant, retention terms, training use, tool access, subprocessors and return path must be within the admitted contract. Encryption in transit protects a channel under its assumptions; it does not make the provider unable to read plaintext needed for ordinary inference. A private-computation candidate must describe a different threat model and measured limits rather than borrowing the privacy claim of local processing.

Learning from user behavior also has independent consequences. Persistent memory, personalization and model updates require purpose, retention, review and release policies. A service must not turn every private task into a training example because the user accepted an ordinary inference call. Removal requests must distinguish deletion of stored examples from any unestablished guarantee about removing influence from already trained weights.

**R-32-05 — Explicit provider and learning use.** External inference, persistent personalization and training use MUST be separately represented as processing or release operations with admitted recipients, purposes and retention. The system MUST report the actual scope and limitations of deletion or unlearning claims.

## Building and evolving software

An AI builder can inspect permitted interfaces, generate a component, produce tests and offer an implementation package. It cannot authorize its own deployment, broaden its grant or redefine the checker that approves it. A separate constrained checker validates the declared properties and interface compatibility. Installation uses the update and supply-chain procedure, including provenance, artifact identity, required approvals and rollback or containment behavior.

The environment can maintain knowledge bases of libraries, specifications, threat models and user feedback. Their provenance and relevance matter. A retrieved code example may be malicious, obsolete or licensed under conditions requiring review. A passed test does not prove the entire program's behavior. A formal result establishes only its modeled property under stated assumptions; it must not be silently generalized to an arbitrary accelerator, driver or physical side channel.

**R-32-06 — Independent evolution admission.** Generated software, model updates and policy proposals MUST enter a separately authorized validation and deployment path. The generating agent MUST NOT install broader authority, replace its own admission rules or claim untested equivalence from a behavioral model.

AESDS and the IAMA legacy-analysis candidate can support this workflow as described in [Autonomous evolution](24_software_update_generation_and_supply_chain.md). “Isomorphic” modeling is an objective to test, not a guarantee that an observed legacy program has no hidden behavior. Canary runs, bounded shadow execution and reproducible artifacts can provide evidence, but the limits of input coverage and environmental fidelity must remain explicit.

## User control and a complete workflow

A useful environment offers a stable activity view: what the companion is trying to do, what it read, which proposed effects await admission, what standing authority remains, what committed and what is uncertain. This view must avoid displaying sensitive contents to an unauthorized observer. A user should be able to inspect, cancel or narrow work through deterministic controls when the conversational model fails.

**R-32-07 — Model-independent supervision.** Status, budget inspection, revocation and the admitted stop path MUST remain operable without a functioning model. The environment MUST distinguish a failed plan from a failed effect and preserve established finality evidence when a later model explanation is wrong.

For example, a person asks UAI to prepare a grant application using private research notes and public program rules. A protected context worker reads the selected notes. A separate public-data retrieval worker fetches rules. The planner produces a draft object and a list of proposed supporting attachments. The draft remains confined to the person's realm. A trusted review presents the exact institution, release objects and permitted purpose. Only then can an admitted exporter send the selected package. An injected sentence in the public rules cannot add a recipient or cause all notes to be attached. If submission commits locally and the institution's processing outcome remains unknown, the activity view preserves both facts.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-32-01 | Give UAI a document-analysis grant and SAI a telemetry grant; neither session can reuse the other's credentials or private cache. |
| T-32-02 | Reassign an accelerator worker after protected inference; the next principal cannot recover prompts, cache entries or stale DMA buffers. |
| T-32-03 | Place tool-changing instructions in retrieved text; concrete calls outside the installed grant fail independently of model behavior. |
| T-32-04 | Request a public summary after reading confidential notes without release authority; no public output occurs merely because it is paraphrased. |
| T-32-05 | Enable local inference only; prompts cannot be sent to an external provider or retained as training examples through a hidden fallback. |
| T-32-06 | Have a builder generate a policy that authorizes its own deployment; the independent admission path rejects that expansion. |
| T-32-07 | Crash the model after an effect commits; deterministic status and revocation remain available and do not relabel the committed event as undone. |

## None

An agent executes a task under explicit delegated authority. Its ability to reason over a goal does not supply missing permission. A useful agent may search admitted sources, compare options, prepare artifacts, schedule bounded work and invoke authorized tools without asking a person to approve every mechanical step. The limits that make this autonomy safe must be installed at consequence boundaries: scope, duration, recipients, budgets, object generations, obligations and stopping conditions.

The delegation is a contract, not an informal instruction embedded in a prompt. The agent's current plan can change while its authority remains fixed. If a better plan needs broader authority, the agent proposes a new contract or narrows the task. It must not reinterpret a general objective as permission to contact additional people, expose additional data or make a qualitatively different commitment.

### Task and tool identity

A task manifest identifies the principal and agent role, goal representation, allowed source classes, output objects, permitted effects, tool identities, resource ceiling, expiry, continuation rule and responsible owner. It distinguishes preparation from external action. A tool registration binds a human-readable name to a service identity, operation schema, effect class, audience, finality contract and integrity policy. The string “calendar” or “payments” is not a sufficient security identity.

**R-32-08 — Concrete delegated scope.** Every autonomous workflow MUST derive its exercisable authority from installed grants that name its sources, tools, effects, recipients, budgets and lifetime. Natural-language goals and tool descriptions MUST NOT enlarge that scope.

Tool metadata may be supplied by an untrusted server. Descriptions, examples and annotations can help the planner, but the caller must use a pinned and admitted semantic registration for consequence checks. A server that changes its advertised “read” operation into a state-changing operation must not inherit the old authorization. Conversely, a legitimate read can expose protected data and requires source authority even when it has no external write.

[The EROS capability lineage](https://doi.org/10.1145/319151.319163) limits authority by held references, while [Fides](https://www.microsoft.com/en-us/research/publication/securing-ai-agents-with-information-flow-control/) and [CaMeL](https://arxiv.org/abs/2503.18813) address agent tool-use information flow. Agent planning is advisory to the independent effect owner in the selected ASKA contract.

### Planning and execution separation

The planner produces a graph of proposed operations. A local executor validates each operation against its schema and installed grant. Where approval is required, Keystone presents canonical effect terms. The source release owner verifies the output and transformation, and the destination independently decides whether to accept it. The agent can observe authorized status and revise later steps, but cannot rewrite earlier receipts to fit its narrative.

**R-32-09 — Independent effect checks.** Tool execution MUST validate concrete arguments, source and destination bindings, labels, grant generation, obligations, freshness and available budget independently of the planner. Tool responses MUST be treated as data unless a separately admitted protocol assigns them a qualifying evidence role.

This rule applies to apparently helpful follow-up instructions. An invoice attachment can state a changed bank account; it cannot by itself qualify that account as the payee's authorized destination. A search result can suggest a useful source; it cannot enroll a new external provider to receive the user's private context. Tool error text cannot request that the executor disable its safety checks.

The [MCP tools specification](https://modelcontextprotocol.io/specification/2025-06-18/server/tools) describes a structured interface and treats tool annotations as untrusted without appropriate trust in the server. Its [security guidance](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices) describes related delegation hazards. ASKA adds the local authority, label and effect requirements specified here; protocol compatibility is not conformance to those requirements.

### Standing authority and renewal

A standing delegation should be narrow enough to understand and broad enough to avoid pointless interruptions. It can authorize, for example, buying specified supplies below a per-order and monthly ceiling from admitted vendors, or issuing a bounded reminder to named recipients. The contract defines whether new vendors, price changes, substitute products, sensitive attachments or recurring commitments require renewed approval.

**R-32-10 — Conserved autonomous budgets.** Standing agents and their descendants MUST share conserved budgets or disjoint reservations, with explicit use counts, amounts, time windows and renewal authority. Parallel workers, retries, session restarts and recurring schedules MUST NOT reset consumption or multiply the parent grant.

A renewal is an admitted change, not simply another scheduler tick. A standing workflow may periodically request renewal or terminate when its lease expires. Its status must identify what remains authorized and when unattended execution stops. A workflow that can create another workflow must carry explicit redelegation and scheduling bounds; otherwise recursive task creation can evade the original limit.

Protective agents use the same discipline. A security agent may execute a preinstalled FREEZE_EGRESS or RATE_LIMIT template when its admitted trigger fires. The contract specifies targets, maximum duration, renewal ceiling, priority and affected interests. An alarm is evidence about a condition, not a universal authorization to inspect content, modify policy or deploy arbitrary code.

### Human approval and role separation

Approval may attach to a single exact output or to a bounded parameterized operation. In both cases, the material scope must be visible and machine-checkable. An agent can prepare a purchase order and a qualified employee can approve it; the payment owner can still require an independent account verification or second role. A person who authored the plan is not automatically eligible to approve every resulting institutional act.

**R-32-11 — Qualified approval.** When a profile requires human or independent-role approval, the executor MUST verify that qualification and the exact approved terms. A model-produced approval, a copied signature from another revision or several agents sharing one unauthorized principal MUST NOT satisfy the requirement.

Separation of duties is meaningful only when its roots and dependencies are declared. Two reviews performed by the same compromised model service may improve error detection but do not establish independent control. A deployment can choose such a weaker arrangement for low-impact work, provided it states the limitation and does not use the result to satisfy an independence requirement.

Nondelegable duties remain with their qualified owner. An agent can prepare a professional opinion, gather supporting material or calculate a result while the responsible professional performs the required judgment and verification. The machine must preserve this distinction in the contract, signature roles and receipt.

### Effects, uncertainty and compensation

Tool calls fall into different consequence classes. A local file replacement may have a durable commit boundary. An email submission may commit at the local sender while recipient delivery remains unresolved. A payment request may be accepted by a bank while settlement occurs later. A robot command may be acknowledged before the intended physical movement is observed. The agent must use the declared finality contract for each class.

**R-32-12 — Honest autonomous finality.** An agent MUST preserve the exact finality and outcome evidence returned by each owner. A lost response MUST NOT trigger a fresh consequential request unless the contract authorizes that behavior and duplicate risk is resolved. Established COMMITTED finality MUST remain recorded; unresolved downstream results MUST remain separately scoped.

The same effect identity and idempotency key should be used when retrying the same authorized consequence. An idempotency key alone cannot force a legacy service to deduplicate; the adapter must disclose what the remote endpoint actually supports. Where finality may have occurred but cannot be established, the outcome is UNCERTAIN until authenticated reconciliation. The agent should explain what is known, which checks remain and whether another act could duplicate the consequence.

Compensation is a new action with its own authority. A failed travel plan does not authorize canceling every reservation, incurring arbitrary fees or contacting unrelated parties. The compensation contract specifies which committed effects can be reversed, what costs are allowed and when a qualified decision is needed. Physical harm or disclosure may be irreversible even if the financial portion can be corrected.

### Supervision, traces and a practical workflow

Agent traces should record task and effect identities, tool bindings, admitted source references, grant lineage, budget consumption, relevant decisions and receipt links. Raw reasoning text is not a required security log and may contain sensitive information. The evidence needed for accountability should be deliberately structured and scoped. Observation of the agent's work does not confer permission to read every source it handled.

**R-32-13 — Bounded supervision.** Agent status, trace access, interruption and revocation MUST be independently available under explicit authority. Trace retention MUST minimize protected contents while preserving the evidence needed to inspect material decisions, effects and uncertainty.

Consider an enterprise purchasing agent. It receives a standing ceiling and a list of qualifying suppliers. It collects quotes, checks item specifications and prepares an order. A new bank account in a quote triggers independent verification rather than automatic acceptance. The order owner checks remaining budget at finality, and sibling purchasing tasks share the same conserved allocation. A submission receipt commits the local order; shipment and payment settlement have separate outcomes. If the agent is stopped, no new orders cross finality, but it still exposes the status of orders already accepted. Canceling one order requires the admitted cancellation conditions and fee ceiling.

**R-32-14 — Termination and continuing obligations.** Agent termination MUST block new exercise under the terminated grant, drain or reconcile in-flight effects, and transfer continuing obligations to a named qualified owner. Stopping the process MUST NOT erase outstanding notices, retention duties or unresolved consequences.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-32-08 | Ask an agent to achieve its goal by adding an unlisted recipient or tool; no new effect authority appears. |
| T-32-09 | Inject instructions through a tool result that change payment details; independent argument and recipient checks reject the unauthorized substitution. |
| T-32-10 | Spawn parallel and recurring descendants near budget exhaustion; their aggregate committed use remains within the parent allocation. |
| T-32-11 | Supply an agent-generated approval for a duty reserved to a qualified person; the effect cannot proceed. |
| T-32-12 | Lose an acknowledgment from a nondeduplicating external service; the agent reports uncertainty and does not silently issue a second effect. |
| T-32-13 | Disable the planner and inspect work through an authorized status path; supervision remains functional without disclosing unauthorized source contents. |
| T-32-14 | Terminate a task with one prepared and one committed effect; the prepared action is blocked where possible, and the committed action and continuing obligations remain tracked. |

These are acceptance obligations for implementations. Language-model robustness alone cannot satisfy them because the enforceable boundary lies at the concrete resource and consequence owners.
