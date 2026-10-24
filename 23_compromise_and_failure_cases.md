# ASKA v5 — Compromise and failure cases

## Added ASKA v5 adversarial scenarios

Compromise one complete Wilder parser and its ordinary transceiver controller. Attempt to steal Sanctum signing state, alter a Polis ballot, spend Agora funds, rewrite Steles receipts, and cause a fallback traffic path between planes. The expected result is denial or an explicitly identified bounded exception; a compromised guard, shared root, physical probe behind the guard, or authorized insider is a different attack condition. Repeat with a malicious but formally authorized court request, malicious AI proposal, double-spend attempt after crash, and hostile upstream community relay.

---

## Detailed technical contract

**Requirements:** R01–R13, R17, R18, R19–R24.

Each primary test starts with the attacker already controlling a component. A separate measurement evaluates exploit prevention. The campaign records the attacker's legitimate starting grants, the forbidden effect, the guards that must deny it, the additional authority or failure needed to succeed, and the useful work that still completes.

## PHP: memory exhaustion during incomplete initialization

The PHP project's 21 October 2026 advisory for CVE-2026-109618 describes memory exhaustion interrupting initialization and leaving cleanup to operate on invalid request state. It reports unauthenticated execution in the worker's account in affected configurations. [Primary advisory](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w).

The ASKA harness must implement a native request graph with an import parser, request worker, and separately owned persistent service. Fault the worker during partial initialization, then deliberately give the attacker arbitrary instruction control. Do not assume the allocator, CHERI, or language runtime prevents that takeover.

Required outcomes:

- The allocator charges the worker's budget and stops allocation at exhaustion; the controller cleans up and retires the cell without attacker cooperation.
- The output guard and recipient commit checks must prevent private malformed state from bypassing publication rules.
- The worker cannot read unrelated objects, invoke an uninstalled database method, emit to an unadmitted destination, or change policy.
- Receipts must distinguish already authorized/committed effects; abort must not claim to roll them back.

The attacker can corrupt the current computation, consume its allowance, return malicious permitted values, and prevent its own completion. Reports must include those remaining harms. Native containment does not repair a vulnerable conventional PHP installation.

## PHP: stale state across requests

The companion advisory, CVE-2026-109619, describes worker-retained references to request-owned memory and operations that encounter them before the next request's initialization replaces the state. [Primary advisory](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp).

Run request A, leave malicious references in every allowed location, abort, retire its cell, and reuse the physical resources for request B. Delay a DMA completion and a message from A until B is active. Attempt to read or overwrite B through those stale references.

Generation checks and endpoint retirement must reject stale effects; drain and sanitation must prevent old accesses or retained bytes from reaching B. A persistent service intentionally shared by A and B must also avoid retaining a live reference to A's private region; it stores an owned copy or an explicitly valid persistent object reference. Resetting a worker alone does not repair a buggy state owner.

Use-after-free within A's own lifetime is a distinct R17 test. Ephemeral execution reduces cross-request state; it does not make every temporal bug impossible.

## Persistent-service request compromise

Give an attacker control of a persistent service's request parser or transition worker. Leave stale references, exhaust scratch memory, submit a candidate for another object, corrupt labels, and substitute a proposal after validation. Reuse the physical worker resources for a request in another confidentiality compartment while delaying old DMA and output completions.

Fresh request-cell lifetimes and the independent commit controller must contain those attempts under [14](14_persistence_and_effects.md). Independent observers must inspect durable state and later-request memory, not merely the controller's allow/deny log. A weakened service that retains request heap references or trusts worker-supplied ownership must produce a detectable failure. A malicious result within a valid method's unchecked semantics remains in-scope abuse; the test does not claim that commit metadata proves application correctness. Authorized transactions must still commit and recover correctly.

## Apple: alternative parser paths and logical escape

Project Zero's FORCEDENTRY analysis documents an attachment presented as GIF reaching PDF/JBIG2 decoding in `IMTranscoderAgent`, outside the intended BlastDoor processing path. Its separate sandbox-escape analysis describes logic vulnerabilities unaffected by pointer authentication or memory tagging. [Initial exploit](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html), [sandbox escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html).

The harness sends a mislabeled attachment through every import path: thumbnail generation, indexing, preview, accessibility extraction, AI context ingestion, export conversion, remote UI, and error reporting. Every path must select an admitted confined decoder or reject the input. A privileged convenience fallback fails the test even when guards isolate the main decoder.

After decoder takeover, supply malicious but well-formed outputs to the renderer. Try oversized dimensions, integer boundaries, cyclic object references, callbacks, embedded grant requests, and values that select privileged operations. The recipient checks schema, resource cost, and effect authority independently. A typed result does not establish harmless semantics.

Give the attacker control of the renderer and complex compositor as well as the decoder. Submit negative or overflowing strides, inconsistent backing lengths, stale surface generations, out-of-range placements, raw device commands, and requests for the trusted layer. Independent observers inspect memory accesses and displayed pixels for any effect beyond the assigned surface. The independent display enforcer must deny those effects while valid frames still display. A weakened path that relies only on renderer-side clipping must expose the intended failure.

The display guard must prevent application surfaces from covering the trusted approval region. A false picture can still mislead the user; report that separately from forged approval or cross-domain escape. Separately compromise the presentation controller and state which guarantees then depend on another boundary.

## Protected-network transfers and insider bridges

The Air Force's [2010 account](https://www.af.mil/News/Article/115277/cyberspace-is-the-new-domain-of-warfare/) describes a flash drive introducing malware into classified military networks in 2008. This supports a removable-media import case; it does not establish a particular live Internet-to-SIPRNet bridge or every exfiltration stage. The Air Force's [Teixeira investigation summary](https://www.usafe.af.mil/News/Article-Display/Article/3613146/results-of-investigation-into-a1c-texieras-unit-following-unauthorized-disclosu/) documents failures involving insider access and supervision. These mechanisms provide complementary tests. They do not establish a common topology for all classified networks.

Start with an insider authorized to read a restricted collection and control one endpoint. Attempt bulk media writes, printing, screen capture, clipboard export, diagnostic export, a dual-homed bridge, and an authenticated response carrying a secret. Then compromise a cross-domain transformer and a release proposer separately. [19](19_cross_domain_security_and_release.md) specifies the approvals and independent observers for each case.

A read grant alone must not authorize machine-mediated export. A bridge attached outside intact guards must not create operation rights. The release enforcer must preserve the exact approved-content binding through substitution attempts, destination changes, replay, policy withdrawal, and reset. Withdrawal that wins the commit order must deny emission. A compromised proposer must remain inside independently enforced release ceilings; if it is the sole semantic approver, report that approved malicious disclosure remains possible.

Photographing a legitimately visible screen is a human/physical disclosure case. Attach a tap behind the last guard as a separate physical-bypass test. The report must not label either outcome a successful digital-boundary defense. Every denial test must have an authorized sharing counterpart that completes useful work.

## AI planner takeover

Give the attacker complete planner control through a malicious document, compromised model, or direct substitution. The attacker tries to fetch unapproved context, send a summary to an attacker recipient, change effect parameters after approval, reuse another user's inference state, export secret-dependent generated code, or deploy a replacement checker.

The context owner denies unapproved reads; intent and flow checks deny unauthorized effects; artifact admission and independent deployment roles deny unauthorized code installation. Their combined checks must block every listed attempt. The attacker can still produce incorrect plans, lie in an application surface, and misuse a standing grant within its valid bounds. Report fraudulent actions within valid grants as authorized abuse. The absence of a boundary escape does not make those actions harmless.

## Authorized abuse and confused deputies

An analysis service allowed to receive restricted data can return false answers or deliberately encode information in its allowed outputs. A payment service can process a fraudulent transaction that satisfies a weak grant. A classifier can choose a valid but inappropriate route through a broad gateway method.

For each case, identify whether narrower object/method grants, release semantics, cumulative limits, independent approval, or a separate trusted computation can limit the harm. If the architecture already granted the effect, it cannot infer that the human would disapprove. Preserve this distinction in every security result.

## Management and correlated compromise

Compromise an application signer and attempt to install gate firmware, broaden admission, recover another realm's keys, and change the physical network purpose. Compromise the AI builder and attempt to approve its own artifact. Compromise one recovery custodian and attempt to replace a sovereign root alone.

Then attack shared dependencies: the build system serving two signers, a package debug controller, a common reset line, and a fleet-wide firmware image. Compromising one shared dependency may defeat several nominally separate boundaries. Update the independence graph when one dependency defeats several boundaries. The report must then stop claiming that the result requires multiple independent failures.

Test a deliberately malicious execution engine issuing arbitrary bus requests. The island's external guard must deny access to foreign memory and uninstalled endpoints. Separately fail that guard: disclose the affected scope and require the next independently enforced boundary to contain propagation. The test includes hardware failure.

## Protocol and availability cases

Interleave duplicate records across receive lanes, withdrawal between preliminary allow and publication, queue exhaustion after authentication, large valid sequence jumps after cancellations, forged victim session IDs, lost control channels, and replacement sessions. Invalid traffic cannot mint authority, advance replay state, or force permanent victim retirement. Bounded temporary service denial and upstream saturation remain measurable risks.

For purpose networks, select a forbidden actual port, splice path proposals, request a cross-purpose circuit, reset the gate, and attempt management-queue transmission. Independent observation at the physical port must distinguish a forbidden crossing from a packet simply dropped later at its destination.

For persistence, the harness crashes before/after durable commit, restores an old snapshot, and loses a device acknowledgment after an irreversible effect. The service must return correct receipts or explicit uncertainty. It cannot invent exactly-once success.

Flood the encounter ports at the apparatus's supported ingress rate with unknown sessions, malformed envelopes, valid first-contact requests, and reset-triggering traffic. Measure established-session progress, reserved control service, buffer occupancy, bus contention, verification work, and interrupt/log load. A weakened shared FIFO or shared free-buffer pool must cause detectable interference. The report must still count first-contact loss under saturation and any residual shared-facility disruption as availability failures.

Interrupt and restore an established link while preserving protected state, then repeat with lost nonce state, replay-state rollback, expired leases, device replacement, and changed path evidence. Continuity-preserving recovery must neither reuse nonces for changed data nor reopen consumed records or release uses. The guard must close the affected contract whenever it cannot establish security-state continuity. Measure recovery amplification under repeated flaps; do not assume every flap requires attestation. A weakened reset that restores old replay state must admit a detectable duplicate.

## Acceptance record

Each campaign includes a deliberately weakened variant that produces the intended failure: retained DMA access, skipped generation check, privileged decoder fallback, cached allow after withdrawal, forged UI approval, or raw transmit bypass. If the observer misses that failure, the campaign supplies no valid evidence for the claimed property.

Report prevention, containment, in-scope abuse, cross-domain propagation, and service loss separately. A common vulnerability can still affect many cells. The guards must prevent those cells' existing narrow rights from becoming control over unrelated systems, management, or purpose networks. These campaigns have not yet produced ASKA results.
