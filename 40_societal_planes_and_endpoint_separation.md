# ASKA v6 — Societal planes and endpoint separation

## Purpose boundaries are enforceable contracts

Sanctum, Polis, Agora, Wilder and Steles name purposes and authority relationships. They do not designate a universal number of connectors, a total ordering of trust or a single administrative hierarchy. A deployment maps those purposes to physical domains, object namespaces, devices, user interaction and transport under an explicit manifest. Physical separation strengthens a particular boundary only when the entire relevant path is separated or guarded.

| Purpose | Intended role | Boundary that remains necessary |
|---|---|---|
| Sanctum | Private and sensitive personal or institutional work | Exact recipient and purpose authorization for every release |
| Polis | Civic and institutional participation | Separate legal basis, local institutional authority and accountable effects |
| Agora | Exchange, collaboration and commerce | Bounded counterparties, transactions and imported content |
| Wilder | Untrusted exploration and encounter with arbitrary content | Containment before payload interpretation or interaction with protected objects |
| Steles | Witnessing admitted commitments and notices | Scoped evidence intake, confidentiality and independent retention rules |

These purposes do not imply that every Polis request outranks every Sanctum restriction, or that Agora data is necessarily public. Object labels, legal bases, contracts and installed grants decide specific operations. A compulsory legal demand, voluntary consent, professional duty and delegated agency remain distinct bases. A credential describing one basis cannot silently become a resource capability for all purposes.

**R-40-01 — Explicit purpose mapping.** Every deployment MUST map purpose endpoints to physical resources, object namespaces, guards and declared shared dependencies. Purpose names MUST NOT substitute for installed authority, a confidentiality label or a universal trust ordering.

## Physical endpoint separation

A purpose endpoint includes its ingress and egress attachments, receive buffers, parser resources, DMA mappings, processing domain, persistent owners and output guards. Separating only the external socket while merging all traffic in a shared writable host buffer leaves a common compromise path before classification. A native first-contact path must establish dedicated encounter resources before arbitrary payloads can influence shared processing; the mandatory physical resource boundary is specified below.

RP-A maps four compute IESs to the four computational purposes and gives Steles a separate witness role. Its per-purpose `G-p` boundary module combines several guard and owner functions, creating a shared per-purpose implementation cut set. RP-B places purposes on separate appliances and uses its declared local/community and upstream interfaces. Exact counts and local service interfaces are owned by [the reference machine](04_reference_machine_and_reachability.md); the counts are not architectural constants.

**R-40-02 — Separation before encounter processing.** A claimed separate encounter endpoint MUST isolate or guard ingress, buffers, DMA and parser execution before arbitrary content reaches other purposes. The manifest MUST expose shared drivers, management roots and downstream processing that weaken that separation.

**R-40-07 — Dedicated native encounter resources.** Native first-contact traffic MUST use dedicated encounter ports, receive/parser lanes, ingress FIFOs, buffer banks and DMA paths. Established ATN/STN service MUST NOT traverse an encounter FIFO or depend on its free-buffer pool. Encounter parsing, authentication, installation requests, interrupts and telemetry MUST have bounded allowances, and MUST NOT consume protected reservations for established-session control or recovery or directly modify established-session tables.

The separation begins before the first shared bottleneck. A common front-end receive queue followed by software classification does not meet the native requirement. Distinct queue names on the same unconstrained buffer pool are insufficient. A protected installer independently admits changes proposed by encounter processing; a parser cannot convert a new peer request into a write to an established session’s keys, mappings or budget.

RP-A and RP-B allocate a dedicated local encounter port `J-E` and a Wilder-governed resource domain `C-E/B-E/G-E`, with physically separate receive/parser lanes, FIFOs, buffer bank and DMA path. `J-W` continues to serve ordinary Wilder purpose traffic and is not the encounter FIFO’s back end. Encounter processing may submit bounded admission metadata through a guarded transfer, but cannot directly install established-session state. `LS-W` and `WM-L-W` cover the declared encounter exports; the shared Wilder installer is an explicit common dependency. The purpose/witness subtotal remains five duplex interfaces in RP-A and ten in RP-B; including the one local `J-E` gives totals of six and eleven respectively. The sixteen simplex security links are unchanged. [Chapter04](04_reference_machine_and_reachability.md) owns the full inventory. A compatibility realization with a shared front end must disclose that weaker boundary and cannot claim native encounter-resource conformance.

The resource inventory continues through memory controllers, interconnect arbitration, cryptographic engines, policy stores, power, clocks, cooling and reset. A shared downstream facility requires an enforceable service bound for any claimed protected service, or an explicit statement that the claim is unmet. Saturation may make first contact unavailable. The protected claim concerns the named established-service resources; it does not promise availability of every upstream carrier or immunity to the declared common physical failures.

A multi-homed endpoint is not a transparent bridge. Possession of two network interfaces authorizes neither forwarding nor copying between them. Bridging, proxying and routing are explicit services with source and destination contracts. Attaching a rogue cable can create physical reachability; it must not create the authority needed for protected publication or egress. A cable inserted behind an enforcing guard is a different physical attack and must be covered by the profile or declared outside it.

## Object crossings and endpoint behavior

A crossing identifies exact source object or bounded transformation, source principal, destination endpoint and recipient, purpose, lifetime, metadata policy, byte or query budget and applicable grant. The destination independently decides whether it accepts the object and associated obligations. A successful source release does not force destination storage, execution or publication.

The crossing service creates a new destination object with an explicit label. It does not let a lower-assurance endpoint borrow a mutable pointer into a protected purpose. A sanitized representation is a separate object bound to the transform and input version. If the transform includes a human or AI judgment, that judgment is evidence to the effect owner; it does not make every output of that actor safe by definition.

**R-40-03 — Independent crossing authorization.** Cross-purpose transfer MUST satisfy source release authority and destination acceptance independently, including exact output or authorized transform, labels, freshness, budget and final checks. Read access, co-location or dual connectivity MUST NOT imply crossing authority.

An opaque encrypted payload also needs a release contract. Encrypting a confidential object to an unauthorized recipient does not cure the disclosure. Conversely, a transport relay that cannot decrypt can carry an authorized ciphertext without obtaining plaintext rights. The contract states which owner establishes the plaintext-to-ciphertext binding and which metadata remains visible to the relay.

## Human interaction and visible output

The trusted interaction path binds what a person is shown and what action they authorize to the actual effect proposal. Keystone provides a protected display/input role under its contract, not a universal override. A dialog must identify relevant purpose, recipient, output representation and effect scope. An application cannot replace those fields with its own misleading labels while obtaining a broader grant.

Display composition, clipboard transfer, screenshots, recording, printing and audio are crossings when they move information to a new recipient or purpose. A person’s ability to perceive an authorized output is an intentional release. The machine cannot claim to revoke the person’s memory afterward or prevent every external camera in an uncontrolled environment. High-assurance interaction profiles must identify that physical environment and the remaining human-mediated channels.

**R-40-04 — Bound interaction and representation.** Purpose-sensitive user interaction MUST bind the displayed proposal and authorized representation to the actual effect. Capture, clipboard, recording, printing and audio MUST have explicit crossing policies rather than inherit permission from the ability to render or read.

A UAI operating for a person may receive selected context under a grant, but cannot automatically merge every purpose’s memory into one unbounded context. Model state, retrieval indexes, conversation history and derived summaries are information-bearing objects. Their migration between purposes follows the same contract as ordinary data. A security-analysis AI has a different purpose and receives only the observation authority installed for that role.

## Availability and failures

Endpoint separation must include service dependencies. Dedicated Wilder ingress is ineffective as an availability guarantee if its unauthenticated traffic can consume every cryptographic engine, memory-controller slot or power budget needed by an established Sanctum session. The admitted service profile therefore reserves or bounds the entire path needed for its promise. When that promise cannot be maintained, the owner records the narrower availability condition.

**R-40-05 — Purpose-bounded resource pressure.** Encounter and cross-purpose services MUST have bounded parser, queue, cryptographic and memory resources. Any claimed protection of established service MUST include shared downstream bottlenecks and declared common-power or management failures.

A purpose can be isolated after compromise while preserving a minimal recovery or oversight path, but that path is itself specified. Emergency isolation must not covertly redirect private content through an unapproved channel. If an essential service needs a limited fail-open behavior, the condition, exact effects and maximum exposure must be admitted in advance; it cannot be inferred from the word “critical.”

## Example and acceptance obligations

A citizen opens an arbitrary document in Wilder while a Polis service prepares an institutional filing. The document parser can use only its Wilder resources. It cannot request the citizen’s Sanctum signing key or silently replace the filing preview. A deliberate transfer creates an inspected, immutable representation and a crossing proposal. The citizen’s trusted interaction grants a particular filing effect. Polis accepts and processes that object under its own contract. Steles may witness a commitment digest if authorized, while the document’s confidential contents remain outside the witness record.

A malicious but authorized semantic approver can still approve bad content within its installed ceiling. Physical separation and exact-output binding limit the consequences; they do not prove the approver’s judgment. The profile must state where human, institutional or AI correctness remains trusted and where independent checking is required.

**R-40-06 — Honest endpoint assurance.** Endpoint claims MUST distinguish enforced boundaries from trusted semantic decisions and physical-environment assumptions. A compromised approver’s possible actions within its ceiling and any unguarded physical bypass MUST remain explicit residual risks.

Acceptance specifications are:

- **T-40-01:** Map every purpose endpoint to the physical manifest and installed authority. A purpose label without an enforcing mapping must fail qualification.
- **T-40-02:** Feed malformed encounter traffic before classification and attempt DMA into another purpose. No protected buffer or parser state may become reachable through the encounter path.
- **T-40-03:** Attach an extra interface and replay a read capability as a release capability. Neither action may authorize a cross-purpose publication.
- **T-40-04:** Change recipient, representation or purpose between trusted preview and effect execution. The guard must reject the mismatch; capture and printing must not inherit ungranted release rights.
- **T-40-05:** Saturate encounter parsing and cryptography. Established service must retain its declared bound under the stated dependencies, or the deployment must report failure of that claim.
- **T-40-06:** Exercise a malicious approver within and beyond its ceiling and a physical tap at the declared boundary. Reports must identify the allowed semantic risk and must not claim coverage of an excluded physical attack.

- **T-40-07:** Saturate the native encounter port before classification with maximum-rate frames, malformed lengths, incomplete handshakes, interrupts and telemetry load. Instrument the physical receive lanes, FIFOs, buffer banks and DMA paths: established ATN/STN traffic must use no encounter FIFO or encounter free-buffer allocation and must retain its declared control/recovery service bound. Repeat with downstream shared facilities stressed; any unenforced coupling must defeat the corresponding assurance claim rather than be hidden by separate queue labels.
