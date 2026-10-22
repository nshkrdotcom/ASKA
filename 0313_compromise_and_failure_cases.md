# ASKA v4 — Compromise and failure cases

[Start](0300_architecture_and_reading_map.md) · [Previous](0312_governance_updates_and_recovery.md) · [Next](0314_validation_and_cost_models.md)

**Requirements:** R01–R13, R17, R18, R19–R24.

The primary test starts after the attacker controls a component. Exploit prevention is measured separately. For each case, record the attacker's legitimate starting grants, the forbidden effect, the guards that should deny it, the authority or further failure needed to succeed, and useful work preserved.

## PHP: memory exhaustion during incomplete initialization

The PHP project's 21 October 2026 advisory for CVE-2026-109618 describes memory exhaustion interrupting initialization and leaving cleanup to operate on invalid request state. It reports unauthenticated execution in the worker's account in affected configurations. [Primary advisory](https://github.com/php/php-src/security/advisories/GHSA-w8hw-w9fx-j79w).

For ASKA, implement a native request graph with an import parser, request worker, and separately owned persistent service. Fault the worker during partial initialization, then deliberately give the attacker arbitrary instruction control. Do not assume the allocator, CHERI, or language runtime prevents that takeover.

Required outcomes:

- Memory exhaustion charges the worker's budget and stops further allocation; cleanup and retirement do not depend on attacker code cooperating.
- Private malformed state cannot become a published output without the output and recipient commit rules.
- The worker cannot read unrelated objects, invoke an uninstalled database method, emit to an unadmitted destination, or change policy.
- Already authorized/committed effects remain visible as such; an abort does not claim to roll them back.

The attacker can corrupt the current computation, consume its allowance, return malicious permitted values, and prevent its own completion. Reports must include those remaining harms. Native containment is not a patch for a vulnerable conventional PHP installation.

## PHP: stale state across requests

The companion advisory, CVE-2026-109619, describes worker-retained references to request-owned memory and operations that encounter them before the next request's initialization replaces the state. [Primary advisory](https://github.com/php/php-src/security/advisories/GHSA-6wmf-4rv5-p3rp).

Run request A, leave malicious references in every allowed location, abort, retire its cell, and reuse the physical resources for request B. Delay a DMA completion and a message from A until B is active. Attempt to read or overwrite B through those stale references.

The generation, drain, endpoint-retirement, and sanitation rules must reject the stale effects. A persistent service intentionally shared by A and B must also avoid retaining a live reference to A's private region; it stores an owned copy or an explicitly valid persistent object reference. Resetting a worker alone does not repair a buggy state owner.

Use-after-free within A's own lifetime is a distinct R17 test. Ephemeral execution reduces cross-request state; it does not make every temporal bug impossible.

## Apple: alternative parser paths and logical escape

Project Zero's FORCEDENTRY analysis documents an attachment presented as GIF reaching PDF/JBIG2 decoding in `IMTranscoderAgent`, outside the intended BlastDoor processing path. Its separate sandbox-escape analysis describes logic vulnerabilities unaffected by pointer authentication or memory tagging. [Initial exploit](https://projectzero.google/2021/12/a-deep-dive-into-nso-zero-click.html), [sandbox escape](https://projectzero.google/2022/03/forcedentry-sandbox-escape.html).

The architectural test sends a mislabeled attachment through every import path: thumbnail generation, indexing, preview, accessibility extraction, AI context ingestion, export conversion, remote UI, and error reporting. Every path must select an admitted confined decoder or reject the input. A privileged convenience fallback is a failure even if the main decoder is isolated.

After decoder takeover, supply malicious but well-formed outputs to the renderer. Try oversized dimensions, integer boundaries, cyclic object references, callbacks, embedded grant requests, and values that select privileged operations. The recipient checks schema, resource cost, and effect authority independently. A typed result does not establish harmless semantics.

The display guard must prevent application surfaces from covering the trusted approval region. A false picture can still mislead the user; report that separately from forged approval or cross-domain escape.

## Protected-network transfers and insider bridges

The Air Force's [2010 account](https://www.af.mil/News/Article/115277/cyberspace-is-the-new-domain-of-warfare/) describes a flash drive introducing malware into classified military networks in 2008. This supports a removable-media import case; it does not establish a particular live Internet-to-SIPRNet bridge or every exfiltration stage. The Air Force's [Teixeira investigation summary](https://www.usafe.af.mil/News/Article-Display/Article/3613146/results-of-investigation-into-a1c-texieras-unit-following-unauthorized-disclosu/) documents failures involving insider access and supervision. These are complementary mechanisms, not evidence that all classified networks share one topology.

Start with an insider authorized to read a restricted collection and control one endpoint. Attempt bulk media writes, printing, screen capture, clipboard export, diagnostic export, a dual-homed bridge, and an authenticated response carrying a secret. Then compromise a cross-domain transformer and a release proposer separately. [0318](0318_cross_domain_security_and_information_release.md) specifies the approvals and independent observers for each case.

A read grant alone must not authorize machine-mediated export. A bridge attached outside intact guards must not create operation rights. Exact approved content must resist substitution, destination changes, replay, policy withdrawal, and reset. A compromised proposer must remain inside independently enforced release ceilings; if it is the sole semantic approver, report that approved malicious disclosure remains possible.

Photographing a legitimately visible screen is a human/physical disclosure case. Attach a tap behind the last guard as a separate physical-bypass test. Neither outcome may be mislabeled a successful digital-boundary defense. Every denial test must have an authorized sharing counterpart that completes useful work.

## AI planner takeover

Give the attacker complete planner control through a malicious document, compromised model, or direct substitution. The attacker tries to fetch unapproved context, send a summary to an attacker recipient, change effect parameters after approval, reuse another user's inference state, export secret-dependent generated code, or deploy a replacement checker.

The context owner, intent commitment, flow rules, artifact admission, and deployment roles must deny those effects. The attacker can still produce incorrect plans, lie in an application surface, and misuse a standing grant within its valid bounds. Measure fraudulent in-scope actions as authorized abuse rather than declaring the attack defeated merely because no boundary escaped.

## Authorized abuse and confused deputies

An analysis service allowed to receive restricted data can return false answers or deliberately encode information in its allowed outputs. A payment service can process a fraudulent transaction that satisfies a weak grant. A classifier can choose a valid but inappropriate route through a broad gateway method.

For each case, identify whether narrower object/method grants, release semantics, cumulative limits, independent approval, or a separate trusted computation can limit the harm. If the architecture already granted the effect, it cannot infer that the human would disapprove. Preserve this distinction in every security result.

## Management and correlated compromise

Compromise an application signer and attempt to install gate firmware, broaden admission, recover another realm's keys, and change the physical network purpose. Compromise the AI builder and attempt to approve its own artifact. Compromise one recovery custodian and attempt to replace a sovereign root alone.

Then attack shared dependencies: the build system serving two signers, a package debug controller, a common reset line, and a fleet-wide firmware image. A single successful common dependency may invalidate several nominally separate boundaries. The result changes the independence graph; it cannot remain a multi-failure success claim.

Test a deliberately malicious execution engine issuing arbitrary bus requests. Its island's external guard must deny foreign memory and uninstalled endpoints. Separately fail that guard: disclose the affected scope and require the next independently enforced boundary to contain propagation. The test does not assume hardware infallibility.

## Protocol and availability cases

Interleave duplicate records across receive lanes, withdrawal between preliminary allow and publication, queue exhaustion after authentication, large valid sequence jumps after cancellations, forged victim session IDs, lost control channels, and replacement sessions. Invalid traffic cannot mint authority, advance replay state, or force permanent victim retirement. Bounded temporary service denial and upstream saturation remain measurable risks.

For purpose networks, select a forbidden actual port, splice path proposals, request a cross-purpose circuit, reset the gate, and attempt management-queue transmission. Independent observation at the physical port must distinguish a forbidden crossing from a packet simply dropped later at its destination.

For persistence, crash before/after durable commit, restore an old snapshot, and lose a device acknowledgment after an irreversible effect. Require correct receipts or explicit uncertainty, not invented exactly-once success.

## Acceptance record

Each campaign includes a deliberately weakened variant that produces the intended failure: retained DMA access, skipped generation check, privileged decoder fallback, cached allow after withdrawal, forged UI approval, or raw transmit bypass. If the observer cannot detect it, the campaign is not valid evidence.

Report prevention, containment, in-scope abuse, cross-domain propagation, and service loss separately. A common vulnerability can still affect many cells. The target is that their existing narrow rights do not automatically become control over unrelated systems, management, or purpose networks. No ASKA result from these campaigns exists yet.
