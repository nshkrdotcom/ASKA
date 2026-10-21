# 09 — Assessment of the patent-claims critique and resulting revisions

[Start](README.md) · [Previous: defensive structural disclosure](08_defensive_structural_disclosure.md)

**ASKA 2.0 · 20 October 2026 · Review of the supplied critique of claims 1–35**

The critique identifies useful engineering relationships, especially the source snapshot and the receiving commit. Its patentability conclusions exceed its evidence. It supplies neither a limitation-by-limitation comparison with prior art nor a basis for declaring low patentability risk, maximum commercial strength, or mechanisms difficult to design around. It also misstates parts of the legal framework and SANE's trust model.

The appropriate response is to improve the actual claim language while preserving the open questions. **Claim 9 remains a sensible first candidate for detailed investigation. It has not been shown to escape prior art.** The same distinction applies to the other groups: a concrete research mechanism can deserve serious development before anyone knows whether a useful patent claim is available.

This review checks selected legal propositions against USPTO guidance and selected technical assertions against primary sources. It is not a patent search or a prediction of an examiner's decision. References to the supplied critique concern the original draft; The technical language reviewed here is **Revision B**, with the same numbering. Document 08 now publishes those statements as a defensive structural disclosure. This document preserves the earlier analysis; references to potential filings explain drafting issues and do not announce a filing plan.

## 1. What the critique gets right about the source handoff

The source-side group identifies a coherent technical question: can protected requester identity and information-flow authority remain bound to the same payload through memory access, authorization, authentication, and transmission? That is more useful to investigate than a claim to secure communication in general.

Claims 10–12 also identify meaningful implementation alternatives: protected copying, exclusive ownership, and shared immutability. Keeping alternatives visible lets the research compare their costs and failure modes.

However, the critique's diagram does not establish novelty. A vulnerable host-controlled adapter is one comparison baseline, not a complete account of protected DMA, secure adapters, information-flow systems, or earlier patent disclosures. Its description also reads limitations into claim 9:

- Claim 9 did not require the specific freeze-and-copy sequence of claim 10.
- It did not require policy evaluation and authentication to occur simultaneously. The relationship is that both concern the same protected snapshot.
- It did not require all headers to be synthesized in hardware. Claims 13 and 14 deliberately retain validation and construction alternatives.
- It did not establish that malicious data could never leave. A compromised participant can still act within its accepted grant; classification, release authority, and enforcement remain trusted assumptions.

The proposed distinction is the **particular arrangement and operation** of these mechanisms. Anticipation requires the claimed limitations arranged as required in a single qualifying reference; obviousness can involve a reasoned combination of references. Neither inquiry is answered by comparing ASKA with one weak baseline. [MPEP § 2131](https://www.uspto.gov/web/offices/pac/mpep/s2131.html), [MPEP § 2141](https://www.uspto.gov/web/offices/pac/mpep/s2141.html).

The critique also calls the three alternatives structurally enabled without examining their implementation. Naming ownership transfer does not explain how dirty caches, pending DMA writes, retries, or aliases are handled. A useful fallback requires support as well as a narrower claim. Full-scope enablement remains a separate question. [MPEP § 2164](https://www.uspto.gov/web/offices/pac/mpep/s2164.html).

## 2. “Circuitry” does not automatically invoke § 112(f)

The critique presents a legitimate issue as a vocabulary rule. The relevant inquiry is whether the limitation, understood in context by a person of ordinary skill, conveys sufficiently definite structure. Without “means,” there is a rebuttable presumption against § 112(f); functional language can still overcome it. USPTO guidance expressly discusses *Linear Technology* as an example where circuit terminology and context supplied structure. [MPEP § 2181](https://www.uspto.gov/web/offices/pac/mpep/s2181.html).

*Williamson* concerned a “distributed learning control module”; it did not hold that every circuit configured to perform a function is a nonce term. [Federal Circuit opinion](https://www.cafc.uscourts.gov/opinions-orders/13-1130.opinion.6-11-2015.1.pdf).

If § 112(f) applies, scope includes corresponding disclosed structure and its equivalents, rather than only an exact schematic. Inadequate corresponding disclosure can also create indefiniteness. For relevant computer-implemented functions, an algorithm may be necessary; a transistor-level drawing is not a universal requirement. Avoiding § 112(f) does not eliminate written-description or enablement requirements. [MPEP § 2181](https://www.uspto.gov/web/offices/pac/mpep/s2181.html), [MPEP § 2163](https://www.uspto.gov/web/offices/pac/mpep/s2163.html).

**Revision decision:** clarify the actual couplings among requester circuitry, protected stores, memory-access controls, processing logic, and transmission or publication interfaces. Keep the structural-disclosure work explicit. Do not replace every functional limitation with an arbitrary collection of flip-flops simply to sound physical.

For ASKA, the useful drawings and descriptions would show:

1. Where requester identity originates and why a descriptor cannot replace it.
2. Which controls stop each processor, coherence, and DMA write path, including already admitted writes.
3. Which storage holds the authorized snapshot, and how its restriction remains associated with it.
4. How the completed authenticated record reaches the transmitter without an untrusted substitution point.
5. How receiving checks and state updates prevent concurrent duplicates or overspending before publication.

These are disclosure tasks tied to the proposed mechanism. Adding circuit names to Document 08 does not complete them.

## 3. Claim 1 needed an authority clarification, not the alleged antecedent repair

The original phrase **“a destination permission”** introduces a permission. It is not the same drafting problem as referring to **“the destination permission”** without an identifiable earlier referent. Antecedent-basis analysis asks whether the scope is reasonably ascertainable; it is not a requirement that every newly introduced noun already appear earlier. [MPEP § 2173.05(e)](https://www.uspto.gov/web/offices/pac/mpep/s2173.html).

Nevertheless, the critique's proposed change improves the architecture-to-claim relationship. The original claim did not say clearly enough where destination permission was stored or protected.

**Revision decision:** claim 1 now places destination-transfer permissions in the protected authority store and expressly checks those permissions. It also connects the identification and enforcement circuitry to that store. This makes the authority source explicit. It is more than correcting an article.

## 4. The SANE comparison needs its controller trust boundary restored

SANE is a relevant reference. Its basic architecture uses a logically centralized domain controller to make routing and access-control decisions and issue capabilities enforced by switches. That controller is trusted. Section 4.3 says its compromise defeats the basic protection model; it then sketches threshold controllers to reduce the single-controller risk. The critique therefore misdescribes basic SANE when it attributes protection against a malicious authority-issuing controller to that design. The threshold extension also means that dismissing SANE as only a trusted single-controller design would be incomplete. [SANE, especially §§ 2.1 and 4.3](https://www.usenix.org/legacy/event/sec06/tech/full_papers/casado/casado_html/paper.html).

Ethane is another relevant comparison, but its controller-managed, flow-based switch design should not be treated as interchangeable with SANE's packet-carried capabilities. Each reference needs its own mapping. [Ethane paper](https://web.stanford.edu/class/cs244/papers/Ethane.pdf).

ASKA's proposed relationship is specific: an ordinary routing controller can propose an egress, while a separately authorized policy path determines what the physical gate may permit. Calling the controller untrusted is insufficient if it can rewrite the gate's policy through another interface.

**Revision decision:** claim 31 now identifies a policy-installation interface that requires authorization from an authority distinct from the ordinary routing controller. The controller may relay an independently authorized update; its own authority is insufficient to approve one. This makes the proposed separation inspectable without asserting that the separation is new.

### Adding an expiry check does not establish patentability

SCION already authenticates forwarding fields that include expiration information. Its documented calculation uses a segment timestamp and a hop expiration field. This does not establish the exact protected elapsed-clock arrangement proposed for ASKA, but it defeats any suggestion that expiring forwarding authority is itself an unexplored idea. [SCION header specification](https://docs.scion.org/en/latest/protocols/scion-header.html).

The assertion that SANE and SCION lack every relevant feature of the proposed clock arrangement is not a search of clock, lease, revocation, or hardware-security literature. Nor does a difference from those two references establish non-obviousness. [MPEP § 2141](https://www.uspto.gov/web/offices/pac/mpep/s2141.html).

The critique also misidentifies `L / (1 - delta)` as claim 33's mechanism. Original claim 33 did not contain that formula. In [Document 04](04_network_transport_and_realms.md), it is part of a derived bound:

```text
maximum real elapsed time before enforcement = L / (1 - delta) + epsilon
```

That bound assumes continuous clock progress, a known maximum fractional slowdown, and bounded enforcement delay. It does not specify a clock circuit or make clock state survive reset. Omitting `epsilon` also omits the stated enforcement delay.

**Revision decision:** retain the elapsed-time limitation in dependent claim 33 and add explicit invalidation on unreliable lifetime evaluation and protection against installation replay restarting the lifetime. This selects a more specific candidate requiring further disclosure. Do not put the formula into claim 31 as a novelty device. Do not automatically import claim 35 either: the original requires separately protected serial gates, not independently designed or vendor-diverse gates.

## 5. Claim 27 does not need an invented register to avoid a mental-process label

The critique focuses too heavily on verbs such as checking and determining. Eligibility analysis considers the claimed process as a whole. The mental-process category concerns activity practically performable in the human mind; those verbs alone do not decide it. In USPTO analysis, Step 2A addresses the exception and practical integration, and Step 2B addresses significantly more if needed. [MPEP § 2106](https://www.uspto.gov/web/offices/pac/mpep/s2106.html).

The appeal to *Enfish* is also misplaced as a demand for physical register transformation. That decision's computer-functionality discussion concerns a self-referential database structure. A particular hardware register is neither a universal requirement nor a guarantee of eligibility. [MPEP § 2106.05(a)](https://www.uspto.gov/web/offices/pac/mpep/s2106.html).

Claim 27 already concerns hardware-controlled identity, memory protection, cryptographic binding, and gated transmission. Its useful technical account is the prevention of a mismatch between authorized bytes and emitted bytes. The original description can still be made more explicit about how that occurs.

**Revision decision:** identify hardware access controls on processor and device write paths, the protected record path, and the transmission gate. Preserve copying, exclusive ownership, and immutable sharing. Requiring a physically disconnected buffer register would select an unnecessarily specific implementation, exclude potentially useful embodiments, and introduce its own disclosure questions. These changes clarify the proposed computer-security improvement; they do not promise an eligibility outcome.

## 6. Engineering gaps the critique missed

### Protecting a snapshot does not by itself protect the completed output

Original claim 9 protected the snapshot during authorization and cryptographic processing, then released a record to an interface. It did not explicitly carry the protection through the completed record's transmission. An implementation must account for both stages, including queues and descriptor substitution.

Revision B adds a protected path through the transmission interface that prevents untrusted alteration or substitution of the generated record. Claim 27 receives the corresponding method limitation. Claims 11 and 12 also make outstanding-write completion or invalidation explicit before the snapshot is used. Removing writable aliases alone does not explain the fate of previously admitted writes.

### A release exception must fit the independent claim

Original claim 9 required permission under the information-flow restriction, while claim 15 addressed a transfer otherwise prohibited by that restriction. The intended exception was not clearly expressed in the parent claim. A dependent claim should add limitations rather than contradict its parent. [MPEP § 608.01(n)](https://www.uspto.gov/web/offices/pac/mpep/s608.html).

Revision B makes the two flow cases explicit in claim 9: ordinary permission or an exception authorized by a protected release record. Claim 15 narrows the exception by specifying its snapshot, destination, operation, lifetime, and reuse limits. Both cases still require source permission and receiver-accepted scope. The corresponding method language is aligned. No release record gives the sender authority to override the receiver.

This is a substantive clarification of the claimed alternatives, not a claim that the original wording already secured that scope.

### “Accounts for” an allowance does not necessarily enforce it

Original claim 19 mentioned resource accounting but did not expressly require sufficient allowance before publication. Its placement of replay checking before the serialized operation also left the check-to-update relationship less clear than the architecture requires.

Revision B puts policy, replay, and available-allowance checks inside the serialized acceptance operation. Successful acceptance updates replay state, consumes the allowance, and assigns the destination restriction before publication. Two concurrent requests must not both rely on the same unchecked pre-commit state.

This describes a local acceptance contract. It does not promise durable exactly-once application effects across crashes; [Document 03](03_protected_handoff.md) explains that separate problem.

## 7. The dependent claims are useful, but their praise exceeds the evidence

**Claim 4 — lifecycle checks on coherence and DMA traffic.** Checking generations on delayed writebacks and retries addresses a concrete failure mode. The open question is the proposed combination's relationship to earlier memory-protection, coherence, device-isolation, and stale-transaction mechanisms. The critique provides no such comparison. Retain the claim and develop a transaction trace, including generation reuse and outstanding traffic.

**Claims 17 and 24 — different state-loss hazards.** Claim 17 addresses sender nonce allocation under a key; claim 24 addresses receiver replay history. Losing receiver replay state can permit repeated acceptance without causing any sender nonce reuse. Calling both a nonce mechanism obscures this distinction.

Nonce uniqueness, counter persistence across restart, and rekeying when uniqueness cannot be maintained are established concerns. RFC 5116 discusses these issues, including persistent counter reservation. That does not establish anticipation of the complete ASKA claims, but it prevents treating the general recovery principle as newly invented here. [RFC 5116, § 3.1](https://www.rfc-editor.org/rfc/rfc5116.html).

**Claim 23 — withholding unauthenticated plaintext.** The hardware quarantine relationship is worth describing, but authenticated decryption already has an authenticated-plaintext-or-failure interface. The broader rule of withholding unauthenticated output is not established as new by this claim. The research question concerns the concrete access controls and their relationship to receiving commit and DMA consumers. [RFC 5116, § 2.2](https://www.rfc-editor.org/rfc/rfc5116.html).

None of these observations means the complete combinations are unpatentable. They mean that identifying a real security hazard and proposing a sound defense do not, by themselves, establish a patentable distinction. Nor does specificity alone make a mechanism hard to design around.

## 8. Revision record

| Claims | Revision B change | Reason and scope consequence |
|---|---|---|
| 1 | Protected destination-transfer permissions; explicit store and interconnect couplings | Identifies authority and enforcement relationships instead of relying on an unexplained permission |
| 9 | Access-control and circuit couplings; protected metadata writes; protected record path; explicit controlled-release alternative | Clarifies the source mechanism and changes the express requirements and alternatives |
| 11–12 | Complete or invalidate already admitted writes | Makes stabilization cover outstanding traffic as well as future writes |
| 15 | Narrow the parent's explicit release exception; retain both parties' scope | Avoids an apparent exception that contradicts the parent or overrides receiving authority |
| 19 | Protected remaining allowance; policy, replay, and allowance checks within serialized acceptance; updates before publication | States the concurrency and budget relationship directly |
| 27 | Memory-access controls, same-snapshot binding, protected output path, transmission gate, and aligned release treatment | Clarifies the technical process without requiring one buffer technology |
| 31 | Separate authenticated policy-installation authority and interface | Makes the routing controller's lack of policy authority inspectable |
| 33 | Invalidate on unreliable lifetime evaluation; prevent installation replay from restarting lifetime | Selects a recovery-sensitive forwarding embodiment without claiming it is novel |
| Other claims | No textual change | Retains the existing alternatives and limitations for further investigation |

All 35 numbers and existing dependency relationships are retained. Claims 33 and 35 remain dependent. No novelty assertion, licensing valuation, named-vendor infringement conclusion, or guarantee against rejection has been added.

The supporting-description map in Document 08 has also been updated. A map to architectural prose is not a finding that the entire claim scope is enabled. In particular, the forwarding installation protocol, precise token construction, reset implementation, and serial-gate design still need work.

## 9. A defensible assessment in place of the scorecard

| Group | Why pursue it | Evidence still needed |
|---|---|---|
| 1–8: IES | Expresses the broader ASKA execution and authority architecture | Concrete identity/lifecycle implementation and comparison with hardware isolation and IFC systems |
| 9–18: source handoff | Gives a bounded, traceable mechanism to study first | Full source-to-wire embodiment, alias and pending-write handling, and a dated prior-art comparison |
| 19–26: receiving | States independent acceptance and controlled publication | Concurrent and interrupted-commit behavior, publication access controls, and comparison with protected receive systems |
| 27–30: method | Describes source operations in addition to apparatus relationships | Support for every step and analysis of how the method would actually be performed |
| 31–35: forwarding | Separates physical egress permission from route selection | Actual forwarding protocol, issuer and installer trust model, lifetime mechanism, and detailed prior-art mapping |

Calling claim 9 the primary licensing asset or assigning low patentability risk would be premature. Claim 1 does not require an entire SoC package. Claim 19 does not cover every DPU merely because it receives packets. Claim 27 does not establish liability for a firmware seller merely because it is a method claim. Naming a switch vendor supplies no product-to-claim analysis.

The next useful deliverable is a worked embodiment and an evidence matrix. For each limitation, record the supporting ASKA passage, the closest reference and exact passage, the reference's relevant date, what it actually discloses, and any remaining difference. Then evaluate the combination and the disclosure rather than inferring patentability from missing keywords.

ASKA's ambition remains intact: the IES machine, memory and device authority, protected communication, independently controlled receiving, and physical enforcement all remain in the series. The revision makes selected mechanisms more precise. Whether they support valuable patent claims remains a question to investigate, not a conclusion supplied by the critique's enthusiasm.
