# ASKA v6 — Independent-security assurance profiles and registries

**Status:** normative declaration format and extensible registries. A profile classifies evidence actually supplied by a named implementation, not an intrinsically certified brand or component.

## 1. Required claim decomposition

Security claims are made separately for: **containment**, **observation coverage**, **observer independence**, **policy-distribution directionality**, **resistance to observer compromise**, **effect-response safety**, **update blast radius**, **recoverability**, **confidentiality**, and **conditional availability**. A device may meet one while failing another. The declaration names monitored adversary, observation classes, permission boundaries, trusted hardware/firmware and exceptions. Use `established_in_profile`, `conditional`, `unestablished` or `violated` against each named target requirement.

No profile assigns a universal numerical trust score. A score from a threat detector can be a risk input but cannot substitute for a root-of-trust or human/institutional decision. A profile name does not replace the permission to perform a specific operation, and an attested endpoint still must pass receiver acceptance and source disclosure checks.

## 2. Reference assurance profiles

| Profile ID | Necessary conditions | Permitted declaration | Prohibited declaration |
|---|---|---|---|
| `OOB_NATIVE` | Physically scoped independent LSM/MSM/WM roots, one-way distribution, protected telemetry ingress, independent guarded response and proven local update scope | Named out-of-band containment and observation under the declared compromise sets | Universal immunity, exhaustive CPU/RAM visibility, unconditional liveness |
| `OOB_PARTIAL` | Independent external root for some monitored paths but shared critical resources or incomplete sensor coverage | Precisely scoped independence and covered events | Full physical separation for shared roots/buses or paths |
| `HARDWARE_GUARDED` | Mandatory external guards but no independently rooted telemetry/watchers | Explicit access/effect containment from surviving guards | Independent out-of-band intrusion detection |
| `SOFTWARE_ISOLATED` | Security and workload rely on named host/hypervisor or privileged software | Conditional software containment and detection | Resistance to compromise of shared privileged software |
| `WITNESS_ONLY` | Independently checks selected receipt/attestation commitments | Bounded provenance and accountable notice | Live observation of unreported host memory events |
| `RESEARCH_MODEL` | Executable specification/simulation, no physical implementation | Properties shown under assumptions | Physical construction or measured hostile-host containment |

Implementations may combine profiles for different subsystems. A high-consequence transaction uses the weakest applicable protection on its actual path; combining a native witness with software-only data release does not upgrade the release boundary.

## 3. Deployment manifest

Every implementation publishes a machine-readable manifest with at least these semantic fields:

```yaml
kind: aska.assurance.manifest
revision: 1
implementation: {name: example-lab, build_digest: "sha256:<placeholder>"}
profiles: [OOB_PARTIAL, HARDWARE_GUARDED]
realm: {id: lab-A, governance_profile_digest: "sha256:<placeholder>"}
claimed_requirements: [R01, R03, R25, R26, R28, R31, R32]
roots:
  - {id: workload-A, role: IES, update_owner: application-team}
  - {id: sensor-guard-A, role: boundary-guard, update_owner: hardware-team}
  - {id: watcher-A, role: WM-L, update_owner: independent-team}
physical_paths:
  - {id: dist-A, source: msm-A, sink: lsm-A, direction: forward_only,
     medium: optical_link, verified_by: T27}
shared_dependencies:
  - {component: main-board-power, affected: [workload-A, sensor-guard-A]}
sensors:
  - {id: bus-tap-A, observation: protected_exported,
     visible: [denied_dma], not_visible: [cache_only_loads]}
response_templates: [FREEZE_EGRESS, REQUEST_REVIEW]
update_policy: {max_canary: 2, independent_approval_roles: 2}
evidence: {test_suite: [T25, T27, T29, T33], raw_results: separate_manifest}
```

The YAML is illustrative and is not a signed interoperable manifest. Exact encodings, cryptographic algorithms, hashes, schema revisions, expiry and critical extensions must be pinned before deployment. Unknown critical fields cause rejection; absence of a claim is not treated as permission or success.

## 4. Component, path and failure registries

The implementation carries a **component registry** listing: immutable physical identity where available, role, generation, current firmware, ownership, memory/DMA reachability, key roles, authorizers, recovery access and physical location class. A **path registry** lists every actual or potential route for signal, data, effect, firmware, debug, power and management, including normally disabled fallback paths. A **dependency register** lists clocks, cooling, roots, certificates, build systems, signers, suppliers, BMCs, data centers, metro facilities and human operators shared between nominally independent components.

For every independence claim define a minimal failure cut-set table. For example, if LSM and WM-L use different execution engines but share an update signer, record `{compromise_shared_signer}` as a plausible common cut set unless an independent install guard prevents that signer from updating both. A high-security profile may require separate teams, hardware roots and distribution infrastructure, but physical and social independence must be evidenced rather than merely asserted.

## 5. Event and action registries

Reserve the event families `SENSOR_EVENT`, `SECURITY_EVENT`, `POSTURE_SUMMARY`, `INCIDENT_HYPOTHESIS`, `RESPONSE_PROPOSAL`, `RESPONSE_RECEIPT`, `MESH_CONFIG`, `OBSERVER_HEALTH`, `COVERAGE_GAP`, and `ROOT_CHANGE`. Each versioned schema specifies sensitivity, mandatory provenance, epoch semantics, size and rate budget, allowed sources and destinations, and whether it is data-only or effect-bearing. Events that are data-only MUST NOT be parsed into executable commands by the security analyzer, watcher or transport layer.

Response templates have a separate registry of method IDs, target types, monotonic narrowing condition where relevant, physical effect owner, authorization role, caller budget, safe abort/commit semantics and required receipts. Extending the registry is itself a governed operation. An unrecognized method ID fails closed at admission and cannot be interpreted as a generic 'execute'.

## 6. Conformance dossier

A release dossier contains: requirement matrix R01–R40 and A01–A16; threat and observer models; path/authority diagrams; actual root and update custody; physical and firmware inspection evidence; formal invariants; full test vector coverage T01–T40; reproduced positive control cases; recovery and power-failure outcomes; measured performance and overhead; false-positive/false-negative bounds; review roles; disclosed exceptions; and exact binary/firmware version digests. Ambiguous or omitted evidence is recorded as unestablished, not silently passed.

A product cannot state 'passive RAM monitoring,' 'compromise-proof sensor,' 'fully out-of-band EDR,' 'air-gapped key authority' or 'independent watcher' without defining the scope and demonstrating the named physical constraints. This rule permits practical partial deployments while preserving accurate engineering claims.

## 7. Registry governance

Registry additions require a canonical schema, unique identifier, explicit backward-compatibility handling, rejection behavior, relevant threats, resource budget and independent design review. Unknown noncritical fields may be ignored only if they cannot change authorization semantics or representation binding. Disputed security evidence is reviewable under the applicable privacy and institutional policies. The responsible authority may publish redacted results, but protection of confidential evidence must not be confused with the absence of evidence.

[31](31_glossary_and_term_registry.md) owns general terminology, [29](29_traceability_and_conformance.md) owns requirement/evidence mapping, and [30](30_sources_and_evidence.md) records external methods. Conformance is always a property of a concrete configuration and observation model, not the document title.
