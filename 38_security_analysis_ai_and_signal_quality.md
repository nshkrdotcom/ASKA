# ASKA v6 — Security analysis, multi-agent intelligence and signal quality

**Status:** security-analysis service contract and evaluation requirements. Statistical or generative models are untrusted advisors. No classifier, threshold or model accuracy number is itself a permission to change a protected machine.

## 1. Distinct intelligence roles

ASKA recognizes at least two distinct AI roles. The **user-facing operating agent** helps with interaction, application development and bounded task orchestration under [17](17_ai_environment_and_trusted_interaction.md). The **security analysis service** correlates sensor evidence, investigates anomalies, proposes triage and may prepare bounded response requests. These two roles MUST NOT share unrestricted context stores, signing keys, output channels or policy installers. An interaction assistant's permission to summarize a document does not give it security-control authority. Conversely, a security analyst's access to sanitized event metadata does not authorize reading private documents or prompting the user's display without policy.

The security service may be a hierarchy of local detectors, site correlators and independently administered regional analysts. Each runs inside an IES with finite memory/CPU/network budgets and an admitted telemetry scope. A distributed implementation is preferred where it reduces correlated blindness, but segmentation is not a substitute for proving provenance and independence. A cloud model used for analysis is an external recipient whose accepted data, retention, training-use restrictions and jurisdiction must be authorized.

## 2. Typed information exchange

Four named exchanges have separate constraints:

| Exchange | Purpose | Minimum binding | Forbidden shortcut |
|---|---|---|---|
| `SECURITY_EVENT` | Hardware/software evidence from named sources | Sensor root, scope, sequence, loss, time class, label | Untrusted process text treated as hardware fact |
| `POSTURE_SUMMARY` | Bounded local aggregation and confidence | Origin set, source evidence digests, validity interval, method/model version | Conflating multiple copies of the same source with independent witnesses |
| `INCIDENT_HYPOTHESIS` | Correlation, causal candidates and confidence | Observation set, detection rule/model digest, known blind spots, counterevidence | Treating inference as a proven root cause |
| `RESPONSE_PROPOSAL` | A candidate protective action | Exact target/generation, template ID, effect budget, expiry and review status | Executing model-generated commands or new privilege grants |

Protected receivers enforce schema, category mapping, byte ceilings and rate ceilings. Textual model explanations, retrieved threat intelligence and snippets from user data are inert untrusted material. A `RESPONSE_PROPOSAL` cannot contain arbitrary shell script, kernel patch, credential reset command or unrestricted network route as an executable effect. Proposal-to-grant compilation follows the Accord contract under [03](03_authority_calculus_and_conflicts.md) and local effect-owner semantics under [14](14_persistence_and_effects.md).

## 3. Local filtration and event provenance

A local detector MAY perform adaptive false-alarm filtering, but MUST preserve loss/provenance metadata and provide an independently reviewable path for severe events. Consider a denial at a hardware guard: no probabilistic filter may rewrite its `DENIED` result into `ALLOWED`; at most it can classify the associated alarm severity. Sensor alarms are events, not mutable labels on the original hardware counter. False-alarm suppression MUST identify whether it affects alerting, human workload, retained evidence, or actual enforcement; those are different consequences.

A security signal may contain: a real hardware boundary fault, a legitimate high-volume workload pattern, a malicious report created within a compromised LSM's scope, a replayed packet, a sensor clock error, or a deliberate evasion event. The classifier records competing explanations rather than assuming that anomalous means malicious. Local privacy-preserving summaries are allowed, but a summary that drops provenance cannot establish which physical boundary failed.

## 4. Threat intelligence and learning

Security knowledge may come from public reports, local detections, vendor updates, neighboring participants or collaborative/federated learning. Each source has an explicitly typed trust role. A signed threat-intelligence feed proves attribution, not truth. Model weights, feature extractors, training corpora, filtering rules and prompts are updateable supply-chain inputs and MUST pass independently authorized deployment gates under [40](40_update_supply_chain_and_evolution.md).

An attacker may poison local observations, submit malicious high-volume reports, manipulate labels, insert backdoors in model updates, extract sensitive training examples, or exploit dataset shift. Research may compare robust aggregation, local filtering, differential privacy and secure multiparty computation, but no algorithm is assumed effective without measurements under the declared threat model. Federated learning cannot establish data secrecy merely by keeping raw examples local: gradients and updates may reveal information.

Any data collection for collaborative detection specifies: contributing realms, exact feature set, sensitivity labels, privacy budget if differential privacy is used, retention and deletion, recipient identities, training-use consent or other applicable authority, and model release/audit obligations. A security purpose is not a universal disclosure permission.

## 5. Confidence and human review

Predictions expose at least `confidence_type`, `score`, `calibration_profile`, `observation_window`, `sensor_coverage`, `out_of_distribution_flag`, and `missing_sources`. A number such as `0.99` without calibration and coverage does not justify emergency administrative privilege. Each detector defines its operating point for its deployment. Critical gates may require rule-based evidence rather than model confidence for specific actions.

Use evaluation datasets separated by time, origin and adversarial role. Report precision and recall by attack class and deployment cohort; false positives per device-day; detection-to-report delay; calibration error; missing-data performance; drift; prompt-injection success; poisoning robustness; demographic or usage-pattern disparate effects where applicable; and benign work lost to false containment. Overall accuracy on an imbalanced dataset is insufficient. Include no-event periods so a flood of false alarms cannot be hidden inside precision alone.

High-severity recommendations include corroborating evidence and counterevidence, the model's explicit uncertainty, the proposed blast radius, alternate less-disruptive interventions, and consequences of doing nothing. A human-facing review interface must present canonical effect terms through Keystone, rather than an AI-authored summary as the sole evidence of consent.

## 6. Isomorphic legacy analysis

A legacy system may be paired with an **isomorphic comparison model** that represents its hardware/software interface expectations, known invariants or workload behavior. This can be useful for predicting anomalies and evaluating patches without instrumenting the legacy kernel. The model is a test hypothesis, not a digital twin whose agreement proves absence of compromise. Its instrumentation profile states whether observations are truly external, obtained from trusted hardware exports, or provided by potentially compromised legacy software.

A legacy-compromise test starts with a hostile kernel and security agent. A separate observer should still receive its hardware-visible events and deny the kernel's attempts to rewrite observer firmware or installation policy. The observer may fail to detect malicious computation that leaves no exposed trace; that limitation is reported. The comparison model never supplies a production root, installs patches automatically or bypasses a recipient's Accord policy because it identified a vulnerability.

## 7. Closed-loop limits

Analysis of an event can trigger a request for one of a finite set of local containment templates. A proposal may narrow a session, stop an explicitly scoped object transfer or require additional approval. It cannot directly replace firmware, expand a grant, create a new trust anchor, reveal a protected key, or seize another realm. Approved response follows [39](39_response_containment_and_recovery_contract.md); software build/update follows [40](40_update_supply_chain_and_evolution.md).

The system MUST retain a safety-critical deterministic path when analysis is unavailable. If a classifier crashes or is compromised, protected guards continue enforcing installed minimal policy. Detection service liveness is not assumed for access-control safety. All AI and data-science workloads are measured for throughput, power, latency and operator workload, and compared with non-ML and human-reviewed baselines.
