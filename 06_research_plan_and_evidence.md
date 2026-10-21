# 06 — Research plan and evidence

[Start](README.md) · [Previous](05_costs_limits_and_open_questions.md) · [Next: prior art](07_prior_art_and_sources.md)

The immediate objective is to produce evidence about ASKA's architecture using work that is possible before fabrication. The first useful artifact is a small executable model with an independent way to detect a forbidden transfer. Hardware is a later source of evidence about implementation and physical assumptions.

ASKA 2.0 provides the written contract, candidate state transitions, illustrative encoding, and research plan. It does not contain that executable model or report experiments that have not been run. Completion of this document set is an editorial milestone, not an architectural validation result.

## Begin with one question

> Under the declared source-classification and hardware-isolation assumptions, can a compromised ordinary host cause an unauthorized explicit transfer by racing the buffer handoff, changing message meaning, replaying records, or exploiting session lifecycle transitions?

Use two confidentiality classes, two source contexts, one allowed restricted destination, one forbidden public destination, bounded queues, and one directional session. Initially omit release, migration, dynamic peering, and timing-channel claims. The complete IES vision remains the research direction; these bounds make the first question answerable.

A model should include source writes, DMA attempts, freeze/copy completion, authorization, sequence allocation, send, receive, replay commit, expiry, policy withdrawal, and reset. An attacker controls ordinary requests and their interleavings. Protected functions are modeled as assumptions with named interfaces, making it possible to weaken them deliberately.

## Establish an oracle before trusting a demonstration

The oracle must describe allowed and forbidden effects independently of the gate's own allow/deny result. A model that reports success because its gate returned `allow` checks no security property.

Record the actual destination, payload version, operation, classification, session generation, and delivery event. Compare these against an independently stated policy and the source history. Include a deliberately broken model that permits a low-label substitution or a buffer race. The oracle must detect that violation before its results are trusted on the candidate design.

This independence is conceptual as well as mechanical. If the same mistaken assumption is copied into both gate and oracle, two matching implementations can still be wrong. Counterexamples, separate formulations of the property, and outside review are useful ways to challenge that risk.

## A sequence of useful studies

| Study | Artifact | What it can establish | What it cannot establish |
|---|---|---|---|
| Contract comparison | Threat-model and assumption matrix for existing systems | Whether the desired property is already available or needs stronger assumptions | Absence of all prior art |
| Finite state model | Executable transitions, attack traces, checked properties | Behavior within the explored state space and assumptions | Arbitrary-scale proof or physical gate integrity |
| Independent encoders and gate models | Known-answer records, malformed cases, differential traces | Agreement on grammar and specified acceptance behavior | Cryptographic protocol security by testing alone |
| Workload and cost model | Communication traces, storage accounting, sensitivity analysis | Which design choices dominate plausible costs and utility | Silicon timing, power, area, or yield |
| Component hardware study, if resources become available | RTL, synthesis reports, FPGA measurements, fault traces | Properties of the specific implementation and apparatus | Production ASIC or cross-realm system assurance |
| Physical composition study | Independently implemented endpoints, separate egress gate, external observation | End-to-end behavior under stated physical and administrative conditions | Universal correctness, all side channels, or supply-chain immunity |

These are evidence dependencies rather than a promised calendar. A negative result may remove a candidate before hardware work is justified. A discovery that an existing architecture already supplies the contract may redirect the project toward evaluating or extending it.

## The first adversarial cases

| Attack or failure | Expected observation under the initial contract |
|---|---|
| Replace a restricted label with public | Protected classification prevails; transfer is denied |
| Reuse a valid grant for another destination or operation | Source or receiver scope check rejects it |
| Modify the buffer during freeze, copy, or authentication | Mutation is prevented, or the operation fails before unauthorized publication |
| Use an old handle after object reallocation | Generation mismatch rejects access |
| Race duplicate records on two receive paths | At most one delivery for that sequence in the live session |
| Forge a high sequence number | Failed authentication cannot advance the replay window |
| Reset after sequence allocation, then restore old session state | Session is retired; old key/nonce use cannot resume |
| Withdraw policy while a record is queued | Outcome follows the declared serialization point; queued receive data is rechecked |
| Replay a lease-installation message | Lifetime is not restarted |
| Flood malformed or authenticated useless requests | Resource use stays within the declared local budget; loss of useful service is reported |
| Compromise a source issuer while receiver policy stays fixed | Existing accepted scope may be abused; receiver scope is not enlarged |
| Add an unmodeled bypass | Topology-dependent result becomes unresolved or changes; it is not retained as a pass |

Every campaign also sends permitted traffic. Report successful authorized deliveries, latency, false denials, and resource use alongside forbidden outcomes. “No forbidden packet observed” with no useful work completed is insufficient.

## Compare mechanisms under the same assumptions

The key mechanism comparison is among a protected software adapter, mandatory validator, and protected constructor. Their source-classification assumptions, cryptographic primitive, workload, and receiver policy should match. Otherwise an apparent performance gain may come from doing less security work.

Include a well-engineered conventional system where the host remains trusted, and show explicitly that this is a different threat model. Also investigate an existing system with an isolated monitor or device enforcement boundary. The relevant question is whether it can satisfy the ASKA contract and at what cost—not whether its branding sounds different.

Measure useful throughput, latency distribution, per-record work, memory traffic, queue demand, protected state per session, and denial behavior under overload. For later hardware, report tool versions, clock constraints, device/process assumptions, utilization, power methodology, and the exact protection enabled. Synthesis estimates and measured board behavior are different evidence categories.

The comparison should expose the cost of the snapshot rule. Run the conservative freeze-and-copy candidate against a carefully specified ownership-transfer candidate. If a faster variant permits a stale alias to write after authorization, its speed does not make it equivalent.

## Formal work with a defined scope

Start with safety: every delivered explicit transfer has the required source and receiver justification for the delivered bytes. State the model's finite bounds and the properties checked. Publish counterexample traces, including those from weakened variants.

A stronger information-flow result compares executions that differ in protected inputs while agreeing on permitted public observations. That requires a declared observer model and treatment of release, termination, and timing. Testing a few secret values is not a proof of noninterference.

Progress from a checked abstract model to implementation evidence through refinement: show how implementation states and events correspond to the abstract states and events, and account for concurrent DMA, queues, clocks, resets, and errors. A proof about a model with an atomic `send` cannot establish an implementation whose buffer changes across multiple bus transactions unless the refinement addresses that difference.

A topology reachability calculation can help bound which sinks are possible under declared paths and policies. Its answer is conditional on that inventory and on the modeled transitions. It cannot discover a hidden physical path merely because the path was omitted from the input. Unknown connectivity must remain unresolved.

## The eventual physical composition experiment

If earlier studies justify hardware work, use two endpoint implementations with separate administrative policy roots, a separate protected forwarding gate, a permitted destination, and an instrumented forbidden egress. Ordinary endpoint hosts and the route controller are attacker-controlled. The protected classification and enforcement components remain within the stated trust boundary.

Place independent observation at the actual egress and destination. Gate logs are useful supporting evidence, but they cannot be the sole account of whether bits crossed a wire or reached protected memory. Publish the connectivity, debug and reset paths, policy state, key roles, and assumptions before interpreting an attack result.

Independent implementations should differ in meaningful ways, such as code ownership or enforcement construction. Two copies of one design do not demonstrate diverse failure behavior. A single-team prototype is still useful, provided the result accurately states that limitation.

Inject label substitution, stale records, controller rerouting, queue overload, and selected component faults. Separate physical-port violations from endpoint-acceptance violations and from ordinary availability failures. Verify that the observer can see a deliberately introduced unauthorized crossing in a controlled negative case.

This study preserves the larger ASKA objective: physical enforcement across multiple machines and administrative boundaries. Passing a component simulation does not substitute for it. The study is a future research target, not a present commitment to purchase or fabricate hardware.

## Decisions the evidence should force

Reject or revise a candidate if its classification depends on the compromised host telling the truth, if a bypass can widen authority, if reset can resurrect old rights, or if the demonstrated contract requires undeclared trust.

Reconsider the architecture if useful workloads need pervasive release authority, if the protected software grows into the broadly privileged stack the design intended to constrain, or if a simpler existing system supplies the same property at materially lower cost.

Continue a candidate when it survives the defined attacks, supports useful operations, and has a credible path to its next evidence requirement. An unresolved timing guarantee does not erase a valid explicit-transfer result; it limits what that result may claim. Equally, an attractive long-term vision does not convert unresolved evidence into success.

## A sustainable public research practice

Keep the architectural narrative small and move detailed experimental records into their own reproducible artifacts only when those experiments exist. Each result should identify the question, model or implementation revision, assumptions, commands, input data, observed outcome, and remaining limits. Preserve failures that changed the design.

AI assistance can help produce candidate models, search for counterexamples, and build supporting software. Record the actual checker or measurement that supports a result. Generated confidence, agreement among assistants, and polished exposition are not independent evidence.

Useful outside contributions include an overlooked precedent, a smaller equivalent mechanism, a counterexample trace, a workload that breaks the utility assumptions, or an analysis of one shared hardware resource. The project can make progress through such contributions without pretending to be a funded fabrication program.
