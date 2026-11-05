# ASKA v6 — STN, ATN, MCN and purpose-network roles

## Three roles that must not be conflated

The sovereign trust network (STN), authenticated trust network (ATN) and multi-channel network (MCN) describe different aspects of a deployment. STN concerns sovereign trust governance: local roots, identity and key-custody relationships, admission authorities and recovery arrangements. ATN provides authenticated connectivity under declared peer and protocol profiles. MCN describes the use and management of multiple channels. None is a universal permission source.

The purpose planes define why an operation is performed and which principals and obligations apply. They can use STN governance, ATN connectivity and one or more MCN channels without becoming interchangeable with those mechanisms. A local Sanctum service may require no external network. A Polis service may use an authenticated public carrier. A Steles witness may accept a minimal commitment over a dedicated channel without receiving the underlying private object.

**R-41-01 — Separate network roles.** A deployment MUST identify the governance, authenticated-connectivity, channel and purpose roles separately. Membership in an STN, successful ATN authentication or selection of an MCN channel MUST NOT automatically grant access to an object or effect.

The naming does not create one global sovereign network operator. Each realm or institution retains its own admitted roots and owner decisions. Cross-realm federation exchanges evidence and negotiates applicable contracts. It does not install a superior root able to rewrite every participant’s local grants.

The reference profiles’ dedicated `J-E` encounter attachment belongs to Wilder governance but is distinct from the ordinary Wilder purpose port. It adds no new societal purpose. Its `C-E/B-E/G-E` resource allocation and bounded installation proposals follow [endpoint separation](40_societal_planes_and_endpoint_separation.md); establishing identity there does not merge its buffers or authority with an established ATN/STN path.

## STN governance and sensitive services

An STN arrangement may host or connect identity admission, protected key custody, trusted interaction, recovery and high-consequence policy services. Those services can use physically isolated links where the selected profile requires them. The isolation claim must identify real interfaces, management paths and dependencies; the name STN alone makes no electrical or physical claim.

Trust-root configuration states which authorities may issue which kinds of claims, how they rotate or revoke keys, how participants detect rollback and how disputes are represented. A trust-root certificate or analogous configuration can identify a recognized issuer without authorizing that issuer to access local resources. Device provenance, role credentials, legal authority and object capabilities remain distinct types.

**R-41-02 — Local sovereign authority.** STN governance MUST preserve local owner and realm authority, typed issuer scopes and explicit recovery rules. Root configuration, reputation or institutional recognition MUST NOT bypass the installed CLAIM–CONTRACT–GRANT process or erase negative restrictions.

Recovery services distinguish restoring keys, restoring encrypted data and restoring permission. A threshold of participants may be authorized to recover one key under a defined event, but cannot use that ceremony to issue arbitrary new grants. An unavailable remote governance service need not halt every local computation; each service declares the freshness and offline limits under which its installed grants remain valid.

## ATN authenticated connectivity

ATN authentication establishes a peer or channel identity under a selected cryptographic profile. It may incorporate device evidence, institution credentials and endpoint binding. Authentication does not establish that a peer is benign, that its software remains uncompromised or that its requested output is lawful. The receive guard still checks destination acceptance and the source’s applicable release contract.

A connection record binds the authenticated peer to the physical or protected logical endpoint actually receiving traffic, negotiated algorithms, session epoch, application protocol and permitted operations. An authenticated tunnel cannot silently transport a different principal’s plaintext authority. If a tunnel aggregates multiple principals, each inner operation retains the necessary object and grant binding and receives independent enforcement.

**R-41-03 — Authentication without authority expansion.** ATN sessions MUST bind authenticated identity to the actual endpoint and protocol context. Session establishment MUST NOT install broader object, device or release rights than explicitly admitted, and loss of identity continuity MUST trigger the declared session recovery rule.

Post-quantum cryptography, classical authenticated key exchange, physically distributed keys and quantum key distribution are possible cryptographic-profile choices with different assumptions. They are not synonyms. A QKD link does not supply destination acceptance. The [NSA’s October 2026 discussion of quantum cryptographic solutions](https://www.nsa.gov/Cybersecurity/Post-Quantum-Cryptography-Resource-Hub/Article-Display/Article/4616320/quantum-cryptographic-solutions-are-limited-compared-to-post-quantum-algorithms/) identifies source authentication as a separate requirement for quantum key distribution. A post-quantum algorithm does not protect plaintext after authorized decryption. The deployment chooses and qualifies its suite in [key custody and continuity](30_boot_key_custody_recovery_and_continuity.md), rather than treating “quantum resistant” as an unspecified feature.

## MCN channel management

An MCN channel record identifies purpose constraints, endpoint bindings, direction, physical medium or logical multiplexing, bandwidth budget, queue ownership, encryption context, failure alternatives and management owner. Dynamic provisioning can create capacity within already admitted authority. It cannot make a forbidden crossing legal by assigning a new channel number.

Physical segregation requires separate resources appropriate to the claim. Separate virtual interfaces on one NIC share whatever firmware, queues, power, bus and reset mechanisms the NIC actually shares. Multiple fibers in one trench may have separate transceivers and still share a civil-works failure. The manifest records both facts without collapsing physical separation into an all-or-nothing label.

**R-41-04 — Qualified multi-channel service.** Every MCN channel MUST have an explicit resource, direction, authority and failure contract. Dynamic channel provisioning and multipath selection MUST preserve those constraints, and logical channels MUST NOT be reported as physically independent without supporting evidence.

Per-channel firewall and protocol workers can limit parser compromise and state interference. They need bounded memory, queues and cryptographic work, and their configurations must be installed by the correct local authority. A shared channel manager is a declared trust and availability dependency. A DTMS recommendation may lower a rate or propose closure under an installed response template; it cannot silently enlarge a firewall’s accepted recipient set.

## Local, community and upstream networks

A local deployment can collaborate with community appliances, institutional services and upstream carriers while retaining explicit boundaries. Distributed storage, content delivery, collaborative analysis, federated learning, threshold key services, software-candidate exchange and threat reporting are application services over those networks. Each service defines its own object operations and release obligations. The existence of a community mesh is not permission for every member to inspect every replica or model update.

RP-B gives each selected purpose appliance local/community and region/upstream carriage interfaces under the topology in [chapter 04](04_reference_machine_and_reachability.md). Local service can continue under its declared offline policy when an upstream path fails. A carrier outage does not authorize rerouting sensitive traffic through an unapproved neighbor. Conversely, a local trust decision does not claim control over a carrier’s undisclosed physical path.

**R-41-05 — Bounded federation and offline operation.** Community and upstream services MUST retain independent local admission, release and recovery decisions. Offline operation MUST have explicit freshness, budget and reconciliation limits, and fallback routing MUST satisfy the existing contract or fail closed at the relevant boundary.

Security configuration, telemetry reports and watcher oversight are separate channels from ordinary application carriage where the profile says so. A one-way configuration link remains one-way. Reports travel on their separately admitted return path and cannot automatically install policy. Steles witnessing is a distinct evidence service, not a substitute for the LSM/MSM watcher hierarchy.

## Example and acceptance obligations

A community clinic exchanges a de-identified aggregate with a regional research service. Its STN governance identifies the clinic’s authorized release process and protected key custodians. Its ATN session authenticates the research endpoint. An MCN reservation selects a permitted carriage path with bounded service. The clinic’s EG still verifies the exact aggregate and release grant; the regional RG independently accepts its label and purpose. A carrier’s bandwidth receipt does not authorize a more detailed patient record, and a research credential does not confer access to the clinic’s key store.

If the upstream link fails, the clinic may continue local operations within installed freshness limits. It preserves the unsent object and its pending effect state. It does not mark the aggregate as delivered, use a newly discovered unauthorized channel, or merge patient data into a general threat-report stream merely to keep the workflow moving.

**R-41-06 — Role-specific evidence.** Network records and receipts MUST identify whether they establish issuer recognition, peer authentication, channel reservation, source release, destination acceptance or delivery. Evidence of one role MUST NOT be substituted for another in admission or audit.

Acceptance specifications are:

- **T-41-01:** Authenticate a peer and mark it an STN participant without installing an object grant. Its protected read and release requests must remain denied.
- **T-41-02:** Present an issuer credential outside its typed scope or a recovery quorum attempting unrelated authority expansion. Local admission must reject the operation.
- **T-41-03:** Replace a session endpoint or multiplex an unauthorized principal inside a valid tunnel. The affected operation must fail its binding or grant check.
- **T-41-04:** Provision a virtual channel and claim physical independence. Qualification must expose its shared resources; changing the channel must not change allowed recipients.
- **T-41-05:** Disconnect upstream service until freshness expires. Local operations must follow the declared offline boundary, and unauthorized fallback transport must remain unavailable.
- **T-41-06:** Substitute a bandwidth-reservation or authentication receipt for a release or delivery receipt. The workflow must reject the type mismatch and preserve the actual pending state.
