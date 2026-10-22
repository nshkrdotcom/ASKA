# ASKA v4 — Native applications and development

[Start](01_architecture_and_reading_map.md) · [Previous](08_authority_and_information_flow.md) · [Next](10_ai_environment_and_trusted_interaction.md)

**Requirements:** R01, R02, R05, R06, R07, R08, R15, R17, R18, R20, R21, R24.

A native application is a graph of components, protected objects, and authorized effects. Admission supplies only the objects and effects the graph is authorized to use, rather than a general-purpose environment with privileges removed afterward. The development tools make small request workers and narrow service interfaces the normal path.

## Component contract

Every deployable component specifies input/output schemas, confinement, effect requirements, isolation class, resource bounds, lifecycle, and failure behavior. The following is an illustrative contract, not a registered schema:

```yaml
component: image.decode
revision: 1
execution:
  lifetime: request
  isolation: P1
  memory: private-regions
inputs:
  image: immutable-untrusted-bytes
outputs:
  pixels: bounded-pixel-buffer
effects:
  persistent-write: none
  network-send: none
  device-command: none
  delegate-authority: none
limits:
  input-bytes: supplied-by-admission
  pixel-count: supplied-by-admission
  memory-bytes: supplied-by-admission
  execution-fuel: supplied-by-admission
failure:
  partial-publication: forbidden
  action: abort-and-retire
```

Admission must replace every supplied limit with a concrete finite value. A descriptor with unresolved limits cannot run. The component cannot increase those values or obtain additional effect handles by changing its own manifest.

## Native interfaces

| Interface | Behavior |
|---|---|
| `read(input, version, range)` | Access an admitted immutable view with bounded local references |
| `region.allocate(size)` | Allocate private scratch within the installed allowance |
| `output.create(schema, size)` | Create unpublished confined output |
| `output.seal(handle)` | End mutation and obtain a stable object version |
| `effect.prepare(handle, parameters, inputs)` | Build a typed request under installed operation authority |
| `effect.submit(prepared_request)` | Request recipient validation/commit; return a receipt or bounded pending result |
| `task.spawn(contract, inputs, attenuated_handles)` | Request a child under parent budgets and the required physical profile |
| `task.finish(outputs)` | Offer sealed outputs and begin local retirement |

These SDK interfaces specify semantics. Implementations can use instructions, queues, or local calls. Separate protected services provide scheduling, allocation, and lifecycle control without requiring a monolithic kernel.

## Composition and authority checking

Before deployment, the graph checker verifies schema compatibility, permitted category flows, effect scope, budget reservations, lifecycle/loan dependencies, and required physical placements. It rejects unbounded recursion of task creation, illegal authority cycles, or a path from an untrusted parser to a privileged effect without a recipient check.

An operation handle is supplied by task admission, not resolved from a global service directory inside the worker. Discovery results are data until a protected authority approves an endpoint. Application modules cannot receive a new capability merely because a schema includes a field called `service`.

The application package separates code from deployment authority. Code declares what it needs; a user or administrator decides what a particular installation receives. Updating a binary under the same name does not inherit every grant of the old binary automatically. Contract changes follow [14](14_governance_updates_and_recovery.md).

Static checks establish structural properties. They do not establish that arbitrary component output is true. Runtime guards remain effective against admitted malicious machine code. Proof-carrying components may receive fewer runtime checks only if the proof, verifier, machine model, and substitution argument are part of the accepted assurance profile.

## End-to-end example: private document review

The user asks the AI environment to review a document received from an admitted external sender. The application graph contains an import owner, a format classifier, disposable decoders, a pixel/text validator, a document state owner, an isolated analysis agent, and separately constrained display and export services.

The classifier selects only from already installed decoder contracts. Claimed file type is untrusted. Every fallback decoder runs under the same or stronger confinement and physical profile; unsupported formats are rejected or offered as uninterpreted data. No convenience helper parses the file in a privileged UI or storage service.

Decoders return bounded typed representations. Validators check dimensions, integer ranges, lengths, nesting, references, and the absence of executable callbacks or capability imports. A validator's assertion covers only the property it checks. Rendering and complex composition run in fresh cells with private scratch and bounded output surfaces. A separate display enforcer checks the surface contract before presentation and excludes the trusted approval region, as specified in [10](10_ai_environment_and_trusted_interaction.md).

The analysis agent receives only user-authorized document/context views. Its result carries their confidentiality restrictions. Saving a review invokes a version-checked method on the document owner. Exporting it requires a distinct destination-bound operation grant and any needed release. A malicious decoder or agent cannot obtain export authority through a well-formed result.

## Cross-domain application contracts

Application manifests enumerate import and export separately. Each edge names the source object/view, transformation, output schema and categories, destination effect, release contract if needed, device owner, observation profile, and quota parent. A request/response pair is two directed edges. An import parser cannot gain an export handle merely because it generates the response.

The review workflow must support an authorized collaborator export through [12](12_cross_domain_security_and_information_release.md): isolate preparation, seal the result, obtain the required independent approval, and emit that exact result. Also test an insider with legitimate read access who requests raw media export, clipboard copy, printing, or a hidden response channel. Denial should identify a concrete missing right and an available authorized workflow. Recommending an unrestricted bridge is not an acceptable repair.

## Persistent and interactive applications

The graph supports long-running protected services and ephemeral workers. A collaboration session can persist while each edit, import, or query executes in a fresh cell. State owners preserve versions and operation receipts. A worker crash does not erase committed application state.

Local scoped namespaces, caches, and library abstractions are permitted when they preserve the contract. They have explicit owners and invalidation rules. Abstractions resembling files and calls are permitted when they carry no undeclared authority.

Large numerical jobs can own a multi-engine island or compose streamed task graphs. Splitting every arithmetic operation into a separate physical cell is unnecessary. Granularity follows the consequences of compromise and the explicit authority boundaries. Its costs require measurement.

## Development environment

The AI-assisted environment provides contract templates, effect previews, graph visualization, local tests, proof/checker integration, and adversarial replay. It should explain a denied edge in terms of the missing object, effect, category, lifetime, or physical requirement. It must not suggest an all-access grant as the routine repair.

Developers can inspect the effective graph before deployment and compare authority changes during an update. Debuggers operate on a paused owned domain with separately authorized access. Production debug cannot become a global memory reader.

[capDL](https://docs.sel4.systems/projects/capdl/lang-spec.html) is a comparison for explicit authority descriptions. [CakeML](https://cakeml.org/index.html) is a comparison for verified compilation, and [Calyx](https://calyxir.org/) for compiling accelerator designs. Each addresses part of the toolchain problem. None alone establishes ASKA application correctness or physical placement.

**Hypothesis H04:** a compositional contract system can make the least-authority application easier to construct than a privileged broker. Evaluate developer effort, grant breadth, trusted application code, denied useful work, debugging access, lifecycle cost, and whether the compromised-parser test survives ordinary feature development.
