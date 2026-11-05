# ASKA v6 — Reference realizations and legacy interoperability

## What constitutes a realization

A realization is a named apparatus, its installed software and firmware, its wiring, the responsible custodians, and a reproducible evidence dossier. A reference organization is a design target. A simulator is evidence about its model. Neither becomes an implemented physical boundary by adopting an ASKA name. The authoritative physical interfaces and counts are in [Chapter 04](04_reference_machine_and_reachability.md); this chapter assigns operating roles and deployment workflows to those interfaces. [Chapter 50](50_assurance_claims_profiles_and_manifests.md) defines the claims each apparatus may publish.

The implementation boundary includes powered-off maintenance paths, provisioning tools and restoration equipment. A demonstration that disables its ordinary debugger only during the attack test has not established the production claim. Every result identifies which attacker credentials and physical access were actually granted, which components were substituted with models, and which sources of power, clock, storage, network and installation authority survived the attack.

[Rushby's separation-kernel work](https://www.csl.sri.com/papers/sosp81/) and [MILS](https://www.inderscience.com/info/inarticle.php?artid=14859) are the primary comparative baselines, alongside [seL4](https://researchportalplus.anu.edu.au/en/publications/sel4-formal-verification-of-an-os-kernel/), [Qubes OS](https://www.qubes-os.org/doc/QubesArchitecture/), OctopOS, M3 and CHERI in [Chapter 52](52_prior_art_sources_and_evidence_register.md). Qualification must compare the same hostile paths and useful workloads rather than assuming that more boards confer more security.

## RP-A: personal or professional workstation

RP-A instantiates four separate purpose slices, each with its own compute C-p, writable bank B-p, guard module G-p and duplex purpose port J-p. It adds separate Keystone, Steles, oversight, five local observer roots, five local watcher roots, MSM and its watcher. G-p combines several protected functions inside one declared failure domain; a report cannot count those functions as independent protection against compromise of G-p itself.

The baseline uses four purpose ports, one Steles port and a separate J-E encounter port: six duplex interfaces in total, plus 16 one-way security links with 32 endpoint modules. J-E has its own parser lane, FIFO, B-E bank, C-E compute and DMA behind G-E; established ATN/STN sessions use separate purpose resources. These counts exclude separately enumerated internal exporters, proposal links, health taps, storage lanes, trusted input/display and maintenance connectors. A design procurement list must expand those classes into actual controllers, connector pins and firmware images. Four virtual network interfaces on one host controller are a comparison configuration, not this physical profile.

A professional workstation can perform the following complete workflow:

1. Wilder accepts an untrusted document into bounded quarantine. Its parser has private temporary memory, a constrained output schema and no Sanctum or Agora bank mapping.
2. A source-approved representation moves through a mailbox to an analysis cell. Labels retain origin, confidentiality restrictions and transformation history. The companion receives only the context explicitly delegated to that task.
3. Keystone presents the canonical effect requested by the analysis, including the actual destination, amount or disclosed object. Untrusted document text is visibly separate from trusted approval controls.
4. The appropriate local owner installs a bounded grant. A source release owner and the destination receiver independently authorize any crossing. The effect owner commits once at its named local finality point.
5. Steles receives a permitted receipt commitment. LSM sees authorized boundary events. Its watcher observes coverage and configuration independently of LSM self-report. Neither receives the document plaintext merely because the transaction is security relevant.

A shared chassis supply can stop all modules. RP-A therefore claims containment under scoped software compromise only when its guards and roots survive; it does not promise operation through a chassis fire, common supply failure or sufficiently invasive physical attack. If a motherboard service controller can reset every observer and guard, its power is in the dependency register and the corresponding independence claim is withdrawn.

## RP-B: independently operated community appliances

RP-B distributes the same logical roles across independently powered realm appliances. Each purpose appliance has guarded local/community and region/upstream ports; Steles has two witness replication interfaces. Its purpose/witness subtotal is ten duplex interfaces. A dedicated local J-E encounter port with its separate resource domain makes eleven duplex interfaces in total, alongside the same sixteen one-way security links before added redundancy. Local routes can use cooperative infrastructure while the upstream routes use a separately inventoried carrier. Sharing a pole, conduit, radio mast, exchange, provider account or utility feed remains a common cause.

The cooperative operates transport, queues and capacity policy. It cannot widen an individual's source release or an institution's receiver acceptance. Each participating realm maintains its own Accord admission, keys, update scope and retention rules. A neighborhood distribution service may relay approved packages, but an independently governed municipal appliance evaluates installation locally. A cooperative election or change of operator cannot silently transfer personal decryption keys.

During regional partition, local appointments, cached public notices, peer communication and already authorized device operations can continue where their policies permit. Expiring financial or civic credentials do not become timeless. The system records unavailable external checks and bounded deferred work. It never fabricates settlement, legal service or election acknowledgment merely to keep a user interface responsive. Conflicting offline operations reconcile under the specific application contract; potentially irreversible effects remain explicit.

RP-B acceptance disconnects each carrier, then each local relay, then distribution and oversight separately. It also tests a common duct or supply failure. Claimed local progress must use an actually surviving path and resource reserve. A physically distinct spare that lacks power, provisioned keys or receiving admission is not a working alternate. Recovery rehearsals include depleted batteries, clock uncertainty and constrained witness capacity.

## LP-1: first physical laboratory prototype

LP-1 is a proposed build, not a claim that equipment has been assembled. It minimizes the experiment while retaining a real consequence boundary:

| Apparatus | Placement and role | Essential experiment limitation |
|---|---|---|
| Two compute boards C-1/C-2 | Separate local RAM; malicious parser and authorized worker | Boards may share supplier, toolchain and bench supply |
| Boundary FPGA or dedicated guard board | MG/DG/BG and a simple durable effect counter | FPGA configuration authority may defeat every function in that device |
| Storage/effect board | Append-only test object and externally observable indicator or load | Indicator transition is not proof of arbitrary actuator safety |
| Local observer board | Receives fixed-schema exports, no memory bus-master connection | Sees only exported transitions and explicit physical taps |
| Local watcher board | Independent reset, installer and sequence/health inputs | Its own firmware and tap provenance remain trusted |
| Distribution source and separate watcher | Sends scoped configuration through optical simplex | Receiver and actual absence of reverse conductors must be inspected |
| Oversight receiver | Receives watcher reports on separate simplex link | Loss affects oversight, not generic guard authority |
| Trusted approval unit | Displays destination and exact operation for one task | Prototype trusted display assurance is separately evaluated |

**Stage 1 (guarded prevention)** requires compute-to-guard requests, guarded owned-memory/device links, a protected effect/consumption owner, and canonical approval-to-local-admission. The compute boards, guard board and storage/effect board, plus the trusted approval unit, establish this test boundary. Its output is independently measured; no watcher verdict is needed to reject a stale DMA or overbroad effect.

**Stage 2 (OOB evidence)** adds the observer, watcher, distribution and oversight apparatus: exporter-to-LSM, independent exporter/health taps, MSM-to-LSM simplex configuration, LSM-to-MSM reporting, watcher-to-OV report and bounded LSM-to-effect-owner proposals. These added boards and links are not prerequisites for Stage 1. Each path is recorded as simplex or duplex with its actual parser, destination and reset owner. A shared bench-management switch must be inventoried as additional reachability, not assumed harmless.

The initial application imports an adversarial image or invoice, extracts a bounded representation, obtains exact approval and appends one authorized durable result. The adversary owns C-1 and supplies delayed DMA during Stage 1; during Stage 2 it also floods reports and proposes a correctly signed but invalid observer configuration. Each stage includes a positive authorized control under the same policy. An independently instrumented output records whether any forbidden append or emission escaped; guest log messages are insufficient evidence.

LP-1 first measures isolation and observability with simple electrical links. An optical component, capability ISA or advanced package is useful only when its specific hypothesis is under test. A single FPGA partition can validate an interface state machine while leaving configuration-root independence unestablished. Changing from an existing core to a minimal object ISA is a separate experiment, with the same externally visible contract and adversarial workload.

## Software and confidential-computing comparisons

A conventional-host interpreter can exercise schemas, PACT, grant attenuation, exact-output binding and recovery schedules. Host compromise is outside that interpreter's enforceable boundary. A capability processor can test local references and compartment costs, but shared writable resources and management roots must be assessed separately. A confidential VM or DPU may establish a useful protected endpoint under its actual platform assumptions; its label does not establish the complete native machine.

Comparisons use equal useful tasks and explicit guarantees. Record parser privilege, untrusted operating-system reach, device assignment, memory bandwidth, copy overhead, lifecycle delay, power, telemetry coverage and recovery authority. If the stronger physical configuration consumes more power or loses utilization, publish that difference. If a baseline offers a property the prototype lacks, publish that too. [Chapter 10](10_processor_isa_and_execution_semantics.md) and [Chapter 51](51_research_program_and_candidate_substrates.md) keep binary ISA selection open pending evidence.

[Ryoan](https://www.usenix.org/system/files/conference/osdi16/osdi16-hunt.pdf) is a specific comparison for confining untrusted processing of secret inputs through a trusted sandbox and enclave, with a request-oriented data model. Its threat model excludes denial of service and hardware/execution-time side channels and trusts the sandbox and SGX. ASKA adopts no inherited whole-system guarantee from that result: its physical ownership, independent observers, durable effects and conditional availability require separate evidence. The useful comparison is the confinement contract and request lifecycle, not the presence of an enclave name.

## Legacy operating systems, applications and cloud services

A legacy OS runs as a confined workload within its assigned IES or compatibility domain. It may manage its own local processes and virtual address space. It cannot become the owner of unrelated persistent banks, guard tables or purpose ports. External effects are exposed through bounded adapters whose schemas identify object, operation, receiver, label and budget. A syscall wrapper that can silently invoke a raw NIC or writable storage path does not provide the required boundary.

The compatibility process is incremental: inventory actual effects; identify irreducible trusted workers; put parsers and presentation in private request lifetimes; separate durable ownership; replace broad credentials with scoped adapters; then test the complete application under a hostile worker. Shared compatibility may allocate a shared service domain by agreement, but participants retain their own release rights. Joining, leaving and revocation retire associated grants, snapshots and keys; a shared hypervisor name does not confer physical independence.

Cloud calls are external effects. A release owner binds the exact prompt, document or record to the service identity and declared retention terms. The local system can enforce what it sends and record consent or another valid basis. It cannot guarantee that an unconstrained external recipient erases plaintext, suppresses model learning or honors a policy beyond the recipient's independently evidenced controls. A returned result is a claim with provenance, not a permission or factual oracle.

Legacy protocols may require TLS termination, authentication brokers, file conversions or transaction coordinators. Each trusted termination point is a separately named disclosure and compromise boundary. An adapter must not combine the union of both realms' keys and raw interfaces in one unrestricted worker. Export to a conventional application explicitly downgrades the continuing enforcement claim for the disclosed copy, without downgrading still protected originals.

## Institutional deployment patterns

A school separates student, guardian, staff, public kiosk and civic service relationships. A campus network name establishes connectivity only. Guardian credentials are evaluated for the specific record and action; they do not inherit student personal keys. A bank uses Agora for authorized payment and a separately admitted Polis obligation for required reporting. Tax-report admission cannot rewrite the payroll recipient list.

An emergency service defines the precise protected stop, safe-state and continuity policies before operation. Its safety controller may reject immediate power removal if that would create a hazard. A municipal office keeps public notice, benefits processing, election administration and evidence disclosure as separate authority domains. All profiles publish the applicable local legal assumptions without asserting universal legal validity.

## Commissioning and retirement

Commissioning verifies schematics against actual wiring, enrolls roots through independent custody, inventories firmware and fuses, binds protected counters to epochs, installs minimum policies and rehearses both permitted work and attack paths. A signed manifest is a statement by its issuer; inspections and results establish its supported claims. Observers and recovery equipment are included in the exercise.

Retirement revokes future grants, reconciles pending effects, records uncertain remote outcomes, retires identities and sanitizes storage according to the actual medium. Backups and witness retention follow their own obligations. Reassigning a serial number or board name never revives a retired generation. Success is defined by the named lifecycle and data-recovery tests, not by an empty application directory.

## Required behavior and test oracles

**R-48-01 — Named apparatus.** Every realization MUST identify actual components, roots, wiring, build state and unimplemented substitutions.

**Acceptance T-48-01:** Compare the dossier with inspected equipment; any undeclared consequential substitution invalidates its claim.

**R-48-02 — Profile fidelity.** RP-A and RP-B claims MUST use the physical inventory and counted boundary in Chapter 04.

**Acceptance T-48-02:** Recompute expanded ports, roots and maintenance paths; a virtual interface cannot satisfy a required separate controller.

**R-48-03 — Laboratory limits.** LP-1 MUST distinguish guard-state evidence from FPGA, supplier, power and installation independence.

**Acceptance T-48-03:** Give the attacker configuration or service access separately; document which protections fail and which remain outside scope.

**R-48-04 — Confined compatibility.** Legacy OS and cloud adapters MUST preserve local effect gates and disclose external plaintext boundaries.

**Acceptance T-48-04:** Compromise the guest and adapter; unrelated banks remain inaccessible and no raw external effect bypasses admission.

**R-48-05 — Useful failure operation.** Deployment tests MUST include authorized progress during each claimed survivable failure and explicit unavailable outcomes.

**Acceptance T-48-05:** Disconnect each enumerated dependency; observe a useful permitted operation or report the precise failed availability assumption.

**R-48-06 — Lifecycle acceptance.** Commissioning and retirement MUST test roots, recovery, pending effects, generation retirement and actual data sanitization.

**Acceptance T-48-06:** Restore an old image after retirement; stale identities cannot act, while legitimate retained records follow their separate policy.
