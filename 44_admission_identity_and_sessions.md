# ASKA v6 — Admission, identity and sessions

## Identity establishes a binding, not permission

Admission binds a peer, device or service identity to a particular endpoint and protocol context under an explicit authority contract. It does not equate recognition with trustworthiness, legal competence or resource ownership. A device certificate, organizational credential, attestation result and installed object capability are different evidence types. The guard checks the type and scope required by the requested operation.

The admitted session record identifies both peers and realms, actual endpoint attachments, application protocol, cryptographic suite, session and boot epochs, applicable grants, permitted directions and record types, lifetime, resource budget, replay profile and recovery policy. The exact identifier widths and exhaustion behavior belong to the selected protocol manifest. No all-zero, truncated or reused identifier receives an implicit administrative meaning.

**R-44-01 — Typed identity admission.** Session admission MUST distinguish identity evidence, device evidence, relationship credentials and installed machine authority. It MUST bind the accepted identity to the actual endpoint, protocol and current epochs, and MUST reject credentials outside their typed scope.

A trust configuration identifies which issuer can make which claim. Local owners retain the decision to admit a contract and install a grant. A recognized sovereign or institutional root is not a universal administrator. DTMS may contribute current risk evidence, but a high score does not mint a capability and a low score does not authorize an unbounded emergency action.

First-contact work in the reference profiles enters through `J-E` and the dedicated `C-E/B-E/G-E` encounter resources. Authentication and installation proposals cross a bounded guarded metadata interface to the relevant protected installer. Established-session traffic, control and recovery use their own receive resources and service reservations. An authenticated encounter peer does not gain direct access to those tables or pools; the native separation contract is in [chapter40](40_societal_planes_and_endpoint_separation.md).

## Adaptive authentication and scoped step-up

Adaptive authentication supports ordinary and remote sessions under an installed authentication profile. That profile fixes the minimum assurance floor, qualifying authenticators and factor-independence conditions, freshness intervals, challenge limits and permitted recovery paths. Hardware tokens, biometric evidence, behavioral signals and out-of-band confirmation are possible inputs with different declared scopes. Several scores derived from the same compromised endpoint do not become independent factors merely because different models produced them.

**R-44-08 — Bounded adaptive authentication.** Session admission and step-up authentication MUST enforce an installed, versioned authentication floor. Fresh challenges and results MUST bind the principal, authenticators, session and endpoint epochs, intended verifier or destination, requested scope and expiry. Risk or model evidence MUST NOT lower that floor, manufacture a factor or turn authentication into resource, release or effect authority. Recovery and fallback MUST follow separately admitted conditions, expose any weaker assurance and satisfy the receiving operation’s current requirements before use.

Device posture, network context, recent events or behavioral analysis may trigger additional checks, suspension or closure only within the installed profile and applicable response grant. Step-up requests have bounded rate, lifetime and cumulative cost. A successful result establishes only the authentication proposition for its bound scope; source authorization, destination acceptance and current grants are still checked. An authenticator result for viewing a remote workspace cannot be replayed as approval of a payment or export. [Native remote-UI services](38_native_apps_toolchains_and_interoperability.md) retain independent input, presentation and redirection grants, and [Keystone](36_keystone_trusted_user_interaction.md) distinguishes remote approval from local presence.

The evidence record retains the authentication-profile version, qualified factor references, challenge and scope commitments, supported time interval and outcome under its privacy label. It need not retain raw biometric samples or authentication secrets. Losing an authenticator does not activate an undocumented bypass: the recovery owner follows the admitted replacement or fallback contract, retires superseded bindings and reports the resulting assurance. If the required floor cannot be met, the dependent operation remains unavailable. Recovery cannot reactivate expired grants, and authentication failure or disconnection cannot erase an already established committed effect.

## Cryptographic migration study

Long-lived identity signatures and confidential data need an explicit migration study. The study evaluates [ML-KEM in FIPS 203](https://csrc.nist.gov/pubs/fips/203/final), [ML-DSA in FIPS 204](https://csrc.nist.gov/pubs/fips/204/final) and [SLH-DSA in FIPS 205](https://csrc.nist.gov/pubs/fips/205/final) in their respective key-establishment and signature roles. These references identify standardized candidate primitives; they do not establish an ASKA handshake, select one universal suite or make the three mechanisms interchangeable. The selected study profile pins standard editions, parameter sets, current errata and implementation assumptions rather than relying on an algorithm-family name alone.

**R-44-07 — Reviewed cryptographic migration.** A deployment’s cryptographic study MUST evaluate post-quantum key-establishment and signature candidates, including ML-KEM, ML-DSA and SLH-DSA, against its long-lived identity and data requirements. Any selected profile MUST bind exact parameters, applicable errata, reviewed implementation and hybrid-composition policy, authenticated negotiation, transcript binding and downgrade protection. Migration MUST preserve current authority and retired-key history; changing cryptography MUST NOT reactivate old sessions, keys or grants.

The study specifies interoperability, key and message sizes, verification and storage costs, failure handling, credential renewal and rollback restrictions under the declared deployment. A hybrid profile must name its reviewed combiner and the properties expected if one component fails; merely placing two mechanisms in one message is not a reviewed composition. Negotiation protects the offered and selected algorithms, peer roles and application context against substitution. Compatibility fallback requires an admitted profile with explicit weaker claims where applicable, rather than an invisible retry under an older suite. The dossier also states which historical ciphertext, archived signatures and offline identities remain outside the achieved migration. [The research program](60_research_program_and_architectural_decisions.md) owns selection evidence and decision gates; this chapter owns their binding to sessions and installed authority.

## Attestation and appraisal

Attestation can provide signed evidence about measured state under a stated root and collection procedure. Its meaning depends on what was measured, when, by whom and against what reference. [The RATS architecture, RFC 9334 sections 3–4 and 7](https://www.rfc-editor.org/rfc/rfc9334.html), separates evidence, verifier appraisal and relying-party decisions. ASKA retains that separation rather than treating an attestation result as direct permission.

A relying owner checks freshness, nonce or challenge binding, audience, device and boot identity, measurement scope, reference policy and verifier authorization. It records what the evidence does not cover: runtime state after measurement, unmeasured device firmware, physical alterations, manufacturing correctness or an alternate path around the measured component. A signed measurement can be authentic while the measured software contains a vulnerability.

**R-44-02 — Scoped device evidence.** Admission using attestation MUST record the measured scope, appraisal policy, freshness and excluded dependencies. An attestation result MUST NOT be treated as proof of correct silicon, perpetual integrity, semantic output correctness or entitlement to a resource.

If the verifier is unavailable, the session follows a pre-admitted policy for cached evidence or stops. Cached evidence has an explicit maximum age and risk scope. The requester cannot choose a weaker verifier simply because the selected one is unreachable. A fresh device replacement requires new endpoint binding and retirement of old session state even if the replacement presents the same organizational identity.

## Establishment and key binding

The establishment protocol includes discovery or encounter, bounded negotiation, mutual identity checks where required, key establishment, application-context binding, contract admission and local grant installation. It must resist downgrade, cross-protocol confusion, unknown critical fields and mismatched peer roles. The two endpoints can install their respective grants at different times; one side becoming active does not prove the other is ready.

TLS 1.3 is one candidate authenticated-channel substrate. [RFC 8446 section 7.5](https://www.rfc-editor.org/rfc/rfc8446.html) defines exporter-based key derivation with application context, while section 8 describes the replay limitations of early data. An ASKA profile using TLS must bind application keys to the negotiated session, both peer roles, protocol version and intended use. It must not assume that encrypted transport itself supplies record-level release or exactly-once effects.

**R-44-03 — Context-bound establishment.** Session keys and grants MUST bind the negotiated protocol, peers, roles, endpoint context and epochs. Effect-bearing operations MUST NOT rely on replayable early data unless the selected application protocol independently supplies and proves the required replay and authority behavior.

A conservative candidate excludes effect-bearing 0-RTT operations and uses the normal authenticated handshake before installing data-plane authority. Another substrate may be selected, but it must establish equivalent explicitly reviewed properties. Algorithm agility is bounded by policy: peers negotiate among admitted suites, not among whatever one side happens to offer. Deprecated or incompatible suites cause denial or an explicit migration workflow.

## Session lifecycle and finite resources

A session can be `NEGOTIATING`, `AUTHENTICATED`, `ADMITTED`, `ACTIVE`, `SUSPENDED`, `REVOKED`, `EXPIRED` or `CLOSED` as a local transport refinement. These are not replacements for PACT’s agreement and grant-installation states. Authentication may complete without a resource contract. Admission may reserve capacity without enabling traffic. Active means the applicable local grants are installed; it does not establish any remote application outcome.

A negotiation budget limits unauthenticated state, CPU, cryptographic operations and response bytes. The endpoint avoids storing unbounded state for arbitrary claimed identities. Repeated failures can consume an encounter budget without consuming a victim’s accepted replay window or one-use grant. Error responses reveal only the information allowed by their protocol and privacy policy.

**R-44-04 — Bounded session lifecycle.** Every session state and transition MUST have finite resource and lifetime bounds. Data-plane authority MUST become usable only after required local grants are installed, and unauthenticated or rejected negotiations MUST NOT consume another principal’s authority or accepted record state.

Session leases use a declared clock model. The manifest specifies local monotonic time, allowed drift, uncertainty and conservative expiration. If a sender relies on a remote lease, its usable interval must account for those bounds rather than assume synchronized perfect clocks. Wall-clock rollback cannot extend a lease. A clock failure or continuity loss follows the declared fail-closed or narrowly bounded degraded policy.

## Rekey, flaps, restart and revocation

Rekeying defines whether old and new keys overlap, which records each accepts, how replay state is partitioned and when old keys are destroyed. Reusing a traffic key with a reset nonce or sequence counter is forbidden. A restart either restores protected continuity state or installs fresh keys and epochs; an ordinary configuration backup cannot resurrect a past session universe.

A link flap is not necessarily a new session, but continuity must be established. If the same protected endpoints retain keys, counters, grants and outstanding-effect state, the profile may resume. If any required state is lost or an endpoint may have changed, the parties close the old context and re-admit. Old records remain rejected even if a new connection uses the same address or cable.

**R-44-05 — Fresh recovery and rekey.** Rekey, restart, link recovery and endpoint replacement MUST preserve nonce uniqueness, replay protection and current authority. Lost continuity MUST cause fresh bindings and retirement of old state rather than counter reset under a reused key.

Revocation prevents future final effects under the revoked grant or session. It may also trigger bounded cleanup, quarantine or egress freeze under installed authority. A peer’s notification of revocation is evidence to verify; local final checks enforce the applicable revocation state. The system records completed effects and unresolved delivery separately. Revoking a session cannot retract plaintext already accepted by a recipient.

## Example and acceptance obligations

A newly attached community appliance presents a device measurement and an institutional role credential. The receiving realm verifies their different issuers and scopes, binds the session to the actual port and boot epoch, negotiates an admitted cryptographic suite and installs a grant for one object class. The credential does not grant access to the realm’s signing keys. If the appliance is replaced during a link outage, the old traffic key and queued records cannot be applied to the replacement merely because its network address is unchanged.

A session may also carry a narrowly delegated agent workflow. The agent’s identity and role identify the requester; the object owner still checks the specific operation, budget, recipient and current delegation. Authentication cannot turn a tool connection into unrestricted ability to send messages, spend resources or export private objects.

**R-44-06 — Session evidence and closure.** Admission, grant installation, rekey, suspension and closure MUST emit scoped evidence identifying the local state and outstanding obligations. A session receipt MUST NOT be substituted for object publication, remote execution or physical completion evidence.

Acceptance specifications are:

- **T-44-01:** Present valid credentials with wrong audience, issuer scope or endpoint binding. Admission must reject the mismatch without creating a resource grant.
- **T-44-02:** Present fresh attestation that omits a relevant device or runtime dependency. The admitted claim must retain that exclusion; the evidence must not be promoted to complete machine integrity.
- **T-44-03:** Replay effect-bearing early data and alter exporter/application context. The conservative profile must reject the early effect and derive no usable cross-context authority.
- **T-44-04:** Flood negotiations and stop between authentication and grant installation. Resource bounds must hold and the partially established session must not authorize data-plane effects.
- **T-44-05:** Reboot or replace an endpoint after losing counters, then replay old ciphertext. Recovery must use fresh bindings or safely restored continuity, and old records must not become valid under reused nonces.
- **T-44-06:** Close a session after local emission but before remote acknowledgement. Evidence must preserve local emission and the unresolved remote outcome rather than report complete delivery or a clean abort.

- **T-44-07:** Evaluate old, new and proposed hybrid peers against the pinned migration profile. Alter algorithm identifiers, parameter sets, component contributions and transcript context; trigger a compatibility fallback and replay a retired credential. Unreviewed composition or unauthorized downgrade must fail, retired authority must remain retired, and the migration dossier must identify its unresolved historical-data and interoperability limits.

- **T-44-08:** Attempt a low-risk model recommendation that drops a required factor, replay a step-up result into another session or destination, flood challenges, and invoke a weaker recovery path. The installed floor and resource bounds must hold; mismatched evidence must fail; fallback must expose its assurance and satisfy the current operation’s policy. Valid authentication without the separate effect grant must authorize no effect, and disconnect must preserve any previously established committed receipt. Then supply fresh qualified factors and a current separate grant: the permitted operation must complete within its admitted scope.
