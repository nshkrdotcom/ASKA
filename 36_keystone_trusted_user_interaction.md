# ASKA v6 — Keystone and trusted user interaction

Keystone provides a bounded path through which a person can understand and authorize a consequential machine action. It does not possess every key or override every resource owner. Its job is to bind a qualified human interaction to specific terms and report that evidence to the admitting owner. A compromised application may suggest an action, but it must not replace the destination, amount, release transformation or effect scope after approval.

The trusted path includes more than a dialog box. Input hardware, display ownership, rendering logic, focus indication, firmware, transport, accessibility mechanisms and freshness all affect what a person actually approved. A deployment must state which parts are trusted and which are outside its guarantee. Remote authentication, local physical presence, deliberate approval and legal capacity are separate predicates. Keystone must not silently substitute one for another.

## 36.1 Canonical consequence presentation

A consequential request is converted into a canonical presentation derived from the admitted operation schema. It identifies the acting principal and role, source object or object class, recipient, operation, amount or resource ceiling, release transformation, timing, expiry, continuing obligations, reversibility limits and named finality point. Human-readable labels are bound to machine identifiers and qualified naming evidence. The application cannot display “clinic” while supplying an unrelated recipient key.

**R-36-01 — Exact consequence binding.** Keystone approvals MUST bind the displayed canonical terms to the exact contract digest, operation arguments, recipient identity, object generation, policy version and freshness challenge accepted by the consequence owner. Any material change MUST require a new approval or remain within an already approved, explicitly presented parameter range.

An approval may authorize one effect or a standing delegation. The difference must be visible. A standing authorization should expose its operation set, budget, duration, renewal rules and stopping procedure. Presenting a broad recurring grant as a single harmless action is a trusted-path failure even if its underlying signature verifies.

Not every operation needs a human interruption. An admitted standing contract can permit routine reminders, bounded purchases or a protective freeze. Keystone provides the initial delegation and subsequent review where required; it should not create meaningless approval fatigue by asking for the same already authorized consequence repeatedly.

The [EROS Trusted Window System](https://www.usenix.org/conference/13th-usenix-security-symposium/design-eros-trusted-window-system) demonstrates an earlier small trusted window/input mediator. Keystone's remaining obligation is to bind the displayed canonical consequence to the exact owner-admitted effect and to evaluate the human-interpretation failure modes stated below.

## 36.2 Trusted display and input ownership

The display pipeline must enforce which producer may supply pixels to the trusted approval region. A sealed display object includes dimensions, pixel format, row stride, buffer length, owner and generation, immutable lifetime, region bounds and intended presentation. Arithmetic validation must prove that each scanout access remains within the admitted object despite overflow, aliasing, cropping or format conversion. A general compositor is not entitled to write into the trusted region merely because it renders the surrounding desktop.

**R-36-02 — Display and input integrity.** A trusted approval surface MUST have an enforced producer, validated geometry, immutable or exclusively owned scanout contents, and protected input focus for its stated lifetime. Reassignment MUST drain outstanding access and invalidate old generations before a new owner can modify the resource.

The path must address cursor overlays, windows that obscure trusted text, stale frames, display switching, remote desktop interception and synthetic input. A hardware indicator may help distinguish trusted interaction if its ownership is itself enforced. A drawn padlock inside an untrusted application is not evidence of a protected path. If a deployment cannot protect the display or input hardware, it must report the weaker assurance rather than promoting an application confirmation to trusted presence.

A renderer can be compromised while remaining unable to alter the approved terms if it only receives a restricted presentation object and cannot sign approval. Conversely, an isolated rendering cell does not guarantee that the physical display showed its output. The endpoint and device guards remain part of the claim.

## 36.3 Freshness, accessibility and ambiguous interaction

Input events carry their origin, target session, challenge, timing class and replay protection. An old confirmation event cannot approve a fresh contract. The interface should require a deliberate action appropriate to consequence and accessibility needs; this need not be a particular gesture. Speech, switch controls, screen readers and other assistive mechanisms require their own authenticated routing and presentation rules. An accessibility path must not become an undocumented universal input injector.

**R-36-03 — Qualified interaction evidence.** Keystone MUST distinguish local presence, remote approval, authenticator use and declared accessibility interaction. It MUST bind the actual interaction mode to the receipt and reject replayed, misfocused or ambiguously targeted approvals under the selected assurance profile.

Biometric signals and experimental neural interfaces may contribute input evidence in a declared research or accessibility profile. They do not prove a person's full intent, understanding or decision-making capacity. A system that predicts what a person probably wants must present a proposal or operate under an existing delegation. Prediction is not a new permission source.

If trusted presentation is unavailable, the operation can pause, use an explicitly admitted alternative channel or proceed under a distinct standing basis. It cannot fabricate a successful human approval to maintain convenience. A safety-critical device may need a separately authorized safe-state transition while a consequential data release remains blocked.

## 36.4 Separation from AI and observation

The user companion may prepare explanations, compare options and draft contracts. Keystone's canonical terms are generated or checked by constrained code from the effect schema, not accepted as an arbitrary model narrative. A model can omit a recipient, exaggerate reversibility or be induced by hostile content to misdescribe a tool call. The trusted path must remain meaningful when that model is wrong.

**R-36-04 — Independent approval semantics.** AI-generated explanations MUST be distinguishable from the canonical effect terms, and a model MUST NOT supply approval evidence or change the trusted presentation schema. The consequence owner MUST validate the bound terms independently of the model's description.

Monitoring also requires its own authority. Keystrokes, gaze, voice, display contents and interaction timing are private observations. A security observer may receive designated event classes or commitments; it does not acquire permission to record every interaction. A one-way observation channel limits a particular return path, but a separate proposal or update channel still exists if the architecture provides it. Such a deployment must not be described as an air gap against all influence.

**R-36-05 — Interaction privacy.** Collection, retention and export of interaction telemetry MUST have explicit observation and release authority. Approval records SHOULD minimize sensitive input content while retaining the evidence needed to distinguish the approved terms, interaction mode and result.

A receipt might commit to the canonical contract and record that a qualified presence check succeeded without retaining the biometric sample or raw voice. Low-entropy commitments need a disclosure strategy that resists guessing by unauthorized readers. Detailed forensic capture requires a separate scoped basis and must account for information about bystanders and other users.

## 36.5 Stopping, recovery and operational example

A person must be able to inspect current standing delegations and invoke their defined stop or revocation path without depending on a functioning conversational model. The control can suspend future grant exercise, request cancellation of a prepared effect or initiate a safe state. Its display must explain when an action has already crossed finality. “Stop” cannot promise to retract a message that has been delivered or physically recall a completed act.

**R-36-06 — Model-independent control.** Revocation, status inspection and the admitted emergency stop or safe-state path MUST remain available through a declared non-model control path. Results MUST distinguish prevented, already committed, uncertain and separately compensable effects.

Consider a user approving release of a medical summary to a named specialist. The companion prepares a useful explanation, but the trusted presentation binds the recipient key, selected summary object, permitted purpose and expiry. The source release owner verifies the exact sealed output. The specialist's receiver separately accepts it. If the application swaps the recipient after approval, validation fails. If the transfer is accepted locally but remote receipt is lost, the interface retains the established local commitment and shows remote delivery as unresolved, rather than displaying either universal success or a false clean cancellation.

Keystone recovery must preserve this separation. Replacing a damaged trusted display module requires qualified enrollment and revocation of old interaction credentials. Recovery of the interaction path does not recover every source key or reactivate all previous grants. A user who regains access must be able to review outstanding uncertain effects and retained standing delegations before new authority is exercised.

**R-36-07 — Scoped Keystone recovery.** Recovery MUST identify the restored interaction identity, assurance level and affected grants, retire compromised generations, and reconcile outstanding approval sessions. It MUST NOT confer unrelated source access or treat stale approvals as current intent.

## 36.6 Human comprehension and deceptive presentations

Cryptographic binding establishes which terms were approved; it does not establish that the person understood those terms. A Keystone qualification campaign must therefore test human interpretation as well as pixel, focus and signature integrity. Use a declared study population that covers the intended accessibility and interaction modes, synthetic records and simulated effects, and scenarios whose expected scope is fixed independently of the model or interface being evaluated. Where practical, blind participants or evaluators to the experimental condition so that the test does not merely reward recognition of a labeled attack.

The scenario set includes coercive wording, lookalike recipient names, fees omitted from a model's explanation, one-time actions presented as recurring permission, delayed-notice consequences and a proposed downgrade of the assurance profile. It also includes legitimate urgent and compulsory operations, so an interface does not pass by training people to reject every consequential request. A proposed downgrade remains executable only if source policy permits it and a new qualified contract is admitted; comprehension does not supply missing authority.

**R-36-08 — Human-comprehension evidence.** A Keystone deployment claiming usable informed approval MUST evaluate whether intended users can distinguish transport permission, data disclosure, payment, ballot casting and future delegated access under both ordinary and deceptive presentations. The campaign MUST report mistaken approvals, mistaken refusals, recipient and scope understanding, accessibility differences, completion time and uncertainty under a preregistered task model; digest agreement alone MUST NOT satisfy this obligation.

The evaluator should test whether people recognize the recipient, amount and fees, disclosure categories, duration, standing budget, revocation path and limits of cancellation after finality. Report sample selection, assistance provided, scenario order, denominators and uncertainty intervals, and separate technical binding failures from misunderstanding or persuasion inside a correctly protected surface. Thresholds for a claimed deployment must be justified before testing; this specification supplies no fabricated success rate. No human-factor study result is asserted here.

| Oracle | Falsifiable acceptance condition |
|---|---|
| T-36-01 | Change a recipient, amount or output digest after confirmation; the consequence owner rejects the approval. |
| T-36-02 | Attempt stride overflow, stale scanout and compositor overlay attacks; protected terms cannot be replaced or read outside the admitted object. |
| T-36-03 | Replay remote input into a local-presence session or redirect accessibility input; the required qualified interaction is not falsely reported. |
| T-36-04 | Make the companion describe a harmless operation while supplying a consequential one; canonical terms show the actual effect and remain independently checked. |
| T-36-05 | Enable ordinary approval logging; raw voice, keystrokes and display contents do not appear without separately admitted observation scope. |
| T-36-06 | Disable the model during an active delegation; the declared revocation and status controls still function and report finality honestly. |
| T-36-07 | Recover Keystone with an old pending confirmation; that event cannot install fresh source or effect authority. |
| T-36-08 | Run the declared blinded or controlled comprehension scenarios, including coercive wording, lookalike recipients, hidden fees and downgrade proposals; measure mistaken approval/refusal and correct identification of transport, disclosure, payment, ballot and standing-delegation scope. A deployment fails its usability claim when its preregistered criteria are unmet, even if every digest binding verifies. |

These requirements are architectural obligations, not a claim that a display prototype has passed adversarial testing. Authentication comparisons should be read within their scope: [NIST SP 800-63B-4](https://pages.nist.gov/800-63-4/sp800-63b.html) addresses digital authentication, while the consequence binding, display ownership and effect semantics above require additional implementation evidence.
