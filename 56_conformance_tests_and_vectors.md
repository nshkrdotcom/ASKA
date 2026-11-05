# ASKA v6 — Conformance tests and vectors

**Status:** proposed normative target. Requirements describe obligations; they do not certify an implemented machine.

## 1. Evidence classes and acceptance rule

This chapter specifies the conformance campaign and supplies a small reproducible semantic demonstration. Tests for actual hardware, firmware, operating software, observers, diodes, cryptographic protocols and civil workflows are **specified but unexecuted** unless a result explicitly says otherwise. The successful finite checks below are evidence about their code and abstraction only. No physical ASKA apparatus, complete protocol implementation or end-to-end proof is certified by this publication.

Every requirement has an owning chapter, a named enforcer, assumptions and a concrete acceptance oracle in [Chapter 61](61_requirement_decision_evidence_traceability.md). Its matching `T-NN-XX` identifier denotes the obligation, not a claim of a test implementation or pass. A campaign record includes requirement, build identity, fixture, attacker powers, initial protected state, ordered stimuli, expected state/effects, observations, positive control, actual result and residual limitations. A missing observation is not automatically a successful denial.

The test oracle must observe the relevant consequence independently of the component under attack. For egress, observe the actual output boundary; for persistence, cut power and recover through the declared durability mechanism; for a watcher, use independent input/output counters; for a physical actuator, measure the device-specific consequence. A guest log saying “blocked” cannot establish that DMA or an external effect was blocked.

## 2. Campaign inventory

| Owning requirements | Required campaign focus | Decisive failure observation |
|---|---|---|
| Chapters 01–08 | Reachability, authority algebra, source/receiver independence, labels and exact finality | Any effect admitted by credential alone, changed binding or unmodeled authority union |
| Chapters 09–14 | Cell lifetime, ISA boundary, shared packaging, cache/DMA reuse, interconnect | Old owner access after reassignment, ambient foreign memory, unguarded device route |
| Chapters 15–19 | Handoff, durable state, reconciliation, temporal/physical leakage, research assumptions | Duplicate publication, false durability, hidden leakage claim or unsupported physical inference |
| Chapters 20–24 | LSM/MSM compromise, watchers, simplex links, telemetry provenance and completeness | Reverse or alternate control path, forged complete coverage, watcher-induced authority expansion |
| Chapters 25–30 | Detector calibration, standing response, signed bad updates, AESDS/IAMA, privacy and recovery | Alarm storm exceeds grant, producer self-installs, baseline telemetry lacks source authority |
| Chapters 31–39 | Accord objects, PACT, relationships, governance, trusted UI, AI and applications | Agreement acts before admission, forged intent, cross-role or tool-driven privilege expansion |
| Chapters 40–46 | Purpose separation, network roles, physical carriage, gateways, sessions and output | Affiliation becomes permission, invalid record poisons replay, non-network release bypasses source policy |
| Chapters 47–53 | Witness, physical evidence, legal/civic/family/enterprise/community processes | Receipt invents truth, compulsion relabeled consent, eligibility or kinship grants unrelated power |
| Chapters 54–62 | Complete traces, models, realizations, cost, profiles, research and traceability | Missing failure consequence, unsupported implementation claim or unverifiable evidence mapping |

For every negative case, use a positive control that differs only in the decisive authorized condition when practical. An all-deny system fails useful-work obligations even if no forbidden output appears. Random fuzzing supplements exact fixtures; it does not replace generation-reuse, crash, malformed critical-field, signed-defect or false-alarm cases.

## 3. Concrete adversarial fixture families

**Lifetime fixture.** Allocate object generation g to cell A, prepare a descriptor and fill cache/device queues. Retire A, revoke its grants, drain and sanitize, reassign the same physical storage under generation g+1, then deliver every delayed old transaction. Expected: none reaches the new object; new-owner operations succeed. Repeat with reset, queue rollover and device-originated retries. An unbounded wait for a malicious device must have a declared isolation or retirement response.

**Release fixture.** Approve bytes B for recipient D and transform X. Change B, D, object generation, label, approval epoch or output device between preparation and finality. Expected: no substituted effect. For a protected snapshot, also introduce a newly arrived secret into the live object after approval: the frozen old representation may remain eligible, but the new secret must not be disclosed under its approval. Merely changing irrelevant bytes does not test this distinction.

**Replay fixture.** In a fresh admitted session, submit valid records 1 and 2, duplicate 1, an authenticated but policy-invalid sequence 100, and an unauthenticated sequence 200. Expected: 1 and 2 publish once; accepted replay state advances only with authorized publication, budget and label transition. The invalid high sequence may enter a separately bounded negative cache but must not shift the accepted window. The executable model below covers all 120 orders of this five-record set, not every protocol schedule.

**Signed-defect fixture.** Use a valid producer signature on packages that crash a worker, widen an observer subscription, add a response method, alter a watcher root or roll back an epoch. Expected: class-specific local admission denies out-of-scope changes; canary and recovery behavior is observable; unchanged authorized packages still install. Repeat for firmware, bitstream, model and parser packages. A signature check alone cannot satisfy the oracle.

**Coverage and response fixture.** Drop a middle event range, reset a source, saturate reports, forge self-reported healthy state and repeatedly trigger false alerts. Expected: gaps and uncertain coverage remain explicit, standing responses remain within cumulative scope, and useful permitted work survives according to the availability profile. Do not relabel an unobserved attack as absent. Include an actuator for which immediate shutdown is hazardous and verify its independently governed safe-state transition.

**Civil and AI fixture.** Present a genuine but irrelevant credential, disputed legal order, expired caregiver delegation and malicious tool description. Expected: each is evaluated under its exact basis and receiver policy; no model or credential creates a decryption key or local resource grant. A valid, appropriately scoped case must complete with protected intent and a receipt naming the actual finality point.

## 4. Executed finite semantic demonstration

The following Python 3.10-or-later standard-library program is the exact demonstrated fixture. Save the code block verbatim as `semantic_models.py` and run `python3 semantic_models.py`. It prints JSON and exits unsuccessfully if its assertions fail. Its SHA-256 as UTF-8 with the final newline is `475fd6f12d4c383e1236dda6f1947648dc9ec70225cb19bf4561fbf475e5a9a6`.

The model has one object generation eligible for one grant, one approved destination and one-use consumption. `prepare` snapshots a fixed payload; `commit` rechecks lifetime, revocation, destination binding and budget. Crash recovery assumes durable consumption and clears unresolved preparation. A local freeze is modeled only as a bounded response counter, not as a full physical egress state machine. Stronger safety, fairness, packet cryptography and real persistence are outside this abstraction.

```python
"""Finite contract demonstrations. Not RTL, protocol, or hardware verification."""
from dataclasses import dataclass, replace
from collections import deque
from itertools import permutations
import hashlib, hmac, json

@dataclass(frozen=True)
class State:
    generation: int = 1
    live: bool = True
    grant_live: bool = True
    proposed_dest: str = 'approved'
    snapshot: tuple | None = None
    uses: int = 1
    commits: int = 0
    freezes: int = 0
    policy_expanded: bool = False
    violation: str = ''

EVENTS = ('propose_good','propose_bad','prepare','mutate','revoke',
          'retire','reuse','commit','false_alert','global_alert',
          'signed_bad_update','crash_recover')

def step(s, event, mutant='none'):
    if event == 'propose_good': return replace(s, proposed_dest='approved')
    if event in ('propose_bad','mutate'): return replace(s, proposed_dest='public')
    if event == 'prepare':
        if s.live and s.grant_live and s.uses and s.generation == 1:
            if s.proposed_dest == 'approved' or s.policy_expanded:
                return replace(s, snapshot=(s.generation,s.proposed_dest,'fixed-bytes'))
    elif event == 'revoke': return replace(s, grant_live=False)
    elif event == 'retire': return replace(s, live=False)
    elif event == 'reuse' and not s.live:
        return replace(s, generation=2, live=True)
    elif event == 'signed_bad_update' and mutant == 'update_scope':
        return replace(s, policy_expanded=True)
    elif event == 'global_alert' and mutant == 'response_scope':
        return replace(s, violation='global protective effect without a grant')
    elif event == 'false_alert' and s.freezes == 0:
        # One standing local freeze use; does not change data/effect grants.
        return replace(s, freezes=1)
    elif event == 'crash_recover':
        # Assumption: committed consumption is durable, unresolved prep is cleared.
        return replace(s, snapshot=None)
    elif event == 'commit' and s.snapshot:
        gen,dest,payload=s.snapshot
        actual_dest = s.proposed_dest if mutant == 'binding' else dest
        generation_ok = (gen == s.generation == 1) or mutant == 'generation'
        grant_ok = s.grant_live or mutant == 'revocation'
        budget_ok = s.uses > 0 or mutant == 'consumption'
        if s.live and generation_ok and grant_ok and budget_ok:
            why=[]
            if actual_dest != 'approved': why.append('wrong destination')
            if gen != s.generation or gen != 1: why.append('stale generation')
            if not s.grant_live: why.append('revoked authority')
            if s.commits >= 1: why.append('duplicate one-use effect')
            return replace(s, uses=0, commits=s.commits+1,
                           violation=', '.join(why))
    return s

def explore(mutant='none'):
    start=State();todo=deque([(start,())]);seen={start};edges=0
    while todo:
        s,trace=todo.popleft()
        for event in EVENTS:
            nxt=step(s,event,mutant);edges+=1
            if nxt.violation:
                return {'states':len(seen),'transitions':edges,
                        'counterexample':list(trace+(event,)),
                        'violation':nxt.violation}
            if nxt not in seen:
                seen.add(nxt);todo.append((nxt,trace+(event,)))
    return {'states':len(seen),'transitions':edges,'counterexample':None,
            'positive_commit_states':sum(s.commits==1 for s in seen),
            'bounded_freeze_states':sum(s.freezes==1 for s in seen)}

def replay_trial(order, mutant=False):
    accepted=set(); high=-1; published=[];negative=set()
    records={'good1':(1,True,True),'duplicate1':(1,True,True),
             'good2':(2,True,True),'bad_high':(100,True,False),
             'bad_mac':(200,False,True)}
    for name in order:
        seq,auth,policy=records[name]
        if not auth: continue
        if mutant: high=max(high,seq)
        if not policy:
            negative.add(seq);continue
        if seq in accepted or seq <= high-4: continue
        accepted.add(seq);high=max(high,seq);published.append(seq)
    return published

def reject_duplicate_pairs(pairs):
    result={}
    for key,value in pairs:
        if key in result: raise ValueError('duplicate key')
        result[key]=value
    return result

def run():
    good=explore();assert good['counterexample'] is None
    assert good['positive_commit_states'] > 0
    mutants={m:explore(m) for m in ('binding','generation','revocation',
        'consumption','update_scope','response_scope')}
    assert all(r['counterexample'] for r in mutants.values())
    orders=list(permutations(('good1','duplicate1','good2','bad_high','bad_mac')))
    assert all(sorted(replay_trial(o)) == [1,2] for o in orders)
    replay_bad=next(o for o in orders if sorted(replay_trial(o,True)) != [1,2])
    vecs=[(bytes.fromhex('0b'*20),b'Hi There',
      'b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7'),
      (b'Jefe',b'what do ya want for nothing?',
      '5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843')]
    for key,msg,want in vecs:
        assert hmac.new(key,msg,hashlib.sha256).hexdigest()==want
        assert hmac.new(key,msg+b'!',hashlib.sha256).hexdigest()!=want
    try: json.loads('{"operation":"read","operation":"send"}',object_pairs_hook=reject_duplicate_pairs)
    except ValueError: duplicate_rejected=True
    else: raise AssertionError('duplicate key accepted')
    return {'effect_model':good,'mutants':mutants,
            'replay_orders':len(orders),'replay_mutant_counterexample':list(replay_bad),
            'hmac_vectors_passed':len(vecs),'hmac_tamper_checks_passed':len(vecs),
            'duplicate_key_rejected':duplicate_rejected,
            'limitations':['finite abstract state only','atomic protected finality assumed',
            'durable consumption assumed','no RTL/physical/protocol implementation tested',
            'JSON parser case is illustrative, not complete wire conformance']}

if __name__=='__main__': print(json.dumps(run(),indent=2))
```

### Observed result and negative controls

The unmodified finite effect model explored **128 states and 1,536 transitions**, with no counterexample to its encoded violation checks. It reached 64 states containing one authorized commit and 64 states containing the bounded local freeze. These are state counts, not independent physical trials or comprehensive proof obligations. Exhaustiveness is limited to the defined state/event space.

| Deliberately weakened check | Detected counterexample event sequence | Encoded violation |
|---|---|---|
| Binding | prepare → propose_bad → commit | Wrong destination |
| Generation | prepare → retire → reuse → commit | Stale generation |
| Revocation | prepare → revoke → commit | Revoked authority |
| One-use consumption | prepare → commit → commit | Duplicate effect |
| Update scope | propose_bad → signed_bad_update → prepare → commit | Expanded policy permits wrong destination |
| Response scope | global_alert | Global protective effect without grant |

All 120 replay permutations published the two authorized sequence numbers exactly once. A variant that advanced the accepted high-water mark before policy acceptance produced a counterexample. The program also verified two HMAC-SHA-256 vectors, rejected two altered-message comparisons and rejected a duplicate JSON operation key. It does not implement the full Accord, record or signature encoding profile.

## 5. Real cryptographic vectors and illustrative encodings

The HMAC vectors are RFC 4231 test cases 1 and 2, sections 4.2 and 4.3 of [Test Cases for HMAC-SHA-224, HMAC-SHA-256, HMAC-SHA-384, and HMAC-SHA-512](https://www.rfc-editor.org/rfc/rfc4231.html). The code contains the exact keys, messages and expected SHA-256 MACs. Passing them checks a primitive invocation on these inputs; it does not establish key management, record construction, side-channel resistance or protocol authentication.

JSON examples elsewhere are explanatory unless a pinned canonical profile explicitly makes them vectors. A deployment must provide exact encoded bytes, canonicalization rules, algorithm identifiers, domain separation, signature/MAC inputs, expected outputs and rejection behavior. Duplicate keys, noncanonical lengths, ambiguous integers, unknown critical fields, invalid enum values, excessive nesting and oversize collections require deterministic handling before effect admission.

Protocol fixtures must include successful interoperability between independently implemented encoders/verifiers. Changing a noncritical field may be acceptable only when the profile proves that the field cannot change authorization or representation semantics. Changing an algorithm identifier, audience or critical extension cannot be normalized away. Tests publish hashes and public test keys, never live credentials.

## 6. Physical and operational qualification

Qualification expands every interface from [Chapter 04](04_reference_machine_and_reachability.md) into actual pins, lanes, queues, parsers and custodians. Test reverse signaling on the configuration diode, alternate BMC/debug routes, cache-only blind spots, firmware reset behavior, storage flush contracts and shared-power failure. Inspect a prototype with its ordinary operational configuration, including recovery and update equipment.

Detector qualification uses held-out benign and attack populations, known base rates, confidence intervals and drift tests. Report false positives, false negatives and abstentions separately. A threshold selected after seeing the test set is exploratory evidence. Physical sensors need calibrated instruments, environmental controls, hostile stimulus and independent replication; plausible heat or electromagnetic activity is not a semantic memory read.

Availability tests measure useful work, denied work, detection delays, cumulative response time, queue exhaustion, recovery labor and unavailability. Warm-up and setup costs are included. A safety-critical deployment adds device-specific hazard analysis and independent interlocks; generic cybersecurity tests cannot establish clinical, industrial or transport safety.

## Human-factor evaluation campaign

Trusted byte binding is necessary but does not establish that people understand an approval. A proposed human-factor campaign presents coercive wording, lookalike trusted controls, hidden fees, ambiguous recipients and silent-downgrade attempts alongside legitimate tasks. Participants must distinguish approval of carriage from disclosure, payment, ballot submission and standing delegation. The study also tests recognition of compelled action versus voluntary consent, cancellation and revocation, and the duration and cumulative scope of continuing grants.

Before data collection, the evaluator specifies representative participant and accessibility needs, realistic task context, comprehension questions, harmful-misapproval and false-rejection measures, completion time, recovery success and decision criteria justified by the operation's consequences. Report denominators, uncertainty, exclusions and the limits of the tested population. A participant clicking the mechanically correct button is not sufficient evidence of informed understanding. Positive controls must remain usable, including deterministic and assistive paths when the companion is unavailable. These evaluations are specified; no participant study or measured misapproval rate is claimed here.

## 7. Failure interpretation and publication

A failed oracle identifies the exact claim defeated and whether the defect lies in the implementation, model or stated assumption. Preserve the failing input and state trajectory. A correction is accepted only after replaying that counterexample and the corresponding permitted-work control. Broadening the assumption to exclude an ordinary admitted attacker requires an explicit weaker profile, not a silent pass.

The full requirement/test mapping is in [Chapter 61](61_requirement_decision_evidence_traceability.md). Implementation reports bind results to artifact digests and retain raw evidence under appropriate privacy controls. This publication supplies obligations, a bounded executed demonstration and reproducible primitive checks; all remaining proposed tests retain their unvalidated status until actual evidence is supplied.

## Normative requirements and acceptance obligations

**R-56-01 — Complete test mapping.** Each normative requirement MUST have a reproducible acceptance oracle and an explicit execution status.

**Acceptance T-56-01:** Compare every declaration with the traceability register; missing or invented pass status fails review.

**R-56-02 — Independent consequence oracle.** Attack tests MUST observe the relevant consequence outside the component whose compromise is assumed.

**Acceptance T-56-02:** A forged guest success/denial log cannot satisfy a DMA, egress, persistence or actuator oracle.

**R-56-03 — Positive and negative controls.** Conformance campaigns MUST demonstrate permitted work and detect deliberately invalid behavior.

**Acceptance T-56-03:** All-deny implementations fail the positive control; intentionally weakened binding/replay checks must yield counterexamples.

**R-56-04 — Exact vector status.** Cryptographic vectors MUST identify exact bytes and source; illustrative schemas MUST NOT be reported as interoperability evidence.

**Acceptance T-56-04:** Cross-check RFC vectors, reject duplicate/critical ambiguity and refuse unpinned examples as production signed inputs.

**R-56-05 — Model scope.** Model results MUST publish code, assumptions, explored scope and limitations without claiming untested physical properties.

**Acceptance T-56-05:** Run the embedded code, confirm counts and mutants, and verify that its evidence does not label hardware requirements established.

**R-56-06 — Preserved failures.** A corrected implementation MUST rerun the concrete failing case and useful-work control while retaining the original counterexample.

**Acceptance T-56-06:** A change that hides the failure or disables all legitimate effects cannot close the test obligation.


**R-56-07 — Human comprehension evidence.** High-consequence approval interfaces MUST undergo a separately specified human-factor evaluation of comprehension, harmful misapproval, false rejection, accessibility and recovery, including misleading and coercive presentations. Mechanical intent binding alone MUST NOT be reported as evidence that people understood the action or its continuing scope.

**Acceptance T-56-07:** Run preregistered permitted and misleading task variants with a justified participant population; measure whether participants distinguish transport, disclosure, payment, ballot and standing delegation and apply declared acceptance criteria. Until the study is performed, comprehension claims remain unestablished.

