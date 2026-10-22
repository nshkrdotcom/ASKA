# ASKA v4 — Requirements and threat model

[Start](01_architecture_and_reading_map.md) · [Previous](01_architecture_and_reading_map.md) · [Next](03_architectural_candidates_and_decisions.md)

The target computing environment remains useful while its security boundaries survive complete compromise of the code they confine. Containment must remain effective when prevention of a particular memory exploit fails. Preventing the exploit still reduces exposure. The requirements below govern every subsystem and intermediate realization.

## Governing requirements

| ID | Target requirement | A design violates it when… |
|---|---|---|
| R01 | Authority is explicit and every consequential boundary is mediated | A pointer, fallback path, descriptor, helper, or controller creates unchecked authority |
| R02 | Applications use granular components by default | Ordinary development requires a broadly privileged shared runtime |
| R03 | Cross-trust native computation has physically owned resources | Shared logical protection is reported as equivalent physical segregation |
| R04 | Native communication is physically separated by purpose and trust boundary | VLANs, overlays, or shared programmable switching silently replace separate paths |
| R05 | Restrictions survive every data and control transformation | Copying, rendering, compilation, logging, or accelerator use launders a label or provenance claim |
| R06 | Recipients independently authorize effects | A valid sender or channel permits every action a recipient can perform |
| R07 | Ownership and lifetime enforcement prevents stale effects after reuse | Delayed DMA, references, or messages acquire a new occupant's authority |
| R08 | Persistence has explicit owners and crash-defined commits | Volatile acceptance is confused with a durable or physical effect |
| R09 | AI is native to interaction and orchestration but cannot create authority | Model output, retrieved instructions, or inferred intent becomes approval |
| R10 | Policy, allocation, updates, recovery, and observation have separate scopes | One convenient administrator can rewrite all independent boundaries |
| R11 | Independence includes management and common-cause dependencies | Separate keys or chips are counted as independent despite one controlling failure |
| R12 | Resource use and recovery are bounded and useful service is evaluated | Security succeeds only by stopping all work or allowing unbounded verification/retry load |
| R13 | Prevention, containment, valid-authority abuse, propagation, and availability are reported separately | A capability check is used as proof of correct application semantics or universal safety |
| R14 | Changes preserve traceability to the destination | A prototype omission silently becomes a weaker target requirement |
| R15 | The native environment operates without legacy infrastructure assumptions | Linux, POSIX, global sockets, or compatibility services become required authorities |
| R16 | Evidence is attributable and claims match it | A proposal, model assumption, roadmap, or vendor result is presented as an ASKA demonstration |
| R17 | Native execution provides defined spatial and temporal memory semantics | Memory safety is inferred from a tag bit, language name, or whole-cell reset alone |
| R18 | Whole applications are tested with malicious components and alternative paths | Only isolated gates are evaluated while the application bypasses them |
| R19 | Physical, network, device, and administrative membership confer no implicit authority | An authenticated peer or attached device gains operations solely from its location or affiliation |
| R20 | Reading, computing, storing, disclosing, transporting, and receiving are distinct rights | Read access or a working encrypted channel implicitly permits export |
| R21 | Every modeled path for information and effects crosses the required controls | Media, print, display, backup, debug, or management bypasses a network-only policy |
| R22 | Ordinary users, workloads, and administrators cannot unilaterally create a forbidden cross-domain flow | Adding a cable, changing a route, or using one ordinary role creates disclosure authority |
| R23 | Release control independently enforces the exact approved output or verified output contract | Approved content, destination, representation, or use limits can change before emission |
| R24 | Intermediaries cannot inherit both domains' authority through participation | A parser, transformer, or gateway can turn one admitted crossing into an unrestricted bridge |

Requirement identifiers are stable. [18](18_traceability_and_evolution.md) maps each to designs, evidence obligations, and regression tests. An implementation can leave a requirement unestablished; it cannot mark it satisfied merely by excluding the difficult case from its report.

## Adversaries

The application adversary controls all instructions in a cell, supplies arbitrary permitted inputs, invokes its valid grants maliciously, races operations, and exhausts its assigned resources. It may control several cells and all ordinary routing proposals. It can retain old handles, corrupt descriptors, replay records, and trigger exposed resets.

The network adversary can observe, reorder, replay, modify, or drop traffic on links it controls. It may also be a legitimately admitted malicious peer. Confidentiality against a carrier, physical route restriction, and availability under a flood are separate properties.

The management adversary can compromise one named role, such as an application signer, planner operator, admission administrator, or recovery custodian. Tests must show the scope it gains and the other roles it cannot acquire. “Management is trusted” is insufficient as a whole-system claim.

The hardware adversary model has two levels. For an execution island, a malicious or defective compute engine may issue arbitrary transactions on its wired interfaces; external guards must contain their explicit effects. For a failed guard, root, fabric controller, or device boundary, guarantees depending on that component are lost. Stronger domains require additional independently enforced boundaries and an explicit common-cause analysis.

Fabrication subversion, invasive probing, electromagnetic coupling, and power/thermal manipulation require named physical threat profiles. The target requires these dependencies to be investigated; it does not assume they have been solved by physical separation. A package containing separate cores remains one possible common physical failure domain.

## Insiders, bridges, and disclosure

The insider adversary may legitimately read selected objects, operate devices, or administer one subsystem. It tries to export bulk data, carry media between disconnected systems, connect an unauthorized bridge, or exploit an approved output path. The compromised-authority adversary may additionally control a release proposer or a scoped installer. Tests give the adversary those rights at the start. They do not require a memory exploit.

Adding a connection at a guarded interface changes physical reachability without authorizing a new operation. Attaching a probe after the last mandatory guard, replacing that guard, or photographing an authorized screen changes the assumptions instead. Each claim states which physical intervention it covers. Human perception is an authorized disclosure to a person; digital confinement cannot guarantee that the person will not reproduce it.

[12](12_cross_domain_security_and_information_release.md) defines transfer paths, release enforcement, and the distinction between guarded connection and physical bypass. An ordinary administrator is a scoped role under 14; an explicitly declared ultimate local root can defeat its own boundary. It must not thereby control another independent root.

## Trust and failure dependencies

Each claim names its trusted functions: local identity attachment, memory ownership checks, transfer control, policy installation, recipient effect checks, key custody, clocks, and physical transmit control. A function can use hardware or protected software, but its location and update authority must be stated.

An independent realm does not need to trust another realm's administrator to define its receiving rights. It may still depend on that realm's enforcement to protect data legitimately disclosed there. Once information is released to a recipient, revocation cannot make the recipient forget it.

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

Each predicate requires its own evidence. One signature does not establish them all. They must be checked at the point where the effect becomes irreversible, with the concurrency rules specified in the relevant subsystem.

Progress is conditional on admitted load, surviving resources, scheduling fairness, and sufficient communication. A network that may drop forever cannot support unconditional eventual delivery. A security result must report permitted operations completed, false denials, bounded recovery work, and service lost under the specified attack.

## Systemic compromise

A common parser flaw may give an attacker control of the same small component on many machines. The intended result is containment at each component's authority boundary, not a claim that widespread exploitation cannot occur. Shared signing infrastructure, gate logic, or physical facilities can defeat that containment across many domains. Claims of independence use an explicit dependency graph. They cannot rely on multiplying assumed independent-failure probabilities.

**Open questions:** the achievable temporal/physical observation boundary, practical independence between guard implementations, and the workload cost of default physical granularity remain research obligations. These questions do not authorize weakening R03, R04, or R11 in an intermediate build.
