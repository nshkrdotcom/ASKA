# ASKA v6 — Formal properties and state models

**Status:** proposed normative target. Requirements describe obligations; they do not certify an implemented machine.

## 1. State and attacker transitions

Let `Σ = (Roots, Profiles, Claims, Contracts, Grants, Cells, Banks, Objects, Transfers, Sessions, Replay, Effects, Receipts, Exports, Watchers, Installations, Resources, Epochs)`. Every protected reference includes its namespace and lifetime. Ordinary workload memory and proposals are attacker-controlled; protected ownership tables, installation boundaries and effect-owner state are trusted only under the selected failure case.

Transitions are typed by owner. `Propose` changes untrusted input only. `Admit` creates a contract after applicable evidence/obligation checks. `Install` creates an attenuated local grant. `Allocate` establishes exclusive resources and a fresh lifetime. `PrepareTransfer` captures identity and excludes writers. `CommitEffect` performs the final check and consequence. `Observe` exports a permitted fact about a visible interface. `ProposeResponse` creates no effect authority. `InstallUpdate` applies a typed artifact only inside a separately authorized scope.

The malicious transition set includes arbitrary guest computation, malformed descriptors, stale handles, forged untrusted labels, legitimate-but-malicious received data, reordering, replay, suppression, reset attempts and resource exhaustion. Observer, watcher and update-producer campaigns replace the corresponding behavior with arbitrary actions available through that component's actual ports. They do not silently grant the attacker protected paths absent from its scope.

## 2. Safety obligations

The following invariants are proof obligations, not completed machine-checked ASKA theorems:

| Invariant | Statement | Required abstraction detail |
|---|---|---|
| INV-01: effect authority | Every final effect has an admitted contract and live installed grant satisfying MayEffect | The actual local finality/consumption point |
| INV-02: non-expansion | Installed child scope is a subset of all required parent scopes | Objects, methods, recipients, budgets, time and exclusions |
| INV-03: physical ownership | An ungranted requester cannot read/write another live owner’s bank | Requester attachment, all DMA/debug paths and aliases |
| INV-04: lifetime safety | Old-generation operations cannot affect a new allocation | Drain, invalidation, quarantine and wrap prevention |
| INV-05: exact release | Every permitted reduction of restrictions binds an authorized output contract | Representation changes, metadata and cumulative disclosure |
| INV-06: receiver sovereignty | Protected publication satisfies the receiver’s current local policy | Quarantine, replay, budget and publication serialization |
| INV-07: proposal nonauthority | AI/observer/watcher output alone cannot change installed rights | Distinct protected installer transitions |
| INV-08: bounded response | Automatic response remains within admitted template scope and cumulative budget | Lease, renewal, safe-state ordering and false alarms |
| INV-09: evidence qualification | Receipts cannot assert a stronger outcome than their observation establishes | Finality type, uncertainty and immutable correction links |
| INV-10: update scope | A valid signature does not permit an artifact to cross installation-class boundaries | Receiver parser, canary cohort and separate recovery root |
| INV-11: observational honesty | Missing/sampled events cannot be interpreted as exhaustive inactivity | Protected epoch/sequence/drop state and visibility |
| INV-12: no rights from routing | Adding an admitted physical route alone creates no object/effect grant | Per-port physical binding and independent endpoint policy |

Invariants about values and rights do not imply that all results are correct or all services remain available. A permitted recipient can return false data. An attacker can prevent its own computation from terminating. Every proof statement names which of these behaviors is excluded, admitted or constrained.

## 3. Freeze, transfer and revocation refinement

A useful concrete transfer model separates `BIND`, `EXCLUDE_WRITERS`, `DRAIN`, `COPY`, `RESTORE_SOURCE_RIGHTS`, `RELEASE_BINDING`, `AUTHORIZE_STAGED`, `EMIT` and `PUBLISH`. Modeling the entire sequence as one atomic copy hides the disputed race.

Ownership/mapping/generation/classification changes serialize with binding acquisition. Earlier writes drain before the coherent snapshot is fixed. Source permissions are restored only while the same protected ownership binding is held. Abort invalidates incomplete staging and releases reservations in the defined order. A retirement cannot reassign the bank while an old device remains an effective writer.

At emission, the owner rechecks current grant, release and path state. At reception, cryptographic verification occurs before protected visibility. Accepted replay state, resource consumption, label placement and publication serialize under the receiver's policy epoch. An authenticated policy-invalid high sequence may enter a separate bounded rejection cache, but must not advance the accepted replay window and suppress legitimate lower records.

The abstract relation must distinguish snapshot-integrity failure from prohibited disclosure. A torn copy of a fixed-class buffer sent to an authorized same-class recipient may violate integrity without leaking to a forbidden endpoint. A disclosure counterexample must show where restricted bytes entered and how they reached an unauthorized observer.

## 4. Assume-guarantee composition

For component `i`, state `A_i -> G_i`, where assumptions include physical reachability and policy roots, not merely input types. To compose adjacent components, show the producer guarantee satisfies the consumer's input assumptions, and separately show the environment supplies all remaining assumptions. Shared dependencies appear once in the global graph rather than being counted as independent support twice.

A refinement map `α` connects concrete tables, counters, queues, bytes and ports to abstract state. Every concrete irreversible event must correspond to an allowed abstract transition or an explicitly reported fault outside the claim assumptions. Stuttering steps may model internal work, but cannot hide emitted bytes, observable errors or unbounded denied service. Useful-service obligations constrain a refinement that would otherwise satisfy safety by never producing output.

[SAFE's verified architecture](https://davidpichardie.github.io/papers/popl14.pdf), Sections 8–10, is a relevant example of connecting concrete and abstract machines by refinement. [HyperFlow](https://www.cs.cornell.edu/andru/papers/hyperflow/hyperflow.pdf) is a comparison for processor-level IFC and timing-aware architecture. Those results do not compose automatically with ASKA's devices or networks.

## 5. Information-flow and authority proofs

For a selected attacker observation function, compare traces beginning in states equivalent in authorized observations. Authorized release events must be explicitly represented. Confidentiality and integrity proofs are separate; an authenticated low-integrity value must not influence a policy decision outside its endorsed scope.

The proof also models authorization queries, delegation updates and denial responses. Otherwise the authority service can leak a confidential relationship even when data-plane checks are correct. [FLAM](https://www.cs.cornell.edu/andru/papers/flam/flam-csf15.pdf) provides a comparison for this interaction. A proof about explicit storage channels must not be labeled a timing/physical noninterference result; [seL4's documented assumptions](https://sel4.systems/Verification/assumptions.html) illustrate that distinction.

## 6. Conditional progress

A suitable bounded progress obligation is: admitted work with a surviving owner, adequate reserved resources, a fair applicable scheduler and available required communication reaches a qualified result or explicit bounded failure. A freeze can be an authorized result while still counting as lost useful service. Renewing it indefinitely under fresh false alerts must not evade the cumulative protective budget.

Distributed agreement cannot assume an always-available perfect failure detector. [Fischer, Lynch and Paterson](https://groups.csail.mit.edu/tds/papers/Lynch/jacm85.pdf) establish a termination limitation under their deterministic asynchronous consensus model. ASKA protocols therefore state timing, quorum, failure and partition assumptions rather than promising unconditional global agreement. Local standing protection can continue without global agreement because it relies on already installed local authority.

## 7. Finite executable demonstrations

The executable fixture in [Chapter 56](56_conformance_tests_and_vectors.md) explores an abstract one-use effect owner with two allocation generations, immutable preparation, revocation, bounded local freeze and typed update scope. It reached 128 states and 1,536 transitions with no invariant violation in that model; 64 reachable states included a committed valid effect. Six deliberately weakened variants produced counterexamples for mutable binding, stale generation, missed revocation, duplicated consumption, update expansion and global response.

A separate enumeration checks 120 orderings of five receive events, including duplicates, an authenticated policy-invalid high sequence and a bad authenticator. These are finite checks of stated rules. They assume atomic protected owner transitions and durable consumption; they do not establish those mechanisms in silicon or storage. They exclude cryptographic compromise, real concurrency granularity, arbitrary queue capacities and physical channels.

## 8. Further formal work

[TLC and other TLA+ tools](https://lamport.azurewebsites.net/tla/tools.html) are candidates for transition-system and liveness exploration; [Tamarin](https://tamarin-prover.com/manual/master/book/001_introduction.html) is a candidate for symbolic protocol reasoning. Neither tool was used to prove the full ASKA design here. A verification project must publish the exact model, bounds, assumptions, commands and counterexamples, and distinguish model checking from theorem proving and physical validation.

The next refinement work must include multi-owner partial installation, durable prepare/commit failure, concurrent DMA aliases, receiver replay races, observer/drop counters, update rollback and standing-response renewal. A proof that places all of these into an unexplained trusted `SecureCommit` primitive has not discharged the central obligation.

A further implementation candidate restricts critical owner and kernel interfaces to bounded state and work, then checks declarative properties against operational transition rules with an SMT solver or theorem prover. Verification at an intermediate representation can simplify a chosen proof obligation only when its semantics, undefined behavior, compiler transformations, ABI, loader and target-ISA correspondence are accounted for. A failed obligation should produce a retained counterexample and, where possible, an executable regression case owned by the independent test authority. Finite bounds and tractable logic are explicit restrictions; they do not establish unbounded distributed behavior, physical diode directionality or correctness of an arbitrary model-generated kernel. This candidate requires a published refinement and reproducible tool invocation before receiving proof credit.

## Normative requirements and acceptance obligations

**R-55-01 — Explicit modeled state.** Formal claims MUST expose attacker transitions, protected state and physical/management assumptions.

**Acceptance T-55-01:** Remove an assumed guard or add a debug path and show which invariants cease to be established.

**R-55-02 — Concrete refinement.** Every implementation claim MUST map concrete irreversible events to abstract allowed transitions.

**Acceptance T-55-02:** Trace bytes, generations and physical ports through finality; a concrete effect with no allowed abstract event fails.

**R-55-03 — Separated race steps.** Models of transfer/reuse MUST include writer exclusion, draining, staging, binding release and finality as separate steps where they can race.

**Acceptance T-55-03:** Enable delayed DMA and reassignment interleavings; demonstrate denial and detect a deliberately removed binding step.

**R-55-04 — Bilateral publication order.** Receiver models MUST serialize current policy, replay consumption, resource debit, label placement and publication.

**Acceptance T-55-04:** Race duplicate records and withdrawal; at most one permitted publication occurs and invalid high sequences do not poison accepted state.

**R-55-05 — Conditional liveness.** Progress claims MUST state load, fairness, surviving resources and communication assumptions.

**Acceptance T-55-05:** Run an admitted positive case and a partition case; only conditional progress is asserted and explicit failure is bounded.

**R-55-06 — Honest finite evidence.** Finite-check results MUST state model bounds, trusted atomicities and untested physical/protocol properties.

**Acceptance T-55-06:** Reproduce the published state/transition counts and six mutant counterexamples; reject any whole-system proof claim from these results.

**R-55-07 — Independent test oracle.** A model or apparatus campaign MUST include an oracle capable of detecting its intended weakened failure.

**Acceptance T-55-07:** Run each mutant and require the expected counterexample before crediting a guarded variant.

