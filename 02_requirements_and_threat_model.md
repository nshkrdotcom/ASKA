# ASKA v5 — Requirements, threat model, and safety properties

## 1. Society-to-machine obligations

The requirements in this document bind **all** physical, local-compute, network, institution-facing and AI-related components. They apply to the native target even where an early laboratory realization tests only a subset. The system recognizes neither a universal social trust rank nor a universal administrator.

| ID | Additional ASKA v5 obligation | Mandatory negative test |
|---|---|---|
| A01 | Claim evidence never directly becomes executable authority | Signed institutional claim alone cannot access protected data |
| A02 | Contracts name governing profiles, purpose, recipient, exclusions, evidence and obligations | Cross-profile ambiguity does not silently admit a request |
| A03 | Grants are compiler-derived, local, bounded and non-expanding | A stolen or duplicated grant cannot broaden object/method/epoch |
| A04 | Receipts distinguish attempted, committed, externally accepted and unknown effects | A lost acknowledgment never reports fabricated success |
| A05 | Societal planes remain independent purposes | A Wilder-controlled route cannot create a Polis or Sanctum effect |
| A06 | Keystone approval binds canonical terms, not model prose | Prompt injection cannot substitute recipient or amount after approval |
| A07 | Civic and legal authority is scope and profile dependent | A signed but overbroad warrant cannot perform bulk export |
| A08 | Unavailable plaintext remains technically unavailable | An order cannot manufacture decryption keys or unaudited access |
| A09 | Notice/appeal/suspension are represented where required | Delayed notice is neither silently lost nor falsely guaranteed offline |
| A10 | Steles witnesses with strict privacy limits | Witness operator cannot read arbitrary raw user payloads |
| A11 | No silent profile/assurance downgrade | Shared carrier does not masquerade as disjoint physical fabric |
| A12 | Personal/family/institutional delegation is context bound | Job title or kinship alone cannot mint account-owner privileges |
| A13 | Recipient acceptance and source disclosure are independent | Valid sender/session cannot force receiver publication |
| A14 | Protected resources preserve public-service continuity under bounded threats | Wilder flood cannot exhaust declared reserved Polis capacity |
| A15 | Community and upstream routing confer no social authority | Rogue neighborhood node cannot rewrite contract/recipient identity |
| A16 | System changes are versioned, reviewable and recoverably scoped | Compromised update role cannot mutate all roots across planes |

A01–A16 extend the native machine requirements R01–R24 below.

## 2. Security decision rule

For each consequential effect `e`, admission and execution must distinguish:

```text
MayEffect(e) = LiveObjectAndCellGenerations(e)
           AND ProvenSourceOperationGrant(e)
           AND PermittedDataFlowOrAuthorizedRelease(e)
           AND IndependentRecipientPermission(e)
           AND StableRepresentationAndDestination(e)
           AND AvailableChargedBudget(e)
           AND AdmittedPhysicalOrLogicalPath(e)
           AND RequiredApprovalsAndProfileObligations(e)
```

The evaluator must not treat `MayEffect` as a proof of correctness of a person's motives, a court's lawfulness, or a program's output. An attested service can intentionally lie; an authorized person can legitimately obtain data and later misuse it. Guarantee statements must specify their observation model: values, identities, timing, traffic existence, resource use, screen contents, physical outputs, and side channels are different classes.

## 3. Threat model and baseline machine requirements

ASKA must complete useful work while its guards contain fully compromised workloads. An attacker who controls a cell's instructions must still face the memory, message, and effect boundaries outside that cell. Preventing a memory exploit reduces exposure; containment must hold when prevention fails. The requirements below govern every subsystem and intermediate realization.

## Governing requirements

| ID | Target requirement | A design violates it when… |
|---|---|---|
| R01 | Grants name authority; guards mediate every consequential boundary | A pointer, fallback path, descriptor, helper, or controller creates unchecked authority |
| R02 | Applications use granular components by default | Ordinary development requires a broadly privileged shared runtime |
| R03 | Cross-trust native computation has physically owned resources | The implementation claims shared logical protection provides physical segregation |
| R04 | Native paths physically separate purposes and trust boundaries | VLANs, overlays, or shared programmable switching silently replace separate paths |
| R05 | Restrictions survive every data and control transformation | Copying, rendering, compilation, logging, or accelerator use launders a label or provenance claim |
| R06 | Recipients independently authorize effects | A valid sender or channel permits every action a recipient can perform |
| R07 | Ownership and lifetime enforcement prevents stale effects after reuse | Delayed DMA, references, or messages acquire a new occupant's authority |
| R08 | Persistence has explicit owners and crash-defined commits | The service reports volatile acceptance as a durable or physical effect |
| R09 | AI is native to interaction and orchestration but cannot create authority | Model output, retrieved instructions, or inferred intent becomes approval |
| R10 | Policy, allocation, updates, recovery, and observation have separate scopes | One convenient administrator can rewrite all independent boundaries |
| R11 | Independence includes management and common-cause dependencies | One failure controls keys or chips that the design counts as independent |
| R12 | Controllers bound resource use and recovery; evaluations measure useful service | Security succeeds only by stopping all work or allowing unbounded verification/retry load |
| R13 | Reports distinguish prevention, containment, valid-authority abuse, propagation, and availability | The argument treats a capability check as proof of correct application semantics or universal safety |
| R14 | Changes preserve traceability to the destination | A prototype omission silently becomes a weaker target requirement |
| R15 | The native environment operates without legacy infrastructure assumptions | Linux, POSIX, global sockets, or compatibility services become required authorities |
| R16 | Claims identify attributable evidence and stay within its scope | The report presents a proposal, model assumption, roadmap, or vendor result as an ASKA demonstration |
| R17 | Native execution provides defined spatial and temporal memory semantics | The argument infers memory safety from a tag bit, language name, or whole-cell reset alone |
| R18 | Tests exercise whole applications with malicious components and alternative paths | Tests check isolated gates while the application bypasses them |
| R19 | Physical, network, device, and administrative membership confer no implicit authority | An authenticated peer or attached device gains operations solely from its location or affiliation |
| R20 | Reading, computing, storing, disclosing, transporting, and receiving are distinct rights | Read access or a working encrypted channel implicitly permits export |
| R21 | Every modeled path for information and effects crosses the required controls | Media, print, display, backup, debug, or management bypasses a network-only policy |
| R22 | Ordinary users, workloads, and administrators cannot unilaterally create a forbidden cross-domain flow | Adding a cable, changing a route, or using one ordinary role creates disclosure authority |
| R23 | Release control independently enforces the exact approved output or verified output contract | Approved content, destination, representation, or use limits can change before emission |
| R24 | Intermediaries cannot inherit both domains' authority through participation | A parser, transformer, or gateway can turn one admitted crossing into an unrestricted bridge |

Requirement identifiers remain stable. [29](29_traceability_and_conformance.md) maps each to designs, evidence obligations, and regression tests. An implementation report may mark a requirement unestablished. Excluding the difficult case cannot turn that entry into satisfied.

## Adversaries

The application adversary controls all instructions in a cell, supplies arbitrary permitted inputs, invokes its valid grants maliciously, races operations, and exhausts its assigned resources. It may control several cells and all ordinary routing proposals. It can retain old handles, corrupt descriptors, replay records, and trigger exposed resets.

The network adversary can observe, reorder, replay, modify, or drop traffic on links it controls. It may also be a legitimately admitted malicious peer. Confidentiality against a carrier, physical route restriction, and availability under a flood are separate properties.

The management adversary can compromise one named role, such as an application signer, planner operator, admission administrator, or recovery custodian. Tests must show the scope it gains and the other roles it cannot acquire. “Management is trusted” is insufficient as a whole-system claim.

The hardware model distinguishes two failures. First, a malicious or defective compute engine may issue arbitrary bus, DMA, or endpoint transactions on its wired interfaces. External guards must contain those transactions' explicit effects. Second, a guard, root, fabric controller, or device boundary may itself fail. That failure defeats every guarantee that depends on it. Stronger domains need additional independent guards and an explicit analysis of failures that can disable several guards at once.

Fabrication subversion, invasive probing, electromagnetic coupling, and power/thermal manipulation require named physical threat profiles. Substrate studies must investigate those dependencies. Physical separation alone does not resolve them. A package containing separate cores remains one possible common physical failure domain.

## Insiders, bridges, and disclosure

The insider adversary may legitimately read selected objects, operate devices, or administer one subsystem. It tries to export bulk data, carry media between disconnected systems, connect an unauthorized bridge, or exploit an approved output path. The compromised-authority adversary may additionally control a release proposer or a scoped installer. Tests give the adversary those rights at the start. They do not require a memory exploit.

Adding a connection at a guarded interface changes physical reachability without authorizing a new operation. Attaching a probe after the last mandatory guard, replacing that guard, or photographing an authorized screen changes the assumptions instead. Each claim states which physical intervention it covers. Human perception is an authorized disclosure to a person; digital confinement cannot guarantee that the person will not reproduce it.

[19](19_cross_domain_security_and_release.md) defines transfer paths, release enforcement, and the distinction between guarded connection and physical bypass. An ordinary administrator is a scoped role under 14; an explicitly declared ultimate local root can defeat its own boundary. It must not thereby control another independent root.

## Trust and failure dependencies

Each claim names its trusted functions: local identity attachment, memory ownership checks, transfer control, policy installation, recipient effect checks, key custody, clocks, and physical transmit control. A function may run in hardware or protected software. The claim must name where it runs and who can update it.

An independent realm does not need to trust another realm's administrator to define its receiving rights. It may still depend on that realm's enforcement to protect data legitimately disclosed there. Once a source releases information, revocation cannot make the recipient forget it.

A grant permits an operation without establishing the holder's intent. A legitimate analysis service can return false answers. A compromised allowed recipient can misuse data within the scope already granted. Avoiding that outcome requires a narrower operation contract, an accepted release computation, independent approvals, or keeping the information out of that domain.

## Observations and information flow

Every security profile lists observations it covers: memory contents, published values, operation effects, record presence, sizes, error categories, timing, termination, resource contention, and physical emissions. Initial models may cover only explicit data and effects. A target deployment needing timing confidentiality must add schedules, isolation, and evidence for its declared observations.

Public errors and audit streams are outputs. So are generated programs, UI surfaces, AI summaries, and the selection of which network path to use. An output schema alone does not bound the cumulative information revealed by repetition or timing.

## Safety and useful progress

The core safety obligation for an effect `e` is:

```text
publish_or_execute(e) implies
  live_source_and_target_generations(e)
  and valid_scoped_source_authority(e)
  and permitted_information_flow_or_release(e)
  and current_independent_recipient_permission(e)
  and stable_bound_inputs(e)
  and available_charged_resources(e)
  and required_physical_path_permission(e)
```

Each predicate requires its own evidence. One signature does not establish them all. The enforcing components must check those predicates where the effect becomes irreversible, in the concurrency order that the relevant subsystem defines.

Useful progress requires admitted load, surviving resources, scheduling fairness, and enough communication to complete the protocol. A network that may drop forever cannot support unconditional eventual delivery. A security result must report permitted operations completed, false denials, bounded recovery work, and service lost under the specified attack.

## Systemic compromise

A common parser flaw may give an attacker control of the same small component on many machines. Each component's guards must contain that takeover within its authority. The architecture does not claim to prevent widespread exploitation. Shared signing infrastructure, gate logic, or physical facilities can defeat that containment across many domains. Claims of independence use an explicit dependency graph. They cannot rely on multiplying assumed independent-failure probabilities.

**Open questions:** the achievable temporal/physical observation boundary, practical independence between guard implementations, and the workload cost of default physical granularity remain research obligations. These questions do not authorize weakening R03, R04, or R11 in an intermediate build.
