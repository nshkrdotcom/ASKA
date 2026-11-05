# ASKA v6 — Requirements and threat model

## Scope and attacker model

Each campaign starts with a named compromised component and the access its physical ports and installed grants actually provide. The attacker can exercise those rights maliciously, supply hostile but authenticated data, suppress reports or exhaust admitted resources. Compromise does not silently add authority over an external guard, another realm, a watcher installer or an independent recovery root.

Conformance requires useful permitted work alongside denied operations. In-scope malicious behavior, lost observation, uncertainty, unavailable service and physical assumption failures are distinct outcomes. Requirements and test oracles are defined by their enforcing components; the assurance claim in [Chapter 50](50_assurance_claims_profiles_and_manifests.md) identifies the evaluated apparatus and evidence.

## Adversary inventory

| Attacker granted at campaign start | Permitted attacks | Trusted boundary whose survival is being tested |
|---|---|---|
| Privileged guest/kernel | Arbitrary instructions, aliases, descriptors, retries, resource exhaustion | External identity, memory/device and effect guards |
| Device/accelerator controller | Malformed DMA, peer requests, interrupt floods, stale completions | Assignment, DG and physical output owners |
| Route/transport controller | Reorder, drop, replay, redirect, metadata observation | Mandatory egress, record integrity and independent receiver |
| Ordinary scoped administrator | Change its own admitted configuration; abuse legitimate rights | Other installation, recovery and realm roots |
| LSM | False alerts, suppressed records, malicious proposals and report payloads | Watcher paths, local EO, peers and MSM receive boundary |
| MSM | Defective signed packages, malformed distributions, report suppression | Local LSM admission, WM-M and separate channels |
| WM-L or WM-M | Fabricated oversight and attempts to change policy | Local roots and response owners outside watcher authority |
| Security AI | Poisoned conclusions, global shutdown proposal, covert report content | Standing-grant scope and release policy |
| User companion/build agent | Prompt injection, malicious tools/code, approval substitution | Context owner, K, independent reviewer and installer |
| Signed artifact producer | Correctly signed but unsafe code/rules/model | Separate acceptance, canary, guard and recovery boundaries |
| Authorized recipient/insider | Malicious in-scope use, outputs, media/photographic disclosure | Exact granted boundary; no claim of forced forgetting |
| Physical/management adversary | Cables, debug, BMC, reset, power or probes as selected | Precisely declared physical profile, with failures outside it explicit |

Compromising a protected guard is a different case from compromising the guest it contains. The campaign must then identify which outer boundaries survive and which local properties fail. A malicious fabrication or invasive probe is included only in a profile with corresponding evidence; omission from an initial model is not proof of resistance.

## Safety, liveness and uncertainty

A consequential effect requires the common predicate in [Chapter 05](05_unified_execution_data_and_effect_contract.md). Safety is conditional on the named enforcement and observation assumptions. Liveness additionally requires admitted offered load, surviving resource capacity, scheduling fairness and an available path where remote work is necessary. Arbitrary permanent packet loss or total power loss defeats unconditional remote progress.

Missing observation is `unknown`, not proof that nothing happened. A guard denial establishes a particular rejected operation, not absence of all compromise. A signature establishes an authenticated assertion under key assumptions, not truthful data, lawful authority or safe execution. [Chapter 03](03_assurance_trust_and_failure_domains.md) owns these evidence distinctions.

## Threat-profile exclusions

An implementation manifest names whether it covers malicious guest software, arbitrary bus transactions from an untrusted compute engine, malicious observer software, malicious privileged sensor firmware, a compromised signer, shared management failure, physical rewiring before the last guard, invasive probing after it, side channels and fabrication subversion. Every included case needs surviving trusted functions and an independent oracle.

For example, a cable attached to an intact guarded interface must not create authority. A probe wired directly to plaintext after the last guard can defeat confidentiality if invasive access is outside the profile. A shared package reset can invalidate supposedly independent watchdogs. The report describes these failures as limitations of its physical boundary, not successful containment.

## Adversarial test method

For each claimed protection, the campaign identifies the initial attacker scope, a permitted positive control, the forbidden consequence, the last trusted enforcement boundary and a measurable oracle. A deliberately weakened guard or policy variant must trigger the expected failure before a protected pass is credited. Physical tests remain proposed until conducted on a named apparatus; finite abstract checks in [Chapter 47](47_conformance_tests_and_vectors.md) have a narrower scope. Integrated incident campaigns appear in [Chapter 45](45_end_to_end_traces_and_incident_walkthroughs.md).

## System-level adversarial coverage

The cross-system attack classes below complement the mechanism-specific oracles. Each case includes a permitted counterpart under the same surviving-resource assumptions.

| Attack class | Required observation and outcome |
|---|---|
| Privileged execution, stale reference and device DMA | Instrument the final physical owner/guard, delayed writebacks and generation changes; an ungranted transfer cannot complete. |
| Foreign route, output channel or dual-homed device | Cover network, screen, removable media, debug and actuator paths; no alternate route bypasses source release and receiver admission. |
| Overbroad delegation, claim or standing grant | Attempt role substitution, recipient or budget expansion, stale epochs and self-approval; the effect owner rejects the excess. |
| Ambiguous delivery, storage or payment | Crash and retry at every declared finality boundary; durable receipts distinguish committed facts from uncertain downstream outcomes. |
| Compromised observer, watcher or security AI | Fabricate and omit reports, trigger false containment and attack installer paths; document lost detection and limits on admitted response effects. |
| Signed malicious software or build artifact | Exercise compromised generation, protected oracle substitution, canary expansion and recovery; signatures alone do not establish safe code. |
| Misleading human, legal or institutional authority | Change canonical approval content, contest a governance basis or request unavailable data; enforce the qualified local profile. |
| Purpose crossing, hostile recipient and metadata leakage | Test receiver withdrawal, private query amplification, authorized abuse and repeated one-bit disclosure. |
| Saturation, partition and management common cause | Measure protected service under admitted load, report blind intervals and identify claims defeated by a shared power, key or reset root. |
| Physical probe and speculative sensor failure | Inspect each trust-boundary path, mark excluded invasive attacks and withdraw claims dependent on failed or unvalidated sensors. |

An executed result identifies the realization, fixture, measurements and positive control. Model results do not establish hardware behavior.
