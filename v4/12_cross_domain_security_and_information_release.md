# ASKA v4 — Cross-domain security and information release

[Start](01_architecture_and_reading_map.md) · [Previous](11_purpose_networks_and_gateways.md) · [Next](13_admission_and_delivery.md)

**Requirements:** R01, R04–R06, R08–R13, R18–R24. **Decision:** D09.

A protected domain can contain malicious endpoints, validly credentialed insiders, compromised controllers, and hostile content. Physical separation removes transfer paths and can reduce shared failure dependencies. It grants no right to read, invoke, disclose, or receive. Permitted crossings remain attack surfaces even when they use authenticated ASKA equipment.

This contract applies inside a package, between purpose fabrics, across independent realms, and through devices that carry information without a live network. The contract retains the physical target in R03/R04. Mandatory guards must enforce authority on every remaining modeled path. No cross-domain safety result exists for ASKA yet.

## Reachability and authority

Each deployment maintains two distinct graphs:

- `G_path` records possible physical and logical transfers, including memory, ports, devices, media, management, output surfaces, and declared side channels.
- `G_auth` records permitted operations and disclosures. An edge binds source/destination identities and generations, input/output categories, method, object scope, representation, prerequisites, observation profile, expiry, and budget.

An effect needs a permitted `G_auth` edge and the guards and resources that implement it on `G_path`. Adding an edge to `G_path` must not add an edge to `G_auth`. The local checker requires an installed grant and separately checks whether the issuer can authorize each named effect. Removing a physical path can stop progress without revoking the corresponding right; revoking the right must stop new commits even while a path remains.

A dual-connected endpoint can receive only its admitted inputs and emit only its authorized outputs. Its two interfaces do not imply forwarding authority. An unauthorized switch can carry or disrupt signals outside the guards, but cannot manufacture a source release or receiver grant. The claim assumes the attacker has not tapped plaintext after the last guard, replaced an enforcement root, or obtained an already sufficient release right. The test plan and failure-dependency record must cover each of those cases separately.

## Separated functions

| Function | Granted scope | Must not imply |
|---|---|---|
| Read/compute | Observe specified versions within confinement | Export, print, delegate, or reveal to another audience |
| Semantic release authorization | Approve exact content or a constrained output relation under local policy | Raw transmission or arbitrary policy installation |
| Release control | Verify approval, stable representation, destination, currentness, and use allowance | Deciding arbitrary content is safe from its syntax or digest |
| Transport | Carry admitted records on permitted resources | Permission to disclose their plaintext |
| Receive | Admit a bounded object or operation under destination policy | Trust in content or unrestricted application effects |
| Boundary configuration | Change scoped resources under required independent approvals | New information-flow rights merely from new connectivity |

The proposer may be an application, AI, or human workflow. An independent approver accepts only the scope delegated to it. The release enforcer has protected metadata and output bindings; the proposing workload cannot write its decisions. A guard that shares the proposer's unrestricted updater is not independent of that updater. Domain dependency records identify actual custodians, firmware, reset, build, and recovery reach.

A compromised semantic approver can make bad decisions inside its installed ceiling. Independent exact-output control prevents later substitution and enforces that ceiling; it does not recover the intended meaning of an arbitrary report. To claim more, the design must use a trusted narrow transformation, independently verify the output relation, require separate approvals whose independence it can justify, or deny the downward flow. If one role retains sufficient authority to disclose the secret, its compromise remains a disclosure failure in the stated model.

## Transfer pipeline

```text
A: confined producer -> immutable candidate -> semantic approval
                                      -> independent release control
                                      -> protected source egress
                            untrusted transit
B: protected ingress -> transport quarantine -> receiver publication
                     -> confined parsing -> independently checked effect
```

A confined transformer may run before approval or in a separate stage whose checks establish the permitted transformation. The pipeline can span several devices. High-consequence boundaries use separately owned source and destination controls; a single DTG cannot reprogram both. Even a properly released, authenticated object can exploit its destination parser. The receiver's memory and effect guards must still contain the parser after takeover.

Imports and exports have different obligations. Import guards constrain hostile code and data; admitting an object grants it no additional authority. Export guards preserve source restrictions and enforce explicit disclosure decisions. An import transformer must not share response plaintext or export handles by convenience. When a request needs response correlation, a guarded service passes bounded typed identifiers between the workers. Responses, errors, acknowledgment presence, and retries are separate information-flow edges.

## Release record and state

The release enforcer resolves a canonical record with these meanings:

```text
release_id; issuer/role and approval-set identities
source realm/domain/generation; source object/version commitments
input and output categories; integrity assertions actually established
transformation artifact/revision and checked relation, if required
output representation revision; immutable output commitment and byte length
destination realm/service/device/audience and generation
method, purpose identifier, operation identity, physical path class
metadata and observation contract; permitted retry behavior
use/byte/query ceilings and shared allowance parent
policy/revocation versions; validity and recovery context
```

A purpose identifier constrains a defined operation; it cannot prove a recipient's private intention. An output commitment covers the entire emitted representation, including the main file body and relevant metadata. Signing a mutable descriptor does not bind the bytes that the engine will emit. Commitments assume the selected cryptography; the enforcer still needs a protected binding from those commitments to actual bytes.

```text
CANDIDATE -> SEALED -> APPROVED -> RESERVED -> EMITTING -> CLOSED
    |          |          |          |           |
    +----------+----------+----------+-----------+-> ABORTED_OR_UNCERTAIN
```

1. The preparation worker runs under the joined source confinement. It seals the candidate and its representation without creating lower-category output during preparation.
2. The semantic authority approves that immutable candidate or an explicitly checked relation. The approver must satisfy every required independent prerequisite. A later transformation produces a new candidate unless the approval already covers that transformation and the enforcer can establish the relation.
3. The release enforcer resolves its own protected bindings and current policy, checks destination, versions, approval scope, lifetime, and aggregate allowance, then reserves bounded engine capacity. The local controller serializes withdrawal and reservation.
4. Before the first irreversible emission, the enforcer commits consumption of the required allowance and rechecks current local permission in the emission order. It rechecks policy for later emissions or chunks as the contract defines. If withdrawal wins that order, the enforcer denies them. It cannot recall an emitted prefix.
5. The engine emits only the bound representation through the admitted endpoint. The encryption path must independently bind its output to that plaintext and destination. A workload cannot replace it with opaque ciphertext or choose unaccounted padding and metadata.
6. The receiver independently checks its current policy before publication, then checks application effects separately. Source-side commit and destination-side policy decisions occur separately. Partitions and lost receipts produce the outcomes defined in 07/13.

The enforcer must persist reserve/charge state whenever reopening it after a crash could duplicate a release. A crash after charging can waste allowance; safety takes precedence over refunding an uncertain emission. The enforcer may refund only when protected evidence shows that emission never reached the irreversible point. It may retry identical protected content only within the explicit retry/byte envelope; a new destination or candidate requires new authority. Receiver deduplication limits repeated application effects but cannot undo repeated wire observations.

The enforcer can buffer a fixed-length bounded object completely. Large objects require a sealed manifest, child commitments, total length, and bounded retention. Whole-object approval can authorize emission of committed chunks without waiting for whole-object receiver publication. If the contract requires no partial disclosure, it cannot send chunks before approval and call later assembly atomicity sufficient. After approval, an interrupted transfer may still disclose a prefix; its failure contract must say so.

## Path register

Every deployment maintains the following fields per path: physical endpoints, possible observers, object/representation, independent authorities, mandatory guards, irreversible point, current-policy order, crash/retry behavior, residual dependencies, and test case. Link paths also record event detection, state retained across interruption, retirement triggers, required endpoint/path evidence, and resumption authority. Encounter paths record dedicated ingress resources and every downstream shared dependency. An unenumerated interface leaves R21 unestablished.

| Path | Required treatment |
|---|---|
| Memory, loans, DMA, accelerator results | Protected ownership/context and confinement through every delayed effect |
| Network and cross-fabric services | Separate release, carriage, independent receipt, and application effect |
| Removable media and offline bundles | External recipient/import source; bind metadata; no executable auto-import or saved authority revival |
| Clipboard, drag-and-drop, screen capture | Explicit source/destination audience and output owner; no implicit desktop-wide copying |
| Display, audio, print | Audience/device, immutable representation, copy/rate limits, and physical disclosure point |
| Backup, migration, recovery, key wrapping | Confidentiality and restore authority under independent current policy; no universal recovery bypass |
| Audit, telemetry, crash dumps, diagnostics | Labeled objects and bounded release; errors and existence are outputs |
| Firmware, management, debug, maintenance | Scoped installation and secret-access rules; no hidden path around ordinary gates |
| Timing, traffic shape, power, heat, emissions | Declared observer and tested bound, or an explicit exclusion; never silently equated with no leakage |
| Human perception and reproduction | Record the authorized exposure and physical controls; no guarantee that a permitted viewer cannot remember or photograph it |

An infected device can lie about identity or format and attack its driver. The encounter boundary subjects it to bounded parsing and external DMA guards. Enrollment is not permission to install firmware or obtain a native memory handle. Export to an approved drive is still disclosure; encryption of that drive does not make the disclosure disappear.

Display access is not print or capture access. A shared terminal serving several domains requires protected input routing and surfaces, per-domain clipboard/capture policy, and a disclosed compositor failure scope. If one compositor sees every plaintext, its compromise crosses those confidentiality boundaries regardless of separate underlying networks.

## Observation contracts

Observation profiles are independent of physical profiles P0–P3. Physical separation alone does not establish any observation profile.

| Profile | Claim to establish | Residual limits |
|---|---|---|
| O1: explicit transfers/effects | Object bytes, labels, capabilities, and named effects follow policy | No general claim about timing, termination, traffic shape, or emanations |
| O2: bounded external observations | Named metadata/status/timing channels have enforced schedules, alphabets, cumulative allowances, and measured or proved bounds | Every unmodeled observation remains excluded; bandwidth limits still permit disclosure |
| O3: specified physical exposure | O2 plus apparatus-specific probing, emanation, peripherals, enclosure, and audience assumptions | No arbitrary physical-subversion or human-memory guarantee |

For O2, compare paired executions differing in protected inputs under the exact allowed observations and release relation. Fixed sizes and schedules can remove some choices. A secret-dependent decision to omit a scheduled result remains an observation; a protected output service needs a specified default and fault behavior. Scheduling, retries, busy indications, and public denial logs require the same analysis.

Repeated narrow outputs may reveal more than one result suggests. Query allowances have a protected shared parent across workers, sessions, and restart. Numeric range checks, redaction, and format normalization alone do not establish a disclosure bound. A differential-privacy candidate would need an explicit adjacent-dataset model that matches the release contract and protected cumulative accounting. This specification selects no such mechanism and claims no proof for one.

A diode restricts physical direction. In its permitted direction it can carry malicious inputs or secrets. A status cable creates another edge. Optical and electrical paths need the same accounting. Conformance reports must state human and physical exclusions explicitly; footnotes alone are insufficient.

## Comparison with established practice

| Primary reference | Relevant established position | ASKA design obligation or difference |
|---|---|---|
| [NCSC architecture, April 2026](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-architecture) | End-to-end controls and ownership dependencies | Apply the crossing contract inside execution, device, persistence, and AI paths; native physical ownership remains mandatory |
| [NCSC design principles](https://www.ncsc.gov.uk/collection/cross-domain/cross-domain-design-principles) | Separate release authorization/control, confined processing, and bidirectional risks; free-form review lacks absolute assurance | Bind immutable output and account for release use through crash/retry; test proposer and transformer compromise independently |
| [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) | Location and ownership do not establish implicit trust | Apply R19 on-chip and on every purpose fabric; physical segregation remains a separate requirement |
| [NIST SP 800-53 revision 5](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) | AC-4 addresses information flows; SC-31 addresses covert channels | Map specific controls below to concrete guards, observable commits, and conformance records |
| [NSA NCDSMO](https://www.nsa.gov/Cybersecurity/Partnership/National-Cross-Domain-Strategy-Management-Office/) | Cross-domain requirements, testing, and Raise the Bar program | Compare public scope only; this source review did not inspect detailed restricted standards and establishes no compliance |

The cited NIST edition distinguishes encrypted flow control in AC-4(4), one-way mechanisms in (7), metadata validation in (19), physical or logical separation in (21), normalized formats in (24), redundant/independent filtering in (27), and failed-content prevention in (31). ASKA maps these to plaintext-to-output binding, direction guards, whole-representation checks, physical purpose paths, confined conversion, declared independent checks, and quarantine until checks pass. SC-31 motivates explicit channel analysis and bandwidth evaluation. These mappings identify research obligations. They establish neither certification nor novelty.

ASKA requires physical separation in places where the cited catalog allows physical or logical mechanisms. ASKA has not established that its selected composition delivers a stronger useful system. Independent release, information-flow control, and multi-stage cross-domain processing are established techniques.

## Adversarial acceptance cases

Every campaign records initial authority, intended forbidden observation/effect, local commits, independent observer placement, surviving trusted components, residual harm, and useful authorized work. A deliberately weakened configuration must cause the expected failure.

| ID | Adversary and attempted effect | Required observation and weakened control |
|---|---|---|
| X01 | Malicious authenticated member invokes an ungranted method | The receiver performs no effect; removing its method check must produce the forbidden effect |
| X02 | Read-authorized insider bulk-exports to removable storage | The device performs no write without distinct release/effect authority; the observer must detect a gate bypass |
| X03 | Infected import device attacks driver/decoder and issues DMA | The confined attacker cannot reach foreign memory; retaining raw DMA must fail the test |
| X04 | Rogue cable or dual-homed endpoint connects guarded ports | Reachability changes without new rights; a location-based allow rule exposes the broken variant |
| X05 | Attacker taps after the last guard or replaces enforcement hardware | Classify the physical assumption failure and observed exposure; no claim that admission blocks it |
| X06 | Candidate bytes, destination, metadata, or schema change after approval | Independent egress sees only the approved representation or denial; mutable-descriptor binding leaks the substituted form |
| X07 | Release or policy revocation races emission; crash follows consumption | Winning withdrawal blocks future emission and uncertain use stays spent; volatile/reopened accounting enables a duplicate |
| X08 | Import transformer takes over a shared response path | No access to unrelated response plaintext or export grants; shared bidirectional worker exposes the pivot |
| X09 | Semantic release proposer or approver is malicious | Independent ceilings hold; explicitly report disclosures within sole-approver authority rather than claiming binding proves safety |
| X10 | One administrator enables ports, weakens release, or replaces a guard | Other authorities' prerequisites remain; one shared installer reveals the common-cause failure |
| X11 | Attacker encodes a secret in status, timing, packet size, errors, or repeat queries | Enforce and measure the chosen O-profile; an uncontrolled status/omission channel defeats an O2 claim |
| X12 | Authorized viewer prints, captures, photographs, or transcribes | Digital export needs separate rights; permitted perception exposes the declared human limit; a granted collaborator release still completes |

The media, insider-output, and cross-domain cases complement the PHP and Apple campaigns in [15](15_compromise_and_failure_cases.md). The Marine Corps' [2010 removable-media directive](https://www.marines.mil/News/Messages/MARADMINS/Article/888508/protection-of-classified-information-on-department-of-defense-dod-secret-intern/) is a historical example of separating write privileges from network access. It does not establish ASKA efficacy or a complete account of the incidents that motivated it.

## Useful release and remaining research

Measure legitimate sharing completion, denial explanation, time awaiting approvals, authority breadth, recovery work, and attempts to resort to uncontrolled media. The planner can propose a narrower view or an approved transformation. The trusted interface can identify the exact remaining permission. Usability must improve the authorized path; it cannot silently broaden it.

Required research includes a small release-control implementation refined to actual emission, durable cumulative accounting across independent services, transform-relation checking, useful O2 schedules, malicious-approver failure analysis, protected multi-domain displays, and apparatus-level path completeness. Executable models can test approval and output binding before custom silicon exists. A host simulation establishes neither physical guard integrity nor protection from a host administrator. Each experiment retains the distinction between requirement, assumption, model result, physical observation, and unresolved mechanism.
