# ASKA v3 — Authority and information flow

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0011_compute_isa_and_ies_gpt.md) · [Next](0013_memory_ownership_and_lifecycle_gpt.md)

ASKA scopes authority to objects and confidentiality categories to realms. Object capabilities limit access, but code that can read an object can copy its contents. Execution-domain confinement restricts where those copies may go.

## Authority records

A protected grant names its issuer, subject, object and generation, permitted operations, delegation limits, resource budget, expiry, and revocation generation. An ordinary caller can select a grant handle; it cannot edit the resolved record.

| Authority | What it answers |
|---|---|
| Access capability | May this execution context read or modify this allocation? |
| Execution policy | Which confidential categories may this context observe, and what restrictions must its outputs inherit? |
| Operation grant | May this subject invoke this destination effect? |
| Receiver consent | Does the destination owner currently accept this operation and source? |
| Transit grant | May this record use this forwarding resource? |
| Release grant | May a particular result cross an otherwise forbidden confidentiality boundary? |

Delegation intersects rights, lifetimes, and budgets. Shared budgets need protected accounting: delegating the same allowance to two children must not double it. Separate key roles govern identity ownership, grant issuance, attestation appraisal, and policy installation.

## Categories and local meaning

The initial v3 policy represents a confidentiality label as a finite set of categories, for example:

```text
{realm-A/project-7, realm-A/customer-19}
```

In this model, `L1 <= L2` means `L1` is a subset of `L2`. A destination with confinement label `L2` may accept input labeled `L1` when that relation holds and its other permissions allow it. Combining information joins categories by set union. Public is the empty set.

Category names are scoped to a realm authority. Two realms using the string `project-7` do not thereby agree about it. Admission installs an explicit immutable mapping. An unmapped category denies transfer. No universal global classification vocabulary is required.

The parser resolves label codes to interned protected objects; it does not parse unbounded category strings. A session can map a compact code to a bounded set. The lab profile caps a label at 32 categories and installs at most 64 label codes per directional session; these are experimental capacity choices. Overflow denies admission or requires a separately negotiated profile.

Producer assertions and endorsement policy govern integrity separately. An authenticated confidential object may contain false data; its categories establish neither measurement accuracy nor trusted computation.

## Execution rule that avoids false low labels

Each request domain receives a fixed confinement set `C` before it starts. It can read objects whose category sets are subsets of `C`. All objects it creates or mutates inherit at least `C`, unless a separately trusted release path applies. A recipient must be permitted to confine those categories.

Under this rule, even a constant produced by a confidential worker inherits its confinement. Object access checks cannot determine whether an output depends on a secret. A future instruction-level IFC profile could track values and control dependencies more precisely, but would need its own model and implementation.

An execution domain cannot read a confidential object and then obtain a lower output label merely by passing a different destination capability. Lowering its confinement requires destruction and clean re-creation, or explicit release. A dynamic join-on-input variant must serialize label changes with outgoing snapshots and every thread sharing that domain; it is outside the first implementation profile.

## Prevent label accumulation through application structure

Create a fresh worker for each request and give it only the categories and operations that request needs. Retire it after completion and sanitize its resources before a new lower-confidentiality request uses them.

For diagnostic analysis:

| Component | Inputs and authority | Output |
|---|---|---|
| Restricted analysis worker | Project measurements; restricted analysis destination | Restricted result |
| Public health service | Independently generated public health state; no measurement reads | Public health report |
| Release service, if required | Explicit restricted inputs and a reviewed aggregation contract | A specifically permitted public aggregate |

The public health service cannot claim a secret-derived job outcome is public merely because it calls the result “status.” Completion, errors, and timing may disclose information. If public reporting depends on secret work, define and authorize that release or keep it restricted.

This decomposition adds worker lifecycle costs, more compartments, and explicit shared-state management. Measure startup cost, denied useful operations, release frequency, and policy maintenance. Finer categories make policy more precise, but still trade confinement against useful communication.

## Controlled release

A release service performs a narrowly defined trusted computation under an explicit input and output contract. Its protected release record binds:

```text
input policy / input selection rule
output allocation generation and snapshot commitment
destination object and operation
source categories and permitted resulting categories
validity interval, maximum uses, and aggregate budget
release-service identity and policy revision
```

The output cannot be changed after the release record is approved. A use limit is consumed in protected state before emission; crash uncertainty must not resurrect uses. The receiver independently decides whether it accepts that service and release scope.

Repeated calls can disclose information even when each output lies in a restricted range. Reviews must cover input manipulation, repeated aggregates, error behavior, and timing. A generic `declassify=true` flag cannot express these restrictions and is excluded.

The first implementation omits downgrade and denies all downward category flows. The release interface leaves room to add a reviewed implementation later. The initial experiment can measure blocked useful work while keeping downward flows denied.

## Effect authority for autonomous software

An agent proposes operations; the gate resolves their authority from installed grants for a mailbox, service method, or device command. Generated plans, tool descriptions, and retrieved documents cannot grant permission.

An append-only telemetry grant does not authorize a control-setpoint change. An application gateway that translates an allowed mailbox message into a physical effect becomes part of that effect's trusted boundary. Transport delivery and physical execution have different commit points.

Multi-party approval and separation of duties require protected transaction state. A packet signature cannot establish that two independent approvals exist unless their identities, scope, freshness, and consumption are checked.

## Receiver policy remains independent

At delivery, require source authority, permitted category flow or release, current receiver consent, current session validity, and resource availability. A source issuer cannot install receiving policy. Receiver narrowing can take effect without obtaining source approval. Broadening a source's disclosure mapping requires new bilateral admission.

Foundations and comparisons are listed in [0019](0019_implementation_contracts_and_sources_gpt.md): capabilities for object authority; Denning-style category ordering, DStar, and Fabric for information flow; narrowly scoped release for exceptions. These mechanisms are established work; ASKA specifies their composition and the tests it needs.
