# 03 — The protected handoff

[Start](README.md) · [Previous](02_ies_execution_and_authority.md) · [Next: network and realms](04_network_transport_and_realms.md)

The handoff is the point where local authority becomes a remotely meaningful operation. A source offers a buffer. A protected mechanism checks its ownership, restrictions, and intended use. The mechanism then authenticates the actual transmitted bytes and the receiver-relevant meaning of the operation. On arrival, another protected mechanism checks acceptance and places the result in the correct domain.

This document proposes that contract. It does not assume that one new hardware block can infer missing provenance, understand arbitrary application semantics, or make an untrusted buffer immutable by inspecting it once.

## The logical descriptor

The sender may propose an operation, but the gate resolves its authority from protected state. A useful descriptor contains the following logical information; the network encoding may use references to installed records rather than carry every item verbatim.

| Item | Authoritative source | Meaning |
|---|---|---|
| Source context and generation | Protected execution or interconnect identity | Which live cell is requesting the operation |
| Buffer object, extent, and version | Protected memory/ownership metadata | Which exact bytes can be transferred |
| Information-flow restriction | Fixed cell policy or validated tracking mechanism | Where those bytes may be delivered |
| Receiver object and operation | Installed grant intersected with the request | What remote effect is authorized |
| Release reference, if applicable | Protected release decision | Which specific exception justifies a weaker output restriction |
| Session and policy mapping | Protected admission record | Keys, label interpretation, accepted scope, and current lifetime |
| Resource allowance | Protected counters or bounded schedule | How much work the operation may consume |

A protected handle is only a way to select state. Its numeric value is not a proof. Unknown, stale, mismatched, or out-of-scope references are rejected rather than interpreted as a default permission.

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

These predicates are a specification outline. Their implementation, atomicity, and composition require evidence. In particular, `permitted_flow` cannot be implemented by trusting an unverified label carried by the sender's ordinary software.

The session records the assurance the receiver accepts about the source gate and classification mechanism. Authenticating that gate's key establishes which gate made an assertion, subject to key security. It does not independently prove that the gate's classification algorithm is sound. That is a separate trust and verification obligation.

## A concrete candidate state machine

For the first study, choose fixed-class cells, a maximum payload size, gate-owned staging buffers, and no shared writable memory across cells. Each message moves through these states:

```text
AVAILABLE -> FROZEN -> STAGED -> AUTHORIZED -> EMITTED -> RELEASED
                  \-> ABORTED <-------------/
```

1. **Freeze the offered extent.** Check source ownership and remove write access from every source or device alias that could change the bytes. Wait for earlier writes to complete under a defined memory-ordering rule. A protected buffer generation identifies the frozen version.
2. **Copy into gate-owned storage.** Copy the frozen bytes and their protected classification. Keep the source frozen until the copy finishes. The gate's staging storage is inaccessible to ordinary software and untrusted DMA. After the copy, source ownership may be returned; only the staging snapshot will be authenticated.
3. **Authorize the snapshot.** Resolve destination, operation, label mapping, release decision, and current limits from protected records. Reserve queue and byte budget. A denial does not create a more permissive alternate path.
4. **Allocate a sequence value and authenticate.** Bind the exact staged payload and canonical header. Sequence values are consumed even if later transmission fails. Reuse after an abort is forbidden.
5. **Check emission eligibility.** Recheck queued records when they are ready for serialization, including policy withdrawal and expiry. Define a serialized decision immediately before the first byte may leave: if withdrawal wins, discard the record; if transmission wins, the record is in flight under the previously valid policy. Bound the delay between that decision and the first byte. The implementation must also bound completion or abort a stalled transmission. Revocation cannot recall a prefix already sent.
6. **Release resources.** Clear or safely recycle staging storage and return unused reservations according to the defined accounting rule. A failed operation must not refund work already spent in a way that permits unbounded abuse.

The extra storage copy and freeze operation are deliberate simplifications. A direct-read or ownership-transfer design might be faster, but it must demonstrate the same snapshot property. A version check performed only before a racing DMA read is insufficient.

Large messages would require chunking or a different buffering design. If chunks have independent authorization, the application must handle partial delivery. If the whole object requires atomic publication, it needs protected assembly and commit state. Neither behavior follows from a packet MAC.

## Receive into quarantine, then commit

Before authentication finishes, the receiver treats the incoming record as untrusted bytes. It may use a bounded quarantine buffer. Any plaintext produced by a streaming decryptor remains inaccessible to workloads and DMA consumers until the authentication check succeeds.

The receiver then checks current policy, destination mapping, and freshness. A serialized commit updates the replay state, consumes the relevant allowance, assigns the receive restriction, and makes the buffer visible to the designated mailbox. Concurrent duplicates must not both pass between the freshness check and the state update.

If the destination is full, the receiver may drop the record or retain it in a bounded authenticated queue. The policy must say which state has been consumed and whether a retry is possible. Queueing is not permission to hold a record indefinitely past the accepted policy lifetime.

The initial model promises at most one mailbox delivery for a sequence value within a live session. It does not promise exactly-once application effects across crashes. An application that retries a financial action or physical command needs an operation identifier, durable deduplication or idempotence, and a separately specified commit protocol. A network acknowledgment alone does not prove the external effect happened once.

## A worked trace

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

Now change the experiment: let the host modify the source while it is being copied, without a freeze or equivalent guarantee. The resulting bytes may not match any authorized version. That is a counterexample to the handoff contract even if the final ciphertext authenticates correctly. It identifies a missing memory-ordering or ownership rule, not a cryptographic failure.

## Controlled release

Sometimes the system must publish a result derived from restricted information. The architecture needs a narrow, explicit exception rather than a claim that secret-dependent output can be made universally harmless.

A release decision binds the approved output snapshot, its source restriction, destination, operation, lifetime, and reuse limits. If a reference is transmitted, both gates must resolve it to the agreed decision or to a narrowly delegated release authority. Replacing the payload after release invalidates that decision. A generic “declassification enabled” bit is insufficient.

A trusted aggregate computation could be authorized to disclose one summary. Its semantics, input selection, and repetition limit would still need review. A field restricted to a small numeric range can encode secrets through valid values. An attacker controlling which records enter an aggregate can also influence what is revealed. The release component and its input contract belong in the trusted computing base.

The first handoff experiment can omit release entirely and reject every downward flow. Adding release later increases utility and introduces a new proof obligation; it should appear as a visible change in the experiment's assumptions.

## Three implementations worth comparing

| Candidate | Where the decisive checks happen | What the comparison should expose |
|---|---|---|
| Protected software adapter | A small isolated component resolves authority and constructs records | Its isolation, dependencies, update authority, and cost |
| Mandatory hardware validator | Software proposes bytes; the gate checks the complete protected binding | Parser ambiguity, omitted fields, races, and validation complexity |
| Protected hardware constructor | The gate forms the security-relevant fields from protected descriptors | Simpler input grammar versus added construction logic and rigidity |

A fourth, ordinary host adapter is a useful weakened baseline: compromising it should demonstrate why its authority is part of the problem. It should not be confused with the protected software candidate, whose independence from the compromised host is an explicit assumption to establish.

Software may be allowed to prepare headers if the final mandatory gate prevents unauthorized accepted meaning. Conversely, synthesizing headers in hardware does not help if the inputs can lie about the buffer's provenance. Constructor and validator designs must face the same attacks.

## What this contract would establish

If the source classification is sound, the buffers remain bound to the decision, the cryptographic construction is secure, and the receiving placement enforces the agreed restriction, the composition can support the stated explicit-transfer property. Each condition can fail independently.

A proof should relate the concrete implementation to this state machine and the state machine to the desired property. Testing should seek counterexamples at every assumption boundary. The current document supplies the candidate contract and adversarial traces; it supplies neither that proof nor an implementation result.
