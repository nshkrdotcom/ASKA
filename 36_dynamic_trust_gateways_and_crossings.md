# ASKA v6 — Dynamic trust gateways and crossings

## A gateway terminates and re-admits

A dynamic trust gateway (DTG) mediates a crossing between domains with different authority, information-flow or protocol contracts. It is not a transparent bridge that inherits every right of both sides. Its ingress service terminates one bounded protocol context, produces a candidate object or transformation result, and submits that object for independently authorized release and destination acceptance. The dynamic part concerns current evidence and admitted policy; risk-rating service scores are not permissions.

The gateway contract identifies source and destination realms and purposes, supported directions, exact object classes, allowed transformations, output representations, metadata policy, resource ceilings, freshness and revocation behavior. Each direction is a separately admitted service. A bidirectional business workflow can use two one-way object crossings with a typed correlation identifier; it does not need shared writable state or symmetric authority.

**R-36-01 — Terminating gateway boundary.** A DTG MUST terminate untrusted input in a bounded domain and independently admit each outward object. Connectivity, favorable trust evidence and authority in one direction MUST NOT create authority in the reverse direction.

A gateway can serve a local purpose crossing, an STN/ATN service boundary, an institutional exchange or a legacy integration. The same invariants apply, but the selected physical profile differs. A logical process gateway on shared hardware must not claim the physical independence of separate appliances with independently controlled power and management.

The [NCSC secure-connectivity guidance](https://www.ncsc.gov.uk/collection/operational-technology/secure-connectivity/principle-5) treats direction control within a broader connectivity decision. ASKA therefore qualifies hardware directionality and semantic cross-domain acceptance separately: a one-way path can still carry an unauthorized or harmful object in its allowed direction.

## The crossing object

A crossing proposal binds an input version or immutable snapshot, source principal, requested output, transformation identity, destination recipient and purpose, confidentiality and integrity labels, applicable contract/grants, byte or query budget, expiration and evidence requirements. Output can be exact bytes or a precisely bounded transform whose admissible outputs are defined. “Approved program” is insufficient when that program can choose arbitrary secret-dependent output.

The source owner decides whether that exact release is authorized. The destination owner decides whether the representation and obligations are acceptable. The gateway’s transformation service cannot consent on behalf of either party unless a specific grant delegates that role. A legal or professional credential is evidence of a relationship; its machine consequence still requires the admitted basis and current grant.

**R-36-02 — Exact crossing authority.** Every crossing MUST bind source authority, destination acceptance, exact output or authorized transform, labels, purpose, recipient, freshness and budget. A read capability, credential or gateway role MUST NOT substitute for release authority.

The output contract includes metadata: names, identifiers, timestamps, sizes, error messages and traffic schedule where relevant. Removing fields from a payload does not automatically remove information from its filename, digest, ordering or timing. A de-identification transform must define its intended privacy property and limits; it cannot promise that arbitrary external knowledge will never reidentify a record.

## Parsing and transformation isolation

The untrusted side’s parser executes with finite memory, CPU, message and recursion budgets. It cannot reach the privileged output path directly. Parsing creates typed candidates with explicit provenance. The trusted acceptance logic receives a bounded representation, not an arbitrary pointer into parser memory. Complex content handling, decompression, rendering and model inference belong in constrained workers whose compromise is expected to remain within their grant ceiling.

A transformation can redact, summarize, aggregate, convert a format, verify a proof or construct an authorized query response. Its result remains a candidate until the final release owner validates the required predicate. For a simple format conversion, a deterministic checker may suffice. For a semantic summary, a human or AI decision may remain trusted; that limit is explicit and can be bounded by exact-output approval and recipient constraints.

**R-36-03 — Confined transformation.** Gateway parsers and transformation workers MUST have bounded resources and no direct authority to publish protected output. The final owner MUST enforce the required output predicate and provenance binding independently of the worker wherever the claimed assurance depends on that separation.

Deep packet inspection is neither universal nor sufficient. An encrypted tunnel can hide plaintext from an intermediate inspector. Even visible bytes can be semantically harmful in ways a format checker does not establish. The design chooses the necessary endpoint decryption and validation boundary and records who becomes trusted with plaintext. It does not claim that a generic firewall certifies all permitted content as safe.

## Final checks, streaming and revocation

Preparation reserves capacity and may perform expensive validation. The egress owner still checks current grant state, destination binding, output commitment and budget at the named finality point. A revocation before that point prevents emission under the revoked authority. Revocation after a completed disclosure affects future effects, not the bytes already released.

Streaming is a sequence of bounded effects or a separately specified stream contract. The policy states chunk size, per-chunk checks, cumulative budget, allowed timing and cancellation behavior. A single initial approval cannot authorize an unbounded stream after its context or recipient changes. If the sender learns of revocation after several chunks were emitted, the receipt records the completed prefix and the denied remainder; it does not label the entire stream aborted.

**R-36-04 — Revocable bounded crossing.** The output owner MUST revalidate current authority at each declared release finality point. Streams MUST have finite cumulative limits and explicit partial-completion semantics. Cancellation or revocation MUST NOT erase evidence of an already emitted prefix.

Bidirectional workflows keep correlation data typed and bounded. A response identifier may match a permitted request without becoming a general reverse channel. A malicious peer must not embed secret payloads in arbitrarily long identifiers or use repeated error requests to create an unbounded query oracle. Query count, output size and aggregate disclosure are part of the grant where that risk matters.

## Physical enforcement and observation

The gateway’s external egress path must be reachable only through its EG-equivalent enforcement. A malware-controlled NIC, management controller or alternate radio that can transmit the worker’s plaintext defeats the claimed boundary. Physical inspection must include diagnostic ports, crash dumps, removable media and display capture. The profile distinguishes controlled machine output from human-mediated or behind-guard physical observation that it does not cover.

Trusted exporters can report crossings, denials, budget consumption and evidence gaps to the security mesh. Their telemetry is another release, with its own privacy and retention rules. An observer may detect anomalous behavior but does not become the output owner. A standing protective grant can freeze a named egress without granting authority to inspect every source object or alter unrelated policy.

**R-36-05 — Complete gateway output mediation.** All gateway paths that can release protected information MUST be guarded, disabled or explicitly excluded from the claim. Observation and protective response MUST retain their separate visibility, privacy and authority contracts.

## Example and acceptance obligations

A professional service sends a bounded clinical aggregate from Sanctum to a Polis reporting endpoint. The source PO freezes an exact input version. A constrained transformation worker produces an aggregate under the admitted query budget. An independent acceptance step checks the required schema, suppression rules and recipient. The EG emits only the sealed accepted result; the destination RG applies its own retention and purpose policy. A failed transformation returns a bounded diagnostic that cannot include the original patient records.

If an adversarial worker creates a syntactically valid but misleading aggregate, format validation alone will not detect every semantic error. The deployment must identify whether a stronger validator, independent computation or accountable human judgment is required. The machine can enforce the authorized output ceiling while preserving that residual semantic risk. Calling the worker “trusted” does not eliminate it.

**R-36-06 — Auditable crossing outcome.** Crossing receipts MUST identify input/output commitments, transformation, source and destination bindings, finality, budget and unresolved semantic or delivery conditions. A successful gateway emission MUST NOT be reported as recipient use, legal acceptance or real-world truth.

Acceptance specifications are:

- **T-36-01:** Compromise one directional worker and attempt transparent forwarding or reverse access. The other direction’s authority and writable state must remain unavailable.
- **T-36-02:** Substitute a new output, recipient or purpose after preparation. The final release check must reject it despite valid source-read credentials.
- **T-36-03:** Feed decompression bombs and malformed nested content, then have a compromised transformer call the output interface directly. Resource bounds must hold and direct publication must fail.
- **T-36-04:** Revoke a stream grant after a known emitted prefix. Further chunks must stop at the declared boundary, and the receipt must preserve the disclosed prefix.
- **T-36-05:** Exercise alternative NIC, radio, diagnostic and telemetry paths. Any unguarded protected-data release defeats the claimed complete gateway mediation.
- **T-36-06:** Deliver a gateway receipt without a destination acknowledgement or semantic acceptance. The workflow must retain those unresolved outcomes rather than mark the entire cross-realm task successful.
