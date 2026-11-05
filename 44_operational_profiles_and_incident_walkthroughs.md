# ASKA v6 — Security operations, deployment profiles and incident walkthroughs

**Status:** reference operational scenarios; each requires implementation-specific hardware, procedures, contracts and verified fallback behavior. Examples are fictional test setups, not incident attribution.

## 1. Security operating responsibilities

A deployment designates independent authorities for: physical ownership and wiring; IES/application operation; LSM local telemetry; MSM configuration distribution; watcher mesh custody; security analysis; response admission; policy and firmware signing; forensic evidence; Steles witness; and recovery. One organization may hold several roles only when the assurance profile permits that concentration. Merely using different account names on one management server does not establish independent authority.

A service-level manifest records expected application availability, permitted safe-mode behavior, reserved civic or industrial resources, sensor/event coverage, analyst availability, incident review latency, recovery hardware, signed-image inventory, update blast-radius limits and the cross-realm release paths available during disruption. All emergency powers have named boundaries and expiry. The response plan is exercised with hostile software, misleading telemetry and offline participants.

## 2. Scenario A — Signed configuration causes kernel-wide failures

**Initial state:** an enterprise retains a compatibility IES for a legacy operating system and an existing privileged endpoint security product. The endpoint is observed by an independent sideband LSM/WM-L. The vendor supplies a correctly signed yet malformed dynamic rule package that causes the privileged endpoint driver to fault.

**Expected trajectory:** protected host-local code may crash because the compatibility profile permits that driver. The external watcher continues monitoring only if its actual hardware, power, clock and update dependencies survive; its coverage record names the resulting gap. MSM/WMs detect discrepancy or lost service, the rollout controller blocks propagation beyond the approved canary stage, and the local response owner leaves the unaffected realm's guard policies intact. Hardware recovery uses a previously approved compatible image with independent authorization. A user-visible receipt distinguishes crashed endpoint, rejected update and restored operation; no record asserts that the original host was unharmed.

**Key test:** a signer-valid artifact is not equivalent to a safe artifact; the experiment measures the number of endpoints affected and whether an independent recovery path remains operable. A deployment still running a high-privilege legacy sensor must not claim to have eliminated all in-band risk.

## 3. Scenario B — Host kernel tries to erase security observations

**Initial state:** a compromised guest kernel uses administrative APIs, kernel memory writes, debug ports and a forged process-health report to disable security monitoring.

**Expected trajectory:** its commands cannot reach externally rooted LSM/WM-L state through the declared paths. The independent protected tap still exports named guard events and local sensor loss/heartbeat conditions. The compromised host can cease useful work or generate ambiguous traffic; the observer cannot infer invisible register/cache operations. Response proposals do not gain root authority automatically. Test both an intact physical sensor boundary and a deliberately shared BMC fault, recording which guarantees survive.

**Key test:** enumerate exactly which bytes and control pins host software can reach; a screenshot of an 'external' dashboard is not enough.

## 4. Scenario C — A watcher manufactures a critical incident

**Initial state:** an attacker controls WM-L's application software, sends fictitious `critical` alerts and requests immediate destruction of a suspicious cell.

**Expected trajectory:** protected ingest records a possibly valid watcher-origin message with a limited scope; independent sensor evidence may contradict it. The response controller rejects destructive action without an installed template, live grant, corroboration if required, and target-generation match. Rate limits prevent a continuous stream of false alarms from exhausting protected service. Steles witnesses selected attempted and rejected effect phases without publishing private sensor payloads.

**Key test:** `CompromisedWatcher` may fabricate in-scope evidence but must not mint an effect grant or change the guarded object itself.

## 5. Scenario D — Malicious analyst tries to widen an incident

**Initial state:** a remote analysis model receives bounded, redacted events for two enterprise realms; a prompt injection or compromised model turns a localized denial into a recommendation to seize all keys and disconnect every realm.

**Expected trajectory:** analyst output remains an untrusted `RESPONSE_PROPOSAL`. The local validator rejects unsupported methods, expanded target set, missing owner agreement, unjustified cross-realm transfers and excessive budget. Local deterministic safeguards continue if the analyst is unavailable. The original guard denials remain operative and independent from analytic model text.

**Key test:** the same prompt replayed as a tool description, incident annotation and authenticated analyst output never expands rights.

## 6. Scenario E — Restricted medical record in an external forensic investigation

**Initial state:** Sanctum contains a protected medical object while its host application appears compromised. A security responder wants a memory image and a court presents a scoped evidence request.

**Expected trajectory:** passive telemetry can report only categories already authorized for security observation. Obtaining plaintext requires a distinct legally and technically applicable extraction contract, object-owner availability, exact selector and independently protected recipient effect. If the key is unavailable, the system records `UNAVAILABLE`; no observer or institutional credential can synthesize it. The received forensic image retains confidentiality category, provenance, loss/clock uncertainty, retention and notice obligations. Steles witnesses minimal commitments, not unrestricted images.

**Key test:** legal authority, sensor authority and cryptographic key custody remain separate.

## 7. Scenario F — Industrial compromise and loss of the network analyst

**Initial state:** a connected industrial controller has a narrow command whitelist and physically independent safety owner. The cloud analyst and MSM network go offline during a sensor anomaly.

**Expected trajectory:** local guard checks continue enforcing allowed physical effects. The protected safety service may enter a predeclared safe state using locally held authorization; arbitrary remote `stop_all` commands are rejected. Remaining power, cooling and network paths determine actual availability. Observer uncertainty persists across the partition, and later reconciliation does not pretend missing data never mattered.

**Key test:** exhibit both forbidden-command denial and a real permitted safe-state action; measure service degradation and recovery in the disconnected state.

## 8. Scenario G — Malicious updater plus correlated administration

**Initial state:** a signing service and central distributor share a compromised administrative computer; two supposedly independent watcher domains share the same firmware-update root.

**Expected trajectory:** the dependency inventory reveals that this is not three independent roots. The test computes the smallest compromise set that can alter both watchers. If no independent protection survives, its assurance claim is `violated` or `unestablished`; written procedures alone cannot rescue it. Staged deployment or physical key custodian separation may contain further spread, but the failed shared root is explicitly recorded.

**Key test:** force actual root transition and firmware access attempts, not only compare signing certificates.

## 9. Scenario H — Community network bridges two purpose fabrics

**Initial state:** an ordinary neighborhood operator adds an unmanaged fiber between a personal and a civic network or a compromised router changes a forwarding rule.

**Expected trajectory:** reachability may increase, but protected source-release and recipient-effect checks still deny ungranted disclosure. Independent network interfaces and transceiver roots block the named physical bypass where installed. A tap placed after the last guarded egress or a photographed display is outside some digital confinement claims and must be treated as an excluded physical/human intervention, not silently folded into a claim of total protection.

**Key test:** enumerate all alternative routes, media devices, updates and management paths while running authorized civic traffic.

## 10. Scenario I — False alarms while retaining service

**Initial state:** a heavy but legitimate database and graphics workload produces high interrupt volume and unusual storage bursts; local detectors misclassify it as a hostile event.

**Expected trajectory:** allowed source and destination effects continue where safe; local filtration may downrank alerts without suppressing protected evidence. A false containment must leave a visible receipt and be subject to appeal/review. The evaluation reports false alarms per device-day, precision at the selected threshold, latency, human-review burden, and percentage of legitimate work completed, not just the number of stopped operations.

## 11. Deployment acceptance report

For each scenario, provide the actual chip/board/firmware/OS, independent-root inventory, diagram of all signal directions, protected expected effect, attacker-controlled parts, permitted attacker behavior, full receipt and forensic trace, coverage gaps, independent witness status, legitimate task result, recovery outcome and observed costs. A deployment is not assumed secure because each component has a separately named software container. See the assurance manifest in [46](46_security_mesh_assurance_profiles_and_registries.md) and the conformance suite in [43](43_security_mesh_formal_model_and_test_vectors.md).
