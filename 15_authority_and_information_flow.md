# ASKA v5 — Authority and information flow

## Societal authority is not a confidentiality lattice

Sanctum, Polis, Agora, and Wilder are **relationship and governance domains**, not four ordered secrecy levels. Data labels and confinement categories exist **within and across** planes, and their information-flow ordering is independent of the plane's name. A court claim, familial designation, employer mandate, and vendor contract do not form a universal total order. Accord conflict evaluation yields an explicit disposition; only separately admitted release grants may authorize controlled lowering of confidentiality restrictions.

---

## Detailed technical contract

**Requirements:** R01, R05, R06, R09, R10, R13, R17, R19, R20, R23.

ASKA distinguishes access to data, permission for an effect, information-flow restrictions, receiver consent, and transport authority. Each participant must satisfy every constraint relevant to its operation. One authenticated credential cannot replace those separate decisions with a trust score.

## Scoped authority

An installed grant contains:

```text
issuer and role; subject realm/domain/generation
target object/service and generation; allowed methods
parameter constraints and schema revision
permitted flow/release references
delegation ceiling and parent grant
time/epoch limits; resource reservation or budget parent
revocation and policy versions; approval commitments when required
```

The local enforcement boundary must prevent workloads from forging a grant handle. A receiver imports remote grants as authenticated statements under its own policy; the incoming bytes create no local capability by themselves. The receiver checks issuer authenticity, accepted scope, currentness, and possession constraints independently.

Delegation can narrow object scope, methods, parameters, lifetime, and budgets. It cannot remove a required approval or disclosure restriction. A shared parent budget must serialize consumption or assign disjoint credits in advance. Copying a grant must never copy its remaining allowance.

## Confidentiality and execution confinement

The reference model labels each object with a set of realm-scoped categories. Public is the empty set. `C1 <= C2` means set inclusion. A worker admitted with confinement `C` can read inputs whose categories are subsets of `C`. Its computed values, outputs, and mutable objects inherit at least `C` unless a separately authorized release applies.

Each issuer defines its categories. Admission installs explicit mappings between realms and denies flow for unknown categories. An installer cannot silently change a map under a live contract. A low-integrity sender cannot attach a “public” code and override a source restriction obtained from protected metadata.

The fixed worker rule assigns derived output at least the worker's confinement categories. A constant computed after secret input still inherits the worker's confinement. Fresh workers and smaller task graphs reduce unnecessary category accumulation. Dynamic value/control-flow tracking is an alternative only when its compiler, hardware, devices, and output interfaces implement a sound contract.

The distributed-policy comparisons are [DStar](https://www.scs.stanford.edu/~nickolai/papers/zeldovich-dstar.pdf) and [Fabric](https://www.cs.cornell.edu/andru/papers/fabric-sosp09.html). The two systems use established mechanisms with different trusted runtimes. An ASKA design that uses either mechanism must show how it composes across physical and device boundaries.

## Integrity and endorsement

Integrity assertions identify a producer, validator, measurement, or computation and the evidence supporting it. They are separate from confidentiality categories. Combining an authenticated value with attacker-controlled input does not preserve a trusted semantic assertion automatically.

A decoder may produce `PixelBuffer` with a validated shape. That validation says nothing about whether the picture is truthful. A financial parser may validate an amount's syntax without endorsing the transaction. An endorser needs separate authority to assert a stated property of a specific immutable input.

## Transformation obligations

| Transformation | Restriction and authority obligation |
|---|---|
| Input bytes to local object | Preserve source categories; keep attacker-controlled content low integrity |
| Computation to output | Include data and control dependencies under the execution policy |
| CPU to device or accelerator | Bind input/output ownership and restrictions; validate device assertions separately |
| Object to storage/index/log | Preserve categories, versions, existence leakage, and retention policy |
| Object to network record | Bind stable bytes, source generation, target effect, map, and session |
| Record to receive object | Quarantine, authenticate, consume freshness, check current policy, assign restriction before publication |
| Parsed object to renderer/device | Independently authorize the specific effect; no implicit authority increase |
| Context to AI output or generated code | Treat outputs and artifacts as derived from all permitted context used |
| Telemetry to monitoring | Bound information released through values, errors, rates, and timing |

An object reference can carry authority; copying its raw representation is not always an ordinary data copy. Export requires a delegation operation specifying recipient and attenuation. Schema validators must distinguish data identifiers from imported grant requests.

A validated `PixelBuffer` shape does not establish that a renderer will process it safely. Every later graphics stage retains source confinement and validates the representation it consumes. The independent presentation checks in [17](17_ai_environment_and_trusted_interaction.md) constrain the effect even after renderer takeover; they do not establish that displayed content is truthful.

## Controlled release

A release record binds the source categories, allowed input selection, release-service identity/revision, immutable output commitment, resulting categories, destination, method, validity interval, and reuse/aggregate limits. Source and receiver policies independently accept that service and scope. The enforcing service commits use accounting before emission or effect.

Release semantics must address repeated queries, chosen inputs, error behavior, and timing. Valid values in a bounded numeric field can still encode a secret. An AI summary is not automatically a safe declassification. The semantic release decision belongs to the relevant trusted computing base unless an independent checker establishes the required output relation. A separate release enforcer checks binding, scope, currentness, and use accounting before emitting bytes. It cannot prove an arbitrary report safe merely by comparing its digest with an approval. The assurance record must declare each function's failure scope.

The initial model has no release mechanism and denies all downward category flows. A later release implementation must extend the properties and tests explicitly; it cannot enable an ambient `declassify` permission for every application.

## Access, disclosure, and encryption

Reading a protected object authorizes computation within its confinement. A disclosure to another category set, device, human audience, or realm requires the corresponding flow and effect permissions. Neither fabric membership, device certification, nor a shared administrator provides a missing grant.

Encryption preserves the restrictions of plaintext and its dependencies. An authorized transport key cannot turn an impermissible disclosure into a permissible one. If an application creates opaque ciphertext, the boundary needs a binding to an approved pre-encryption object and protected encryption path, or an explicitly authorized opaque-transfer contract. Scanning ciphertext cannot establish its plaintext meaning. Chosen encryption randomness, padding, record sizes, and error behavior are observations when the sender can influence them.

[19](19_cross_domain_security_and_release.md) defines independent release control, cumulative disclosure accounting, and the limits of semantic review.

## Confused deputies and policy currentness

A valid caller can request only the methods granted to it. A broker cannot combine its broad internal rights with untrusted parameters and call the result authorized. Where a service needs internal access to implement a method, its method semantics and parameter validation become part of that effect's trusted boundary.

Permission checks and the effect commit share an order with policy changes. Preliminary checks can avoid wasted work, but the service must recheck current policy at the irreversible decision. If withdrawal wins that order, the service denies the effect. It cannot recall committed writes, emitted prefixes, or disclosed data.

## Observations and proof obligations

An explicit-transfer model checks whether delivered bytes and effects satisfy the rules. Stronger noninterference compares executions differing in secret input while preserving the declared public observations. The proof must explicitly include or exclude termination, object existence, queue pressure, and timing from its observations.

Physical ownership can reduce shared timing dependencies but does not eliminate power, thermal, clock, or management channels. The target's secrecy contract must name the observation profile that its evidence covers. A proof covering values alone cannot establish that other observations reveal nothing.

**Open research:** scalable category interpretation without global trust, sound labels through accelerators and synthesis, usable narrow release services, and formal composition of source ownership with receiver effects. Counterexamples should cover malicious authorized producers as well as forged credentials.
