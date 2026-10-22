# 03 — The protected handoff

[Start](README.md) · [Previous](02_ies_execution_and_authority.md) · [Next: network and realms](04_network_transport_and_realms.md)

During a handoff, a source offers a buffer for an operation at a receiver. The source gate checks ownership, data restrictions and permission for the requested operation, then authenticates the bytes and their meaning. The receiver checks its own policy before placing the payload in the designated protected domain.

This candidate uses existing isolation, information-flow control (IFC) and secure-channel mechanisms. It requires explicit provenance, operation semantics and control over buffer writers.

The closest starting points are [DStar §§3–4](07_prior_art_and_sources.md#c05) for exporter and label mappings, [Ryoan §§4–6](07_prior_art_and_sources.md#ry) for protected IFC endpoints, [Elasticlave §§3–5](07_prior_art_and_sources.md#b05) for stable exclusive access, and [SENG](07_prior_art_and_sources.md#seng), [attested TLS](07_prior_art_and_sources.md#e08) for terminating existing channels inside a protected domain. [CVID profiles draft](07_prior_art_and_sources.md#cv), [WO2026154461A2](07_prior_art_and_sources.md#cvp) describe release tied to a specific action. They are public proposals; an ASKA handoff implementation remains to be built.

## The logical descriptor

The sender may propose an operation, but the gate resolves its authority from protected state. The descriptor needs the information below. On the wire, references to installed records can stand in for individual fields.

| Item | Authoritative source | Meaning |
|---|---|---|
| Source context and generation | Protected execution or interconnect identity | Which live cell is requesting the operation |
| Buffer object, extent, and version | Protected memory/ownership metadata | Which exact bytes can be transferred |
| Information-flow restriction | Fixed cell policy or validated tracking mechanism | Where those bytes may be delivered |
| Receiver object and operation | Installed grant intersected with the request | What remote effect is authorized |
| Release reference, if applicable | Protected release decision | Which specific exception justifies a weaker output restriction |
| Session and policy mapping | Protected admission record | Keys, label interpretation, accepted scope, and current lifetime |
| Resource allowance | Protected counters or bounded schedule | How much work the operation may consume |

A protected handle selects state; the gate must check the referenced authority. It rejects unknown, stale, mismatched or out-of-scope references.

Descriptor fields combine distinct precedents: source/endpoint identity ([M³](07_prior_art_and_sources.md#a01), [CURE](07_prior_art_and_sources.md#a13)), buffer permissions ([Elasticlave](07_prior_art_and_sources.md#b05)), IFC/mapping ([DStar](07_prior_art_and_sources.md#c05), [Ryoan](07_prior_art_and_sources.md#ry)), attenuated or negotiated scope ([Macaroons](07_prior_art_and_sources.md#e01), [WAVE](07_prior_art_and_sources.md#e02), [IKEv2](07_prior_art_and_sources.md#ike)), and freshness/time ([RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [TPM 2.0](07_prior_art_and_sources.md#tpm)). ASKA still needs to specify how these fields fit together in protected state and on the wire. No single source supplies that complete design.

## Proposed acceptance predicates

Let `b` be the exact payload snapshot, `c` the protected source context, `d` the destination object, and `o` the operation. Let `S` be a directional session installed at both endpoints. The source gate checks:

```text
live(c)
AND owns_or_may_read(c, b)
AND stable_snapshot(b)
AND source_grant(S, c, d, o)
AND permitted_flow(label(b), d, o, release)
AND current(S)
AND within_source_budget(S, length(b))
```

The receiver independently checks:

```text
authentic_record(S, header, payload)
AND current_receiver_policy(S)
AND fresh_sequence(S, sequence)
AND receiver_accepts(S, source, d, o, label, release)
AND within_receiver_budget(S, length(payload))
AND protected_destination_ready(d)
```

These predicates outline the checks. Their implementation must show how the checks run atomically where required and work together. In particular, `permitted_flow` cannot be implemented by trusting an unverified label carried by the sender's ordinary software.

The session records the assurance the receiver accepts about the source gate and classification mechanism. With secure key custody, authentication identifies the gate that made an assertion. The receiver must separately assess and verify the gate’s classification algorithm.

Bilateral flow reasoning is explicit in [DStar §3.2](07_prior_art_and_sources.md#c05); independent local limits on negotiated scope are in [IKEv2 §§2.9,5.1](07_prior_art_and_sources.md#ike). These systems address parts of the object and operation requirements. Authentication and attestation roles remain distinct ([RFC 5116](07_prior_art_and_sources.md#ae), [RFC 9334 / RATS](07_prior_art_and_sources.md#e03)).

## A concrete candidate state machine

For the first study, choose fixed-class cells, a maximum payload size, gate-owned staging buffers, and no shared writable memory across cells. Each message follows the selected states below.

The experiment uses the following states and order. [Elasticlave](07_prior_art_and_sources.md#b05) provides a protected exclusive-access mechanism to compare, while [Composite Enclaves](07_prior_art_and_sources.md#a12), [CURE](07_prior_art_and_sources.md#a13) matter for device paths. The full sequence still needs comparison against those systems.

```text
AVAILABLE -> FROZEN -> STAGED -> AUTHORIZED -> EMITTED -> RELEASED
                  \-> ABORTED <-------------/
```

1. **Bind and freeze the offered extent.** Acquire a protected binding of the extent’s owner, physical mapping, generation and classification before checking source authority. Acquisition and authority lookup serialize with changes to those fields. Hold the binding while removing write access from every source or device alias and waiting for earlier writes to complete. The protected generation identifies the bound extent. For the oracle, the snapshot version names its bytes after write drain; it is not a wire field.
2. **Copy into gate-owned storage.** Copy the frozen bytes and the classification held by the source binding. Keep writes disabled and the binding held until the copy finishes. The staging storage and its metadata are inaccessible to ordinary software and untrusted DMA. After completion, restore source write permissions under the binding and then release it. This ordering prevents restoration of an old owner’s permissions after reassignment. Only the staged bytes and captured metadata are used for the remaining transfer. On abort, invalidate the incomplete staged copy, restore source permissions and release the binding in that order.
3. **Authorize the snapshot.** Resolve destination, operation, label mapping, release decision, and current limits from protected records. Reserve queue and byte budget. A denial does not create a more permissive alternate path.
4. **Allocate a sequence value and authenticate.** Bind the exact staged payload and canonical header. Sequence values are consumed even if later transmission fails. Reuse after an abort is forbidden.
5. **Check emission eligibility.** Recheck queued records when they are ready for serialization, including policy withdrawal and expiry. Define a serialized decision immediately before the first byte may leave: if withdrawal wins, discard the record; if transmission wins, the record is in flight under the previously valid policy. Bound the delay between that decision and the first byte. The implementation must also bound completion or abort a stalled transmission. Revocation cannot recall a prefix already sent.
6. **Release resources.** Clear or safely recycle staging storage and return unused reservations according to the defined accounting rule. A failed operation must not refund work already spent in a way that permits unbounded abuse.

The source binding blocks reassignment, remapping, generation changes and reclassification until staging completes or the transfer safely aborts. These changes wait for release of the binding. In a dynamic-label design, input that would raise the classification must also wait, so newly restricted input cannot enter a lower-class snapshot. Compartment teardown treats the bound copy as outstanding work. The binding must also cover buffer reallocation that does not involve compartment teardown. The implementation must coordinate binding acquisition, alias disabling, write drain and copying. The model tests them as separate transitions.

Freezing and copying simplify this candidate. A direct-read or ownership-transfer design might be faster, but it must demonstrate the same snapshot property. A version check performed only before a racing DMA read is insufficient.

A protected copy remains stable during authorization and authentication even if its source changed during copying. It may contain bytes from several source versions. This candidate requires one coherent version, so it freezes the source and drains writes before copying.

In the fixed-class allowed-mailbox example, a malicious workload can change its own writable source bytes without changing their class. A torn copy then violates snapshot integrity without necessarily disclosing data to a forbidden destination. Compare a stable-copy baseline when authorization does not depend on content or version; it does not satisfy [statement 3’s freeze-and-copy sequence](08_defensive_structural_disclosure.md#protected-source-handoff). [Elasticlave’s spatial-isolation baseline and exclusive-access design](07_prior_art_and_sources.md#b05) provide the relevant comparison.

Large messages would require chunking or a different buffering design. If chunks have independent authorization, the application must handle partial delivery. If the whole object requires atomic publication, it needs protected assembly and commit state. Both need state beyond a packet MAC.

## Receive into quarantine, then commit

Before authentication finishes, the receiver treats the incoming record as untrusted bytes. It may use a bounded quarantine buffer. Any plaintext produced by a streaming decryptor remains inaccessible to workloads and DMA consumers until the authentication check succeeds.

The receiver then checks current policy, destination mapping, freshness and available allowance. Authentication, policy and allowance failure leave the accepted replay state unchanged. In particular, an authenticated but policy-invalid high sequence value cannot advance the window.

A serialized commit updates replay state, debits the allowance, assigns the receive restriction and then makes the buffer visible to the designated mailbox. Receiver-policy updates share that ordering; a queued record cannot rely solely on policy checked before queueing. Concurrent duplicates must not both pass between the freshness check and the state update. This is the acceptance relationship required by [statement 5](08_defensive_structural_disclosure.md#protected-receiver-acceptance); the implementation still needs arbitration, failure rollback and access-control transitions.

Authentication before output and replay protection are established ([RFC 5116](07_prior_art_and_sources.md#ae), [RFC 4303 / ESP](07_prior_art_and_sources.md#esp), [US8438641B2 replay hardware](07_prior_art_and_sources.md#arp)); IFC placement, mappings and receiver credits have precedents ([DStar](07_prior_art_and_sources.md#c05), [M³](07_prior_art_and_sources.md#a01)). [CVID §§1.2,7.2](07_prior_art_and_sources.md#cv) describes ordering protected checks, resource consumption and release. The inspected sources have not supplied one arrangement with this ordering of replay update, resource debit, label assignment, memory publication and policy changes. That gap in the search leaves novelty unresolved.

If the destination is full, the receiver may drop the record or retain it in a bounded authenticated queue. The policy must say which state has been consumed and whether a retry is possible. A queued record remains subject to the policy lifetime.

The initial model promises at most one mailbox delivery for a sequence value within a live session. It does not promise exactly-once application effects across crashes. An application that retries a financial action or physical command needs an operation identifier, durable deduplication or idempotence, and a separately specified commit protocol. A network acknowledgment alone does not prove the external effect happened once.

The reviewed [IPsec counter-recovery literature](07_prior_art_and_sources.md#ha) concerns transport replay state; [silicon-finality §8](07_prior_art_and_sources.md#cvs) also discusses crash/partial-commit hazards. Application-level exactly-once effects need a durable commit protocol, which is outside the initial model.

## A worked trace

This hypothetical trace applies the ASKA rules. It has not been run as an experiment.

Suppose source cell `A7` is restricted. Receiver `B` accepts `analysis.submit` from that cell into restricted mailbox `B12`. A public mailbox `B2` is a different object. The session's installed label map preserves the restricted classification.

```text
t0  A7 creates buffer v9 containing restricted measurements.
t1  Source gate freezes v9, copies it, and resolves A7 from protected identity.
t2  Source and receiver grants permit analysis.submit to B12.
t3  Gate authenticates the staged bytes, B12, operation, label, and sequence 41.
t4  Untrusted transport delivers the record to B's gate.
t5  B verifies it, commits replay state, and delivers to B12 with its restriction.
```

Changing `B12` to `B2` after `t3` invalidates authentication. Asking the source gate to create the `B2` version fails the flow policy before emission. Supplying a descriptor that claims a public label fails because the gate obtains the label from protected state. Replaying sequence 41 fails the receiver's replay check.

Suppose a malicious in-cell workload retains write access during copying because the freeze is incomplete. It can produce staged bytes that match no coherent source version, even though the final ciphertext authenticates correctly. Report that as a snapshot-integrity failure. For a fixed-class transfer to an allowed mailbox, it need not be a confidentiality failure.

The receiver cannot infer source coherence from AEAD verification or this header. The source-side oracle must compare the copied bytes with the bound extent’s history. Sending a version field alone would not prove that the source enforced the binding.

A separate weakened variant can release the owner or mapping binding after checking authority but before freezing. Reassign the extent and write restricted data before the freeze, or remap the copy to an extent already holding restricted data. Test whether the gate stages those bytes with stale public metadata. That trace is a disclosure failure only if the model admits the reassignment and stale classification through its other checks. Reassignment after all physical writers are blocked cannot introduce new secret bytes by itself; the trace must show where the restricted bytes came from.

## Controlled release

Sometimes the system must publish a result derived from restricted information. The release policy must specify which disclosure it permits.

A release decision binds the approved output snapshot, its source restriction, destination, operation, lifetime, and reuse limits. If a reference is transmitted, both gates must resolve it to the agreed decision or to a narrowly delegated release authority. Replacing the payload after release invalidates that decision. A generic “declassification enabled” bit leaves those conditions unspecified.

Controlled downgrading has direct precedents in [DStar](07_prior_art_and_sources.md#c05), [Ryoan](07_prior_art_and_sources.md#ry), [information-flow ISA](07_prior_art_and_sources.md#c04), [FLAM](07_prior_art_and_sources.md#c07). Protected authorization tied to parameters, time and sessions is illustrated by [TPM §19.7.12](07_prior_art_and_sources.md#tpm) and act-specific release by [WO2026154461A2](07_prior_art_and_sources.md#cvp). Their semantics differ: Ryoan can remove its own principal tag; TPM tickets may be reusable. Neither source alone specifies all of the snapshot, destination, operation, interval and reuse-count conditions required here.

A trusted aggregate computation could be authorized to disclose one summary. Its semantics, input selection, and repetition limit would still need review. A field restricted to a small numeric range can encode secrets through valid values. An attacker controlling which records enter an aggregate can also influence what is revealed. The release component and its input contract belong in the trusted computing base.

The first handoff experiment can omit release entirely and reject every downward flow. Adding release later may improve utility, but it requires a proof and a stated change to the experiment’s assumptions.

## Three implementations worth comparing

| Candidate | Where the checks run | What to compare |
|---|---|---|
| Protected software adapter | A small isolated component resolves authority and constructs records | Its isolation, dependencies, update authority, and cost |
| Mandatory hardware validator | Software proposes bytes; the gate checks the complete protected binding | Parser ambiguity, omitted fields, races, and validation complexity |
| Protected hardware constructor | The gate forms the security-relevant fields from protected descriptors | Simpler input grammar versus added construction logic and rigidity |

Include an ordinary host adapter as a weakened baseline and compromise it to test the consequences. For the protected software adapter, establish that the compromised host cannot override its decisions.

Software may prepare headers if the final gate rejects unauthorized field values. Hardware-generated headers still require trustworthy input about the buffer’s provenance. Constructor and validator designs must face the same attacks.

Hardware-generated identity/header fields already exist in [M3 §4.4.2](07_prior_art_and_sources.md#a01); its sender badge is not an IFC label or cryptographic record. Protected metadata checks and scoped delegation appear in [DStar](07_prior_art_and_sources.md#c05), [Intel NIC control paths](07_prior_art_and_sources.md#cps). Isolated-software alternatives include [Ryoan](07_prior_art_and_sources.md#ry), [SENG](07_prior_art_and_sources.md#seng), [Komodo](07_prior_art_and_sources.md#c13), [Sanctorum](07_prior_art_and_sources.md#c14). Compare these candidates under the same assumptions before deciding whether a hardware constructor is needed.

## What this contract would establish

If the source classification is sound, the buffers remain bound to the decision, the cryptographic construction is secure, and the receiving placement enforces the agreed restriction, the composition can support the stated explicit-transfer property. Each condition can fail independently.

A proof should relate the concrete implementation to this state machine and the state machine to the desired property. Testing should seek counterexamples at every assumption boundary. The contract and hypothetical attack traces here still need a proof and implementation tests.

For refinement and IFC proofs, compare [SAFE](07_prior_art_and_sources.md#c01), [seL4 IFC proofs](07_prior_art_and_sources.md#c11), [Komodo](07_prior_art_and_sources.md#c13) and for hardware verification methods, see [VerIFI](07_prior_art_and_sources.md#c15), [guarded-equivalence preprint](07_prior_art_and_sources.md#c17), [RTL-flow trace analysis](07_prior_art_and_sources.md#c18). The last two are preprints. An exhaustive proof of this state machine would require work beyond running trace analysis or obtaining the tools.
