# ASKA 2.0 — Research Architecture

**ASKA 2.0 · 21 October 2026**

ASKA explores how a computer can enforce authority across execution, memory, devices and networks. Each participant has explicit limits on what it may access, disclose or cause. Its central unit is the **Isolated Execution Stack (IES)**, a proposed hardware-enforced compartment spanning computation and its relevant resources.

An IES combines established mechanisms. Separation, externally enforced heterogeneous cells, distributed IFC and protected cross-provider computation already have close precedents: [Rushby separation](07_prior_art_and_sources.md#g01), [M³](07_prior_art_and_sources.md#a01), [untrusted-core isolation](07_prior_art_and_sources.md#a02), [Composite Enclaves](07_prior_art_and_sources.md#a12), [DStar](07_prior_art_and_sources.md#c05), [Ryoan](07_prior_art_and_sources.md#ry). ASKA needs to specify its requirements and compare them with these systems.

The long-term vision includes heterogeneous IES cells, protected on-chip and external fabrics, independently governed receiving systems, and constrained autonomous software. The first study asks:

> Can a system preserve the meaning of an authorization as data moves from protected computation, through memory and devices, into a network message, and into another independently governed machine—even when ordinary operating systems and routing controllers are compromised?

Answering this requires tracing authority and data classification through each representation change and identifying the components that must remain trusted. An authenticated connection addresses only part of that problem.

ASKA is an independent architecture investigation. It has **no fabricated silicon, implemented ASKA protocol, measured performance results, or completed security proof**. The design uses existing cryptographic primitives and leaves the ISA undecided. A new ISA remains a research option if the required execution semantics justify one. Existing instruction sets and components are comparison points and possible building blocks.

## The architecture in one view

```mermaid
flowchart LR
  subgraph A[Administrative realm A]
    AC[Protected policy and key authority]
    IES[IES computation and protected memory]
    EG[Memory, DMA, and egress enforcement]
    AC -.-> EG
    IES --> EG
  end
  EG --> N[External transport]
  subgraph B[Administrative realm B]
    BC[Independent receiving authority]
    IG[Ingress and placement enforcement]
    DST[Receiving IES]
    BC -.-> IG
    IG --> DST
  end
  N --> IG
  U[Ordinary OS and route controllers] -.->|requests and route proposals| EG
  U -.->|requests and route proposals| IG
```

The diagram leaves two enforcement problems to explain. Authenticated encryption can protect a message over untrusted transport. Preventing that message from traversing a particular physical port requires enforcement at that port and an accurate account of the topology. The documents examine these properties separately.

## Reading the set

| Document | Question it answers |
|---|---|
| [01 — Vision, problem, and threat model](01_vision_problem_and_threat_model.md) | What is ASKA trying to change, and against which adversary? |
| [02 — IES execution and authority](02_ies_execution_and_authority.md) | What makes an IES a security boundary, and where does its authority come from? |
| [03 — The protected handoff](03_protected_handoff.md) | How could a buffer become an authorized message without losing its restrictions? |
| [04 — Network transport and independent realms](04_network_transport_and_realms.md) | What must travel on the wire, what state remains, and what can a receiver independently refuse? |
| [05 — Costs, limits, and unresolved questions](05_costs_limits_and_open_questions.md) | Where can the architecture become too expensive, too restrictive, or incorrect? |
| [06 — Research plan and evidence](06_research_plan_and_evidence.md) | What useful work can be done before hardware, and what would falsify a candidate? |
| [07 — Prior art and sources](07_prior_art_and_sources.md) | Which ideas already exist, and what comparisons remain necessary? |
| [08 — Defensive structural disclosure](08_defensive_structural_disclosure.md) | Which precise lifecycle, handoff and receiver relationships are specified, and what prior art and missing support constrain them? |

Read 01–03 for the core argument. Read 05 before deciding whether its costs could be acceptable. Document 06 is a starting point for contributing an analysis, counterexample, or experiment.

Document 08 is an open defensive structural disclosure with seven statements specifying compartment lifecycle, protected source handoff and receiver acceptance. Each independent statement specifies the ordering and protected paths it requires. Physical forwarding still needs a specified protocol. No patent application is being filed as part of this release; the statements do not establish novelty or patentability.

The [source register](07_prior_art_and_sources.md) identifies existing mechanisms, closest comparisons and inspection limits. [Document 08](08_defensive_structural_disclosure.md#prior-art-and-scope) distinguishes the established components from each specified relationship and maps missing implementation evidence. Failing to find a match does not establish novelty. A useful comparison must identify differences in requirements, assumptions or cost.

## What ASKA 2.0 commits to

ASKA places IES enforcement in hardware. An ordinary host kernel is not the final authority over an IES boundary. A routing controller may select permitted routes; it cannot create permission merely by installing a route. A receiving realm retains its own decision. Recovery, debug, and device access must obey explicit boundaries too.

The architecture does **not** yet commit to one core design, a universal label format, a new Internet protocol, or dedicated hardware for every logical process. Those decisions depend on the properties and costs established through research. A small experiment can test a requirement while leaving the rest of the machine undecided.

The first study uses coarse compartment labels and a bounded message handoff. It checks source ownership and mapping through copying, receiver-controlled policy installation, and acceptance ordering. The checks distinguish snapshot integrity and source lifetime from delivery permission, receiver authority and acceptance atomicity. The feasibility of the full IES architecture remains open.

## How to interpret claims

**Existing work** is attributed beside its discussion and through the [source register](07_prior_art_and_sources.md). **Proposed mechanisms** describe designs to investigate. **Derived examples** show arithmetic under stated assumptions. **Open questions** identify missing decisions or evidence. None of these categories implies a measured ASKA result.

Useful outcomes include a better architecture, a component worth building, a counterexample, or evidence that an existing system already meets the requirements.

The earlier repository, including its original README, is preserved in [ASKA_v1](https://github.com/nshkrdotcom/ASKA/blob/main/ASKA_v1/ARCHIVE_NOTICE.md). It is historical material; its patent-portfolio language, performance assertions, and proposed specifications are not evidence of granted patents or validated results. The ASKA 2.0 documents at the repository root describe the current research position.

## License and reuse

The original documentation and diagrams in this repository are licensed under [Creative Commons Attribution 4.0 International](https://github.com/nshkrdotcom/ASKA/blob/main/LICENSE), including the historical archive except where separate terms are identified. You may share and adapt this material, including commercially, with attribution and an indication of changes. Third-party quotations, linked publications, and other separately attributed material retain their own terms.

Suggested attribution: **Paul Lowndes and ASKA contributors, ASKA 2.0**, with a link to [this repository](https://github.com/nshkrdotcom/ASKA) and the commit used. This is a copyright license, not a public-domain dedication or a patent license. See [Document 08](08_defensive_structural_disclosure.md) for the defensive-publication intent and its limits.

## Contributing

Useful contributions include counterexamples, missing references, corrected assumptions, and small models or measurements that test a stated property. Cite the relevant document and distinguish a proposal from an observed result. Original documentation contributions are accepted under the repository's CC BY 4.0 license; identify any third-party material and its terms.
