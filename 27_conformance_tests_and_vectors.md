# ASKA v5 — Conformance requirements, tests, and protocol vectors

## 1. Certification statement

This is an **architecture and research specification**, not a statement that a conforming ASKA system or finished certified hardware already exists. Conformance evidence is attached to a particular artifact, implementation manifest, threat model, proof/test revision and physical placement. A software-only proof of an evaluator does not prove memory isolation, and a dedicated PHY does not prove that a manufacturer's recovery key is harmless.

## 2. Test levels

| Level | Assurance claim | Required artifacts |
|---|---|---|
| S — semantic | contract/object/state-machine soundness under a stated model | schemas, deterministic interpreters, property tests, counterexample traces |
| P — protocol | signed transcript, anti-replay, downgrade and recipient semantics | test corpus, negative vectors, fuzzing, interoperability logs |
| E — execution | grant bounds, object ownership, effect finality | instrumented traces, malicious-cell tests, crash tests |
| H — physical | owned compute/memory, separate active paths and witness | hardware inventory, probes, DMA/port/flood tests, failure-dependency graph |
| I — institutional | governance, identity, lawful-process and notice | signed role/profile scenario corpus, contestation records |
| U — usable | comprehension and correctness of trusted interaction | blinded human evaluation and attack-induced misapproval measurements |

## 3. Core positive and negative test matrix

| ID | Stimulus | Required result |
|---|---|---|
| T01 | signed valid CLAIM, no supporting contract | no executable GRANT |
| T02 | signed warrant outside time/object/jurisdiction | DENY or documented ESCALATE |
| T03 | missing required independent approval | no grant installation |
| T04 | AI changes recipient after displayed approval | digest mismatch, DENY |
| T05 | ATTACK: Wilder parser with arbitrary instructions | no Sanctum/Polis writable access |
| T06 | mutate a submitted source snapshot under DMA | stable bytes or safe abort |
| T07 | route protected traffic to public egress | mandatory egress denial |
| T08 | receiver withdraws current accept policy | deny new publication when withdrawal effective |
| T09 | authenticated, denied record repeated | bounded replay and reprocessing work |
| T10 | stale object/IES generation after reuse | reject old grant and DMA request |
| T11 | lose response after irreversible effect | receipt `uncertain` until reconciliation |
| T12 | offline Steles full | fail closed or explicitly authorized degraded outcome |
| T13 | replace governance profile in flight | reject silent downgrade |
| T14 | revoke sibling delegate; shared budget | no double spending or grant resurrection |
| T15 | malicious community route controller | cannot invent source release permission |
| T16 | user-approved legitimate release | completes useful operation with correct receipts |
| T17 | regulator requests inaccessible end-to-end plaintext | `UNAVAILABLE`, no phantom key |
| T18 | compromise firmware signer for one plane | independent roots unaffected under declared dependency model |
| T19 | leak through print/display/removable media alternate path | path register includes bound effect checks and declared human exclusions |
| T20 | malformed critical-field or duplicate canonical key | reject before expensive policy resolution |
| T21 | hold claimant to revoked professional credential | reject when staleness bound exceeded |
| T22 | delayed notice matures during offline period | unfulfilled/queued notice state, never fabricated human delivery |
| T23 | flooded encounter PHY while reserved civic service runs | measure retained useful throughput under stated shared-resource constraints |
| T24 | lawful user revokes already disclosed plaintext | new effects cease; record impossibility of recall |

## 4. Test corpus and fixture model

A fixture defines `principals`, `claims`, `profiles`, `object_generations`, `route_graph`, `approval_roles`, `clock`, `revocations`, `resources`, `expected_decision`, `effect_trace`, and `expected_receipts`. Store canonical binary test vectors only after selecting an exact serialization revision; **do not mislabel the YAML illustrations in this docset as signed vectors**. A deterministic runner can produce reproducible signed forms with known test keys that are explicitly marked nonproduction.

```yaml
fixture_id: T04_recipient_substitution
initial:
  profile: org.finance.test
  object: {id: invoice:77, generation: 4}
  user_approved: {recipient: bank-alias:A, amount_minor: 1200}
adversary:
  compromise: ai_planner
  mutation: {recipient: bank-alias:Attacker}
expected:
  decision: DENY
  receipt_class: rejected_contract_mismatch
  external_effect_count: 0
```

## 5. Formal invariants to model check

Model the sequence of installed grants, generation changes, revocations, output binding, share/release transitions, receiver acceptance and effect commit. Prove or exhaustively test finite-state properties:

- `Effect -> ValidContract ∧ LiveGrant ∧ BoundObject ∧ RecipientAccepts`;
- `GrantScope ⊆ ContractScope`;
- `ForbiddenFlow -> no publication before authorized release`;
- `OldGeneration -> cannot mutate new allocation`;
- `AuthenticatedDeniedRecord -> bounded replay handling`;
- `UncertainIrreversibleEffect -> no invented success`;
- `OneCompromisedRole -> cannot install a new independent role's root`.

For confidentiality, specify the observer: values-only noninterference is not timing, traffic-analysis or physical-emission noninterference. Conditional liveness needs surviving resources and a fair scheduling assumption. See [33](33_formal_properties_and_model_sketch.md).

## 6. Measurements and performance accounting

Benchmark native vs isolated-vs-shared comparison systems on equivalent workloads. Report useful task completion, false denials, application throughput, admissions/s, CPU cycles/operation, memory fragmentation, object-copy bytes, grant table entries, retained ciphertext slots, startup/shutdown latency, witness growth, key rotation, battery/power draw, offered vs delivered traffic, and failure recovery time. Include a **credible baseline**, not only an intentionally unprotected naive host.

Example cost calculation, explicitly illustrative: a 2 KiB payload copied twice across a 25 Gb/s target link produces 4 KiB local copy traffic per operation before headers and retries. At 100,000 such operations/s, this is about 390.6 MiB/s extra memory write/read-copy volume depending on precise accounting. The required measurement must reveal what was counted; it is not a forecast of ASKA hardware throughput.

## 7. Human-factor tests

A protected UI test suite includes coercive wording, lookalike recipient names, hidden fees, delayed notice consequences, caregiver access expiration, profile downgrade warnings and alternative output devices. Evaluate whether users can reliably distinguish “disclose records,” “allow transport,” “cast ballot,” “pay invoice,” and “permit future delegated access.” It is insufficient to measure only cryptographic digest agreement while users misunderstand the screen.

## 8. Conformance declaration

```text
implementation name, revision and hashes
profile(s) and cryptographic suites
normative requirement IDs: established / assumed / unestablished / violated
trusted roots and external dependencies
physical resource and path graph
observer/threat scope and exclusions
formal models and proof assumptions
reproducible tests and raw measurement inputs
negative tests, failed claims, and mitigation notes
signed responsible review and date
```

No negative result is removed from the evidence register by deleting the test. A model omission is not a product guarantee.
