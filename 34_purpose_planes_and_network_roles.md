# ASKA v6 — Purpose planes and network roles

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

**R-34-01 — Explicit purpose mapping.** Every deployment MUST map purpose endpoints to physical resources, object namespaces, guards and declared shared dependencies. Purpose names MUST NOT substitute for installed authority, a confidentiality label or a universal trust ordering.

## Physical endpoint separation

A purpose endpoint includes its ingress and egress attachments, receive buffers, parser resources, DMA mappings, processing domain, persistent owners and output guards. Separating only the external socket while merging all traffic in a shared writable host buffer leaves a common compromise path before classification. A native first-contact path must establish dedicated encounter resources before arbitrary payloads can influence shared processing; the mandatory physical resource boundary is specified below.

RP-A maps four compute IESs to the four computational purposes and gives Steles a separate witness role. Its per-purpose `G-p` boundary module combines several guard and owner functions, creating a shared per-purpose implementation cut set. RP-B places purposes on separate appliances and uses its declared local/community and upstream interfaces. Exact counts and local service interfaces are owned by [the reference machine](04_reference_machine_and_reachability.md); the counts are not architectural constants.

**R-34-02 — Separation before encounter processing.** A claimed separate encounter endpoint MUST isolate or guard ingress, buffers, DMA and parser execution before arbitrary content reaches other purposes. The manifest MUST expose shared drivers, management roots and downstream processing that weaken that separation.

**R-34-03 — Dedicated native encounter resources.** Native first-contact traffic MUST use dedicated encounter ports, receive/parser lanes, ingress FIFOs, buffer banks and DMA paths. Established ATN/STN service MUST NOT traverse an encounter FIFO or depend on its free-buffer pool. Encounter parsing, authentication, installation requests, interrupts and telemetry MUST have bounded allowances, and MUST NOT consume protected reservations for established-session control or recovery or directly modify established-session tables.

The separation begins before the first shared bottleneck. A common front-end receive queue followed by software classification does not meet the native requirement. Distinct queue names on the same unconstrained buffer pool are insufficient. A protected installer independently admits changes proposed by encounter processing; a parser cannot convert a new peer request into a write to an established session’s keys, mappings or budget.

RP-A and RP-B allocate a dedicated local encounter port `J-E` and a Wilder-governed resource domain `C-E/B-E/G-E`, with physically separate receive/parser lanes, FIFOs, buffer bank and DMA path. `J-W` continues to serve ordinary Wilder purpose traffic and is not the encounter FIFO’s back end. Encounter processing may submit bounded admission metadata through a guarded transfer, but cannot directly install established-session state. `LS-W` and `WM-L-W` cover the declared encounter exports; the shared Wilder installer is an explicit common dependency. The purpose/witness subtotal remains five duplex interfaces in RP-A and ten in RP-B; including the one local `J-E` gives totals of six and eleven respectively. The sixteen simplex security links are unchanged. [Chapter04](04_reference_machine_and_reachability.md) owns the full inventory. A compatibility realization with a shared front end must disclose that weaker boundary and cannot claim native encounter-resource conformance.

The resource inventory continues through memory controllers, interconnect arbitration, cryptographic engines, policy stores, power, clocks, cooling and reset. A shared downstream facility requires an enforceable service bound for any claimed protected service, or an explicit statement that the claim is unmet. Saturation may make first contact unavailable. The protected claim concerns the named established-service resources; it does not promise availability of every upstream carrier or immunity to the declared common physical failures.

A multi-homed endpoint is not a transparent bridge. Possession of two network interfaces authorizes neither forwarding nor copying between them. Bridging, proxying and routing are explicit services with source and destination contracts. Attaching a rogue cable can create physical reachability; it must not create the authority needed for protected publication or egress. A cable inserted behind an enforcing guard is a different physical attack and must be covered by the profile or declared outside it.

## Object crossings and endpoint behavior

A crossing identifies exact source object or bounded transformation, source principal, destination endpoint and recipient, purpose, lifetime, metadata policy, byte or query budget and applicable grant. The destination independently decides whether it accepts the object and associated obligations. A successful source release does not force destination storage, execution or publication.

The crossing service creates a new destination object with an explicit label. It does not let a lower-assurance endpoint borrow a mutable pointer into a protected purpose. A sanitized representation is a separate object bound to the transform and input version. If the transform includes a human or AI judgment, that judgment is evidence to the effect owner; it does not make every output of that actor safe by definition.

**R-34-04 — Independent crossing authorization.** Cross-purpose transfer MUST satisfy source release authority and destination acceptance independently, including exact output or authorized transform, labels, freshness, budget and final checks. Read access, co-location or dual connectivity MUST NOT imply crossing authority.

An opaque encrypted payload also needs a release contract. Encrypting a confidential object to an unauthorized recipient does not cure the disclosure. Conversely, a transport relay that cannot decrypt can carry an authorized ciphertext without obtaining plaintext rights. The contract states which owner establishes the plaintext-to-ciphertext binding and which metadata remains visible to the relay.

## Human interaction and visible output

The trusted interaction path binds what a person is shown and what action they authorize to the actual effect proposal. Keystone provides a protected display/input role under its contract, not a universal override. A dialog must identify relevant purpose, recipient, output representation and effect scope. An application cannot replace those fields with its own misleading labels while obtaining a broader grant.

Display composition, clipboard transfer, screenshots, recording, printing and audio are crossings when they move information to a new recipient or purpose. A person’s ability to perceive an authorized output is an intentional release. The machine cannot claim to revoke the person’s memory afterward or prevent every external camera in an uncontrolled environment. High-assurance interaction profiles must identify that physical environment and the remaining human-mediated channels.

**R-34-05 — Bound interaction and representation.** Purpose-sensitive user interaction MUST bind the displayed proposal and authorized representation to the actual effect. Capture, clipboard, recording, printing and audio MUST have explicit crossing policies rather than inherit permission from the ability to render or read.

A UAI operating for a person may receive selected context under a grant, but cannot automatically merge every purpose’s memory into one unbounded context. Model state, retrieval indexes, conversation history and derived summaries are information-bearing objects. Their migration between purposes follows the same contract as ordinary data. A security-analysis AI has a different purpose and receives only the observation authority installed for that role.

## Availability and failures

Endpoint separation must include service dependencies. Dedicated Wilder ingress is ineffective as an availability guarantee if its unauthenticated traffic can consume every cryptographic engine, memory-controller slot or power budget needed by an established Sanctum session. The admitted service profile therefore reserves or bounds the entire path needed for its promise. When that promise cannot be maintained, the owner records the narrower availability condition.

**R-34-06 — Purpose-bounded resource pressure.** Encounter and cross-purpose services MUST have bounded parser, queue, cryptographic and memory resources. Any claimed protection of established service MUST include shared downstream bottlenecks and declared common-power or management failures.

A purpose can be isolated after compromise while preserving a minimal recovery or oversight path, but that path is itself specified. Emergency isolation must not covertly redirect private content through an unapproved channel. If an essential service needs a limited fail-open behavior, the condition, exact effects and maximum exposure must be admitted in advance; it cannot be inferred from the word “critical.”

## Example and acceptance obligations

A citizen opens an arbitrary document in Wilder while a Polis service prepares an institutional filing. The document parser can use only its Wilder resources. It cannot request the citizen’s Sanctum signing key or silently replace the filing preview. A deliberate transfer creates an inspected, immutable representation and a crossing proposal. The citizen’s trusted interaction grants a particular filing effect. Polis accepts and processes that object under its own contract. Steles may witness a commitment digest if authorized, while the document’s confidential contents remain outside the witness record.

A malicious but authorized semantic approver can still approve bad content within its installed ceiling. Physical separation and exact-output binding limit the consequences; they do not prove the approver’s judgment. The profile must state where human, institutional or AI correctness remains trusted and where independent checking is required.

**R-34-07 — Honest endpoint assurance.** Endpoint claims MUST distinguish enforced boundaries from trusted semantic decisions and physical-environment assumptions. A compromised approver’s possible actions within its ceiling and any unguarded physical bypass MUST remain explicit residual risks.

Acceptance specifications are:

- **T-34-01:** Map every purpose endpoint to the physical manifest and installed authority. A purpose label without an enforcing mapping must fail qualification.
- **T-34-02:** Feed malformed encounter traffic before classification and attempt DMA into another purpose. No protected buffer or parser state may become reachable through the encounter path.
- **T-34-04:** Attach an extra interface and replay a read capability as a release capability. Neither action may authorize a cross-purpose publication.
- **T-34-05:** Change recipient, representation or purpose between trusted preview and effect execution. The guard must reject the mismatch; capture and printing must not inherit ungranted release rights.
- **T-34-06:** Saturate encounter parsing and cryptography. Established service must retain its declared bound under the stated dependencies, or the deployment must report failure of that claim.
- **T-34-07:** Exercise a malicious approver within and beyond its ceiling and a physical tap at the declared boundary. Reports must identify the allowed semantic risk and must not claim coverage of an excluded physical attack.

- **T-34-03:** Saturate the native encounter port before classification with maximum-rate frames, malformed lengths, incomplete handshakes, interrupts and telemetry load. Instrument the physical receive lanes, FIFOs, buffer banks and DMA paths: established ATN/STN traffic must use no encounter FIFO or encounter free-buffer allocation and must retain its declared control/recovery service bound. Repeat with downstream shared facilities stressed; any unenforced coupling must defeat the corresponding assurance claim rather than be hidden by separate queue labels.

## None

### Three roles that must not be conflated

The sovereign trust network (STN), authenticated trust network (ATN) and multi-channel network (MCN) describe different aspects of a deployment. STN concerns sovereign trust governance: local roots, identity and key-custody relationships, admission authorities and recovery arrangements. ATN provides authenticated connectivity under declared peer and protocol profiles. MCN describes the use and management of multiple channels. None is a universal permission source.

The purpose planes define why an operation is performed and which principals and obligations apply. They can use STN governance, ATN connectivity and one or more MCN channels without becoming interchangeable with those mechanisms. A local Sanctum service may require no external network. A Polis service may use an authenticated public carrier. A Steles witness may accept a minimal commitment over a dedicated channel without receiving the underlying private object.

**R-34-08 — Separate network roles.** A deployment MUST identify the governance, authenticated-connectivity, channel and purpose roles separately. Membership in an STN, successful ATN authentication or selection of an MCN channel MUST NOT automatically grant access to an object or effect.

The naming does not create one global sovereign network operator. Each realm or institution retains its own admitted roots and owner decisions. Cross-realm federation exchanges evidence and negotiates applicable contracts. It does not install a superior root able to rewrite every participant’s local grants.

The reference profiles’ dedicated `J-E` encounter attachment belongs to Wilder governance but is distinct from the ordinary Wilder purpose port. It adds no new societal purpose. Its `C-E/B-E/G-E` resource allocation and bounded installation proposals follow [endpoint separation](34_purpose_planes_and_network_roles.md); establishing identity there does not merge its buffers or authority with an established ATN/STN path.

### STN governance and sensitive services

An STN arrangement may host or connect identity admission, protected key custody, trusted interaction, recovery and high-consequence policy services. Those services can use physically isolated links where the selected profile requires them. The isolation claim must identify real interfaces, management paths and dependencies; the name STN alone makes no electrical or physical claim.

Trust-root configuration states which authorities may issue which kinds of claims, how they rotate or revoke keys, how participants detect rollback and how disputes are represented. A trust-root certificate or analogous configuration can identify a recognized issuer without authorizing that issuer to access local resources. Device provenance, role credentials, legal authority and object capabilities remain distinct types.

**R-34-09 — Local sovereign authority.** STN governance MUST preserve local owner and realm authority, typed issuer scopes and explicit recovery rules. Root configuration, reputation or institutional recognition MUST NOT bypass the installed CLAIM–CONTRACT–GRANT process or erase negative restrictions.

Recovery services distinguish restoring keys, restoring encrypted data and restoring permission. A threshold of participants may be authorized to recover one key under a defined event, but cannot use that ceremony to issue arbitrary new grants. An unavailable remote governance service need not halt every local computation; each service declares the freshness and offline limits under which its installed grants remain valid.

### ATN authenticated connectivity

ATN authentication establishes a peer or channel identity under a selected cryptographic profile. It may incorporate device evidence, institution credentials and endpoint binding. Authentication does not establish that a peer is benign, that its software remains uncompromised or that its requested output is lawful. The receive guard still checks destination acceptance and the source’s applicable release contract.

A connection record binds the authenticated peer to the physical or protected logical endpoint actually receiving traffic, negotiated algorithms, session epoch, application protocol and permitted operations. An authenticated tunnel cannot silently transport a different principal’s plaintext authority. If a tunnel aggregates multiple principals, each inner operation retains the necessary object and grant binding and receives independent enforcement.

**R-34-10 — Authentication without authority expansion.** ATN sessions MUST bind authenticated identity to the actual endpoint and protocol context. Session establishment MUST NOT install broader object, device or release rights than explicitly admitted, and loss of identity continuity MUST trigger the declared session recovery rule.

Post-quantum cryptography, classical authenticated key exchange, physically distributed keys and quantum key distribution are possible cryptographic-profile choices with different assumptions. They are not synonyms. A QKD link does not supply destination acceptance. The [NSA’s October 2026 discussion of quantum cryptographic solutions](https://www.nsa.gov/Cybersecurity/Post-Quantum-Cryptography-Resource-Hub/Article-Display/Article/4616320/quantum-cryptographic-solutions-are-limited-compared-to-post-quantum-algorithms/) identifies source authentication as a separate requirement for quantum key distribution. A post-quantum algorithm does not protect plaintext after authorized decryption. The deployment chooses and qualifies its suite in [key custody and continuity](26_boot_key_custody_recovery_and_continuity.md), rather than treating “quantum resistant” as an unspecified feature.

### MCN channel management

An MCN channel record identifies purpose constraints, endpoint bindings, direction, physical medium or logical multiplexing, bandwidth budget, queue ownership, encryption context, failure alternatives and management owner. Dynamic provisioning can create capacity within already admitted authority. It cannot make a forbidden crossing legal by assigning a new channel number.

Physical segregation requires separate resources appropriate to the claim. Separate virtual interfaces on one NIC share whatever firmware, queues, power, bus and reset mechanisms the NIC actually shares. Multiple fibers in one trench may have separate transceivers and still share a civil-works failure. The manifest records both facts without collapsing physical separation into an all-or-nothing label.

**R-34-11 — Qualified multi-channel service.** Every MCN channel MUST have an explicit resource, direction, authority and failure contract. Dynamic channel provisioning and multipath selection MUST preserve those constraints, and logical channels MUST NOT be reported as physically independent without supporting evidence.

Per-channel firewall and protocol workers can limit parser compromise and state interference. They need bounded memory, queues and cryptographic work, and their configurations must be installed by the correct local authority. A shared channel manager is a declared trust and availability dependency. A risk-rating service recommendation may lower a rate or propose closure under an installed response template; it cannot silently enlarge a firewall’s accepted recipient set.

### Local, community and upstream networks

A local deployment can collaborate with community appliances, institutional services and upstream carriers while retaining explicit boundaries. Distributed storage, content delivery, collaborative analysis, federated learning, threshold key services, software-candidate exchange and threat reporting are application services over those networks. Each service defines its own object operations and release obligations. The existence of a community mesh is not permission for every member to inspect every replica or model update.

RP-B gives each selected purpose appliance local/community and region/upstream carriage interfaces under the topology in [chapter 04](04_reference_machine_and_reachability.md). Local service can continue under its declared offline policy when an upstream path fails. A carrier outage does not authorize rerouting sensitive traffic through an unapproved neighbor. Conversely, a local trust decision does not claim control over a carrier’s undisclosed physical path.

**R-34-12 — Bounded federation and offline operation.** Community and upstream services MUST retain independent local admission, release and recovery decisions. Offline operation MUST have explicit freshness, budget and reconciliation limits, and fallback routing MUST satisfy the existing contract or fail closed at the relevant boundary.

Security configuration, telemetry reports and watcher oversight are separate channels from ordinary application carriage where the profile says so. A one-way configuration link remains one-way. Reports travel on their separately admitted return path and cannot automatically install policy. Steles witnessing is a distinct evidence service, not a substitute for the LSM/MSM watcher hierarchy.

### Example and acceptance obligations

A community clinic exchanges a de-identified aggregate with a regional research service. Its STN governance identifies the clinic’s authorized release process and protected key custodians. Its ATN session authenticates the research endpoint. An MCN reservation selects a permitted carriage path with bounded service. The clinic’s EG still verifies the exact aggregate and release grant; the regional RG independently accepts its label and purpose. A carrier’s bandwidth receipt does not authorize a more detailed patient record, and a research credential does not confer access to the clinic’s key store.

If the upstream link fails, the clinic may continue local operations within installed freshness limits. It preserves the unsent object and its pending effect state. It does not mark the aggregate as delivered, use a newly discovered unauthorized channel, or merge patient data into a general threat-report stream merely to keep the workflow moving.

**R-34-13 — Role-specific evidence.** Network records and receipts MUST identify whether they establish issuer recognition, peer authentication, channel reservation, source release, destination acceptance or delivery. Evidence of one role MUST NOT be substituted for another in admission or audit.

Acceptance specifications are:

- **T-34-08:** Authenticate a peer and mark it an STN participant without installing an object grant. Its protected read and release requests must remain denied.
- **T-34-09:** Present an issuer credential outside its typed scope or a recovery quorum attempting unrelated authority expansion. Local admission must reject the operation.
- **T-34-10:** Replace a session endpoint or multiplex an unauthorized principal inside a valid tunnel. The affected operation must fail its binding or grant check.
- **T-34-11:** Provision a virtual channel and claim physical independence. Qualification must expose its shared resources; changing the channel must not change allowed recipients.
- **T-34-12:** Disconnect upstream service until freshness expires. Local operations must follow the declared offline boundary, and unauthorized fallback transport must remain unavailable.
- **T-34-13:** Substitute a bandwidth-reservation or authentication receipt for a release or delivery receipt. The workflow must reject the type mismatch and preserve the actual pending state.
