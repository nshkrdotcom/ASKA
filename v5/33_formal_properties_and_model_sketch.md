# ASKA v5 — Formal properties and model-checking sketch

## 1. State model

An ASKA state can be abstracted as:

`Σ = (Principals, Claims, Profiles, Contracts, Grants, Cells, Objects, EffectOwners, Sessions, Received, Receipts, Witnesses, RevocationEpochs, Resources)`.

Each object is referenced as `(realm, object_id, generation)`, each cell as `(island, cell_id, epoch)`, each grant as `(id, contract_hash, allowed_ops, object_generation, recipients, remaining_uses, expiry, revocation_epoch)`. An attacker may fully control ordinary cell instructions, unprotected network transport, malicious claims from compromised issuers inside their remaining authority, and the writable fields of exposed descriptors. A protected guard/installer's action is modeled separately.

## 2. Example transitions

- `Propose(a)` appends untrusted proposal bytes; does not change `Grants`.
- `SubmitClaim(c)` stores purported evidence subject to verification; does not change `Grants`.
- `Admit(a)` requires valid provenance, applicable profile, local/recipient policy, restrictions, conflict resolution and necessary approvals; creates immutable `Contract`.
- `Install(contract, executor)` checks current object generations and allocates a subset-scope grant with charged budget.
- `StartCell(grant)` allocates fresh private resources; no ambient foreign pointers.
- `Snapshot(src)` holds stable ownership/data constraints until copied, transferred or aborted.
- `Release(snapshot, policy)` checks an exact fixed output or an independently validated transformation and consumes protected release budget.
- `Transmit` checks live session/physical-path authority at egress and authenticates the bound record.
- `Receive` authenticates into quarantine, updates replay state according to policy, then tests independent current receiver acceptance and protected placement.
- `CommitEffect` checks final live grant/objects and appends durable outcome evidence or explicit uncertainty.
- `Witness` commits a privacy-scoped evidence digest under independent key/root.
- `Revoke` changes epoch or qualified status; future final checks must observe it within the declared effective boundary.

## 3. Safety invariants

For all reachable states, require:

```text
S1:  Effect(e) => exists c,g:
       Admitted(c) and Installed(g) and Refines(g,c)
       and Live(g,e) and FinalOwnerAuthorized(e)

S2:  PublicOutput(x) and DependsOnRestricted(x)
     => exists exact independently authorized Release(x)

S3:  CellRead(c,o) => OwnerOrGranted(c,o)

S4:  PublishedAtRecipient(r,o)
     => AuthenticatedDelivery(r,o) and ReceiverAcceptsNow(r,o)

S5:  InstalledGrant(g) => g.scope subset of Contract(g).scope

S6:  StaleGenerationRequest(q) => no write to new occupant

S7:  NewPhysicalPath(p) alone => no new EffectAuthority

S8:  ProposedByAI(a) alone => no InstalledGrant(a)
```

These are high-level logical obligations, not mechanically checked theorems. They become testable when each predicate is refined to concrete hardware, network and storage semantics. A requirement that a source “did not leak any bit” additionally needs a defined observer model including covert timing channels and influences from repeated allowed outputs.

## 4. Transaction refinement

To show contract-to-grant correctness, define an abstraction mapping `α` from the installed hardware tables, object-owner state and NIC transfer records to the abstract authority graph. Prove that any concrete irreversible effect with valid local transition can be matched to an abstract admitted contract transition; that is, `ConcreteTrace ⊑ AllowedAccordTrace` under named trust assumptions. For physical path claims, include requester ID, actual port binding, DMA/queue separation, protected configuration, power/reset and alternative egress checks in the refinement. An overlay's route label cannot stand in for a proof of physical path separation.

## 5. Receiver and replay ordering

Do not permit an unauthenticated packet to consume arbitrary replay state. Authenticated but rejected records may consume their sequence as specified to bound repeated expensive processing. Independent current policy is checked before protected publication. A receiver's anti-replay window, policy version and object generation must remain consistent across crashes and restored snapshots; if uncertain, close the session and establish fresh epochs. Model sequence gaps, local burned nonces, reorder, retransmission and path flaps.

## 6. Liveness and fairness

Safety can hold while everything is denied. Liveness needs explicit assumptions, e.g. bounded authorized offered load, some surviving physical path, fair scheduling of reserved control queues and finite cryptographic work per first-contact attempt. Prove only conditional progress: `Admitted ∧ ResourcesSurvive ∧ FairScheduler ∧ PeerReachable -> Eventually(ResultOrExplicitFailure)`. An adversary allowed to sever all cables can prevent global delivery.

## 7. Conflict semantics is not a total algebra

Proposed rights, duty and prohibition records may be simultaneously valid. A final decision may require a profile-defined court, institutional review, guardian consent or human challenge. Therefore the evaluator is a **partial function with explicit uncertainty**, not a total precedence lattice whose greatest element is “the government.” Formal verification should establish that the evaluator follows its configured rules and cannot silently bypass them; it should not state that those rules are objectively just.

## 8. Counterexample-driven research

Begin with a finite model containing two realms, two planes, a source object, one hostile parser, one claimed recipient, a compromised AI planner, independent guard, revocation and witness. Try to falsify S1–S8 under alternate physical sharing, loss of monotonic state, reused object generations, authorized release mistakes, and two independent approval requirements. Expand only when the simple model eliminates obvious authority creation bugs. Publish failing traces and revised assumptions alongside successes.
