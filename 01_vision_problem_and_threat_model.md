# 01 — Vision, problem, and threat model

[Start](README.md) · [Next: IES execution and authority](02_ies_execution_and_authority.md)

ASKA aims to limit what a compromised component can access, disclose or cause at each boundary. The component may be an application, an operating system, a device, an accelerator driver, or a network controller. The question is how to maintain those limits across the system when a broadly privileged software layer is compromised.

Processor organization and communication may need substantial changes. Each change needs a stated benefit, assumptions and cost. The research begins with one path through the larger architecture.

Separation and mediated cross-domain communication are established architectural approaches ([Rushby separation](07_prior_art_and_sources.md#g01), [EURO-MILS](07_prior_art_and_sources.md#mils)). Distributed restrictions between participants that distrust each other are studied by [DStar](07_prior_art_and_sources.md#c05), [Fabric](07_prior_art_and_sources.md#c06), [Ryoan](07_prior_art_and_sources.md#ry). These systems provide the starting comparisons for evaluating the proposed IES design.

## A concrete failure to study

Consider two organizations exchanging diagnostic data. A source machine holds restricted measurements. A receiving organization permits those measurements into a particular protected analysis service. The source also has a public status channel.

In a configuration where a host kernel can read all the measurements, control the NIC's DMA descriptors, and invoke the relevant network credentials, compromising that kernel can give an attacker the means to send restricted data through an otherwise valid connection. Encryption can hide that unauthorized transmission from outsiders while delivering it to the chosen destination. Authenticating an endpoint does not establish that every operation initiated by that endpoint is authorized.

The weakness depends on the configuration. Existing systems offer compartmentalization, device isolation and protected key custody that can prevent it. ASKA must be compared against the strongest relevant configurations, including the costs and trust they require.

In particular, [Ryoan](07_prior_art_and_sources.md#ry), [SENG](07_prior_art_and_sources.md#seng), [attested TLS](07_prior_art_and_sources.md#e08) address protected computation or channel endpoints on hostile infrastructure; [Composite Enclaves](07_prior_art_and_sources.md#a12), [ACAI](07_prior_art_and_sources.md#a14), [TDX Connect](07_prior_art_and_sources.md#e05) extend protection toward devices. Their trusted computing bases (TCBs) differ. Comparisons must include these systems as well as an ordinary kernel-owned TLS endpoint.

The example requires the following outcomes:

| Attempt | Intended outcome |
|---|---|
| Restricted source cell sends to the receiver's approved restricted mailbox | Accept within the installed scope and resource budget |
| The same cell sends restricted data to the public status mailbox | Deny unless an independently authorized release applies |
| Host software changes a valid message's destination or operation | Deny |
| A DMA device substitutes the buffer after validation | Prevent substitution or deny the transfer |
| An ordinary route controller selects an unauthorized protected egress | Deny at that egress, if the physical-fabric claim is being tested |
| The source presents valid credentials after the receiver withdraws acceptance | Deny once the receiver's withdrawal is effective locally |

An approved receiver can still receive false, useless, or malicious content within an authorized operation. The gate enforces permission to deliver; it cannot determine whether the content is true or the application is correct.

## The boundary-continuity hypothesis

The proposed rule is that authority and data restrictions survive changes in representation. A local reference may become a queue entry, a DMA operation, a ciphertext record, and finally a protected receive buffer. Each conversion needs an explicit justification.

Related work includes exporter checks and mappings in [DStar §§3.1–3.2,4.2](07_prior_art_and_sources.md#c05), distributed policies in [Fabric](07_prior_art_and_sources.md#c06), delegation and flow reasoning in [FLAM](07_prior_art_and_sources.md#c07), and component contracts in [CONTINUITY](07_prior_art_and_sources.md#f01). The [execution-finality drafts](07_prior_art_and_sources.md#f02), [CVID profiles draft](07_prior_art_and_sources.md#cv) and [silicon-finality draft](07_prior_art_and_sources.md#cvs) propose checking current authority where an action takes effect. These individual drafts have neither IETF standards status nor validated IES hardware. The overlap gives no basis for claiming “boundary continuity” as an ASKA invention.

For a single accepted operation, the intended rule is:

```text
permitted operation =
    source authority
  AND permitted information flow or explicit release
  AND receiver acceptance
  AND applicable transport authority
  AND current freshness and resource constraints
```

Each predicate has its own meaning and evidence requirements. A memory capability, a data classification, and permission to operate a remote actuator answer different questions.

Continuity is also about receiving. A correctly authenticated packet loses its practical restriction if the receiver then places its plaintext in memory readable by the compromised host kernel. The protected path must end at the object or execution domain named in the acceptance decision.

Protected receive placement and independent checks have separate precedents in [M³](07_prior_art_and_sources.md#a01), [DStar](07_prior_art_and_sources.md#c05), [Ryoan](07_prior_art_and_sources.md#ry). For the proposed ordering of resource accounting, replay updates and publication, see [the ESP comparison](07_prior_art_and_sources.md#esp) and [Document 08, statement 5](08_defensive_structural_disclosure.md#protected-receiver-acceptance).

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

An implementation may combine these functions. It must identify the hardware and firmware responsible for each one, along with its provisioning and update authorities.

The distinction between attester, verifier and relying party follows [RFC9334](07_prior_art_and_sources.md#e03); for device measurement and protected assignment, see [SPDM](07_prior_art_and_sources.md#e04), [TDX Connect](07_prior_art_and_sources.md#e05), [OpenTitan](07_prior_art_and_sources.md#ot). [CURE](07_prior_art_and_sources.md#a13), [Composite Enclaves](07_prior_art_and_sources.md#a12), [OctopOS](07_prior_art_and_sources.md#a10) illustrate which monitors, device firmware and management paths must remain trusted. Identify those components in each comparison.

A candidate fails this threat model if the compromised host can read protected plaintext or impersonate every protected source. Packet checks cannot undo access that has already occurred. A simulation can assume such separation; hardware evidence must establish how it is enforced.

## Three claims that must remain separate

**Constrained acceptance.** A receiving gate delivers a message only when its authenticated content and operation satisfy the receiver's current policy. This can be studied across untrusted transport. An attacker may still copy ciphertext, disrupt delivery, and observe exposed metadata.

**Constrained physical forwarding.** A named protected egress forwards only traffic permitted there, despite a hostile ordinary controller. This requires a mandatory gate on that egress, trusted port binding, and a topology that includes alternate paths. An encrypted tunnel over an uncontrolled carrier does not establish this property for the carrier's internal cables.

**Information-flow security.** Protected information cannot influence a disallowed observation except through an explicitly authorized release. This is stronger than checking labels on packets. The observer model must state whether it includes output values, message existence, sizes, termination, timing, resource contention, or physical emissions. The initial handoff study checks explicit labeled transfers and treats timing and traffic analysis as unresolved extensions.

The first claim can succeed while the second or third fails.

The comparisons differ accordingly: [DStar](07_prior_art_and_sources.md#c05), [TVA](07_prior_art_and_sources.md#d06) for controlled delivery, [ICING](07_prior_art_and_sources.md#d01), [EPIC](07_prior_art_and_sources.md#d03), [SCION](07_prior_art_and_sources.md#d10), [FABRID](07_prior_art_and_sources.md#d04) for consent/path evidence, and [SAFE](07_prior_art_and_sources.md#c01), [HyperFlow](07_prior_art_and_sources.md#c03), [seL4 IFC proofs](07_prior_art_and_sources.md#c11), [time protection](07_prior_art_and_sources.md#c12) for information-flow and temporal models. These comparisons address logical paths and information flow; they supply no proof of physical geography. Results must state which property was tested.

## What the initial model excludes

The initial safety model assumes correct enforcement hardware and excludes invasive probing, malicious fabrication, and compromise of the protected policy or release implementations. It does not claim protection against cache, DRAM, power, thermal, electromagnetic, or packet-timing channels. These exclusions set the first model's scope; [Document 05](05_costs_limits_and_open_questions.md) keeps their implications visible for the eventual architecture.

Availability is conditional. A malicious router can drop all traffic; an attacker can cut power or saturate an upstream link. Useful service can be promised only under stated assumptions about surviving resources, admission, scheduling, and offered load. The experiment must also demonstrate successful authorized transfers.

Key compromise is a separate experiment with a narrower expected result. If the source issuer is compromised, it may exploit whatever scope the receiver already accepts. The required result is that it cannot expand the receiver's independently installed permissions. A stolen accepted key remains dangerous until expiry, revocation, or another effective constraint intervenes.

Once a recipient legitimately obtains information, ASKA cannot make that recipient forget it.

Continued distributed IFC relies on trusted enforcement for the relevant principal/category, as in [DStar §§3.2–3.3](07_prior_art_and_sources.md#c05) and [Fabric](07_prior_art_and_sources.md#c06). Independent administration alone does not establish that the recipient enforces the required post-delivery policy.

## Why the full IES vision remains open

The initial example crosses only a small part of the possible machine. A long-term IES architecture may organize heterogeneous compute cells, protected memory pools, accelerator access, on-chip channels, and external fabrics around the same boundary contract. It may favor dedicated resources for some domains and controlled sharing for others.

Which arrangement is worthwhile remains a research question. A new instruction set could help if existing execution semantics make a necessary invariant impractical. Reusing an ISA could preserve substantial compiler and software investment. Either choice still requires enforcement in the surrounding memory and device system.

Choose hardware by the properties it must enforce. If a simpler architecture meets the same threat model and service needs at lower cost, that is evidence ASKA should use. If an existing abstraction cannot express a needed boundary without trusting the compromised host, that is a reason to investigate a different abstraction.

Compare the machine options with [M³](07_prior_art_and_sources.md#a01), [untrusted-core isolation](07_prior_art_and_sources.md#a02), [TEEM³](07_prior_art_and_sources.md#a03), [CHERI](07_prior_art_and_sources.md#b01), [CHERIoT](07_prior_art_and_sources.md#b02), [HyperFlow](07_prior_art_and_sources.md#c03), [information-flow ISA](07_prior_art_and_sources.md#c04). Reusing, extending or replacing an ISA remains a design choice whose value needs evidence. [TEEM³](07_prior_art_and_sources.md#a03) still needs a full-text comparison when access is available. Its abstract and artifact description leave some mechanisms unresolved.
