# ASKA v6 — Authority calculus and non-expansion

**Status:** proposed normative target. Requirements describe obligations; they do not certify an implemented machine.

## 1. Authority describes a derivation

An ASKA operation is authorized by a specific derivation from recognized evidence, applicable rules and installed rights. Neither physical possession, a network address, a role title, a cryptographic identity nor an AI recommendation creates all the prerequisites of that derivation. A person may own a device without owning every hosted institution's records; an institution may issue an applicable order without controlling the device's boot keys.

The candidate action is `a = (actor, operation, target, content_selector, recipient, purpose, plane, time_window, budget, output_contract, obligations)`. Evaluation occurs in a bounded context `Γ = (profiles, claims, relationships, revocations, resource_ownership, clock_basis, local_policy, recipient_policy)`. A decision applies to that action and context, not to all actions by the actor.

## 2. Evidence kinds and independent rights

| Evidence or right | Permitted use | Cannot imply |
|---|---|---|
| FACT | Establish an asserted relationship, time or event | Truth beyond the issuer/measurement model |
| ROLE | Qualify office, professional role or employment scope | Unlimited access to another principal's resources |
| DELEGATION | Derive a permitted subset of delegable authority | Nondelegable duties, rights outside parent scope |
| DUTY | Establish a profile-specific required act | Possession of unavailable data or keys |
| PROHIBITION | Exclude a named effect, recipient or disclosure | Universal precedence over all other lawful instruments |
| CONSENT | Authorize a bounded voluntary choice under required process | Consent where the basis is coercion or legal compulsion |
| ORDER | Supply an institutional instruction for review | Automatic legality, decryption or hardware installation |
| CAPACITY | Qualify guardianship, care or fiduciary powers | Unbounded ownership transfer |
| ATTESTATION | Report evidence about a measured system | Application truth or a right to receive data |
| Resource capability | Name permitted local object operations | Release, carriage, recipient publication or semantic correctness |
| Effect grant | Authorize exact bounded consequence at its owner | Rights at another owner without its acceptance |

The distinctions remain even when the same party supplies several records. [Chapters 34–35](34_identity_relationships_delegation_and_revocation.md) define relationships and governance profiles; [Chapter 49](49_legal_process_rights_and_emergencies.md) defines legal process constraints.

## 3. Partial decision procedure

The result is one of `ALLOW`, `ALLOW_WITH_OBLIGATIONS`, `DENY`, `SUSPEND`, `ESCALATE` or `UNAVAILABLE`. `SUSPEND` means a prerequisite or contest is unresolved. `ESCALATE` identifies a recognized independent review path. `UNAVAILABLE` records a technical inability after the relevant authority assessment, without creating bypass rights. Each result binds reason codes, evidence references, profile hashes, time basis and any notice/challenge obligations.

The evaluator performs the following ordered work:

1. Validate bounded canonical encodings, issuer identity and critical fields.
2. Select applicable, pinned profiles without silently importing an unrelated jurisdiction.
3. Establish evidence validity and revocation freshness within the declared staleness budget.
4. Resolve resource ownership, delegated scope and nondelegable exclusions.
5. Evaluate negative restrictions independently of positive rights.
6. Check source information release, receiving permission and physical-path requirements separately.
7. Apply the profile's conflict procedure. If no procedure determines a result, suspend or escalate.
8. Bind stable effect parameters, resource limits, required approvers and obligations.
9. Collect required approvals through protected paths and admit the immutable contract.
10. Compile and locally install grants only if every required restriction is enforceable at its owner.

There is no default rule `State > Employer > Parent > User`. A profile may recognize specific precedence for a particular obligation, but the proof graph records that rule and its applicability. If two profiles cannot agree, connectivity and cryptographic compatibility do not settle the dispute.

## 4. Non-expansion algebra

Represent grant scope as `(objects, operations, recipients, purposes, paths, interval, uses, quantity, generations, exclusions, delegation_depth)`. A grant `g` refines contract `c`, written `g ⊑ c`, only if all positive sets are subsets, the interval is contained, each budget is no greater, generation bindings match, exclusions are at least as restrictive, and delegation depth does not increase.

For independent authorities that are all required, admitted positive rights use intersection, restrictions use union, time uses interval intersection and budgets use the tightest applicable ceiling. Empty intersection is a denial or unresolved negotiation; it is not a reason to select the more permissive source. Budgets from independent grants cannot be summed unless an admitted aggregation contract explicitly allows it. Combining two narrow methods can reveal more than either method individually, so the owner also enforces cumulative disclosure and effect ceilings.

An explicit delegation chain binds parent grant, delegator, delegatee, child scope, context, expiry, maximum depth and revocation dependencies. The installer checks every parent at installation and the relevant live epoch at finality. A duplicated grant is still the same protected use budget, not a second account of rights. Forwarding a signed blob without the corresponding installation cannot create a local owner entry.

## 5. Authority-changing operations are effects

Policy installation, root replacement, enrollment, capability creation, release approval, test-oracle modification and recovery are all consequential operations. Each needs an owner outside the untrusted proposer. Otherwise a planner could write the predicate that later approves its own request.

Dynamic trust assessment may recommend more restrictive admission or route selection. An improved risk score does not expand a grant. A degraded score can trigger only an admitted denial or protective template, with safeguards against discriminatory or endless denial. General confidence and legal authority remain different types.

[Flow-Limited Authorization](https://www.cs.cornell.edu/andru/papers/flam/flam-csf15.pdf), especially Sections II, IV and V, addresses interaction between delegation and information flow. It motivates treating trust-configuration updates and authorization queries as information-bearing operations. ASKA's physical installation calculus is a separate design obligation; the cited logic does not prove ASKA's implementations.

## 6. Revocation, partition and concurrency

A revocation record names scope, issuer authority, effective boundary and a protected epoch or counter. Local owners define an order between revocation application and finality. A remote revocation can have propagation delay; the grant must bound allowed stale operation. A contract requiring immediate remote revocation cannot remain available through an arbitrary network partition.

A contract may authorize offline local protection with a short lease, a cumulative use limit and no new recipient. It may not convert inability to contact a policy service into broader rights. On loss of trusted time or monotonic state, the affected grant is suspended, expired conservatively or retired according to its contract. Clock reset cannot restart a spent budget.

Revocation does not erase information already disclosed, undo a physical act or invalidate the truth of an earlier receipt. A correction or compensation requires a new operation and its own authority.

## 7. Source and receiving authority

A source must authorize reading and, separately, the relevant release. A destination must independently authorize receiving, storage, publication or execution. These checks can be compiled into standing grants but cannot be merged into a sender credential. A source's contract with an intermediary does not appoint that intermediary as the receiver's administrator.

For instance, a guardian may have an admitted right to obtain a dependent's appointment schedule. The clinic's release policy, the scope of guardianship, the dependent's protected confidentiality interests and the receiving account all remain relevant. A credential naming a family relationship is evidence for those checks, not a master read capability.

## 8. Conflict and proof privacy

The authority proof is a directed acyclic graph of claims, applicability checks, approvals and installations. It must retain enough evidence for challenge while limiting disclosure. The existence of a confidential relationship, investigation or refusal can itself be sensitive. Public denial responses should expose a bounded reason class; authorized review may receive a fuller explanation under a separate release.

An authenticated adversary can submit many valid-looking claims to probe protected relationships. Query rate, response shape and timing therefore belong to the information-flow policy. If an evaluator cannot decide within its bounded proof-search budget, it returns an explicit unresolved result. It must not accept because verification was expensive or silently turn resource exhaustion into a permanent denial for unrelated principals.

## Normative requirements and acceptance obligations

**R-06-01 — Explicit authority derivation.** An admitted action MUST bind a finite proof graph from recognized evidence and applicable profiles to exact effect scope.

**Acceptance T-06-01:** Submit a valid role credential without resource/release authority; installation must fail with a bounded reason.

**R-06-02 — Grant attenuation.** Every installed or delegated grant MUST refine all required parent scopes and budgets without expansion.

**Acceptance T-06-02:** Mutate each scope field, split a use budget and combine grants without aggregation authority; deny expansions.

**R-06-03 — Typed authority bases.** Consent, compulsion, duty, delegation, guardianship and key custody MUST remain separately typed.

**Acceptance T-06-03:** Present a court order as consent or a family credential as ownership; require rejection or correct separate processing.

**R-06-04 — Conflict without universal rank.** Unresolved conflicting instruments MUST produce SUSPEND or ESCALATE with a recognized review path.

**Acceptance T-06-04:** Supply equally applicable contradictory instruments and confirm that issuer prestige does not select a winner.

**R-06-05 — Protected authority mutation.** Authority-changing operations MUST require independent admission and effect ownership.

**Acceptance T-06-05:** Give a builder or observer arbitrary proposal bytes; it cannot install its own signer, oracle or policy.

**R-06-06 — Revocation ordering.** Owners MUST state revocation linearization, freshness and offline limits and enforce them at finality.

**Acceptance T-06-06:** Race finality with revocation, then reset time; effects obey recorded order and spent rights do not revive.

**R-06-07 — Private bounded decisions.** Authorization queries MUST obey confidentiality, bounded proof search and query-resource policy.

**Acceptance T-06-07:** Probe a confidential relationship through repeated queries; verify release/rate bounds and explicit unresolved outcomes.

