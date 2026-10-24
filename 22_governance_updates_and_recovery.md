# ASKA v5 — Governance, updates, and recovery

## Separation of institutional and technical rulemaking

A signed governance **PROFILE** declares recognized issuers, institutional decision procedures, notice and challenge rules, optional exceptional-access features, retention, and the assurance claims that an endpoint is willing to make. A national government, enterprise, user, and witness operator each retain only powers lawfully or contractually assigned in the relevant realm; no PROFILE grants universal root by naming an institution. Boot roots, policy installers, software signers, allocation controllers, recovery custodians, and observation readers remain separately scoped.

---

## Detailed technical contract

**Requirements:** R01, R08, R09, R10, R11, R12, R14, R16, R21, R22.

Protected installation interfaces must constrain the administrators who create and change boundaries, just as guards constrain application cells. A fleet-wide signer or management daemon that can write every policy register defeats the target even when each application owns private compute and memory.

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

Protected installation interfaces and immutable or separately governed root state enforce each role's scope. Merely naming different accounts in one omnipotent daemon does not separate authority. If one component can rewrite every installation interface, it remains that domain's controlling root. The dependency record must name it.

The architecture permits local ultimate ownership within a domain; it rejects a convenient universal ownership path across supposedly independent domains. A cross-root action requires each affected root's explicit approval under its own policy.

## Admission and policy changes

A policy update binds role, target objects/guards, allowed dimensions, previous/new policy versions, validity, and required independent approvals. The local controller serializes each policy update with the effects it governs. Permission narrowing can stop subsequent commits; broadening cannot exceed the installer's scope or an active bilateral contract without fresh admission.

A behavioral trust score can recommend restrictions. It cannot use observations to create new authority or remove an independent approval. The response contract fixes each automatic response's maximum scope and duration. Tests must exercise and measure that contract under forged denial floods, including attempts to make the observer quarantine unrelated useful work.

## Boundary creation and exceptional access

No ordinary role can unilaterally create a forbidden cross-domain flow. Installing a cable, adding a route, enabling a peripheral, or changing a release rule cannot supply the approvals held by other affected authorities. Installation interfaces enforce both the installer's maximum scope and the independent prerequisites. Distinct accounts controlled by the same service do not satisfy that separation.

Grants must bound exceptional release and maintenance by object/category, destination, method, expiry, and use limits. Emergency mode must not introduce a universal export, debug, or recovery path. If an ultimate root can replace its local release guard, disclose that authority and the data at risk. Another independent domain still controls its own admission. [19](19_cross_domain_security_and_release.md) defines the topology and policy-change failure cases.

## Software evolution

The update pipeline separates artifact production, evidence checking, authorization, and deployment. An update binds a digest, target role/platform, effect-contract revision, provenance, required tests/proofs, and rollback/recovery procedure. Local owners inspect authority changes before installation. An update under the same package name receives no automatic grant expansion.

The update design should apply established role separation, thresholds, version/expiry checks, and consistent metadata where those mechanisms meet its declared update threats. [TUF](https://theupdateframework.github.io/specification/latest/) is a specification comparison. Its protections against update-distribution attacks do not make a legitimately authorized malicious firmware image safe, and thresholds do not create independence when one operator controls every signer.

High-consequence changes require separately held approvals, bounded deployment cohorts, and independent observation. Diversify implementations where it removes a known shared failure path. Using different keys with two copies of the same buggy verifier does not provide independent verification.

The installer must preserve authority and data-version semantics while staging or rolling back an update. An older binary may be incompatible with newer persistent state or vulnerable under a retired policy. Reverting executable bytes cannot rewind operation history, nonce allocation, or receiver acceptance state. Safe rollback may require a forward repair into a fresh generation.

## Boot and root replacement

Each independent domain boots from its own authorized root and verifies the enforcement configuration before opening data/effect paths. Attestation identifies that root and configuration. Other realms decide whether to accept it; no global attestation service can require acceptance.

Replacing a root, enabling debug, changing an isolation profile, or reassigning a sovereign physical port is an exceptional local action with explicitly defined authority. Data owners determine whether retained secrets survive such a transition. A service/debug mode can require erasing secrets before access. The implementation must perform that erasure, and tests must establish it. Policy text cannot erase a secret.

Physical manufacturing tests, scan chains, field diagnostics, and package controllers belong in the path inventory. If a shared controller can put every guard into debug, those guards do not provide independent resistance to that controller's compromise.

## Recovery and partitions

The recovery controller first closes affected paths. It identifies reliable state, isolates suspect devices/roots, preserves required evidence within its classification, and establishes fresh execution/session generations wherever continuity is uncertain. Unaffected domains can continue within their independently reserved resources and authority.

Lost object state, lost keys, lost operation receipts, and lost availability have different remedies. Recovery contracts name who can decrypt restored data, which authorities must approve, which controls prevent rollback, and which uncertain outcomes recovery must report. A hidden universal recovery key would violate the recovery contract.

Distributed policy groups may use consensus or threshold authorization, but must state membership, failure bounds, quorum, and partition behavior. Installers stop safety-critical authority expansion when any required approval is missing. Preauthorized local safety actions can continue within a bounded envelope; a partition creates no new cross-realm rights.

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

The dependency analysis constructs failure sets showing which targets one compromise can affect. A set can include an administrator, compiler defect, signing service, shared power controller, or software exploit. A minimal cut set identifies a smallest set of failures that defeats a claimed boundary. That analysis is useful only if the dependency graph includes the real bypasses. Do not calculate independence by multiplying arbitrary failure probabilities.

## Observation and audit

Log owners protect audit objects under explicit classification, retention, integrity, and volume limits. Security monitoring does not authorize a passive tap to read every secret. Independent witnesses can detect conflicting update histories when they receive the relevant evidence, but a hash chain or replicated ledger cannot prove an event that no witness observed.

Security response must continue when the AI is unavailable or malicious. Deterministic revoke, local stop, and recovery controls must retain their own authority paths. The AI can help explain events without controlling those paths.

**Open research:** practical distributed authority without an emergent universal control plane, recovery that preserves confidentiality and durable effect history, diversity that reduces actual shared dependencies, and usable policies for root evolution over decades. A full-root compromise remains catastrophic within that root's disclosed reach; the target limits that reach through independent domains.
