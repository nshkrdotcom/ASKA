# ASKA v5 — AI operating environment and trusted interaction

## Keystone and the Accord interface

Keystone owns the trusted confirmation channel. The AI environment is an **authority interpreter and contract drafter**, not an authorization source. Its proposals are canonically rendered by a separately protected display/input mechanism, bound to operation ID, contract digest, recipients, cost, data selected for release, profile, and revocation/notice consequences. Prompts obtained from Wilder, embedded documents, commercial services, or civic notices have no ability to alter the approval checker.

---

## Detailed technical contract

**Requirements:** R01–R03, R05–R07, R09–R12, R17, R18, R20, R21, R23.

The native AI interface interprets requests, searches admitted context, explains alternatives, constructs application graphs, and proposes operations. Context owners decide what it may observe; admission and effect owners decide what its proposed graph may do. No security decision relies on the model's reasoning.

## Separation of roles

| Domain | Inputs and outputs | Enforced limit |
|---|---|---|
| Trusted interaction | Physical user input, protected approval display, signed intent records | Applications and AI cannot inject approval events or draw trusted indicators |
| Context owner | User-selected documents, UI views, preferences, session state | Supplies only admitted views; labels and retention follow their sources |
| Planner | Intent plus permitted context; proposes task/effect graphs | Cannot install grants, directly access devices, or rewrite policy |
| Builder | Source, dependencies, specifications; produces artifacts and optional proofs | Artifacts confer no execution or deployment authority |
| Contract checker | Immutable graph/artifact, effective grants, policy | Checks structure, bounds, provenance, and effects under a pinned semantics |
| Local orchestrators | Admitted task descriptors and reserved resources | Allocate only delegated islands and endpoints; cannot expand scope |
| Protected services | Scoped effect requests | Independently authorize current methods and commit |

The planner and builder can share a user workflow without sharing administrative keys. A management assistant runs as a separate task with separately admitted context. Prompting the personal assistant cannot give it firmware-administration rights.

## User interaction path

1. The user selects an intent and a context scope through trusted input routing. The context owner issues bounded views with source categories and integrity metadata.
2. The planner proposes a graph of computations and effects. It can ask for additional context, but the context owner supplies none until the required authority exists.
3. The checker resolves requested effects against existing task grants. For any effect outside those grants, the checker requires an explicit authorization decision. Model output supplies no permission.
4. For an action requiring approval, the trusted interaction service displays canonical parameters: recipient identity, object/version, information to be released, operation, resource/financial bounds, expiration, and relevant uncertainty. It binds approval to the immutable proposal commitment and policy version.
5. Orchestrators create cells with the admitted contract. Recipients independently validate each effect at commit. Changed parameters, destinations, or artifacts require a new authorization decision unless already covered by a bounded delegated envelope.
6. Results and receipts return through labeled channels. The planner can summarize them, while the UI lets the user inspect the actual effect receipts independently of that summary.

Routine work need not require a confirmation for every call. A user can establish a bounded standing grant, such as reading one collection and writing drafts to a named workspace. It must specify effects, recipients, lifetime, resource/repetition limits, and revocation. An instruction to “help with mail” does not silently authorize arbitrary export or deletion.

## Trusted display and input

The display service assigns surfaces to owners and constrains dimensions, rates, composition, and device access. The display enforcer prevents application pixels from covering a protected region or independently indicated approval surface. Rendering inputs contain bounded values rather than code, callbacks, or imported capabilities. Complex formatting, codecs, rendering, and application composition run in fresh confined cells. Their output reaches a separate display enforcer through a bounded surface contract.

A syntactically valid image can still deceive a human. The UI distinguishes application content from authoritative effect parameters and displays identities in an unambiguous canonical form. User misunderstanding remains possible; hardware cannot infer intent from a click. Under the trusted interaction assumptions, the AI and applications cannot forge or rebind approval.

Physical input hardware, its routing, and the approval service are part of that guarantee. A compromised input device or approval implementation is a separate failure case. Remote UI sessions require an explicitly authenticated interaction domain and cannot impersonate local physical presence where the interaction contract requires local presence.

## Graphics transformation and presentation

Each complex graphics stage receives immutable inputs, private scratch, and bounded output surfaces. It receives no ambient storage, network, administrative, or raw display-controller authority. A stage submitting output for presentation holds only a scoped surface-submission handle. Decoder, renderer, and composition cells have independent lifetimes; their scratch and retained references follow [13](13_memory_ownership_and_lifecycle.md).

The display enforcer checks surface identity and generation, immutable backing extent, format, dimensions, offsets, stride, placement, layer rights, and presentation allowance. The enforcer must reject overflow and unsupported layouts in every extent and coordinate calculation before memory access or scanout. It accepts a small fixed descriptor schema, excludes callbacks and raw command streams, and rechecks current surface ownership at presentation. Application descriptors cannot select the trusted approval layer.

While the independent enforcer holds, it must confine malformed output and a fully compromised renderer to admitted memory and presentation rights. Memory/DMA guards must bound accesses, and the actual output boundary must clip destination placement or enforce an equivalent checked mechanism. A rectangle check inside the compromised renderer cannot provide that boundary. Persistent scanout uses owned sealed buffers and retires pending reads before reuse; it does not require restarting the physical display on each frame.

The small presentation controller may remain long-lived. Its assurance record must explicitly trust and test its parser, arithmetic, memory access, and update dependencies. Compromising that controller can defeat the presentation guarantee within its reach unless another independent boundary enforces it. Complex composition across confidentiality categories requires an admitted joined context or a separately justified protected composition mechanism; sharing a display does not erase source restrictions.

## Data diodes and context observation

The target supports a one-way observation path from approved UI/context views to an isolated agent. A separate guarded proposal path carries assistance back to an untrusted application surface or to the intent checker. The two interfaces have distinct permissions. Because they carry information in both directions, the combined arrangement is not an air gap.

An observation diode prevents reverse signaling on its own physical channel. It does not decide which secrets may leave, remove malicious instructions from documents, or make a response safe. The context owner applies release/access policy before observation, and response effects pass the checker afterward. Timing and event rates remain observations requiring policy.

Sanitization can reduce format complexity or redact fields. It does not establish that natural-language content is free of prompt injection. Endpoint and effect guards must constrain a fully compromised planner exactly as they constrain any malicious component.

## Assisted release and human exposure

A planner may prepare a collaborator report, identify source versions, propose redactions, and explain a denial. Its report and explanation retain the context restrictions until an accepted release decision permits a narrower output. A confidence score or another unconstrained model's agreement is not independent release authority. Arbitrary natural-language review remains fallible, even when a trusted user approves the exact bytes.

The trusted approval surface must show the actual destination, output commitment, audience/device, reuse limits, and scope of any declassification. Display permission is distinct from permission to print, capture the screen, or copy to an external clipboard. A person permitted to view a secret can still remember or photograph it. The architecture reports that exposure and the required physical protections. Digital revocation cannot undo perception.

Useful authorized release is part of the operating environment. Test time to complete legitimate sharing and whether failures encourage removable-media workarounds, alongside the compromised-planner tests in [19](19_cross_domain_security_and_release.md).

## Confidential inference and persistent context

An agent that reads restricted context operates under its joined confinement. Its summaries, plans, embeddings, generated programs, error reports, and optimization choices inherit that restriction. A public model API is an external recipient requiring explicit disclosure permission; convenience cannot create it.

The session owns private inference state, accelerator scratchpads and memory, KV caches, and per-user adaptation. Its lifecycle controller must retire that state under the same ownership rules. A shared base model may be read-only, but confidential sessions cannot silently update globally shared weights or retrieval indexes. Any learning/export operation has an explicit state owner and flow policy. Conversation memory is a persistent object with user-controlled scope, retention, and deletion rules.

## Program synthesis and evolution

The builder emits a content-addressed artifact, dependency manifest, effect contract, provenance, test results, and any machine-checkable certificates. The checker verifies certificates under a small accepted proof system; it does not trust a model's statement that a proof passed. Runtime guards continue to confine accepted code.

Compiler correctness, contract validity, termination bounds, and functional correctness are different properties. Restricted languages and region/effect typing can simplify some obligations. The checker cannot infer correctness or termination from a generated program's short length. [CakeML](https://cakeml.org/index.html) provides a verified-compilation comparison. It does not establish user intent.

An independent deployment role authorizes the approved artifact digest. Updating the planner, checker, build system, or orchestrator follows the same separation. A model may propose a patch to itself and run isolated experiments. It cannot approve its own expanded authority or replace the checker evaluating the patch.

[CaMeL](https://arxiv.org/abs/2503.18813v2) investigates separation of control/data flow and capability-like policies around an LLM. Its software threat model and benchmark results provide comparisons. They do not prove a hardware OS design. ASKA extends the separation obligation through physical execution, persistent effects, trusted interaction, and update authority.

## Acceptance tests and unresolved work

Give the attacker full control of the planner before the test starts. Test context overreach, cross-user cache reuse, secret-dependent code export, forged approvals, changed recipients after approval, malicious renderer output, and self-deployment. Permitted drafting and search must still work under the same policy.

The operating environment is incomplete until ordinary users and developers can accomplish tasks without broad administrative grants. Research must measure authority requested per task, false denials, comprehension of effect previews, context leakage, workflow latency, and recovery when the model fails. Deterministic revocation and recovery controls must remain available during an AI outage. They complement the native AI interface rather than replacing it.
