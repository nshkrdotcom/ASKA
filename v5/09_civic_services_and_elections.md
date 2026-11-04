# ASKA v5 — Civic services, public participation, and elections

## 1. Polis as a public-service plane

Polis supports identity and eligibility, voter services, local agencies, taxation, public benefits, judicial notices, infrastructure services, emergency broadcast and controlled interaction with sovereign institutional networks. Its purpose is not unconditional state visibility; it is structured, reviewable participation in institutions whose authority is explicitly declared. The same resident may interact as a taxpayer, volunteer, employee and voter without exposing the complete private graph of those identities.

## 2. CIVIC operations

Recommended typed methods include `verify_eligibility`, `issue_notice`, `acknowledge_notice`, `file_return`, `apply_benefit`, `submit_evidence`, `register_service_request`, `issue_ballot_style`, `cast_ballot`, `verify_cast_record`, `challenge_result`, and `report_emergency`. A deployment must not implement a method name as an unrestricted network RPC; each operation still binds profile, object, eligibility, party, recipient and effect semantics.

## 3. Eligibility with minimal identity exposure

A civic service should distinguish enrollment identity, authorization to participate, and the content of a participation act. Where suitable credentials permit a one-time eligibility assertion, the receiving service need not receive a person's entire noncivic identity history. However, unlinkability depends on chosen credential scheme, issuance records, network metadata and coercion model; the protocol does not automatically provide it.

## 4. Election integration requirements

ASKA can provide protected eligibility presentation, plane-specific transport, independent ballot custody, trusted UI, receipts and witness commitments, but does not by itself constitute a certified voting system or prove end-to-end verifiability. A deployment using CIVIC for ballots must specify:

- voter eligibility/uniqueness checks and challenge procedure;
- ballot definition and trusted presentation of precise choices;
- cast-as-intended, recorded-as-cast, tallied-as-recorded or other verifiability goal and the scheme that supports it;
- secrecy/anonymity and coercion/receipt-freeness assumptions;
- separation of registration identifiers from vote choices;
- independent election authority quorum and audited results;
- dispute, recount, accessibility, offline and equipment-failure rules.

The endpoint SHOULD issue a **cast confirmation** that cannot be used as a transferable proof of vote choice when the election threat model forbids such receipts. A public Steles digest cannot leak individual ballots merely to make an audit convenient. A physical 3D microstructure or printed artifact may be studied as additional evidentiary media; it is not an automatic substitute for election-specific cryptographic and legal safeguards.

## 5. Public service transaction

A resident applies for a municipal permit. Polis receives a signed service schema and demands a proof of address and eligibility. IDENT produces a selective disclosure with defined expiration. The person approves exact data fields through Keystone. The municipal receiver has an independent contract to accept the application and retain it for a published period. The resident obtains a submission receipt; subsequent agency action produces another signed disposition. The local network cannot alter the submitted record without failing authenticated binding.

```mermaid
flowchart LR
  U[Resident intent] --> V[Eligibility proof]
  V --> A[Canonical public-service contract]
  A --> T[Keystone review]
  T --> P[Polis execution cell]
  P --> C[Municipal service owner]
  C --> R[Receipt / appeal reference]
  R --> S[Private witness commitment]
```

## 6. Public-safety resilience

A community may provision an independently administered civic edge for emergency operations, separate from open encounter queues and commercial overload. Such resilience must enumerate actual reserved capacity, power, link paths, queueing and regional dependencies. “Municipal mesh” is not proof of delivery if a shared radio or flood fails. Alerts should include authenticated issuer, locality, expiry, update and cancellation records; unauthenticated alert payloads stay in low-integrity space until verified.
