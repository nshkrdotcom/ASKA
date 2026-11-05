# ASKA v6 — Watcher independence, oversight and finite trust roots

**Status:** target fault-containment contract. Independent oversight is not an assertion that any watcher is incorruptible. The implementation must state its shared dependencies and the compromise sets for which a surviving boundary remains enforceable.

## 1. The supervision problem

A local security mesh (LSM) can suppress sensor data, fabricate alerts, leak its intake or accept malformed updates. The master security mesh (MSM) can distribute a malicious configuration, silence sites or misrepresent fleet health. A security analysis service can be poisoned or co-opted. Their protection cannot depend exclusively on their own self-report. For each significant observing or distributing component, ASKA therefore defines an **independently rooted watcher role** with a narrower collection and intervention scope.

The architecture requires one **WM-L** for a designated local observation compartment and one **WM-M** for each declared MSM trust domain in the high-assurance profile. These are independent security *roles*: hardware packaging and multiplicity are deployment parameters. A full native claim requires genuinely independent memory protection, protected collection paths, distinct firmware/control signers and sufficient physical common-cause separation for the threat profile. If those resources are shared, the implementation reports a conditional or reduced independence claim instead of relabeling a process as out-of-band.

## 2. Who watches what

| Subject | Watcher-visible signals | Required independent confirmation | Effects the watcher cannot issue |
|---|---|---|---|
| LSM | Sensor subscription generation, filter digest, event counts/loss, policy load trace, update attempts, local status, report sequencing | Protected tap-side counters, policy-register commitments, observer channel heartbeat | Rewrite observed LSM, grant global privileges or silently delete raw evidence |
| MSM | Signed distribution packages, policy generation, timing, issuer/quorum evidence, distribution port activity, management reset | Independent source log, distribution-link monitor, protected signer role | Sign new policy on behalf of MSM, rekey all sites, approve its own override |
| Security-analysis service | Inputs selected, model digest, outputs and effect requests, uncertainty metadata | Request/response envelope witness at protected API boundary | Change effect grants, inspect unrestricted protected payloads |
| Response controller | Admitted templates, quota usage, effect-owner receipts, rejected requests | Protected effect-owner counters, independently witnessed permit/deny phases | Expand own authority, erase its own audit obligations |

A watcher uses the minimum observation signals needed to detect its subject's unauthorized boundary behavior. It does not need the subject's decrypted customer databases to verify that a policy digest changed. Where semantic inspection of protected content is necessary, a purpose-bound release or delegated inspection service must be used; protection of the observer is not a consent exemption.

## 3. Avoiding recursive watcher chains

An infinite hierarchy of watchers is neither buildable nor required. ASKA instead chooses a **finite, explicit assurance cut**: independently rooted watcher domains, protected enforcement gates, verified update/boot chains, and an externally reviewable dependency graph. The proposition being evaluated is conditional: given the named surviving roots and guards, compromise of a designated workload, LSM, MSM or analyst cannot cause a specified forbidden effect.

A high-consequence profile MAY use two independent watcher implementations with different hardware, teams or vendors; diversity does not prove independence if both accept a shared image signer, compiler toolchain, distribution package, power regulator or central administrator. The required evidence is a list of *minimal cut sets*—smallest collections of failures that defeat the property. A third watcher simply sharing the first watcher's root adds little fault tolerance.

## 4. Independent information paths

WM-L obtains evidence from taps on its LSM's sensor/event export and local management ingress, not solely from the LSM's own health endpoint. WM-M inspects an MSM's distribution activity and installed protected configuration via its own protected tap; the MSM is not allowed to fabricate all evidence the WM-M uses. The watcher exports signed, filtered status through its own independently admitted one-way reporting interface. This path must not act as a command transport into the watched subject.

The protected security ingest compares reports by time interval and coverage, recording disagreement. It MUST NOT choose the most optimistic account by default. Sample discrepancy classes include `LSM_SILENT_TAP_ACTIVE`, `LSM_REPORT_MORE_THAN_TAP`, `SENSOR_PATH_MISSING`, `MSM_PACKAGE_UNAPPROVED`, `POLICY_DIGEST_DIVERGES`, `WATCHER_UNAVAILABLE`, and `CLOCK_INCONSISTENT`. Disagreement is an incident candidate, not proof of maliciousness.

## 5. Compromised watcher semantics

Grant attacker control of all software in WM-L. The test asks whether it can (a) access LSM/private workload memory; (b) inject observations with protected source identity it does not own; (c) change mandatory guard policy; (d) invoke a destructive containment effect; or (e) rewrite its own effect receipts. The expected result is denial for (a)–(e) under the defined independent guards, while allowing that it can send false reports within its admitted report schema, exhaust its own budget and hide events visible only to it.

Grant attacker control of WM-M. It may lie about MSM health or induce alarms; it cannot become the MSM policy signer or installation authority. Grant simultaneous compromise of an MSM and its sole dependent signing hardware: independence claims conditional on that signer no longer hold. Reports MUST identify this difference rather than claiming that watchers solve every shared trust failure.

## 6. Quorum, disagreement and governance

For high-consequence intervention, a policy may require corroboration by independently rooted observations or a protected deterministic guard event. Corroboration is not a majority vote by identical clones of the same compromised sensor. A rule records eligible signer/source classes, minimum independent origins, tolerated staleness, and fallback when evidence is incomplete. Protect against event amplification: a single underlying tap event copied by several observers counts as one origin, not multiple independent witnesses.

A watcher can request `SUSPEND`, `ESCALATE`, quarantine, or safe-state consideration, but its evidence does not itself authorize an irreversible effect. The local response controller verifies a separate grant, target generations, budget, independent approvals and an effect template. A malicious watcher cannot force a fleet wipe by repeatedly reporting high model confidence. See [39](39_response_containment_and_recovery_contract.md).

## 7. Updates, recovery and observability gaps

Watcher firmware, models, policy, keys and boot roots MUST NOT be updated by the watched component's ordinary software administrator. Update provenance, cohort schedules and rollback policy are recorded separately. Independent watchers MUST be able to report an MSM distribution package even when the MSM later resets or loses network connectivity; if they cannot, the gap is a declared limitation. A lost watcher or broken evidence path triggers explicit coverage degradation and narrowly scoped fallback, not the fiction of a healthy empty log.

Recovery requires mutually scoped authority: a local administrator may restore LSM service only within installed policy and a recovery custodian may rotate watcher credentials only through a separately authorized path. An ultimate physical/root owner may defeat its own local trust boundary; another independent realm must not silently inherit that owner's keys. Reports of restored service include source/target generations and retained uncertainty about events during the blind interval.

## 8. Assurance evidence

Required tests include disabled LSM telemetry with live tap activity, replay of healthy heartbeats, malicious watcher firmware, malformed package accepted by an MSM application but denied by installation guards, simultaneous shared power failure, stale observer clocks, telemetry loss storms and false quorum independence. Measure true detection coverage, service loss and time to repair under each case. [43](43_security_mesh_formal_model_and_test_vectors.md) defines the formal safety statements; [42](42_secure_storage_and_cryptographic_services.md) defines separate custody for sensitive forensic records.
