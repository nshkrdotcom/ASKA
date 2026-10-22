# ASKA v4 — Governance, software evolution, and recovery

[Start](0300_architecture_and_reading_map.md) · [Previous](0311_admission_and_delivery.md) · [Next](0313_compromise_and_failure_cases.md)

**Requirements:** R01, R08, R09, R10, R11, R12, R14, R16, R21, R22.

ASKA must limit both the authority that creates and changes boundaries and the applications inside them. A single fleet-wide signer or management daemon with access to every policy register would defeat the target even if every application cell were isolated.

## Role-scoped control

| Role | Permitted authority | Excluded authority |
|---|---|---|
| Resource allocator | Reserve/reassign specified engines and banks under lifecycle rules | Read confidential objects or broaden application effects |
| Application signer | Attest an artifact and its declared contract for an allowed namespace | Install firmware, change receiving scope, or approve a user effect |
| Policy administrator | Install specified local policy dimensions | Replace unrelated guard code or another realm's policy |
| Gate updater | Install reviewed firmware for named gates | Install endpoint/data-owner updates or self-expand update scope |
| Recovery custodian | Perform specified recovery with required co-approvals | Obtain universal decryption or bypass future policy |
| Observer/response service | Receive admitted telemetry; execute narrowly bounded restriction actions | Read all payloads or create new permissions |
| AI assistant/builder | Propose plans, code, and explanations | Sign its own acceptance, grant authority, or root changes |

Each role is enforced by protected installation interfaces and immutable or separately governed root state. Merely naming different accounts in one omnipotent daemon does not separate authority. Where one component can rewrite all those interfaces, that component remains the controlling root for that domain and must be disclosed.

The architecture permits local ultimate ownership within a domain; it rejects a convenient universal ownership path across supposedly independent domains. A cross-root action requires each affected root's explicit approval under its own policy.

## Admission and policy changes

A policy update binds role, target objects/guards, allowed dimensions, previous/new policy versions, validity, and required independent approvals. Updates serialize with the effects they govern. Permission narrowing can stop subsequent commits; broadening cannot exceed the installer's scope or an active bilateral contract without fresh admission.

A behavioral trust score can recommend restrictions. It cannot use observations to create new authority or remove an independent approval. Automatic responses have predefined maximum scope and duration. A forged denial flood must not trick the observer into quarantining unrelated useful work without its response contract being exercised and measured.

## Boundary creation and exceptional access

No ordinary role can unilaterally create a forbidden cross-domain flow. Installing a cable, adding a route, enabling a peripheral, or changing a release rule cannot supply the approvals held by other affected authorities. Installation interfaces enforce both the installer's maximum scope and the independent prerequisites. Distinct accounts controlled by the same service do not satisfy that separation.

Exceptional release and maintenance authority is itself bounded by object/category, destination, method, expiry, and use limits. Emergency mode must not introduce a universal export, debug, or recovery path. If an ultimate root can replace its local release guard, disclose that authority and the data at risk. Another independent domain still controls its own admission. [0318](0318_cross_domain_security_and_information_release.md) defines the topology and policy-change failure cases.

## Software evolution

The update pipeline separates artifact production, evidence checking, authorization, and deployment. An update binds a digest, target role/platform, effect-contract revision, provenance, required tests/proofs, and rollback/recovery procedure. Local owners inspect authority changes before installation. An update under the same package name receives no automatic grant expansion.

Use role separation, thresholds, version/expiry checks, and consistent metadata from established update-system research where appropriate. [TUF](https://theupdateframework.github.io/specification/latest/) is a specification comparison. Its protections against update-distribution attacks do not make a legitimately authorized malicious firmware image safe, and thresholds do not create independence when one operator controls every signer.

High-consequence changes require separately held approvals, bounded deployment cohorts, and independent observation. Diversify implementations where it removes a known shared failure path. Using different keys with two copies of the same buggy verifier does not provide independent verification.

Staging and rollback must preserve authority and data-version semantics. An older binary may be incompatible with newer persistent state or vulnerable under a retired policy. Reverting executable bytes cannot rewind operation history, nonce allocation, or receiver acceptance state. Safe rollback may require a forward repair into a fresh generation.

## Boot and root replacement

Each independent domain boots from its own authorized root and verifies the enforcement configuration before opening data/effect paths. Attestation identifies that root and configuration. Other realms decide whether to accept it; no global attestation service can require acceptance.

Replacing a root, enabling debug, changing an isolation profile, or reassigning a sovereign physical port is an exceptional local action with explicitly defined authority. Data owners determine whether retained secrets survive such a transition. A service/debug mode can require erasing secrets before access. Implementation and testing must establish that erasure; policy text alone is insufficient.

Physical manufacturing tests, scan chains, field diagnostics, and package controllers belong in the path inventory. If a shared controller can put every guard into debug, those guards do not provide independent resistance to that controller's compromise.

## Recovery and partitions

Recovery begins with affected paths closed. Identify which state is reliable, isolate suspect devices/roots, preserve required evidence within its classification, and establish fresh execution/session generations where continuity is uncertain. Unaffected domains can continue within their independently reserved resources and authority.

Lost object state, lost keys, lost operation receipts, and lost availability have different remedies. Recovery contracts identify who can decrypt restored data, which approvals are needed, how rollback is prevented, and what uncertainty is reported. A hidden universal recovery key would violate the recovery contract.

Distributed policy groups may use consensus or threshold authorization, but must state membership, failure bounds, quorum, and partition behavior. Safety-critical expansion stops without the required approvals. Preauthorized local safety actions can continue within a bounded envelope; a partition creates no new cross-realm rights.

## Common-cause dependency record

For each claim of independence, record:

```text
enforcement implementations and specifications
signing keys and actual custodians
source, compiler, build, release, and verification pipelines
root/update/recovery authorities
power, clock, reset, package, debug, and network facilities
administrative and supplier relationships
```

Construct failure sets showing which targets one compromise can affect. A set can include an administrator, compiler defect, signing service, shared power controller, or software exploit. Minimal cut sets are useful only when the dependency graph includes real bypasses. Do not calculate independence by multiplying arbitrary failure probabilities.

## Observation and audit

Logs are protected objects with classification, retention, integrity, and volume limits. Security monitoring does not authorize a passive tap to read every secret. Independent witnesses can detect conflicting update histories when they receive the relevant evidence, but a hash chain or replicated ledger cannot prove an event that was never observed.

Security response remains useful when the AI is unavailable or malicious. Deterministic revoke, local stop, and recovery controls must retain their own authority paths. The AI can help explain events without controlling those paths.

**Open research:** practical distributed authority without an emergent universal control plane, recovery that preserves confidentiality and durable effect history, diversity that reduces actual shared dependencies, and usable policies for root evolution over decades. A full-root compromise remains catastrophic within that root's disclosed reach; the target limits that reach through independent domains.
