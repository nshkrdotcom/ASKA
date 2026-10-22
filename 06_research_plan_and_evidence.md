# 06 — Research plan and evidence

[Start](README.md) · [Previous](05_costs_limits_and_open_questions.md) · [Next: prior art](07_prior_art_and_sources.md)

Begin by comparing ASKA’s requirements and assumptions with existing systems. Then build an executable model for the requirements that still need testing, with an independent check for forbidden transfers. Later hardware studies can test implementation details and physical assumptions.

The documents specify candidate state transitions, an experimental encoding and a research plan. The executable model and experiments remain to be done.

The [source register](07_prior_art_and_sources.md) and [statement comparisons](08_defensive_structural_disclosure.md#prior-art-and-scope) identify the sources and requirements to compare. The three apparatus contracts cover lifecycle generation checks, source binding and copying, and serialized receiver acceptance. Compare those required relationships against existing systems before treating any as an ASKA contribution. A contribution needs a demonstrated difference; a failed search for a complete match cannot supply that evidence.

Prioritize the bounded model of source lifetime and receiver policy authority alongside those comparisons. Its traces can resolve the specified interleavings, while hardware construction and legal enablement remain separate questions.

## Begin with one question

> Can a compromised host or an attacker-controlled workload cause a forbidden delivery, an incoherent snapshot or an unauthorized policy change by racing source lifetime, copying, acceptance or session transitions?

Use two confidentiality classes, two source contexts, one allowed restricted destination, one forbidden public destination, bounded queues, and one directional session. Initially omit release, migration, dynamic peering, and timing-channel claims. These bounds make the first question small enough to investigate.

Model authority lookup and binding acquisition, owner and mapping changes, generation changes, individual alias-write attempts, alias disabling, write drain and copy steps separately. Include source and DMA writes, authorization, sequence allocation, send, preliminary replay checks, receiver acceptance, policy-installation requests, expiry, withdrawal and reset. An attacker controls requests and their interleavings, including workload writes within its assigned rights. Protected management changes retain their own authority checks but can race those requests.

Model the binding, write exclusion, drain and copy transitions rather than assuming an atomic `freeze_and_copy`. Bound the number of cells, aliases, source bytes, queued records and transitions explicitly. Give each assumed protected function a named interface and state which behavior is assumed and which synchronization is being tested.

Start from actual boundary contracts in [M³](07_prior_art_and_sources.md#a01), [untrusted-core isolation](07_prior_art_and_sources.md#a02), [TEEM³](07_prior_art_and_sources.md#a03), [Composite Enclaves](07_prior_art_and_sources.md#a12), [Ryoan](07_prior_art_and_sources.md#ry), [DStar](07_prior_art_and_sources.md#c05), [Elasticlave](07_prior_art_and_sources.md#b05), alongside the baseline of an ordinary host with all authority. For [TEEM³](07_prior_art_and_sources.md#a03), record that full text remains unavailable; its artifact and author descriptions provide leads that still need checking against the paper.

## Establish an oracle before trusting a demonstration

This is the proposed ASKA validation procedure; no result from the procedure is reported here.

The oracle checks allowed and forbidden effects independently of the gate’s decision. Checking only the gate’s `allow` result would repeat the decision being tested.

Record source owner, physical extent and mapping, generations, classification, writes and bytes read during each copy step. At the receiver, record destination, operation, session, policy credential and update events, replay changes, allowance debit and publication. Compare these with an independently stated policy and source history.

| Outcome | Independent condition to check |
|---|---|
| Delivery | The delivered bytes’ restriction and requested operation satisfy source authority and current receiver acceptance |
| Snapshot coherence | The staged bytes equal the bound extent’s bytes after write drain and before source writes resume |
| Source lifetime | Owner, mapping, generation and classification remain bound from authority lookup through staged-copy completion or safe abort |
| Receiver authority | Only receiver-authorized installation can change receiver policy; source records and grants cannot expand it |
| Acceptance atomicity | Concurrent records and policy changes have one acceptance order; replay, debit and classification commit before publication |

Same-class mutation can fail snapshot coherence without causing forbidden delivery. Source coherence is checked against source history; the receiver cannot infer it from AEAD verification or an unverified version number. Include separate broken variants that release the source binding too early, retain a writable alias, accept a source credential at the receiver installer, or split duplicate checks from commit. Each broken variant must produce a trace that fails the relevant independent check. The protected candidate must also complete permitted transfers.

Separate code is insufficient if the gate and oracle share the same mistaken assumption. Challenge their assumptions with counterexamples, independently stated properties and outside review.

## A sequence of useful studies

| Study | Artifact | What it can establish | What it cannot establish |
|---|---|---|---|
| Contract comparison | Threat-model and assumption matrix for existing systems | Whether the desired property is already available or needs stronger assumptions | Absence of all prior art |
| Finite state model | Executable transitions, attack traces, checked properties | Behavior within the explored state space and assumptions | Arbitrary-scale proof or physical gate integrity |
| Independent encoders and gate models | Known-answer records, malformed cases, differential traces | Agreement on grammar and specified acceptance behavior | Cryptographic protocol security by testing alone |
| Workload and cost model | Communication traces, storage accounting, sensitivity analysis | Which design choices dominate plausible costs and utility | Silicon timing, power, area, or yield |
| Component hardware study, if resources become available | RTL, synthesis reports, FPGA measurements, fault traces | Properties of the specific implementation and apparatus | Production ASIC or cross-realm system assurance |
| Physical composition study | Independently implemented endpoints, separate egress gate, external observation | End-to-end behavior under stated physical and administrative conditions | Universal correctness, all side channels, or supply-chain immunity |

Each study depends on evidence from the preceding work; no schedule is set. A negative result may remove a candidate before hardware work is justified. A discovery that an existing architecture already supplies the contract may redirect the project toward evaluating or extending it.

For each baseline keep a matrix of source classification, plaintext access, DMA/alias control, trusted management, bilateral scope, lifecycle generation, replay/accounting commit, expiry/reset and physical output. Use [FLAM](07_prior_art_and_sources.md#c07), [RFC 9334 / RATS](07_prior_art_and_sources.md#e03) to keep policy/trust roles distinct. Mark a requirement supported, changed, or unassessed; do not infer absent features from a short abstract.

## The first adversarial cases

| Attack or failure | Expected observation under the initial contract |
|---|---|
| Replace a restricted label with public | Protected classification prevails; transfer is denied |
| Reuse a valid grant for another destination or operation | Source or receiver scope check rejects it |
| Reassign or remap an extent between authority lookup and copy completion | The change waits; completion or safe abort restores source permissions under the binding before releasing it |
| In a later dynamic-label extension, admit input that would raise a bound source’s classification | Input waits until release of the binding; no lower-class copy includes the new restricted input |
| In a weakened variant, reassign or remap after authority lookup, then introduce restricted bytes before freeze | Report forbidden delivery if stale public metadata survives the remaining checks; record the origin of the restricted bytes |
| Mutate a fixed-class source through an in-cell workload or stale alias during copying | Reject the write or abort the transfer; a torn same-class snapshot is an integrity failure, not automatically a disclosure |
| Change the source after staging completes | Staged bytes and metadata remain unchanged; the later source version cannot replace them |
| Use an old handle after object reallocation | Generation mismatch rejects access |
| Race duplicate records on two receive paths | At most one delivery for that sequence in the live session |
| Forge a high sequence number | Failed authentication cannot advance the replay window |
| Reset after sequence allocation, then restore old session state | Session is retired; old key/nonce use cannot resume |
| Withdraw policy while a record is queued | Outcome follows the declared serialization point; queued receive data is rechecked |
| Replay a lease-installation message | Lifetime is not restarted |
| Flood malformed or authenticated useless requests | Resource use stays within the declared local budget; loss of useful service is reported |
| Present a source-controlled record or grant outside receiver scope | Receiver rejects the operation without expanding policy |
| Present a source credential to the receiver policy installer, attempting to expand each policy dimension | Installation fails and receiver policy remains unchanged |
| Install a valid receiver-authorized policy update while records are queued or committing | Update succeeds and orders with acceptance; records use the policy current at their acceptance point |
| Repeat an accepted record or a record below the replay window | Preliminary replay check rejects it without cryptographic work |
| Repeat an authenticated, policy-invalid record whose sequence is still eligible | Accepted replay state remains unchanged; count repeated verification and policy work |
| Add an unmodeled bypass | Topology-dependent result becomes unresolved or changes; it is not retained as a pass |

Every campaign also sends permitted traffic.

Attach each campaign to the relevant precedent and its difference: replay/window ([RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [US8438641B2 replay hardware](07_prior_art_and_sources.md#arp)), nonce loss/failover ([RFC 5116](07_prior_art_and_sources.md#ae), [IPsec failover RFCs](07_prior_art_and_sources.md#ha)), reset-safe time ([TPM 2.0](07_prior_art_and_sources.md#tpm)), protected buffer mutation ([Elasticlave](07_prior_art_and_sources.md#b05)), and control-plane bypass ([Intel control-plane isolation](07_prior_art_and_sources.md#cpi), [Intel NIC control paths](07_prior_art_and_sources.md#cps), [ICING](07_prior_art_and_sources.md#d01)). Include an authenticated **policy-invalid** high sequence case to test policy-before-window-advance, and repeat it to measure the verification cost. A forged tag tests a different rejection path. Report successful authorized deliveries, latency, false denials, and resource use alongside forbidden outcomes. “No forbidden packet observed” with no useful work completed is insufficient.

## Compare mechanisms under the same assumptions

Compare a protected software adapter, mandatory validator, and protected constructor. Their source-classification assumptions, cryptographic primitive, workload, and receiver policy should match. Otherwise an apparent performance gain may come from doing less security work.

Include a well-engineered conventional system where the host remains trusted, and show explicitly that this is a different threat model. Also investigate an existing system with an isolated monitor or device enforcement boundary. Compare whether it meets the ASKA requirements and at what cost.

Measure useful throughput, latency distribution, per-record work, memory traffic, queue demand, protected state per session, and denial behavior under overload. For later hardware, report tool versions, clock constraints, device/process assumptions, utilization, power methodology, and the exact protection enabled. Synthesis estimates and measured board behavior are different evidence categories.

The comparison should expose the cost of the snapshot rule. Run the conservative freeze-and-copy candidate against a carefully specified ownership-transfer candidate. A faster variant that allows writes through a stale alias after authorization fails that snapshot requirement.

Also compare a stable protected copy without a coherent-source-version guarantee when the task only needs fixed-class bytes. If version/content authorization is required, retain and test the stronger rule. [Elasticlave](07_prior_art_and_sources.md#b05) distinguishes the copying and exclusive-access alternatives; neither its lock transfer nor a plain copy establishes all of statement 3’s freeze/drain/copy ordering. Ownership transfer and immutable sharing need separate specifications.

## Formal work with a defined scope

Start with safety: every delivered explicit transfer has the required source and receiver justification for the delivered bytes. State the model's finite bounds and the properties checked. Publish counterexample traces, including those from weakened variants.

A stronger information-flow result compares executions that differ in protected inputs while agreeing on permitted public observations. That requires a declared observer model and treatment of release, termination, and timing. A proof of noninterference must cover the executions allowed by that model, beyond a few tested secret values.

Progress from a checked abstract model to implementation evidence through refinement: show how implementation states and events correspond to the abstract states and events, and account for concurrent DMA, queues, clocks, resets, and errors. A proof about a model with an atomic `send` cannot establish an implementation whose buffer changes across multiple bus transactions unless the refinement addresses that difference.

A topology reachability calculation can help bound which sinks are possible under declared paths and policies. Its answer depends on the path inventory and modeled transitions; omitted physical paths remain outside the calculation. Unknown connectivity must remain unresolved.

Proof baselines include [SAFE](07_prior_art_and_sources.md#c01), [seL4 IFC proofs](07_prior_art_and_sources.md#c11), [Komodo](07_prior_art_and_sources.md#c13), [Sanctorum](07_prior_art_and_sources.md#c14). Other methods to examine include [VerIFI](07_prior_art_and_sources.md#c15), [SPLITR](07_prior_art_and_sources.md#c16), [guarded-equivalence preprint](07_prior_art_and_sources.md#c17), [RTL-flow trace analysis](07_prior_art_and_sources.md#c18); distinguish static proofs, compiler assumptions and trace-based observations. [time protection](07_prior_art_and_sources.md#c12) provides a comparison for temporal isolation. Reproducing or refining an existing result is different from proposing a new proof technique.

## The eventual physical composition experiment

If earlier studies justify hardware work, use two endpoint implementations with separate administrative policy roots, a separate protected forwarding gate, a permitted destination, and an instrumented forbidden egress. Ordinary endpoint hosts and the route controller are attacker-controlled. The protected classification and enforcement components remain within the stated trust boundary.

Place independent observation at the actual egress and destination. Gate logs are useful supporting evidence, but they cannot be the sole account of whether bits crossed a wire or reached protected memory. Publish the connectivity, debug and reset paths, policy state, key roles, and assumptions before interpreting an attack result.

Independent implementations should differ in meaningful ways, such as code ownership or enforcement construction. Two copies of one design do not demonstrate diverse failure behavior. A single-team prototype is still useful, provided the result accurately states that limitation.

Compare the fabric with independently controlled policy roots against [ICING](07_prior_art_and_sources.md#d01), [SANE](07_prior_art_and_sources.md#d07), [EPIC](07_prior_art_and_sources.md#d03), [BlueField restricted mode](07_prior_art_and_sources.md#bf), [Intel control-plane isolation](07_prior_art_and_sources.md#cpi), [Intel NIC control paths](07_prior_art_and_sources.md#cps). Differences in policy installation, key authority, real ingress/egress and management bypasses must be stated before interpreting the experiment.

Inject label substitution, stale records, controller rerouting, queue overload, and selected component faults. Separate physical-port violations from endpoint-acceptance violations and from ordinary availability failures. Verify that the observer can see a deliberately introduced unauthorized crossing in a controlled negative case.

This proposed study tests physical enforcement across machines and administrative boundaries, beyond what a component simulation can establish. Hardware purchase or fabrication is not yet planned.

## Decisions the evidence should force

Use the following criteria to decide whether a candidate merits further work.

Reject or revise a candidate if its classification depends on the compromised host telling the truth, if a bypass can widen authority, if reset can resurrect old rights, or if the demonstrated contract requires undeclared trust.

Reconsider the architecture if useful workloads need pervasive release authority, if the protected software grows into the broadly privileged stack the design intended to constrain, or if a simpler existing system supplies the same property at materially lower cost.

Continue a candidate when it survives the defined attacks, supports useful operations, and has a credible path to its next evidence requirement. Report an explicit-transfer result within its tested scope, with unresolved timing properties identified separately.

## A sustainable public research practice

Keep the architectural narrative small and move detailed experimental records into their own reproducible artifacts only when those experiments exist. Each result should identify the question, model or implementation revision, assumptions, commands, input data, observed outcome, and remaining limits. Preserve failures that changed the design.

AI assistance can help produce candidate models, search for counterexamples, and build supporting software. Record the actual checker or measurement that supports a result. Agreement among assistants and confidence in generated prose cannot replace checker or measurement results.

Record the references and versions used in every result. Expand the [accelerator-TEE survey](07_prior_art_and_sources.md#b11) and the closest paper bibliographies when a decision depends on an unmatched requirement. [CONTINUITY](07_prior_art_and_sources.md#f01), [execution-finality drafts](07_prior_art_and_sources.md#f02), [CVID profiles draft](07_prior_art_and_sources.md#cv), [silicon-finality draft](07_prior_art_and_sources.md#cvs), [WO2026154461A2](07_prior_art_and_sources.md#cvp) must remain proposal/preprint/published-application comparisons until their implementation claims and assumptions have been checked.

Useful outside contributions include an overlooked precedent, a smaller equivalent mechanism, a counterexample trace, a workload that breaks the utility assumptions, or an analysis of one shared hardware resource. These contributions can advance the project before hardware funding is available.
