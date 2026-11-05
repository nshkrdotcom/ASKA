# ASKA v6 — Security-mesh formal properties and adversarial test catalogue

**Status:** normative test obligations and finite-model sketch; text examples are illustrative fixtures, not validated signed wire vectors. Tests supplement [27](27_conformance_tests_and_vectors.md) and [33](33_formal_properties_and_model_sketch.md).

## 1. State and assumptions

The independent-security model extends the state of the protected machine with:

```text
MeshState = {
  domain_roots, dependency_graph, physical_edges,
  source_generations, protected_policy, policy_minimum,
  distribution_packages, lsm_state, msm_state,
  watcher_state, sensor_counters, sensor_loss,
  telemetry_queue, analysis_proposals,
  response_grants, active_effects, update_cohorts,
  rollback_protection, attestations, receipts
}
```

An adversary may fully control an ordinary IES OS and its allowed device requests, one LSM, one MSM, one watcher, the analysis process or one update/management role in separate test configurations. It may forge every software-level report inside a compromised domain, flood exposed queues, replay packets, poison training inputs, and present correctly signed malformed configuration through a compromised producer. Surviving protected gates, separately listed roots and physical isolation components are conditional assumptions; they are *not* magically immune to compromise. Repeat tests with deliberately failed guards or shared roots to identify where guarantees end.

## 2. Safety properties

The following statements are predicates over machine state or transitions. An implementation MUST refine their observable meaning and map each predicate to hardware/firmware or software checks.

```text
P1: EffectCommitted(e)
    => LiveGrant(e) AND Scope(e) <= AdmittedContract(e)
       AND RecipientAccepts(e) AND TargetGenerationLive(e)

P2: LSMAcceptsConfig(l, p)
    => ApprovedIssuer(p) AND IntendedTarget(p, l)
       AND Scope(p) <= LocalPermittedScope(l)
       AND MinimumPolicyPreserved(l, p)

P3: CompromisedWorkload(w) AND SurvivingObserverRoot(o)
    => NOT CanWrite(w, ObserverProtectedState(o))

P4: OneWayDistEdge(MSM, LSM)
    => NOT PhysicalSignalPath(LSM, MSM, on_that_edge)

P5: ReportAccepted(r)
    => OriginVerified(r) AND ReplayFresh(r)
       AND DeclaredLossAndCoverage(r) AND LabelFlowAllowed(r)

P6: ResponseApplied(x)
    => ExactTemplate(x) AND TargetGenerationLive(x)
       AND CurrentEffectGrant(x) AND ChargedBudget(x)

P7: AnalysisProposal(a) WITHOUT IndependentGrant(a)
    => NOT PrivilegedEffect(a)

P8: UpdateInstalled(u, t)
    => ApprovedManifest(u) AND TargetMatch(u, t)
       AND CohortAuthorized(u, t) AND RootScopedInstaller(u, t)

P9: ObserverUnavailable(o) => NOT ClaimCompleteCoverage(o)

P10: CompromisedMSM AND IndependentWatcherAndLocalRoot
     => NOT SilentExpansionOfLocalRootOrWatcherAuthority
```

The notation `<=` means scope containment, not numerical hierarchy. P3 and P10 must be conditioned on an explicit unbroken path of protective guards and distinct root credentials. P4 refers to the named physical edge, not to all possible paths in the system: there may be a deliberately separate, mediated telemetry path that carries messages in the opposite direction.

## 3. Additional mandatory negative and positive tests

The base test IDs T01–T24 remain defined in [27](27_conformance_tests_and_vectors.md). The security-mesh acceptance suite adds:

| Test | Attack or fault | Required observable outcome |
|---|---|---|
| **T25** | Fully compromised host kernel tries to stop/patch independent LSM or WM-L | Observer protected state unchanged; loss/coverage measured; no implicit host administrative authority |
| **T26** | Passive sensor attempts a write, DMA read outside grant, or backpressure stall | Forbidden access denied; actual passive influence and saturation behavior measured |
| **T27** | LSM sends traffic backwards through MSM→LSM physical distribution link | No physical reverse signaling through that edge under stated test conditions |
| **T28** | Attacker embeds an executable control instruction in telemetry or sensor event | Ingest treats it as data; no policy installation or local effect |
| **T29** | Compromise WM-L, spoof LSM source and invoke quarantine | Source forgery/effect denied; false report allowed only within its separate bounded scope |
| **T30** | Cache-only reads, SSD internal operation, and missing tap event | Coverage limitations explicit; no assertion of exhaustive RAM/SSD observability |
| **T31** | Poison security model or prompt; demand new root/signing rights | Proposal rejected or inert; no model-origin authority minting |
| **T32** | Replayed response command targets reused IES ID | Generation mismatch denies command and avoids another occupant |
| **T33** | Correctly signed but malformed guard data/configuration update | Parsing/install fault contained as declared; rollout halted by staged gates; report actual host effect |
| **T34** | Compromised single signer attempts WM-L, LSM, MSM and Keystone update | Independently rooted, out-of-scope changes denied; shared-root limitation recorded |
| **T35** | Telemetry flood and prolonged watcher disconnect | Bounded loss counters; safe coverage degradation; measured essential service retained |
| **T36** | Security operator requests unrestricted Sanctum telemetry/plaintext | Deny absent independent source release and receiver acceptance |
| **T37** | False positive triggers repeated freeze requests | Quotas and corroboration bound effects; report lost legitimate work |
| **T38** | Power loss mid-update; rollback image conflicts with security floor | Protected recovery path or explicit unrecoverable failure; no forged restored receipt |
| **T39** | Two supposedly independent watchers share compromised boot key or BMC | Dependency graph exposes common cut set; no false independence claim |
| **T40** | Real permitted workload under repeated alarms and partial link loss | Measure admitted useful work, bounded incident latency and availability assumptions |

For every negative test supply a legitimate positive control: permitted telemetry delivery, approved update, scoped response, protected authorized storage read, or normal application progress. An implementation cannot pass by disabling all output.

## 4. Illustrative fixtures

### 4.1 Compromised security observer

```yaml
fixture_id: T29_compromised_local_watcher
assumptions:
  surviving_roots: [lsm_A, effect_guard_A, local_policy_installer]
  compromised_domains: [watcher_A]
  observer_source_id: watcher_A
initial:
  target: {ies: cell-17, generation: 8}
  independent_quarantine_grant: null
adversary:
  emit_report: {type: critical, model_confidence: 1.0}
  request_response: {template: QUARANTINE_CELL, target: cell-17}
expected:
  report_may_be_logged: true
  privileged_effect_count: 0
  decision: DENY
  reason: missing_independent_effect_grant
```

### 4.2 Signed defect in privileged update

```yaml
fixture_id: T33_signed_malformed_configuration
initial:
  rollout_cohort: canary_A
  root_policy_revision: 12
  protected_minimum_policy: base-12
candidate:
  artifact_type: DATA_RULE
  signature_valid: true
  semantic_validation: malformed_rule_table
  rollout_scope: [canary_A, cohort_B, fleet]
expected:
  attempt_may_fail_on_canary: true
  cohort_B_deployed: false
  fleet_deployed: false
  incident_receipt: required
  observed_host_outage: must_be_measured_not_assumed_absent
```

### 4.3 Physically one-way distribution

```yaml
fixture_id: T27_distribution_reverse_attempt
physical_fixture: inspectable_unidirectional_link
attacker_port: lsm_config_receive_side
attack:
  send_reverse_frames: 1000
  toggle_link_controls: true
expected:
  ingress_at_msm_on_distribution_link: 0
  independent_telemetry_path: may_continue_with_separate_grant
  link_integrity_and_measurement_limits: recorded
```

No fixture asserts valid cryptographic bytes. When selecting exact serialization, implementations publish reproducible canonical binary cases, nonproduction test keys, expected digest/signature bytes and verification tools.

## 5. Trace, oracle and proof requirements

Capture a *reference trace* from protected effect-owner state and externally instrumented physical outputs, not just a compromised observer's logs. Every test identifies `injected_compromise`, `surviving_trust`, `expected_forbidden_effect`, `allowed_attacker_behavior`, `legitimate_task`, `coverage`, `observed_effects`, `uncertainty`, and `recovery_result`. Where truth cannot be physically measured, state the gap rather than substituting model agreement.

Finite-state modeling should explore concurrent update/response/revocation events, token budgets, ring-buffer saturation, watcher restarts, signed-policy generations, local-site partitions, delayed DMA, reusable IDs and receipt ordering. For topology properties, combine executable model checks with physical reachability evidence; a software transition graph cannot prove a board contains a diode or separate power domain.

## 6. Measurement and claim discipline

Report CPU and memory overhead, security bandwidth, energy, sensor loss, observation latency, false-positive rate per unit of service, attack coverage, false negatives, intervention latency, rollout failure containment, firmware recoverability, network partition duration, independent roots affected, and benign work completed. Use matched baselines, including a well-configured endpoint with modern isolation/EDR, to determine whether physical separation improves expected safety at an acceptable cost.

A test result is tagged `established_in_profile`, `conditional`, `unestablished`, or `violated` with the full trust/failure assumptions. A successful prevention test is not a successful detection test; an alert is not proof of authorized response; a working diode is not a proof of source-data confidentiality. Traceability to R25–R40 is defined in [29](29_traceability_and_conformance.md) and [46](46_security_mesh_assurance_profiles_and_registries.md).
