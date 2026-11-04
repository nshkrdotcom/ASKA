# ASKA v5 — Governance profiles, institutional authority, and assurance

## 1. Signed PROFILE manifests

A governance profile is a **scoped public commitment** about authority procedures and technical capabilities, not a magic list of authorities who may override all owners. An endpoint, civic institution, corporate network, household, or cooperative can publish a signed manifest identifying how its decisions will be made and what assurances its equipment offers. Profiles are selected based on object, actor, jurisdiction, institution and operation, not as an unreviewed machine-wide “government mode.”

Required fields: `profile_id`, `revision`, `canonical_hash`, `issuer(s)`, `applicability_rule`, `recognized_credential_classes`, `legal_process_procedures`, `required_approval_roles`, `privacy_and_retention`, `emergency_rules`, `attestation_expectations`, `exceptional_access_declaration`, `notice_and_contestation`, `update_authority`, `rollback_policy`, `expiry` and `interoperability_suites`.

## 2. Independent institutional controls

| Institution | Authority asserted | Must not inherit |
|---|---|---|
| Individual/household | personal release, family delegation, local recovery choices | authority to change a court's official record |
| Court or qualified tribunal | scoped legal order/appeal under applicable law | permanent unrestricted endpoint root |
| Municipal service | civic acceptance and public records inside local remit | rights over unrelated private applications |
| Bank or employer | contract, account or organizational rules | authority over civic ballots or intimate family state |
| Community network provider | physical/link provisioning and capacity | capability to approve arbitrary plaintext release |
| Hardware manufacturer | product keys, implementation measurements | authority to decide medical or political questions |
| Independent witness | records commitments and attestation statements | private key escrow or unrestricted data reads |

No institution is assumed “honest” merely because a credential is cryptographically valid. Admission also checks revocation, actual role, scope, jurisdiction, local effect enforcers and governance obligations.

## 3. Profile intersection

A proposed cross-realm action may be governed simultaneously by a person, an institution, the receiver, a transit operator and a retention rule. Profiles are **not silently merged** through precedence of whichever party operates the network. The evaluator constructs an applicable constraint set and, when contradictory obligations lack a recognized decision procedure, enters `SUSPEND` or `ESCALATE`. A profile may reference recognized dispute procedures; the cryptographic mechanism verifies the attributed decisions and bounded execution, not the ethical soundness of the procedure itself.

## 4. Assurance is separate from governance

A governance profile can require strong user approval on both a software prototype and a disjoint physical machine, but the implementations must declare different properties. Native ASKA is **physical separation oriented**. Assurance **descriptors**, not marketing names, identify which properties are established:

| Dimension | Evidence question |
|---|---|
| G — governance | Which issuers and challenge bodies can authorize the named operation? |
| H — hardware | Are compute islands, RAM, ingress queues and guards independently protected? |
| F — fabric | Are links, PHYs, switch queues, management and uplinks disjoint? |
| K — keys | Who can sign, recover or rotate subject, plane and witness keys? |
| O — observation | What memory, output, timing, power or network metadata may attackers observe? |
| W — witness | Is logging durable, independent, privacy-scoped, and reachable? |
| U — updates | Which separate roles can revise policy or firmware? |

A simulated H0 platform cannot claim true physical isolation just because it displays four colored tabs. Physical disjointness also requires an explicit common-cause analysis of shared manufacturing, reset, cooling and carrier facilities.

## 5. Exceptional access disclosures

- `E0`: no specially provisioned third-party decryption/access path; valid custodians can still release records they legitimately can access.
- `E1`: declared custodial access for information already available to a named provider/owner.
- `E2`: user-established delegated recovery, escrow or emergency trustees with scoped and revocable controls.
- `E3`: mandated additional technical access path, **explicitly reported** with its trust and confidentiality consequences.

These labels report facts, **not** a legal or moral endorsement. A device MUST NOT silently advertise `E0` while retaining an unreported access mechanism. A lawful order cannot manufacture absent plaintext or keys.

## 6. Attestation and profile pinning

A session may include an independently appraised attestation about available physical planes, firmware, key custody, witness path, installed profile hash, exceptional-access declaration, and update epoch. Evidence is evaluated by a verifier and then by the relying party's own policy. An endorsement from a manufacturer does not prove an application result is true. For privacy, attestation SHOULD avoid unnecessary stable identifiers, revealing only the required assurance predicates where possible.

Every admitted contract pins applicable profile digests. Updated profiles require new decisions or a declared transitional procedure; silent unilateral substitution at effect time is forbidden.

## 7. Update, appeal and community governance

Profiles should publish update quorum and notice rules. A community cooperative may set access pricing, resilience obligations or routing policy but cannot silently alter a person's data release grant or a court's order. If an institution changes its issuer roots, historical receipts remain verifiable through published key-transition and status evidence. Escalation and dispute mechanisms must identify a responsible institution; AI cannot be the final interpreter of institutional legitimacy.
