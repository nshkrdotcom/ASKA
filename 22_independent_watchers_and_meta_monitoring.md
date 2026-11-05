# ASKA v6 — Independent watchers and meta-monitoring

## 1. What a watcher watches

A watcher evaluates the reliability of an observer within a stated scope. WM-L watches a particular LSM and relevant source/export interfaces. WM-M watches MSM distribution and health. The independent oversight receiver OV receives their reports. Watchers do not replace memory, device or effect guards, and Steles does not become a watcher because it stores a commitment about a watcher report.

The purpose is to make selected forms of observer failure independently visible: an LSM stops receiving events, changes an admitted filter, reports fewer inputs than a protected tap counted, exhausts its queue, or falsely claims that a response was accepted. That purpose is achievable only for observable properties. A watcher cannot determine that every classification was correct by checking a heartbeat, nor can it prove the absence of a hidden circuit by measuring an image digest.

**R-22-01 — Finite rooted oversight.** A deployment MUST enumerate the watcher graph, its final trusted roots and its terminal oversight recipients. Each LSM and the MSM MUST have the separately rooted watcher required by the selected physical profile. The graph MUST stop at explicitly accepted hardware, custody and governance assumptions; it MUST NOT claim security by an unbounded sequence of watchers watching watchers.

The physical instances are fixed by [chapter 04](04_reference_machine_and_reachability.md): five WM-L instances and one WM-M in RP-A, reporting through six distinct simplex links to OV. Their local tap bundles are additional interfaces. Sharing one oversight receiver is a declared dependency, not six independent end-to-end reporting systems. The reference profiles deliberately leave that distinction visible.

## 2. Evidence that does not depend solely on the observer

An LSM’s own log is useful but insufficient to establish that the LSM honestly collected all input. At least one relevant measurement must originate outside its writable state. Candidate evidence includes TE emission and drop counters, an independently sampled configuration register, admitted image identity, measured report-output counters, reset state, queue occupancy and power-good or clock-fault signals. Each measurement needs the same coverage and provenance discipline as other sensors.

| Property under oversight | Independent evidence | What remains unresolved |
|---|---|---|
| LSM received an expected input interval | TE sequence range and independently visible ingress accounting | Whether its inference about those records was correct |
| Active configuration matches admission | Protected activation digest and epoch | Whether the admitted policy is well designed |
| LSM report path is alive | Output sequence, link health and OV receipt | Whether omitted evidence was relevant |
| MSM sent a particular package | Distribution-tap digest, target and send counter | Whether a local receiver installed it |
| Protective action occurred | Protected owner receipt | Whether the action achieved its physical safety objective |
| Watcher itself remained available | Its rooted counters, local retention and receiver continuity | Compromise of the watcher root or common power loss |

**R-22-02 — Independent observation path.** A watcher MUST base each independence claim on at least one declared source outside the monitored observer’s writable authority. Its report MUST identify which facts came from that source and which are observer self-reports. It MUST NOT turn an observer’s authenticated self-report into independent evidence by forwarding or countersigning it.

A comparison can establish a discrepancy without identifying its cause. Missing reports might result from tampering, a disconnected cable, parser rejection or exhaustion. The watcher records the facts and alternatives. Security analysis may prioritize a hypothesis, while the effect owner remains responsible for deciding whether a particular standing grant permits containment on that evidence.

## 3. Separate lifecycle and installation authority

Physical separation fails as an independence claim if the monitored software can replace the watcher through a shared installer, open a debug channel, manipulate its clock or hold it in reset. A watcher lifecycle therefore includes its own image admission, configuration policy, key custody, maintenance connector and retirement procedure. A deployment can share manufacturing or physical service responsibilities, but it must report those common roots.

**R-22-03 — Independent lifecycle.** The monitored LSM or MSM MUST NOT control its watcher’s boot image, installation keys, configuration admission, reset, debug enablement or retained evidence. Watcher updates MUST follow a separate admitted lifecycle and preserve a recovery path outside the monitored component. Any shared signer, controller or maintenance mechanism MUST be listed as a common dependency rather than counted as independent protection.

Independence is an operational property as well as a wiring property. Two signing keys in one CI account, or two reviewers whose approvals can be replaced by one service administrator, may represent one effective compromise set. Conversely, a threshold scheme can provide meaningful separation only where the approval domains and recovery procedures remain separate under the selected attacker. Counting keys is not sufficient.

[NIST SP 800-193, May 2018, §§4.1–4.4](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-193.pdf) distinguishes roots and chains for update, detection and recovery and treats host software inputs as untrusted. ASKA applies a more specific oversight topology to those functions. The NIST guidance does not demonstrate that a particular set of boards, custodians or installation services is independent.

## 4. A malicious watcher

A watcher can be the attacker. It can fabricate an allegation, hide its own missed samples, selectively accuse one purpose plane or attempt to exhaust OV. A valid watcher signature establishes which admitted key produced the report; it does not establish the truth of the allegation. An oversight display must preserve the evidence basis, observation interval and disagreements instead of treating “watcher says so” as a final finding.

**R-22-04 — Containment of malicious watchers.** The security model MUST include full software compromise of each watcher class. A watcher MUST be unable to forge another independent origin, expand a response grant, install code on the observed component or alter protected owner receipts. OV MUST apply bounded parsing, source authentication, replay checks and receiving policy even to reports from a trusted watcher key.

A malicious WM-L report can trigger a permitted short freeze if the installed grant deliberately accepts that trigger. That is a bounded denial-of-service capability which must be assessed, not hidden by saying the watcher is read-only. Repeated freezes, cross-purpose accusations and attempts to disable emergency functions must be covered by the response limits in [chapter 26](26_protective_response_and_containment.md). A watcher may request investigation; it cannot manufacture the legal or technical right to inspect private plaintext.

The supervision policy may compare distinct origins. Three copies of one TE record sent through three relays remain one origin. A majority vote among cloned models sharing a training set and update root does not establish independent corroboration. Disagreement is often the useful outcome: one source saw a writeback, another had a gap, and a third reports an incompatible epoch. The record should retain that structure.

## 5. Failure graph and cut sets

For each claimed oversight property, the assurance dossier lists the minimal combinations of failures that defeat it. Examples include a shared supply removing LSM and watcher together; a boundary export root fabricating both the LSM input and the watcher’s comparison counter; a common signer replacing every observer image; or OV storage corruption losing all delivered reports. These are structural examples, not quantified probabilities.

**R-22-05 — Common-cause accounting.** Watcher assurance MUST include a dependency graph covering physical source, exporter, transport, decoder, clock, power, boot root, signing service, installer, recovery and custodian. Evidence paths sharing a defeating dependency MUST NOT be counted as independent votes. The dossier MUST identify relevant minimal cut sets and state which are accepted assumptions, mitigated failures or unresolved gates.

A passive tap can avoid a particular software dependency without removing all semantic dependencies. [Vigilare, Moon et al., 2012, §5.4](https://cysec.kr/publications/vigilare.pdf) illustrates how cache behavior changes what a bus monitor can observe. The lesson for watcher design is to state the monitored interface precisely. Another observer on the same bus does not automatically reveal activity that never reached it.

A useful failure graph separates safety of the protected operation from availability of the evidence. Loss of OV can prevent timely oversight while a local guard continues to enforce its installed predicate. A compromised MG can defeat a memory boundary even if all watchers remain responsive. The graph must not combine those outcomes into one ambiguous “security unavailable” condition.

## 6. Loss, maintenance and recovery

**R-22-06 — Qualified watcher health.** Watcher reports MUST state observed interval, source and observer epochs, freshness, loss ranges and dependency faults. Absence of a report MUST be classified as missing evidence until a valid coverage basis establishes otherwise. A recovered watcher MUST not describe an unobserved outage as healthy or infer that no event occurred during it.

Maintenance creates real blind intervals. A planned update may suspend one watcher while local enforcement continues. The profile identifies which contracts can remain active, what local records buffer during the interval, and whether a separately authorized substitute can provide enough coverage. Substitution cannot be assumed from role names: its sources, permissions and dependencies must satisfy the same claim.

**R-22-07 — Auditable maintenance boundary.** Watcher maintenance MUST begin and end with protected lifecycle records, retire old epochs and identify the exact lost-coverage interval. Rejoining MUST reconcile retained sequences, active configuration and receiver state before asserting continuity. A maintenance grant MUST be limited to the named component and MUST close debug or service access before ordinary operation resumes.

Recovery preserves old evidence as old evidence. If a watcher’s secret was compromised, reports signed during the affected interval may require qualification even when they verify cryptographically. Rotating the key does not retroactively make those reports reliable. If retained evidence was lost, the dossier records the loss and the dependent claims that can no longer be established.

## 7. Conformance campaign

| Test | Adversarial or failure stimulus | Required oracle |
|---|---|---|
| T-22-01 | Follow every oversight edge through physical root and custodian | Finite graph terminates in declared assumptions; no hidden recursive claim |
| T-22-02 | Malicious LSM omits inputs while maintaining a plausible self-log | Independent counters expose the supported discrepancy; invisible semantics remain qualified |
| T-22-03 | Monitored component attempts watcher image replacement, reset, clock or debug manipulation | Undelegated operations fail; every successful maintenance path matches the manifest |
| T-22-04 | Malicious watcher emits false, replayed, oversized and cross-origin reports | OV bounds the input; no forged origin or expanded response/install privilege appears |
| T-22-05 | Disable a shared signer, supply, export root or receiver in a fault model | Predicted lost claims match the dependency graph; copied evidence is not counted twice |
| T-22-06 | Lose, reorder and delay watcher reports across reboot | Missing intervals and epoch discontinuities remain explicit after recovery |
| T-22-07 | Interrupt a watcher update and attempt to reuse an old maintenance session | Recoverable state, closed service path and fresh epoch are independently established |

These tests establish particular properties of a realization when executed with credible fixtures. They do not eliminate the finite roots on which the watcher system depends. The corresponding dossier belongs in [chapter 59’s assurance manifests](59_assurance_claims_profiles_and_manifests.md), with physical attack limits retained rather than hidden behind the oversight hierarchy.
