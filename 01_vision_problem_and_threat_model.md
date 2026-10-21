# 01 — Vision, problem, and threat model

[Start](README.md) · [Next: IES execution and authority](02_ies_execution_and_authority.md)

ASKA's architectural ambition is to make a compromised component encounter enforceable limits at every relevant boundary. The component may be an application, an operating system, a device, an accelerator driver, or a network controller. The proposal asks how those limits could compose across a complete system rather than depend on one broadly privileged software layer behaving correctly.

This ambition allows substantial changes to processor organization and communication. It also creates a burden: each change must explain which property it improves, which assumptions it needs, and what it costs. The research begins with one path through the larger architecture.

## A concrete failure to study

Consider two organizations exchanging diagnostic data. A source machine holds restricted measurements. A receiving organization permits those measurements into a particular protected analysis service. The source also has a public status channel.

In a configuration where a host kernel can read all the measurements, control the NIC's DMA descriptors, and invoke the relevant network credentials, compromising that kernel can give an attacker the means to send restricted data through an otherwise valid connection. Encryption can protect the malicious transmission from outsiders while faithfully delivering it. Authenticating an endpoint does not establish that every operation initiated by that endpoint is authorized.

This is a **configuration-dependent authority problem**. Existing systems already offer forms of compartmentalization, device isolation, and protected key custody. The claim is not that every current machine has the same weakness. ASKA must be compared against the strongest relevant configurations, including the costs and trust they require.

The target example is precise:

| Attempt | Intended outcome |
|---|---|
| Restricted source cell sends to the receiver's approved restricted mailbox | Accept within the installed scope and resource budget |
| The same cell sends restricted data to the public status mailbox | Deny unless an independently authorized release applies |
| Host software changes a valid message's destination or operation | Deny |
| A DMA device substitutes the buffer after validation | Prevent substitution or deny the transfer |
| An ordinary route controller selects an unauthorized protected egress | Deny at that egress, if the physical-fabric claim is being tested |
| The source presents valid credentials after the receiver withdraws acceptance | Deny once the receiver's withdrawal is effective locally |

An approved receiver can still receive false, useless, or malicious content within an authorized operation. Confinement does not establish scientific truth, benevolent intent, or application correctness.

## The boundary-continuity hypothesis

The proposed property is that a change in representation does not silently enlarge authority or weaken the restrictions associated with data. A local reference may become a queue entry, a DMA operation, a ciphertext record, and finally a protected receive buffer. Each conversion needs an explicit justification.

For a single accepted operation, the intended rule is:

```text
permitted operation =
    source authority
  AND permitted information flow or explicit release
  AND receiver acceptance
  AND applicable transport authority
  AND current freshness and resource constraints
```

This is a conjunction of predicates with different meanings, not a claim that all authority can be represented by one interchangeable token. A memory capability, a data classification, and permission to operate a remote actuator answer different questions.

Continuity is also about receiving. A correctly authenticated packet loses its practical restriction if the receiver then places its plaintext in memory readable by the compromised host kernel. The protected path must end at the object or execution domain named in the acceptance decision.

## The adversary and the remaining trust

The initial investigation grants the attacker control of ordinary host operating systems and hypervisors, workload code within its assigned rights, ordinary NIC and accelerator drivers, route controllers, and untrusted network links. The attacker can request operations, race descriptors, replay traffic, reorder or drop records, and exhaust exposed queues. It can run malicious software inside an IES; that software still faces the IES's external boundaries.

The hypothesis depends on the following components behaving as specified:

| Trusted function | Why it is needed | Consequence if it fails |
|---|---|---|
| Memory, DMA, and interconnect enforcement | Stops access and identity spoofing across cells | Plaintext or authority can escape before packet checks |
| Protected policy installation and key custody | Keeps ordinary software from rewriting rights or extracting session secrets | Valid-looking evidence can be forged or policy broadened |
| Classification at protected inputs and transfers | Establishes the restrictions that egress enforces | A false low classification can be authenticated perfectly |
| Any authorized release component | Decides the specific disclosure exception | Restricted information can leave through a valid exception |
| Receiving gate and protected placement | Enforces independent acceptance and local confinement | An accepted record can be exposed or misdelivered |
| Protected state and elapsed-time source where used | Bounds replay, rollback, and lease lifetime | Old permissions or nonce values may become usable again |

These are functions, not necessarily six chips. A candidate implementation must identify the hardware, firmware, provisioning, and update authorities that implement each one. Naming a root-of-trust product does not supply the rest of the design.

The distinction between an ordinary host and protected execution is decisive. If a candidate allows the compromised host to read the protected plaintext or impersonate every protected source, it does not meet this threat model. No downstream packet format can repair that access. A simulation can assume such separation; hardware evidence must establish how it is enforced.

## Three claims that must remain separate

**Constrained acceptance.** A receiving gate delivers a message only when its authenticated content and operation satisfy the receiver's current policy. This can be studied across untrusted transport. An attacker may still copy ciphertext, disrupt delivery, and observe exposed metadata.

**Constrained physical forwarding.** A named protected egress forwards only traffic permitted there, despite a hostile ordinary controller. This requires a mandatory gate on that egress, trusted port binding, and a topology that includes alternate paths. An encrypted tunnel over an uncontrolled carrier does not establish this property for the carrier's internal cables.

**Information-flow security.** Protected information cannot influence a disallowed observation except through an explicitly authorized release. This is stronger than checking labels on packets. The observer model must state whether it includes output values, message existence, sizes, termination, timing, resource contention, or physical emissions. The initial handoff study checks explicit labeled transfers and treats timing and traffic analysis as unresolved extensions.

The first claim can succeed while the second or third fails. Reporting them separately makes partial results useful without enlarging their meaning.

## What the initial model excludes

The initial safety model assumes correct enforcement hardware and excludes invasive probing, malicious fabrication, and compromise of the protected policy or release implementations. It does not claim protection against cache, DRAM, power, thermal, electromagnetic, or packet-timing channels. These exclusions set the first model's scope; [Document 05](05_costs_limits_and_open_questions.md) keeps their implications visible for the eventual architecture.

Availability is conditional. A malicious router can drop all traffic; an attacker can cut power or saturate an upstream link. Useful service can be promised only under stated assumptions about surviving resources, admission, scheduling, and offered load. A gate that denies everything cannot pass a useful-system experiment.

Key compromise is a separate experiment with a narrower expected result. If the source issuer is compromised, it may exploit whatever scope the receiver already accepts. The target is that it cannot enlarge the receiver's independently installed scope. A stolen accepted key remains dangerous until expiry, revocation, or another effective constraint intervenes.

Once a recipient legitimately obtains information, ASKA cannot make that recipient forget it. Continued confinement requires trust in the recipient's enforcement and applicable policy. Independent administration is not evidence that another organization's post-delivery behavior is trustworthy.

## Why the full IES vision remains open

The initial example crosses only a small part of the possible machine. A long-term IES architecture may organize heterogeneous compute cells, protected memory pools, accelerator access, on-chip channels, and external fabrics around the same boundary contract. It may favor dedicated resources for some domains and controlled sharing for others.

Which arrangement is worthwhile remains a research question. A new instruction set could help if existing execution semantics make a necessary invariant impractical. Reusing an ISA could preserve substantial compiler and software investment. Neither choice establishes the security of the surrounding memory and device system by itself.

The working principle is to derive machinery from required properties. If a simpler architecture meets the same threat model and service needs at lower cost, that is evidence ASKA should use. If an existing abstraction cannot express a needed boundary without trusting the compromised host, that is a reason to investigate a different abstraction.

The closest intellectual comparisons include separation architectures and distributed information-flow systems, as well as capability machines. Rushby's separation work, DStar, and Fabric already explore important parts of this territory. Their existence makes a precise comparison necessary; it does not decide the feasibility of ASKA's proposed hardware composition. See [the prior-art map](07_prior_art_and_sources.md).
