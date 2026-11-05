# ASKA v6 — Software evolution, update supply chains and fleet safety

**Status:** normative controls for firmware, software, sensors, policy bundles and AI models; no guarantee of a defect-free update process. A common update authority is a security failure domain even when all endpoints use physically isolated execution.

## 1. Architectural rationale

Software shipped by a security supplier can be privileged and can arrive on many machines within a short window. Its defect or compromise can cause correlated outages, invalid access decisions or unauthorized control. Cryptographic authenticity proves an update came from the named signer, not that the bytes are safe. ASKA therefore separates **creation**, **evaluation**, **authorization**, **distribution**, **installation**, **runtime enforcement**, and **rollback/recovery** as different authorities with bounded scopes and independent evidence.

Automated evolutionary software development (AESDS) may propose code patches, security rules, drivers, firmware, models and tests. Isomorphic architecture monitoring and adaptation (IAMA) may generate hypotheses about legacy software and compare candidate repairs on detached test systems. Neither system is allowed to publish executable privileged code directly into the target fleet. Model-generated artifacts are untrusted source inputs subject to the same review and build controls as human-authored artifacts.

## 2. Artifact classes and irreversible effects

| Class | Examples | Primary risk | Additional gate |
|---|---|---|---|
| `DATA_RULE` | Detection signatures, category mapping, feature lists | Parser fault or false positives in privileged interpreter | Bounded schema, parser fuzzing, feature and acceptance diffs |
| `MODEL_WEIGHT` | Detector or orchestration parameters | Poisoning, behavior drift, resource saturation | Shadow evaluation, retained baseline and calibrated performance |
| `APPLICATION` | Confined analysis tools, native app cell | Authorized abuse or semantic compromise | Compartment manifest, effect-contract proof, canary and scoped grants |
| `GUARD_FIRMWARE` | Memory, DMA, egress or policy enforcement logic | Root compromise and cross-domain escape | Separate root approvals, physically isolated test rig, high-assurance rollback plan |
| `OBSERVER_FIRMWARE` | LSM/MSM/WM code | Blindness or fabricated telemetry | Independent watcher validation and signer separation |
| `BOOT_ROOT` | ROM-fused keys, policy trust anchors | Permanent loss of independent roots | Physical/manual multi-party process, irreversible-transition audit |
| `HARDWARE_CONFIG` | FPGA bitstream, interconnect mapping, port assignments | Unreviewed bypass or bus reachability change | Structural reachability analysis and post-install circuit checks |

A data-only package is not automatically harmless: a vulnerable interpreter in a privileged sensor can turn malformed configuration into system-wide failure. Conversely a confined application update may be less consequential than a privileged detection-rule package. Assurance and rollout size follow actual effect authority and common-cause scope, not file extension.

## 3. Update record and provenance

Every update is an immutable manifest whose canonical digest binds: `artifact_type`, `payload_digest`, `target_roots`, `hardware/ABI compatibility`, `producer`, `reproducible_build_claim`, `dependency/SBOM commitments`, `installer role`, `independent approvals`, `allowed source and destination domains`, `least firmware/security floor`, `test evidence`, `staging cohorts`, `expiry`, `rollback rule`, and `post-install observation plan`. Reviews must pin what was tested: firmware, compiler, OS, silicon errata, feature flags and baseline policy revision.

Verification of a build recipe or code-signing chain does not prove lack of a malicious maintainer, infected compiler, compromised signing service, or logic defect. Critical builds should use diverse independent verification where justified by cost and threat model. The Update Framework (TUF) offers relevant threshold and metadata patterns, but signature thresholds do not create administrative independence when all keys share the same operator or machine.

## 4. Fleet-wide blast-radius control

An installer MAY deploy only within a preapproved cohort/percentage/site limit. Critical updates use a defined sequence: offline/static tests; adversarial simulation; independent physical test rigs; a shadow or passive observation interval where feasible; canary devices with recoverable power; a cohort with different workloads/silicon; then explicit gates for each expansion. Rollout must pause automatically when observed safety indicators exceed bound thresholds, and failures must be reported even when collection is degraded.

Cohorts need **fault independence**, not just random hosts: separate sites, hardware revisions, root vendors, security profile combinations, administration domains and recovery paths. A common faulty dependency can still propagate to every apparently separate cohort. At least one recovery path must not depend on executing the component being replaced. Staging policy MUST name *what prevents* a revoked or broken update source from forcing continued rollout.

A preapproved emergency signature rule may permit narrow, short-lived defensive configuration without full organizational lead time, but it cannot install arbitrary root firmware or cross independent realms. A rollback may conflict with antirollback protections; define compatible signed recovery images, recovery counters and state-migration constraints *before* deployment. Turning off rollback safeguards without review is not an acceptable incident workaround.

## 5. Security mesh update independence

MSM distribution is a one-way transport for independently admitted packages, not an exemption from per-LSM verification. LSMs must independently validate target identity and baseline minimum policy. A compromised MSM, one vendor build service or one distribution-channel signer must not be able to erase watcher roots or rewrite Keystone/Steles keys in the native independent profile. WM-L and WM-M update authorities remain distinct from the corresponding observed LSM/MSM authorities; watchers monitor protected package generations and installation results.

A malicious or malformed `DATA_RULE` must not gain arbitrary write privileges by exploiting a parser inside the protection gate. A privileged interpreter is part of the TCB and needs hardening, formal or exhaustive small-state testing where feasible, memory and execution bounds, versioned schemas and fault containment. When an interpreter fault can crash a host, the risk is explicitly reported as an in-band/common-kernel dependency even if package transport was externally controlled.

## 6. AI-generated repair and isomorphic staging

The automated repair loop is bounded:

```text
Evidence -> candidate hypothesis -> detached build/test
 -> formal/static/behavioral checks -> independent review
 -> scoped update contract -> canary -> observed cohort
 -> explicit expansion authorization -> retained recovery evidence
```

The AI has no authority to sign the resulting artifact, adjust the acceptance thresholds in its own favor, or modify the test oracle that grades it. Test fixtures include hostile content, reverse dependencies, memory/IO pressure, clock anomalies, partial install, stale device generations, operator mistakes and downgrade attempts. The system records false repairs and test coverage, not merely successful samples. For low-risk data-only tuning, automation may proceed within a preinstalled narrow policy; out-of-profile transitions require review.

## 7. Emergency isolation and continuity

If a signing service, build host or package distribution network is compromised, the incident procedure may revoke only those authorizations whose independent owners confirm their scope. Already-installed data and firmware cannot be retroactively deleted from endpoints without an admitted action. Devices disconnected from the recovery service must remain within their previous allowed scope or an independently specified safe mode. A bad update that prevents boot may require hardware recovery; no declaration of 'remote self-healing' is sufficient without testing a physically independent recovery mechanism.

Availability evidence includes time to detect/stop rollout, number of affected independent roots, recoverable versus unrecoverable devices, mean restoration time, irreversible effects during incident, and secure service retained. Authentication alone must never be counted as successful resilience.

## 8. Mandatory attack cases

Inject a correctly signed malformed channel/configuration package; compromise the package signer; corrupt a detector model; poison canary telemetry; forge success receipts; deploy a stale but valid artifact; trigger a halfway firmware install; compromise MSM while WM-M survives; compromise one LSM while peers remain safe; remove network access mid-rollout; exploit an antirollback/recovery conflict. The expected outcome is **limited, measurable** propagation under the declared independent roots; a test that cannot recover a stopped machine records that failure plainly.

Update claims are included in the full-system failure model [23](23_compromise_and_failure_cases.md), conformance cases [43](43_security_mesh_formal_model_and_test_vectors.md), and research gates [28](28_research_program_and_realizations.md).
