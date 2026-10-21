# 08 — Defensive structural disclosure

[Start](README.md) · [Previous: prior art and sources](07_prior_art_and_sources.md)

**ASKA 2.0 · 20 October 2026 · Public technical disclosure**

This document publishes 35 formal structural statements describing selected ASKA mechanisms: IES hardware, protected source handoff, protected receiving, source-side transfer, and physical forwarding enforcement. It retains patent-claim syntax and numbering to make the relationships and alternative embodiments precise and easy to cite.

**Publication intent:** This is an open defensive technical disclosure, not a patent application or an assertion of exclusive rights. No patent application is being filed as part of this release. The purpose is to make the described mechanisms available for examination, discussion, and reuse, including consideration as prior art where applicable.

The original text and diagrams are offered under [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/). That is a copyright license, not a public-domain dedication or a patent license. Publication does not guarantee that every described mechanism is unpatentable, eliminate existing patent rights, or establish freedom to operate. The effect of a disclosure depends on its actual content, public accessibility, relevant dates, and applicable law. [CC BY 4.0 legal terms](https://creativecommons.org/licenses/by/4.0/legalcode.en), [MPEP § 2128](https://www.uspto.gov/web/offices/pac/mpep/s2128.html).

The numbered statements describe the proposed mechanisms. Their claim-like form does not establish novelty, sufficient enabling disclosure, a filing or priority date, or the validity of any later patent. No patent search or freedom-to-operate analysis has been completed. The architecture remains at the research stage described in the preceding documents.

The emphasis is on concrete relationships between protected state, hardware access paths, payload snapshots, and acceptance decisions. Isolation, capabilities, information-flow labels, authenticated encryption, replay windows, and receiver-authorized networking already have substantial histories.

## Claim organization

| Independent claim | Subject | Dependent claims | Architectural focus |
|---:|---|---|---|
| 1 | Computing apparatus with IES boundaries | 2–8 | Source identity, separate resource and flow restrictions, lifecycle, subdivision |
| 9 | Source-side transfer apparatus | 10–18 | Stable payload, protected classification, bilateral scope, authenticated meaning |
| 19 | Receiving apparatus | 20–26 | Independent acceptance, protected placement, replay and publication commit |
| 27 | Method performed at a source apparatus | 28–30 | Obtaining, authorizing, authenticating, and transmitting a protected snapshot |
| 31 | Physical forwarding apparatus | 32–35 | Mandatory egress veto distinct from ordinary route selection |

These groups organize the disclosure; they do not assert that five patentable inventions exist. The apparatus and method formulations deliberately overlap. The source and receiver groups also allow their mechanisms to be examined separately rather than making every claim depend on an entire deployed federation.

The claims use one sentence per numbered claim. Each dependent claim refers to one earlier claim and adds a limitation. This follows the general claim-form and dependency framework described in [MPEP § 608.01](https://www.uspto.gov/web/offices/pac/mpep/s608.html). Here, that form makes dependencies explicit; it gives the publication no special legal status.

## Terminology

**Execution compartment** is the claim term for an IES. It includes a processing resource and an assigned relationship to memory and communication resources; it does not require a particular ISA, number of cores, or die-stacking arrangement.

**Untrusted software domain** means the ordinary workload, operating-system, hypervisor, driver, or routing-control domain excluded from authority to modify the relevant protected state. It does not include a separately authorized policy-installation function merely because that function uses software.

**Protected state** means state for which hardware access controls prevent modification by the specified untrusted software domain and prevent disclosure where a claim requires confidentiality. The claims identify the protected state and its relevant access relationship rather than asserting immunity to arbitrary physical or supply-chain compromise.

**Information-flow restriction** identifies a restriction on delivery or use of information. It is distinct from a resource-access permission. A restriction may be obtained from a fixed compartment classification; it need not imply fine-grained tracking of every computed value.

**Payload snapshot** means the particular sequence of bytes held stable for an authorization and authentication operation. The dependent claims identify copying, exclusive ownership, and immutable sharing as alternative ways of maintaining that stability.

**Publication** means making received payload accessible to the designated receiving execution compartment through a protected destination object. It does not mean publication on the Internet.

These explanations accompany the formal statements. Their technical support and unresolved implementation details are mapped below.

## Claims 1–8: IES computation and authority

**1.** A computing apparatus comprising:

  a plurality of execution compartments, each execution compartment comprising a processing resource and an assigned memory region;

  an interconnect coupling the execution compartments to memory and input/output resources;

  a protected authority store containing, for each execution compartment, a compartment identifier, a lifecycle generation, resource-access permissions, destination-transfer permissions, and an information-flow restriction distinct from the resource-access permissions;

  request-identification circuitry coupled to the interconnect and the protected authority store and configured to associate a transaction with a source execution compartment and its lifecycle generation using a hardware-controlled execution or requester context; and

  enforcement circuitry coupled to the request-identification circuitry and the protected authority store, arranged on memory-access and communication paths of the execution compartments, and configured to determine whether the transaction is permitted by the resource-access permissions, to determine whether a requested transfer from the source execution compartment is permitted by the information-flow restriction and the destination-transfer permissions, and to prevent the transaction or the requested transfer when a respective determination fails;

  wherein hardware access controls prevent an untrusted software domain from modifying the protected authority store or substituting a different compartment identifier or lifecycle generation for the transaction, and wherein a change made by the untrusted software domain to a page table, device descriptor, or routing selection does not bypass the enforcement circuitry on the memory-access and communication paths.

**2.** The computing apparatus of claim 1, wherein the information-flow restriction comprises a fixed classification assigned to the source execution compartment, and the enforcement circuitry applies the fixed classification to each outgoing payload from the source execution compartment irrespective of a classification value supplied by software executing in the source execution compartment.

**3.** The computing apparatus of claim 1, wherein the enforcement circuitry maintains a compartment classification that becomes at least as restrictive as a classification of newly accepted input and prevents a transition of the compartment classification to a less restrictive classification until a lifecycle transition clears or invalidates retained execution state, memory references, queued transfers, and assigned device state associated with the compartment classification.

**4.** The computing apparatus of claim 1, wherein the request-identification circuitry associates direct-memory-access transactions and coherence transactions with hardware-controlled requester contexts, and the enforcement circuitry checks the associated compartment identifier and lifecycle generation for a writeback, retry, or response before allowing that writeback, retry, or response to affect an assigned memory region.

**5.** The computing apparatus of claim 1, wherein the enforcement circuitry reassigns an execution compartment by blocking admission of new work, completing or invalidating outstanding memory and device transactions, invalidating communication references associated with a previous lifecycle generation, making retained data of a previous occupant inaccessible to a new occupant, and activating a different lifecycle generation before admitting work of the new occupant.

**6.** The computing apparatus of claim 1, wherein the enforcement circuitry creates a child execution compartment in response to a subdivision request only when resource-access permissions assigned to the child execution compartment are within delegable permissions of a parent execution compartment, and maintains protected accounting that prevents duplicated assignment of an exclusive memory resource and prevents allocations against a shared resource allowance from exceeding that allowance.

**7.** The computing apparatus of claim 1, wherein a first execution compartment comprises a general-purpose processor, a second execution compartment comprises an accelerator or a device-control processor, and transactions from both execution compartments are subject to the enforcement circuitry using their respective hardware-controlled requester contexts.

**8.** The computing apparatus of claim 1, further comprising an observation circuit coupled to receive denial or fault records from the enforcement circuitry and to request throttling or suspension of a specified resource, wherein an actuator restricts the observation circuit to a preauthorized response scope that does not increase resource-access permissions or weaken an information-flow restriction of an execution compartment.

## Claims 9–18: protected source handoff

**9.** A source-side transfer apparatus comprising:

  an interface configured to receive, from an untrusted software domain, a transfer request identifying a source buffer, a destination object, and an operation;

  protected storage containing buffer-ownership information, information-flow restrictions, and a directional session record identifying source-side transfer permissions, receiver-accepted scope supplied under authority of a receiving system, and a cryptographic key inaccessible to the untrusted software domain;

  a buffer-control circuit coupled to the protected storage and to hardware access controls on processor and device write paths to memory holding a payload snapshot, the buffer-control circuit configured to identify a requesting execution compartment from a hardware-controlled context, verify that the requesting execution compartment is authorized to access the source buffer, and establish the payload snapshot from the source buffer with the hardware access controls preventing alteration of its bytes by the untrusted software domain or an untrusted direct-memory-access requester during authorization and cryptographic processing;

  a transmission interface; and

  transfer-processing circuitry coupled to the buffer-control circuit, the protected storage, and the transmission interface, and configured to obtain an information-flow restriction associated with the payload snapshot from the protected storage, determine whether the destination object and the operation are within both the source-side transfer permissions and the receiver-accepted scope, determine whether delivery of the payload snapshot is permitted by the information-flow restriction or by an exception authorized by a protected release record, generate an authenticated record binding the bytes of the payload snapshot to the requesting execution compartment, the destination object, the operation, the information-flow restriction, and a session freshness value, and release the authenticated record to the transmission interface only after both determinations permit the transfer;

  wherein the transfer-processing circuitry uses the same payload snapshot for the determinations and generation of the authenticated record, the hardware access controls prevent the untrusted software domain and the untrusted direct-memory-access requester from modifying the protected storage, and a protected transfer path through the transmission interface prevents those requesters from substituting or modifying the authenticated record between its generation and completion of its transmission.

**10.** The source-side transfer apparatus of claim 9, wherein the buffer-control circuit establishes the payload snapshot by disabling writes through each writable processor or device alias of an extent of the source buffer, waiting for previously issued writes to the extent to complete, copying the extent into staging storage inaccessible to the untrusted software domain and the untrusted direct-memory-access requester, and maintaining the disabling of writes until the copying is complete.

**11.** The source-side transfer apparatus of claim 9, wherein the buffer-control circuit establishes the payload snapshot by transferring exclusive ownership of a memory extent to the transfer-processing circuitry, invalidating or disabling preexisting writable aliases of the memory extent, and completing or invalidating previously admitted writes to the memory extent before authorizing the transfer.

**12.** The source-side transfer apparatus of claim 9, wherein the buffer-control circuit establishes the payload snapshot in shared storage by disabling further writes to a memory extent, completing or invalidating previously admitted writes to the memory extent, and enforcing immutability of the memory extent against processor and device writers until the transfer-processing circuitry completes its use of the memory extent for the authenticated record.

**13.** The source-side transfer apparatus of claim 9, wherein the transfer-processing circuitry receives proposed record-header fields from the untrusted software domain, resolves the proposed record-header fields against the protected storage, and rejects the transfer request when a proposed field changes a source identity, information-flow restriction, destination object, or operation outside the scope resolved from the protected storage.

**14.** The source-side transfer apparatus of claim 9, wherein the transfer-processing circuitry constructs record-header fields representing the requesting execution compartment and the information-flow restriction from the hardware-controlled context and the protected storage, and cryptographically binds the constructed record-header fields to the payload snapshot.

**15.** The source-side transfer apparatus of claim 9, wherein, for a transfer permitted by the exception, the protected release record specifies the payload snapshot, a permitted destination object, a permitted operation, a validity interval, and a reuse limit, and the transfer-processing circuitry permits the transfer only when the payload snapshot and the transfer request satisfy the protected release record in addition to the source-side transfer permissions and the receiver-accepted scope.

**16.** The source-side transfer apparatus of claim 10, wherein the buffer-control circuit restores writable access to the source buffer after completion of the copying while the staging storage remains protected against modification, and the transfer-processing circuitry authenticates and transmits only data derived from the staging storage for that transfer request.

**17.** The source-side transfer apparatus of claim 9, wherein the session freshness value comprises a sequence number allocated in protected state, the transfer-processing circuitry consumes the sequence number notwithstanding an abort after allocation, and loss or uncertain restoration of the protected state causes retirement of the directional session record and prevents reuse of the cryptographic key with a restarted sequence allocation.

**18.** The source-side transfer apparatus of claim 9, further comprising a protected elapsed-time source, wherein the transfer-processing circuitry rechecks withdrawal and expiry of the directional session record when a queued authenticated record is ready for transmission, serializes the recheck with a policy-withdrawal operation before enabling transmission of a first byte, and prevents transmission when withdrawal or expiry takes effect before that enabling.

## Claims 19–26: protected receiving and independent acceptance

**19.** A receiving apparatus comprising:

  a network input interface;

  protected session storage containing an authentication key, a source-context mapping, a destination-object mapping, an information-flow mapping, and replay state;

  protected receiver-policy storage containing receiver-authorized source, destination, operation, and information-flow constraints and a remaining receiver resource allowance;

  a protected destination memory and a publication interface for making data in the protected destination memory accessible to a receiving execution compartment; and

  receive-processing circuitry coupled to the network input interface, the protected session storage, the protected receiver-policy storage, the protected destination memory, and the publication interface, and configured to authenticate a received record comprising a payload and fields identifying a source context, destination object, operation, information-flow restriction, and sequence value, resolve the fields using the protected session storage, and perform a serialized acceptance operation that checks the resolved fields against current contents of the protected receiver-policy storage, checks the sequence value against the replay state, checks that the remaining receiver resource allowance is sufficient for an amount determined for the received record, and, only when authentication and those checks succeed, updates the replay state, reduces the remaining receiver resource allowance by the determined amount, assigns a destination information-flow restriction to the payload, and enables publication of the payload to the resolved destination object;

  wherein the serialized acceptance operation is ordered with respect to concurrent acceptance operations and changes to the protected receiver-policy storage, publication is prevented until the replay-state update, allowance reduction, and assignment of the destination information-flow restriction have occurred within that operation, and hardware access controls prevent an untrusted host software domain from changing the protected session storage, changing the protected receiver-policy storage, or accessing the payload through an alternate memory-access path.

**20.** The receiving apparatus of claim 19, wherein the replay state comprises a highest accepted sequence value and a bitmap for a bounded window of sequence values, and the receive-processing circuitry prevents a record from advancing the highest accepted sequence value until the record has passed authentication and the receiver-policy checks.

**21.** The receiving apparatus of claim 19, wherein the receive-processing circuitry checks a fixed record-header grammar and a bounded payload length before performing authentication, and rejects a record containing an unknown session identifier without allocating a new session entry in response to that record.

**22.** The receiving apparatus of claim 19, wherein the source-context mapping, the destination-object mapping, and the information-flow mapping are fixed for a live session and identified by a policy-generation value, and a change in the meaning of one of the mappings causes retirement of the live session and installation of a different session before records using the changed meaning are accepted.

**23.** The receiving apparatus of claim 19, further comprising a quarantine buffer in which plaintext produced during authentication of the received record is held inaccessible to the receiving execution compartment and to an untrusted direct-memory-access requester until authentication succeeds and the serialized acceptance operation enables publication.

**24.** The receiving apparatus of claim 19, wherein loss or uncertain restoration of the replay state causes the receive-processing circuitry to retire the associated session and reject subsequent records for that session instead of initializing an empty replay window under the same session credentials.

**25.** The receiving apparatus of claim 19, further comprising a protected elapsed-time source, wherein the receive-processing circuitry checks a locally maintained session deadline at the serialized acceptance operation, invalidates the session when reset or clock uncertainty prevents reliable evaluation of the deadline, and prevents replay of a previously accepted session-installation message from restarting the deadline.

**26.** The receiving apparatus of claim 19, wherein the protected receiver-policy storage is writable through a policy-installation interface authorized by a receiver-controlled credential, and verification of a record or grant using a source-controlled credential does not authorize a write through the policy-installation interface that expands the set of sources, destination objects, operations, or information flows permitted by the receiver-authorized constraints.

## Claims 27–30: source-side transfer method

**27.** A method performed by a source apparatus having a hardware-protected enforcement domain, the method comprising:

  receiving a transfer request from an untrusted software domain;

  determining a requesting execution compartment from a hardware-controlled requester context;

  checking a protected ownership record for a source buffer identified by the transfer request;

  obtaining a payload snapshot from the source buffer and operating hardware access controls on processor and device write paths to memory holding the payload snapshot to prevent alteration of the payload snapshot by the untrusted software domain and untrusted device writers during authorization and authentication;

  obtaining an information-flow restriction for the payload snapshot from protected metadata rather than adopting a classification asserted by the untrusted software domain;

  checking that a destination object and an operation identified by the transfer request are within both source-authorized scope and receiver-accepted scope recorded in a protected directional session, and that delivery of the payload snapshot is permitted by the information-flow restriction or by an exception authorized by a protected release record;

  allocating a freshness value in protected state;

  generating, using a key retained within the hardware-protected enforcement domain, an authenticated record binding the same payload snapshot used for the checking, the requesting execution compartment, the destination object, the operation, the information-flow restriction, and the freshness value;

  preventing substitution or modification of the authenticated record by the untrusted software domain and the untrusted device writers along a protected transfer path from generation of the authenticated record through completion of its transmission by a transmission interface; and

  enabling a hardware transmission gate to transmit the authenticated record through the transmission interface only when the checking permits the transfer and the protected directional session remains valid at a transmission-authorization decision preceding emission of the record.

**28.** The method of claim 27, wherein obtaining the information-flow restriction comprises selecting a fixed classification assigned to the requesting execution compartment and applying that classification to the payload snapshot despite a less restrictive classification supplied in the transfer request.

**29.** The method of claim 27, further comprising serializing the transmission-authorization decision with a protected session-withdrawal operation, discarding a queued record when withdrawal takes effect before the transmission-authorization decision, and preventing a previously allocated freshness value from being reassigned to a different record after the discarding.

**30.** The method of claim 27, further comprising detecting loss of protected freshness-allocation state, retiring the protected directional session in response to the detecting, and requiring installation of a different session key before restarting allocation of freshness values.

## Claims 31–35: protected physical forwarding

**31.** A network forwarding apparatus comprising:

  a physical ingress interface and a plurality of physical egress interfaces;

  a routing-control interface configured to receive an egress selection from an untrusted routing controller;

  protected forwarding-policy storage containing forwarding permissions, authentication material, and policy-generation state;

  a policy-installation interface coupled to the protected forwarding-policy storage and configured to accept an update to that storage only upon verification of authorization by a policy-installation authority distinct from the untrusted routing controller, and to reject an update authorized solely by the untrusted routing controller; and

  a hardware forwarding gate coupled to the protected forwarding-policy storage, interposed in a transmission path to the physical egress interfaces, and configured to obtain an ingress identity from the physical ingress interface, obtain packet-carried forwarding-authorization data from a received packet, authenticate the packet-carried forwarding-authorization data using the authentication material, determine whether the authenticated forwarding-authorization data and the forwarding permissions permit the received packet to use the selected physical egress interface from the physical ingress interface under the policy-generation state, and enable transmission through the selected physical egress interface only when the determination permits the transmission;

  wherein the untrusted routing controller is prevented from modifying the protected forwarding-policy storage or enabling transmission through the selected physical egress interface independently of the hardware forwarding gate.

**32.** The network forwarding apparatus of claim 31, wherein the hardware forwarding gate performs the determination without storing forwarding-authorization entries indexed by application-flow identifiers, and the apparatus maintains protected port-policy state, authentication material, policy-generation state, and resource-class queues used to limit forwarding work.

**33.** The network forwarding apparatus of claim 31, further comprising a protected elapsed-time source, wherein the hardware forwarding gate checks a forwarding-authorization lifetime using the protected elapsed-time source in addition to checking the policy-generation state, denies use of an expired forwarding authorization despite continued possession of authentication material for its policy generation, invalidates the forwarding authorization when reset or clock uncertainty prevents reliable evaluation of its lifetime, and prevents replay of a previously accepted authorization-installation message from restarting that lifetime.

**34.** The network forwarding apparatus of claim 31, further comprising a packet buffer, wherein the hardware forwarding gate verifies an authentication value computed over a canonical encoding of the forwarding-authorization data, a payload of the received packet, and selected header fields of the received packet, with an authentication-value field excluded from the canonical encoding, and withholds the received packet in the packet buffer until verification succeeds before permitting transmission through the selected physical egress interface.

**35.** The network forwarding apparatus of claim 31, further comprising a second hardware forwarding gate arranged in series with the hardware forwarding gate and having separately protected policy and authentication state, wherein transmission through the selected physical egress interface requires permission from both gates and either gate can prevent the transmission independently of an allow decision by the other gate.

## Implementation support and open questions

The following map identifies passages that motivate the claim language. It is **not a finding of legally sufficient written description or enablement**. Those requirements concern what the application actually discloses and enables across the claimed scope. Adding a functional result to a claim does not supply a missing implementation. [MPEP § 2163](https://www.uspto.gov/web/offices/pac/mpep/s2163.html), [MPEP § 2164](https://www.uspto.gov/web/offices/pac/mpep/s2164.html).

| Claims | Existing architectural basis | Implementation detail still needed |
|---|---|---|
| 1–4, 7 | [02: machine organization, classification, memory and devices](02_ies_execution_and_authority.md) | Concrete policy-store layout, requester-identity paths, transaction formats, enforcement logic, and an implementation of the selected classification rule |
| 5–6 | [02: subdivision and lifecycle](02_ies_execution_and_authority.md) | Lifecycle state transitions, outstanding-transaction handling, generation reuse rules, allocation accounting, and treatment of parent/child authority |
| 8 | [02: protected observation](02_ies_execution_and_authority.md) | Event interface, actuator wiring, protected response limits, and behavior under lost or forged observations |
| 9–14, 16 | [03: descriptor, state machine, and implementation alternatives](03_protected_handoff.md) | A worked buffer-controller design, cache/DMA ordering, ownership transitions, header resolution, protected output path through the transmission interface, and recovery from interrupted copying |
| 15 | [03: controlled release](03_protected_handoff.md) | Representation of the snapshot binding, release-record creation, verification, reuse accounting, and release-component authority |
| 17–18, 27–30 | [03: emission and freshness](03_protected_handoff.md), [04: nonce discipline and withdrawal](04_network_transport_and_realms.md) | Counter persistence or mandatory retirement mechanism, concurrency ordering, reset detection, and the decision-to-wire timing bound |
| 19–24 | [03: receive quarantine and commit](03_protected_handoff.md), [04: parsing, replay, and mappings](04_network_transport_and_realms.md) | Atomic or serialized commit construction, checks and allowance consumption within the commit, queue reservation rules, concurrent duplicate handling, and destination access-control transitions |
| 25–26 | [04: independent admission and expiry](04_network_transport_and_realms.md) | Protected clock/reset implementation, session-installation replay defenses, policy-installation authentication, and separate authority paths |
| 31–33 | [04: transit state, separate authorities, physical forwarding, and expiry](04_network_transport_and_realms.md) | Actual forwarding-token construction, authenticated fields, key hierarchy, policy-installation authority and interface, port binding, parser bounds, reset handling, and protection against restarting expired authorizations |
| 34 | [04: buffering and authentication before forwarding](04_network_transport_and_realms.md) | A specified token-to-packet binding and verification path; ASKA 2.0 presents the need and alternatives but does not select this protocol |
| 35 | [05: serial gates and shared dependencies](05_costs_limits_and_open_questions.md) | Series-path circuit, policy provisioning for both gates, separate veto wiring, and analysis of shared reset, power, debug, and bypass paths |

Claims 31–35 are the least developed group in the current description. They should remain candidate language until the forwarding mechanism is specified. Claim 34 selects a buffered, packet-bound embodiment from alternatives discussed in ASKA 2.0; the exact binding is additional design work. Claim 35 selects a serial-veto embodiment without asserting that two gates eliminate common-mode failure.

The claims concerning exclusive ownership, immutable sharing, dynamic classification, and subdivision also span alternatives that ASKA 2.0 has not implemented. Their inclusion preserves those branches for examination; it does not establish that the current prose enables every covered implementation.

Claim 33 applies protected expiry and installation-replay rules to forwarding authorization. Its concrete installation protocol remains unspecified.

## Candidate distinctions to investigate against prior art

The most useful search targets are combinations of mechanisms, especially the relationship between protected classification, the actual payload snapshot, separately controlled receiving scope, and lifecycle-safe delivery. The following are research questions, not novelty conclusions.

| Claim group | Candidate distinction to investigate | Closest comparison work already identified |
|---|---|---|
| IES apparatus | The combined enforcement of hardware-derived source identity, resource permission, information-flow restriction, and lifecycle generation across memory and I/O paths | Separation architectures, CHERI/CHERIoT, hardware IFC, and protected messaging |
| Source apparatus and method | Authorizing and authenticating the same stable payload under protected source classification and recorded receiver scope, including races and retirement | Protected DMA, trusted communication adapters, DStar, Fabric, and secure-channel endpoints |
| Receiving apparatus | A protected commit that joins independent receiver policy, replay state, resource accounting, classification, and publication to the destination | Distributed IFC, protected receive queues, replay-protected transports, and isolation monitors |
| Forwarding apparatus | A physical egress veto that an ordinary controller cannot override, with precisely defined packet-carried authority and optional buffered validation | TVA, SANE, SCION, restricted device-control modes, and hardware policy enforcement |

The relevant technical sources and their limits are collected in [Document 07](07_prior_art_and_sources.md). That reading map is not a search of published patent applications or issued claims. A patent-focused review would need both patent and non-patent literature, including relevant dates and the actual disclosure of each close reference.

Known submechanisms remain known even when they appear in an ASKA claim. A dependent claim can be useful for describing a narrower embodiment without being independently inventive. The hardware form of a claim, the use of “configured to,” and the inclusion of several familiar checks do not establish eligibility, novelty, non-obviousness, or sufficient disclosure.

## Choices deliberately left out of the independent claims

The independent claims do not require a particular ISA, named capability architecture, programming language, crypto primitive, packet width, or fixed number of cores. The 64-byte record and AES-GCM example in Document 04 are candidate implementation details. Their omission here is a drafting choice to examine against the supporting disclosure, not a conclusion that unlimited breadth is justified.

The source and receiver claims concern protected explicit transfers. They do not claim elimination of timing channels, malicious fabrication, all denial of service, or all malicious behavior within an accepted grant. The physical-forwarding claim concerns identified interfaces; it does not establish geographical truth about an uncontrolled carrier.

No standalone claim is proposed here for the general idea of AI generating an ISA, a secure processor, or a complete software stack. AI-assisted development is a planning assumption in the architecture, not a disclosed ASKA-specific automation mechanism. Likewise, the document does not claim ownership of actors, message passing, or hardware isolation as general ideas.

## Publication record and reuse

The numbered statements complement the mechanisms, state transitions, examples, and limits in Documents 01–07. Claim syntax is not a substitute for disclosing how a mechanism works. A later claim must be compared with what a qualifying reference actually teaches; formal wording does not automatically anticipate every implementation or improvement. [MPEP § 2121](https://www.uspto.gov/web/offices/pac/mpep/s2121.html), [MPEP § 2131](https://www.uspto.gov/web/offices/pac/mpep/s2131.html).

When citing this disclosure, identify the repository URL, a specific commit, the document, and the relevant numbered statements. A Git commit identifies a content snapshot; its author and committer dates are configurable and do not independently prove when the public could access it. Public accessibility and its date require evidence beyond a local filename or commit timestamp. Search indexing and independent archival capture should not be assumed to have happened. [Git commit metadata](https://git-scm.com/docs/git-commit-tree), [MPEP § 2128](https://www.uspto.gov/web/offices/pac/mpep/s2128.html).

The release preserves a precise, inspectable description and invites technical comparison. It makes no promise of patent immunity or exclusive ownership of the ideas described.
