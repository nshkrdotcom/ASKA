# 08 — Defensive structural disclosure

[Start](README.md) · [Previous: prior art and sources](07_prior_art_and_sources.md)

**ASKA 2.0 · 21 October 2026**

This disclosure specifies three mechanisms. The first checks lifecycle generations before delayed transactions affect memory. The second binds the source extent’s owner, mapping, generation and classification while freezing and copying it, then uses the protected copy through authorization, authentication and emission. The third commits receiver policy checks, replay state, accounting and placement before exposing plaintext. Seven numbered statements define these mechanisms and their dependent conditions.

**Publication intent:** This is an open defensive technical disclosure, not a patent application or an assertion of exclusive rights. No patent application is being filed as part of this release. The original documentation and diagrams are offered under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode.en), a copyright license rather than a patent license. Publication does not eliminate existing patent rights or establish freedom to operate.

Compartment isolation, protected device access, fixed classifications, capability attenuation, authenticated records, replay windows and receiver-controlled admission have established precedents. The [comparisons below](#prior-art-and-scope) identify them alongside the particular relationships specified here. The novelty and nonobviousness of these relationships and dependent conditions remain unresolved. The [support map](#technical-support-and-missing-evidence) identifies missing implementation details and evidence.

## Organization and terminology

| Independent statement | Subject | Dependent statements | Required relationship |
|---:|---|---|---|
| 1 | Computing apparatus | 2 | Generation checks on delayed memory effects together with ordered compartment reassignment |
| 3 | Source-side transfer apparatus | 4 | Protected source binding, all-writer freeze and drain, staging, and withdrawal ordered before first-byte enable |
| 5 | Receiving apparatus | 6–7 | Protected quarantine and one acceptance order covering current policy, replay, resource debit, classification and publication |

**Execution compartment** means an IES with a processing resource and an assigned memory region. **Untrusted software domain** means the workload, ordinary OS, hypervisor, drivers or routing controller excluded from modifying the relevant protected state; a separately authorized policy installer is outside that domain.

**Protected state** means state whose integrity, and where required confidentiality, is enforced by hardware access controls against the stated untrusted software and device requesters. Arbitrary physical and supply-chain compromise are outside the protection assumed here.

**Lifecycle generation** distinguishes successive occupants of a compartment identifier. Hardware attaches it from a protected requester context; software cannot substitute a descriptor value. **Information-flow restriction** governs delivery or use of information and is distinct from permission to access a resource.

**Source binding** means protected state that holds the source extent's owner, physical mapping, generation and information-flow restriction fixed from authority lookup through staged-copy completion or safe abort. Changes to those fields wait until release of the binding. A dynamic-label design must also defer input that would raise the classification. Freezing separately excludes writes to the bound extent.

**Payload snapshot** means the bytes held stable for the authorization and authentication of one transfer. Statement 3 requires both a source binding and a frozen-and-drained source copy; a stable copy obtained while its source changes does not meet that requirement. **Publication** means enabling the receiving compartment to access the accepted payload through its designated protected object.

**Serialized acceptance** means that concurrent acceptance operations and receiver-policy updates have a defined order. The operation may span several clock cycles or memory instructions. Publication follows the successful state updates in that order; application-level exactly-once effects across crashes are outside this contract.

## Compartment lifecycle

**1.** A computing apparatus comprising:

  execution compartments, each having a processing resource and an assigned memory region;

  an interconnect coupling the execution compartments to memory and input/output resources;

  a protected authority store containing, for each execution compartment, a compartment identifier, a lifecycle generation, resource-access permissions, destination-transfer permissions, and an information-flow restriction distinct from the resource-access permissions;

  request-identification circuitry configured to associate processor, direct-memory-access and coherence transactions with a source execution compartment and its lifecycle generation using hardware-controlled requester contexts;

  enforcement circuitry on the memory-access and communication paths, configured to check resource-access permissions for a transaction, check destination-transfer permissions and the information-flow restriction for a requested transfer, and check the associated compartment identifier and lifecycle generation before a writeback, retry or response is allowed to affect an assigned memory region; and

  lifecycle-control circuitry configured to reassign a compartment by blocking admission of new work, completing or invalidating outstanding memory and device transactions, invalidating communication references associated with the previous generation, making retained data of the previous occupant inaccessible to the new occupant, and activating a different lifecycle generation before admitting the new occupant's work;

  wherein hardware access controls prevent the untrusted software domain from modifying the protected authority store or substituting a transaction's compartment identifier or lifecycle generation, and the enforcement circuitry remains on the memory-access and communication paths despite changes by that domain to page tables, device descriptors or routing selections.

**2.** The computing apparatus of statement 1, wherein the enforcement circuitry maintains a compartment classification at least as restrictive as the classification of newly accepted input, and permits a transition to a less restrictive classification only after a lifecycle transition clears or invalidates retained execution state, memory references, queued transfers and assigned device state associated with the previous classification.

## Protected source handoff

**3.** A source-side transfer apparatus comprising:

  an interface receiving transfer requests from an untrusted software domain, each request identifying a source-buffer extent, destination object and operation;

  protected storage containing buffer-ownership information, information-flow restrictions, and a directional session record identifying source-side transfer permissions, receiver-accepted scope supplied under authority of the receiving system, and a cryptographic key inaccessible to that domain;

  staging storage and a buffer-control circuit coupled to hardware access controls on processor and device write paths and to protected ownership and mapping controls, the buffer-control circuit configured to identify the requesting execution compartment from a hardware-controlled context, acquire a protected source binding that serializes authority lookup with changes to the source extent's owner, physical mapping, generation and information-flow restriction, verify the requesting compartment's authority using that binding, retain the binding while disabling writes through every writable processor or device alias of the bound extent, wait for previously issued writes to complete, copy the bound extent and its information-flow restriction into protected staging storage while writes remain disabled, and, only after the copying completes or an abort invalidates the incomplete staged copy, restore source write permissions under the binding before releasing it;

  transfer-processing circuitry configured to obtain the staged payload's information-flow restriction from the protected metadata captured with that staged copy, check the destination object and operation against both the source-side transfer permissions and receiver-accepted scope, check that delivery is permitted by that restriction or a protected release record, and generate an authenticated record binding the same staged payload used for those checks to the requesting compartment, destination object, operation, information-flow restriction and a protected session freshness value; and

  a transmission interface, a protected elapsed-time source, and transmission-control circuitry configured to recheck session withdrawal and expiry when the authenticated record is ready for transmission, serialize that recheck with a session-withdrawal operation before enabling transmission of the first byte, and prevent transmission if withdrawal or expiry takes effect before that enabling;

  wherein hardware access controls prevent the untrusted software domain and untrusted direct-memory-access requesters from modifying the protected storage or staging storage, and a protected transfer path prevents those requesters from substituting or modifying the authenticated record from its generation through completion of transmission, such that restored source writes cannot alter the payload authenticated or transmitted for that request.

**4.** The source-side transfer apparatus of statement 3, wherein a protected release record permitting an exception binds the staged payload snapshot, permitted destination object, permitted operation, validity interval and reuse limit, and the transfer-processing circuitry permits that exception only when the snapshot and request satisfy the release record as well as both the source-side transfer permissions and receiver-accepted scope.

## Protected receiver acceptance

**5.** A receiving apparatus comprising:

  a network input interface;

  protected session storage containing an authentication key, source-context mapping, destination-object mapping, information-flow mapping, and replay state comprising a highest accepted sequence value and a bounded-window bitmap;

  protected receiver-policy storage containing receiver-authorized source, destination, operation and information-flow constraints and a remaining resource allowance, the storage writable through a policy-installation interface authorized by a receiver-controlled credential;

  a quarantine buffer whose plaintext is inaccessible to the receiving execution compartment and untrusted direct-memory-access requesters, a protected destination memory, and a publication interface; and

  receive-processing circuitry configured to authenticate a record containing a payload and source-context, destination-object, operation, information-flow and sequence fields, resolve those fields using the protected session storage, hold any plaintext in the quarantine buffer pending acceptance, and perform an acceptance operation serialized with concurrent acceptance operations and receiver-policy updates, the acceptance operation checking the resolved fields against current receiver policy, the sequence against replay state, and the determined resource cost against the remaining allowance, and only when authentication and all those checks succeed updating replay state, debiting that allowance, assigning the destination information-flow restriction and enabling publication to the resolved destination object;

  wherein a record that fails the current receiver-policy checks cannot advance the highest accepted sequence value, publication is prevented until the replay update, allowance debit and destination-restriction assignment have occurred in the serialized acceptance operation, hardware access controls prevent the untrusted host domain from modifying the protected stores or obtaining plaintext through an alternate memory-access path, and verification under a source-controlled record or grant credential does not authorize policy installation expanding the receiver's permitted sources, destinations, operations or information flows.

**6.** The receiving apparatus of statement 5, wherein the source-context, destination-object and information-flow mappings are fixed for a live session and identified by a policy-generation value, and a change to the meaning of any such mapping requires retirement of that session and installation of a different session before records using the changed meaning are accepted.

**7.** The receiving apparatus of statement 5, further comprising a protected elapsed-time source, wherein the receive-processing circuitry checks a locally maintained session deadline within the serialized acceptance operation, invalidates the session when reset or clock uncertainty prevents reliable evaluation of that deadline, and prevents a previously accepted session-installation message from restarting the deadline.

## Prior art and scope

Each dependent statement includes all requirements of its parent. A reference for one component is not automatically a reference for the complete arrangement. Conversely, combining known components can be obvious even when no single reference contains the whole arrangement. [USPTO: anticipation](https://www.uspto.gov/web/offices/pac/mpep/s2131.html), [obviousness](https://www.uspto.gov/web/offices/pac/mpep/s2141.html).

| Statement | Established mechanisms and closest comparisons | Specific relationship requiring comparison |
|---:|---|---|
| 1 | [M³ §§4.3–4.4](07_prior_art_and_sources.md#a01): compartments and protected communication; [CURE §§5.1,5.3](07_prior_art_and_sources.md#a13): CPU/DMA/cache identity and sanitation; [FractOS §§3.5–3.6](07_prior_art_and_sources.md#a08): invalidation and reboot counters; [Sanctum §6](07_prior_art_and_sources.md#sc): blocking and reclamation; [DataSafe §4.5](07_prior_art_and_sources.md#ds): output restrictions; [silicon-finality profiles 153/240/242](07_prior_art_and_sources.md#cvs): boundary and reassignment proposals. | Checking the compartment and generation before delayed transactions affect memory, together with the specified reassignment sequence and separate resource, destination and flow checks. A reboot epoch alone does not establish this relationship. No complete match has been located in the inspected passages. |
| 2 | [Ryoan §§4.2,5.2](07_prior_art_and_sources.md#ry): input-label union and reset; [DataSafe](07_prior_art_and_sources.md#ds), [hardware IFC patent](07_prior_art_and_sources.md#dsp): propagation. | Lowering the label only after the parent statement’s lifecycle transition clears or invalidates the listed execution, memory, queued-transfer and device state. Ryoan's own-principal tag removal has different semantics. Monotonic labels and resetting state are not individually new. |
| 3 | [Elasticlave §§3–5](07_prior_art_and_sources.md#b05): protected copying/exclusion; [Composite Enclaves §§3.3–4](07_prior_art_and_sources.md#a12): CPU/device boundaries; [Ryoan §§4–6](07_prior_art_and_sources.md#ry), [DStar §§3–4](07_prior_art_and_sources.md#c05): protected IFC endpoints and mappings; [IKEv2 §2.9](07_prior_art_and_sources.md#ike): negotiated local/peer scope; [RFC 5116 §2](07_prior_art_and_sources.md#ae): byte/metadata authentication; [CVID §7.59](07_prior_art_and_sources.md#cv): currentness at effect. | Holding owner, mapping, generation and classification fixed from authority lookup through staging; excluding writers and draining prior writes before copying; then authorizing, authenticating and transmitting only staged bytes, with withdrawal ordered against first-byte enable. Stable private bytes, exclusive locks, secure channels and generic effect-boundary checks do not alone establish this entire sequence. Its nonobviousness has not been established. |
| 4 | [DStar](07_prior_art_and_sources.md#c05), [Ryoan](07_prior_art_and_sources.md#ry), [FLAM](07_prior_art_and_sources.md#c07): controlled downgrading; [TPM §19.7.12](07_prior_art_and_sources.md#tpm): parameter/session/time-bound authorization; [WO2026154461A2 claims 5–7](07_prior_art_and_sources.md#cvp): act/sink-bound release proposal. | Binding the staged snapshot to an object, operation, interval and reuse limit within the complete source apparatus, while enforcing both source permissions and receiver-accepted scope. Declassification itself is prior art; own-tag release and reusable authorization tickets do not establish these exact restrictions. |
| 5 | [ESP §§3.4.3–3.4.4](07_prior_art_and_sources.md#esp), [replay hardware patent](07_prior_art_and_sources.md#arp): authentication/replay; [RFC 4301 §§4.4,5.2](07_prior_art_and_sources.md#ip): receiver policy; [DStar §4.2](07_prior_art_and_sources.md#c05): mappings; [M³ §4.4](07_prior_art_and_sources.md#a01): buffers/credits; [Composite Enclaves](07_prior_art_and_sources.md#a12): protected memory; [CVID §§1.2,7.2](07_prior_art_and_sources.md#cv): serialized consumption before effect; [Intel control paths](07_prior_art_and_sources.md#cps): protected installation paths. | Ordering current-policy checks, replay update, debit, classification and publication within one protected acceptance operation, including quarantine and separately authorized receiver policy installation. In RFC 4301 §5.2, selector checks follow ESP processing; the ESP replay algorithm alone does not establish policy-before-window-advance. A complete receiver match has not been located. |
| 6 | [DStar §4.2](07_prior_art_and_sources.md#c05): protected mappings; [IKEv2 §§2.9.2,4](07_prior_art_and_sources.md#ike): negotiated/replaced session context. | Retiring the session before accepting changed source, object or IFC meanings, within the receiver of statement 5. Versioning is established; compare how existing systems keep mappings valid during a session. |
| 7 | [TPM §19.7.12, pp.128–130](07_prior_art_and_sources.md#tpm): timed assertions invalidated by clock discontinuity; [IKEv2](07_prior_art_and_sources.md#ike): fresh establishment. | Deadline enforcement at the receiver's joint acceptance point, including installation-replay protection. Protected expiry itself is established; the installation protocol and clock implementation remain unspecified. |

The search covered selected sources and may have missed a complete match. It cannot establish novelty. The source register distinguishes inspected passages, discovery leads, specifications, individual drafts and published patent applications. CVID and silicon-finality are individual proposals without verified implementations or IETF standards status.

## Technical support and missing evidence

The passages below explain the architecture but leave implementation details unresolved. Their legal sufficiency as written description or enabling disclosure has not been assessed. A patent disclosure must support its claimed scope independently of novelty and nonobviousness. [USPTO written description](https://www.uspto.gov/web/offices/pac/mpep/s2163.html), [enablement](https://www.uspto.gov/web/offices/pac/mpep/s2164.html).

| Statements | Descriptive basis | Detail and evidence still needed |
|---|---|---|
| 1–2 | [02: memory/device paths and lifecycle](02_ies_execution_and_authority.md#memory-devices-and-internal-communication) | Transaction formats, generation attachment and checking on every relevant path, reuse/wrap policy, cache/device completion rules, sanitation and the mechanism for a transition to a lower classification. |
| 3 | [03: source state machine](03_protected_handoff.md#a-concrete-candidate-state-machine), [04: withdrawal](04_network_transport_and_realms.md#expiry-withdrawal-and-partitions) | Source-binding acquisition and release, lock ordering with lifecycle and mapping changes, alias inventory, write-drain and copy rules, safe abort, protected staging/output wiring, serialized withdrawal and send scheduling, decision-to-first-byte delay, stalled-transmission handling and reset behavior. |
| 4 | [03: controlled release](03_protected_handoff.md#controlled-release) | Protected snapshot identifier, release creation authority, interval evaluation, reuse accounting and atomicity. No release implementation or proof is supplied. |
| 5 | [03: quarantine and commit](03_protected_handoff.md#receive-into-quarantine-then-commit), [04: parsing and delivery](04_network_transport_and_realms.md#bounded-parsing-and-delivery) | Commit arbitration and linearization point, preliminary and commit-time replay checks, policy-installer credential checks, current-policy recheck, reservation/debit rules, duplicate handling, quarantine-to-destination access transition, failure rollback and all alternate memory paths. |
| 6–7 | [04: admission](04_network_transport_and_realms.md#independent-admission-before-data-transfer), [expiry](04_network_transport_and_realms.md#expiry-withdrawal-and-partitions) | Mapping installation/retirement protocol, authenticated installation freshness, protected clock continuity and uncertainty detection. |

These statements specify requirements to test. No executable ASKA model, RTL implementation, performance measurement or security proof is supplied. An executable specification can define protocol transitions and ordering, but the apparatus still needs concrete memory, device and control paths. For enablement, the teaching must let a skilled reader carry out the subject matter. Code or RTL can contribute technical detail but is not a prerequisite. [Prior-art enablement](https://www.uspto.gov/web/offices/pac/mpep/s2121.html).

A defensive disclosure need not itself be novel. Its value against a later claim depends on what it teaches, when that teaching became publicly accessible and how it bears on the claimed subject matter.

## Established mechanisms and design alternatives

Fixed classifications and heterogeneous compartment enforcement are established choices ([hardware domain separation](07_prior_art_and_sources.md#fpga), [M³](07_prior_art_and_sources.md#a01)). Capability attenuation, exclusive-resource subdivision and distributed capability management have precedents ([seL4 allocation](07_prior_art_and_sources.md#sel), [FractOS](07_prior_art_and_sources.md#a08), [SemperOS](07_prior_art_and_sources.md#a07)). Event-triggered security responses also have precedents ([OPTIGA monitor](07_prior_art_and_sources.md#obs)); the bounded actuator remains a design requirement in [02](02_ies_execution_and_authority.md#observation-without-a-universal-supervisor).

Protected construction or validation of metadata uses established identity and mapping mechanisms ([M³ §4.4.2](07_prior_art_and_sources.md#a01), [DStar §4.2](07_prior_art_and_sources.md#c05)). Exclusive ownership transfer and immutable sharing are alternatives to copying. Both must control aliases and complete pending device writes ([Elasticlave](07_prior_art_and_sources.md#b05), [Composite Enclaves](07_prior_art_and_sources.md#a12)). Statement 3 specifically requires freezing and copying; the ownership-transfer and sharing alternatives need separate evaluation.

Freshness allocation, key retirement on uncertain counters, receive-state loss and session recovery are protocol engineering requirements with direct predecessors ([RFC 5116 §3.1](07_prior_art_and_sources.md#ae), [ESP §3.3.3](07_prior_art_and_sources.md#esp), [IPsec failover RFCs](07_prior_art_and_sources.md#ha)). Consuming every allocated sequence number even on an early abort is the conservative local rule in [03](03_protected_handoff.md#a-concrete-candidate-state-machine), not a general requirement of AEAD nonce uniqueness. Bounded parsing and unknown-session rejection likewise have precedents ([TLS §5.1](07_prior_art_and_sources.md#tls), [ESP §3.4.2](07_prior_art_and_sources.md#esp)). The experiment adopts these established mechanisms and conservative recovery rules.

## Physical forwarding research

Packet-carried forwarding consent, packet/header authentication, and forwarding without application-flow authorization tables have close precedents in [ICING §§2–3, Figs.3,7](07_prior_art_and_sources.md#d01), [EPIC](07_prior_art_and_sources.md#d03) and [SIBRA](07_prior_art_and_sources.md#d08). Protected management separation has precedents in [BlueField restricted mode](07_prior_art_and_sources.md#bf), [Intel control-plane isolation](07_prior_art_and_sources.md#cpi) and [Intel NIC control paths](07_prior_art_and_sources.md#cps). Independent vetoes in series are established ([serial-filter patent, Background/Fig.2](07_prior_art_and_sources.md#serial)); both gates may still depend on shared power, reset, debug or management paths.

The ASKA forwarding question is whether authenticated packet authority can be bound to actual ingress and selected physical egress while the route controller cannot alter policy or bypass the gate. A construction must identify token fields, canonical encoding, payload/header binding, key and installation authorities, protected buffering or authenticated chunks, and every transmit path. Expiring consent has an ICING precedent; clock-discontinuity-safe authorization has a TPM precedent. ASKA still needs to specify its installation and forwarding protocol.

[Document 04](04_network_transport_and_realms.md#physical-forwarding-and-cut-through-behavior) sets out the requirements and alternatives; the forwarding apparatus remains unspecified. A static protected port-policy experiment can test whether the egress veto resists bypass. Scalable packet-carried authorization needs a separate study.

## Citation and reuse

Cite the repository URL, exact commit, document and numbered statement. Evidence of public availability must identify the published content and when it was accessible. A deposit or web capture of new content cannot establish that it was public earlier. Local file dates and configurable Git timestamps do not independently prove public accessibility; the legal effect of a disclosure depends on its content, accessibility, relevant dates and applicable law. Claim-like formatting gives it no special status. [USPTO: printed publications](https://www.uspto.gov/web/offices/pac/mpep/s2128.html).
