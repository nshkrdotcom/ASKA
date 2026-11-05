# ASKA v6 — Protected security response, containment and recovery

**Status:** normative authority and state-transition contract for security effects. Observation does not authorize intervention, and intervention does not imply permission to rewrite governance, destroy data or impersonate recipients.

## 1. Separate detection from effect finality

An anomaly detector, watcher or analysis hub may request a protective effect, but only a protected effect owner determines whether the effect takes place. A response request is evaluated against the ordinary Accord tuple: source and recipient, method, target and generations, data classes, governance profile, authority and obligations, budget, expiry, approved output and witnesses. The target's local root may require independent consent or emergency authorization. A valid security alarm is not a universal exception to information-flow policy.

A response controller has no ambient access to IES memory, arbitrary packet injection, user files or update signers. It invokes a small typed interface of **preinstalled protective templates** whose implementation and maximum scope have been independently approved and verified. An external security service must not remotely load an executable kernel module or arbitrary dynamic library into the protected workload as its ordinary response mechanism.

## 2. Response templates

| Template | Allowed meaning | Required bound | Explicit nonpermission |
|---|---|---|---|
| `FREEZE_EGRESS` | Prevent future transfers from a named queue/IES/port | Object and IES generation, egress IDs, lease | Read plaintext or alter prior delivered messages |
| `NARROW_GRANT` | Replace a live grant with a strict subset | Old and new grant digests, target root, revocation order | Broaden scope, add recipients, reset a spent budget |
| `QUARANTINE_CELL` | Isolate a specified cell and cancel admitted future effects | Cell generation, protected queue drain, state ownership | Destroy unrelated IESs or silently corrupt persistent state |
| `SUSPEND_EFFECT` | Hold a specific pending external effect | Effect ID and prepare/commit state | Falsify that an irreversible effect was undone |
| `ISOLATE_PORT` | Disable a defined protected egress or link | Port ID and local safety profile | Cut independent witness/recovery paths automatically |
| `SAFE_STATE_DEVICE` | Request a device's separately verified safe-state operation | Device identity, authorized command, physical safety contract | Issue arbitrary actuator commands |
| `REQUEST_REVIEW` | Present incident and bounded options through trusted UI | Canonical incident and proposed terms | Interpret model prose as approval |
| `ROLLBACK_STAGED_UPDATE` | Restore an approved compatible prior image on named targets | Provenance, antirollback and state-compatibility rule | Override cryptographic floor or mass-reimage unseen targets |

Templates are not assumed safe by their names. The implementation must specify their actual hardware/firmware effects and test crash behavior, race behavior, target reuse and protected receipt semantics. A `SAFE_STATE_DEVICE` can be dangerous on a real plant and may require an independent safety authority. `QUARANTINE_CELL` may sacrifice service; test that it cannot cross into an uninvolved realm.

## 3. Response state machine

```text
OBSERVED -> TRIAGED -> PROPOSED -> ADMITTED -> PREPARED
  -> APPLIED -> VERIFIED -> {ACTIVE, EXPIRED, REVERSED}

OBSERVED/TRIAGED/PROPOSED -> DISMISSED
PROPOSED/PREPARED -> REJECTED | EXPIRED | UNCERTAIN
APPLIED/VERIFIED -> UNCERTAIN  (if authoritative effect proof is lost)
```

A `PROPOSED` response is not an active grant; `ADMITTED` records a policy decision, not hardware completion. `PREPARED` reserves resources and ensures the target generation is live. `APPLIED` requires the specific effect owner's acknowledged commit. `VERIFIED` is independent observation of the effect within a stated coverage profile; a watcher may fail to verify an effect even though it was applied. `UNCERTAIN` is preserved instead of fabricated success or failure. Receipt types and durability follow [04](04_accord_objects_and_schemas.md) and [14](14_persistence_and_effects.md).

## 4. Monotonic narrowing and privilege expansion

Under a live compromise, automatic security action is normally restricted to **monotonic reductions** in authority: no new recipients, methods, identity scope, data-release rights or resource budgets. If a response needs new permissions for recovery, key rotation, code deployment or data extraction, it is a *separate governed operation*. New privileges require independently scoped approval, a protected installation path and any rights of the affected realm.

Even narrowing can be dangerous. An attacker can weaponize repeated `FREEZE_EGRESS` requests to cause downtime or suppress evidence. Each response is charged against site and actor budgets, rate-limited, deduplicated by incident commitment, and subject to anti-denial safety policies. The system measures false containment and preserves essential service reservations. Under ambiguous sensor evidence, `REQUEST_REVIEW` or scoped degradation may be preferred to an unbounded response.

## 5. Ordering and race safety

The response owner resolves current resource generation and installs a gate change at the point where an effect becomes irrevocable. It must serialize with in-flight transfers and durable commits; updating a policy field after a NIC has already emitted a record cannot undo that disclosure. For a revoked capability, deny new submissions and either complete or safely abort already prepared operations according to their allowed effect contract. A stale quarantine command cannot apply to a new occupant of a reused cell or port.

An automatic reset must drain or fence DMA, revoke stale aliases, account for retained encrypted records, sanitize private memory, verify persistent owner state and distinguish aborted from externally committed operations. A checkpoint outside the trusted boundary is untrusted input on restore. Recovery must not use an unspecified management network as a bypass for forbidden normal transfers.

## 6. Feedback paths and independent authority

The analysis hub's output is a typed proposal delivered to a protected request validator. It is not a control packet sent into the monitored OS or upstream through the MSM-to-LSM distribution diode. If a new security policy is required, a separate change contract passes independent policy/root review, signing, staged deployment and local admission. The protected distribution source cannot treat watcher testimony as an instruction without authorization.

Steles may witness incident phase commitments, rejected attempts and dispute/notice obligations. Witness disclosure is constrained by the incident's data categories. A false-positive incident may require a user-visible correction without revealing a private evidence store to all affected parties. Human emergency overrides must be typed, expiring, reviewable and constrained by the independent roots they are permitted to affect.

## 7. Disconnected operation

A local response controller continues to enforce minimum policy when the MSM, cloud analyst or watcher reports are unavailable. Each deployment declares whether it can enter locally verified restricted operation, whether it must suspend specific sensitive effects, and how long stale policy remains safe. Safety cannot depend on a continuously reachable central classifier; liveness cannot be promised without surviving resources and communications. If a local controller itself loses trustworthy protected time or state, it denies time-sensitive new rights rather than treating elapsed leases as current.

## 8. Required negative tests

Submit: forged high-confidence alerts, unsigned model instructions, compromised LSM reports, stale cell IDs, replayed response grants, two racing quarantine commands, operator denial-of-service via false alarms, a revoked-but-in-flight transfer, a remote update disguised as a `NARROW_GRANT`, and a safety-critical port disconnect. Expected outcomes are scoped denial or safe uncertain state, with explicit false-positive service impact. A response service must demonstrate that a fully compromised AI analyst cannot add an independent signer, disclose restricted data or reboot unrelated machines. Cross-reference [37](37_watcher_independence_and_meta_monitoring.md), [40](40_update_supply_chain_and_evolution.md) and [43](43_security_mesh_formal_model_and_test_vectors.md).
