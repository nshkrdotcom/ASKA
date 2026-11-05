# ASKA v6 — Commerce, enterprise and institutional workflows

Commercial and enterprise systems need useful delegation, predictable costs, reliable records and enforceable separation of responsibilities. ASKA supports purchasing, invoicing, payments, payroll, asset management, contracts, supply chains and regulated record handling through explicit owners and bounded effects. An organization's authority over its resources does not make it the administrator of every employee, customer, supplier or partner realm.

The principal architectural distinction is between institutional roles and ambient account power. A purchasing role can prepare an order; a budget owner can reserve funds; an approver can accept a commitment; a payment owner can submit an instruction. These roles may be combined for a small organization under a declared profile, but the resulting concentration of control must not be presented as independent oversight.

## Institutional roles and resource ownership

An institutional relationship identifies the organization, person or service, role, resource scope, duties, commencement, expiry and revocation conditions. Employment status qualifies some institutional actions but does not confer general access to personal correspondence, private medical information or unrelated family records. Device management authority must identify the actual managed resources and observation scope.

**R-44-01 — Bounded institutional administration.** Enterprise administrators and role holders MUST operate within explicit resource, purpose and observation scopes. Employment, device ownership or organizational rank MUST NOT create universal access to personal or external realms.

Institutional applications should expose separate accounts or views where their purposes differ. Payroll can receive the information required to calculate and deliver compensation without inheriting unrelated personnel investigations or clinical records. A compliance reviewer may inspect specified controls or transaction evidence without receiving a general private-data browser. An institution that requires broader access must establish and disclose a separate applicable basis, including any limitations and review duties.

Role changes must invalidate future exercise under stale grants. A departing employee's signing key may remain useful for historical verification but cannot authorize new purchases. A service account must not retain broader rights than the role whose workflow it implements merely because no human remembers to revoke it.

## Orders, invoices and payment instructions

A commercial contract identifies parties, goods or services, price and currency, delivery terms, tax or fee treatment where applicable, payment destination, permitted substitutions, approval roles, cancellation conditions, dispute procedure and evidence requirements. The machine representation must bind human-readable descriptions to concrete recipients and effect arguments. A purchase request and a payment request may share evidence but remain distinct effects.

**R-44-02 — Verified transaction bindings.** Orders and payments MUST bind the exact counterparty, destination account or service identity, amount, currency, object or invoice references and approved terms. A document assertion or tool result changing material payment details MUST require the qualifying verification specified by the transaction profile.

An invoice can be authentic while its payment destination is wrong or compromised. The invoice sender's signature is evidence of origin, not necessarily evidence that a newly supplied bank account is qualified. Verification may use an independently enrolled destination, qualified counterparty confirmation or another admitted procedure. The system should make the check explicit rather than relying on the agent's impression that the document looks credible.

Approvals must identify whether they authorize preparation, submission, commitment, payment or settlement acceptance. A manager's approval of an expense report does not necessarily authorize a payment owner to ignore a frozen account or exhausted budget. The effect owner performs current checks at finality.

## Budgets and separation of duties

Budgets can have per-transaction, per-counterparty, per-category and period limits. Child tasks may receive disjoint reservations or share a conserved parent account. Concurrency, refunds, partial fulfillment, cancellation fees and exchange-rate assumptions require explicit semantics. A nominal monthly ceiling is ineffective if every restarted worker receives a fresh copy of the full allowance.

**R-44-03 — Conserved commercial authority.** Financial and resource commitments MUST consume admitted budgets under a declared reservation and finality model. Parallel agents, repeated invoices, aliases, renewals and retries MUST NOT multiply authority or reset consumption without qualified renewal.

A separation-of-duties rule should name the distinct approvals and their independence assumptions. A person who creates a vendor may be prohibited from approving the first payment to that vendor. A contractor may submit work but not certify its acceptance. An autonomous agent may compare bids but cannot impersonate a required procurement reviewer. The system must also account for common control: multiple keys stored under one administrator are not necessarily independent approval roots.

**R-44-04 — Enforced role separation.** Where the applicable profile requires independent approvals or nondelegable duties, the transaction owner MUST verify those roles and their admitted independence before finality. Several signatures from the same disallowed control root MUST NOT satisfy a required separation.

## External finality and reconciliation

Commercial effects cross organizational and physical boundaries. A local order submission may commit before the supplier accepts it. A bank may acknowledge a payment instruction before settlement. A shipment record may state that a carrier accepted a package without proving delivery to the intended recipient. The contract must name each finality point and the evidence accepted for later outcomes.

**R-44-05 — Scoped commercial finality.** Commercial receipts MUST distinguish local submission, counterparty acceptance, settlement, shipment, delivery and other relevant outcomes. A known COMMITTED event MUST remain recorded; missing downstream evidence MUST be represented separately and reconciled without inventing universal success or clean rollback.

If an acknowledgment is lost, the workflow should query the existing effect identity or retry under a demonstrably compatible idempotency contract. An adapter to a legacy bank or supplier must describe its actual duplicate-prevention behavior. A retry using a different identity can create a second order even if the agent believes it is repairing the first. Where finality is genuinely unknown, UNCERTAIN is the honest state until evidence resolves it.

Returns, refunds and corrections are separately authorized effects. They have their own budgets, recipients, fees, accounting treatment and finality. A refund receipt does not erase the original payment. A corrected invoice must retain provenance to the superseded one so auditors can understand what changed without relying on mutable narrative text.

## Records, privacy and legacy systems

Institutional records may have retention, confidentiality, deletion, preservation and inspection obligations. The selected profile must explain which applies to which object and event. Ordinary deletion authority may be suspended by an independently applicable preservation duty. That duty does not automatically disclose the retained material to the requesting party or make every employee a reviewer.

**R-44-06 — Scoped record obligations.** Enterprise retention, deletion, preservation and audit workflows MUST identify their objects, basis, duration, qualified recipients and conflict rules. An audit or hold MUST NOT create unrestricted disclosure, and closing a transaction MUST NOT silently erase continuing obligations.

Legacy integration should map data fields and operations explicitly. A customer-relationship system, accounting package or industrial controller may be unable to enforce fine-grained ASKA labels or remote deletion. The adapter must identify this gap and require an admitted compatible contract. It cannot convert an unenforceable promise into a verified guarantee by adding a signature around the outgoing request.

Supply-chain workflows can bind a component artifact to build provenance, test evidence, custody and deployment approval. Provenance says where a claim or artifact came from; it does not prove that a supplier is trustworthy or that all delivered goods meet their specification. Physical inspection, acceptance tests and independent review remain separate evidence sources. A compromised supplier signature may authenticate a malicious package, so deployment admission must evaluate more than signature validity.

Privacy-preserving institutional analytics can reduce raw-data exposure, but an aggregate can still leak through repeated queries or small groups. Federated learning does not establish privacy merely by keeping raw records local: updates, gradients, model outputs and participation metadata need their own leakage and collusion analysis. Secure aggregation or other mechanisms must state the adversary and failure assumptions they actually address.

## Operational example and acceptance

A purchasing agent prepares an equipment order within a quarterly allocation. It can retrieve admitted supplier quotes, check specifications and propose terms. A qualified budget owner reserves funds, and an independent approver accepts the order where the profile requires separation. The payment owner verifies the enrolled supplier account and current available budget. The local instruction commits at a named boundary. Bank acceptance, settlement and delivery are tracked separately. If the supplier changes the account in an emailed invoice, the agent cannot treat that text as new payment authority. If the employee responsible for the order leaves, the institution assigns outstanding reconciliation and retention duties to a qualified successor rather than allowing the abandoned service session to continue indefinitely.

**R-44-07 — Institutional continuity without privilege residue.** Role termination, service replacement and organizational handoff MUST withdraw stale future authority, preserve established receipts and assign outstanding effects and duties to named qualified owners. Continuity MUST NOT depend on retaining an unrestricted former administrator or agent credential.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-44-01 | Use an enterprise administrator credential against an employee's separately protected personal realm; access remains denied. |
| T-44-02 | Substitute a bank account in an otherwise authentic invoice; payment cannot proceed without the admitted destination verification. |
| T-44-03 | Race duplicate invoices and sibling purchasing agents across a restart; committed obligations remain within the conserved budget. |
| T-44-04 | Present multiple approval keys controlled by a prohibited common root; an independence requirement remains unsatisfied. |
| T-44-05 | Commit a local instruction and lose settlement status; the local receipt persists and settlement stays separately unresolved. |
| T-44-06 | Apply a preservation hold; deletion is constrained as admitted, but unrelated audit or public disclosure rights do not appear. |
| T-44-07 | Remove a role while transactions remain open; stale grants cease future exercise and qualified successors receive only the required outstanding duties. |

These requirements define a transaction architecture, not a guarantee that every counterparty, financial institution or supply-chain participant will honor a contract. The relevant adapter, institutional and physical assumptions must remain visible in the deployment's assurance manifest.
