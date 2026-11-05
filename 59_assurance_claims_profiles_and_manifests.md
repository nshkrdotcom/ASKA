# ASKA v6 — Assurance claims, profiles and manifests

**Status:** proposed normative target. Requirements describe obligations; they do not certify an implemented machine.

## 1. A claim names an apparatus and a proposition

Assurance is a structured account of what a particular realization establishes against a named attacker, with named assumptions and evidence. The phrase “ASKA compliant” is incomplete without a configuration, profile, requirement set and evidence status. The reference architecture is proposed; it is not a certified implementation. A component's commercial description, signature, numerical risk score or successful boot does not establish the machine's security properties.

Each claim is a tuple `(subject, property, adversary, scope, assumptions, evidence, status, validity)`. The subject includes build digests and relevant hardware revision. Scope names interfaces, objects, lifetimes and physical consequences. Evidence distinguishes executable models, proof artifacts, inspection, measurement and independent replication. Validity includes expiry or the changes that invalidate the evidence. A profile is a set of such claims and required evidence obligations, not a universal trust rank.

## 2. Independent assurance dimensions

| Dimension | Question that must be answered | Example of an invalid inference |
|---|---|---|
| P: physical reachability and separation | Which compute, writable memory, DMA, ports and maintenance paths are physically or mandatorily guarded? | Separate VLANs imply separate controllers or cables |
| O: observation and watcher independence | Which event classes are visible, complete and independent of each named compromised root? | A live observer sees all cache activity or all malicious intent |
| C: confidentiality and integrity | Which explicit flows, transformations, releases and side channels are covered? | Capability safety implies information-flow noninterference |
| F: forwarding and receiving | Which route, quarantine, replay and receiver conditions hold at actual publication? | Authenticated carriage creates source or receiver permission |
| E: effect and persistence finality | Which consequence is committed, consumed, durable, uncertain or reconciled? | A network enqueue proves external financial settlement |
| U: update and recovery resilience | Which compromised producer, signer, distributor or installer can alter which roots? | Correct signature proves semantic safety or separate boards imply separate signers |
| A: conditional availability and safety | Which useful work survives specified faults, resource pressure and protective response? | Fail-closed behavior proves service availability or actuator safety |

A dimension contains predicates and coverage bounds, not a single level that can be averaged with another dimension. Physical independence from a workload CPU can coexist with shared power dependence. Strong witness durability cannot compensate for unguarded egress. A profile may require all seven dimensions for an integrated claim while documenting different strengths and residuals in each.

## 3. Composition algebra

Let `Claims(X)` be the set of propositions established for component X under `Assumptions(X)`. A path claim is established only when every component and crossing needed by that proposition supplies its obligation and the combined assumptions are consistent. For serial steps, the supported property set is constrained by the intersection of applicable guarantees; assumptions accumulate by union together with crossing obligations. This is a conservative proof rule, not a rule for intersecting unrelated labels or a numerical scoring formula.

For example, source release, protected transport and destination admission jointly support a narrowly scoped delivered-object claim. None independently proves that the semantic approver understood the content or that a recipient will behave ethically. If transport shares a hostile host's plaintext termination, the claimed confidentiality path ends there even if the far endpoint has a separate guard. If two redundant observers share an update installer, their independence claim includes that common cut set.

Alternative paths require separate arguments. A system claiming tolerance of one path failure must establish that the second path's required components survive the same failure. Quorum analysis states the threshold, common causes and Byzantine assumptions; adding nominal replicas does not automatically improve it. The dependency graph in [Chapter 03](03_assurance_trust_and_failure_domains.md) and interface inventory in [Chapter 04](04_reference_machine_and_reachability.md) take precedence over marketing descriptions.

## 4. Useful profile families

| Family | Minimum declared evidence | Permitted scope |
|---|---|---|
| RESEARCH_MODEL | Exact model/code, inputs, assumptions, results and counterexamples | Properties of that abstraction only |
| SOFTWARE_ISOLATED | Host privilege model, parser/effect mediation and adversarial tests | Conditional protection while named host roots survive |
| HARDWARE_GUARDED | Mandatory external boundary and physical bypass inspection | Named access/effect containment; observation may remain partial |
| OOB_PARTIAL | At least one independently rooted observation boundary, explicit shared dependencies | Particular observation and compromise scopes only |
| OOB_NATIVE | Scoped LSM/MSM/watchers, one-way configuration, independent reports, protected response, root/update evidence | Integrated out-of-band target under its declared cut sets and visibility |
| WITNESS_ONLY | Receipt provenance, retention, privacy and correction evidence | Accountability for received commitments, without live host-memory observation |

These families are composable descriptors. RP-A and RP-B are physical design targets that seek specified combinations; they have no automatic established status. LP-1 can produce HARDWARE_GUARDED and OOB_PARTIAL evidence if its tests support them. The finite examples in [Chapter 56](56_conformance_tests_and_vectors.md) support RESEARCH_MODEL statements only. No family grants an action, and no receiving realm must accept a profile merely because its issuer self-attests.

## 5. Evidence status and freshness

`established_in_profile` means named evidence supports the proposition within the supplied scope and assumptions. `conditional` means the proposition depends on explicitly unresolved environmental prerequisites; it is not an unconditional pass. `unestablished` means the required evidence is absent or insufficient. `violated` means a counterexample or observation defeats the claim in the stated configuration. A failed physical test must not be reported as merely conditional to hide a known violation.

A new compiler, firmware, model, board route, signer, debug policy, root custodian or cooling configuration may invalidate only part of the dossier. The impact analysis names those dependencies. A cryptographic digest freezes an artifact identity; it does not prove the artifact correct. Evidence retains the original failed results and corrections so that an assessor can understand the actual scope of any later success.

## 6. Manifest example

The following valid JSON is an **illustrative unsigned semantic manifest**, not an interoperable signed vector. Human-readable reference names are not cryptographic digests. A production schema must pin encodings, algorithms, lengths, critical extensions and validation rules through [Chapter 32](32_claim_contract_grant_receipt_schemas.md).

```json
{
  "kind": "aska.assurance.manifest",
  "schema_version": 1,
  "implementation": "LP-1-proposed",
  "artifact_digest": null,
  "evidence_status": "unestablished",
  "profiles": ["HARDWARE_GUARDED", "OOB_PARTIAL"],
  "profile_meaning": "target_obligations_only",
  "roots": [
    {"id": "guard-1", "installer": "boundary-custodian", "reset": "guard-local"},
    {"id": "lsm-1", "installer": "observer-custodian", "reset": "lsm-local"},
    {"id": "wm-l-1", "installer": "watcher-custodian", "reset": "watcher-local"}
  ],
  "paths": [
    {"id": "cfg-1", "from": "msm", "to": "lsm-1", "direction": "simplex",
      "medium": "optical_candidate", "inspection_result": null},
    {"id": "report-1", "from": "lsm-1", "to": "msm", "direction": "simplex",
      "separate_from": "cfg-1", "inspection_result": null}
  ],
  "observations": [
    {"exporter": "guard-1", "visible": ["accepted_effect", "denied_dma"],
      "not_visible": ["private_cache_load", "unexpressed_intent"]}
  ],
  "common_causes": ["bench_supply", "guard_fpga_configuration", "shared_toolchain"],
  "response_templates": ["FREEZE_EGRESS", "PRESERVE_EVIDENCE"],
  "claims": [
    {"requirement": "R-04-03", "status": "unestablished", "evidence": []},
    {"requirement": "R-03-01", "status": "unestablished", "evidence": []}
  ],
  "expiry_policy": "invalidate_on_component_root_or_path_change"
}
```

A null digest or empty evidence array is acceptable only for an explicitly proposed object; admission must reject it wherever an established implementation claim is required. The example does not install its listed response templates. Each actual response still needs a separate local standing grant with scope, budget and safety checks.

## 7. Required registers

The **component register** records physical identity, role, owner, lifecycle generation, firmware, memory/DMA reach, keys, installers, reset, debug and recovery. The **path register** includes data, power, timing, management, maintenance, fallback, wireless and removable-media routes. The **dependency register** records suppliers, toolchains, signers, administrators, power, clock, cooling, ducts and facilities. Each independence claim includes minimal defeating cut sets and the evidence that the claimed barriers actually differ.

The **observation register** records event source, counter origin, sampling, drop detection, expected delay, false-signal behavior, blind spots and privacy authority. The **response register** records finite templates, owners, priority, cumulative budgets, safe abort/finality and permitted recovery. The **evidence register** binds tests and artifacts to build identity, attacker powers, positive controls, uncertainty and assessor. The **legal/governance register** identifies applicable profiles and challenge procedures without asserting substantive legal correctness.

Registries use unique versioned identifiers and reject unknown critical semantics. Extension review examines authorization, privacy, parser complexity, memory/rate budgets, failure handling and compatibility. A data-only event cannot acquire command semantics by adding an optional field. A risk score or model revision cannot become a new authority class without a separately governed change.

## 8. Conformance dossier and independent assessment

The dossier contains all applicable requirements in [Chapter 61](61_requirement_decision_evidence_traceability.md), diagrams, complete manifest expansion, signed artifacts, raw results, adversary scripts, positive controls, physical photographs or schematics where relevant, calibration data, recovery traces, performance measurements and disclosed exclusions. Privacy-sensitive evidence may be access controlled, but its existence, custodian and review route are declared. Redaction must not erase the facts needed to evaluate a claimed protection.

The assessor repeats the decisive attack and useful-work cases on the named configuration. For a diode, that includes physical signaling and alternate management routes. For watcher independence, it includes malicious LSM/MSM installation and reset attempts. For confidentiality, it includes timing and output paths within the stated model. For availability, it includes repeated false alarms and depleted resource budgets. A declaration remains scoped after these tests: finite campaigns do not prove immunity to every vulnerability.

## Normative requirements and acceptance obligations

**R-59-01 — Claim decomposition.** Every assurance claim MUST identify subject, property, adversary, scope, assumptions, evidence, status and validity.

**Acceptance T-59-01:** Reject a universal security label lacking one of the required claim fields.

**R-59-02 — No averaging.** Conformance MUST evaluate applicable P/O/C/F/E/U/A obligations separately and MUST NOT average away a failed boundary.

**Acceptance T-59-02:** Combine strong witness evidence with unguarded egress; the release claim remains violated or unestablished.

**R-59-03 — Composition dependencies.** A composed claim MUST include crossing obligations and all common causes capable of defeating it.

**Acceptance T-59-03:** Give two observers a shared hostile installer; the dossier must expose the single shared cut set.

**R-59-04 — Evidence status.** Evidence status MUST distinguish established scope, unresolved assumptions, missing evidence and observed violations.

**Acceptance T-59-04:** Inject a known bypass; its exact claim becomes violated rather than a vague conditional pass.

**R-59-05 — Machine-readable manifests.** Production manifests MUST use pinned schemas, artifact identities, unknown-critical rejection and explicit proposed versus established status.

**Acceptance T-59-05:** Try the unsigned example where established evidence is required; admission rejects it without creating authority.

**R-59-06 — Registry completeness.** Component, path, dependency, observation, response and evidence registries MUST cover every consequential declared interface.

**Acceptance T-59-06:** Match paths and roots against hardware and fault traces; omissions block the affected conformance claim.

**R-59-07 — Evidence freshness.** A material implementation or custody change MUST trigger dependency-scoped evidence re-evaluation.

**Acceptance T-59-07:** Replace a watcher signer or enable debug; the affected independence evidence is invalidated before reuse.

