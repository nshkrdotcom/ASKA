# ASKA — Transport and protected transit

[Start](0010_architecture_and_reading_map_gpt.md) · [Previous](0014_identity_and_online_admission_gpt.md) · [Next](0016_records_and_receive_processing_gpt.md)

Endpoints authorize application delivery; transit gates authorize forwarding. Encryption protects a record across hostile carriers. A physical transmission can be prevented only if its path passes through an unavoidable enforcement gate.

## Three transport profiles

| Profile | Carriage | Property to evaluate |
|---|---|---|
| Protected endpoint overlay | Endpoint records over IPv6/UDP or another bounded carrier | Protected source and destination semantics across untrusted transit |
| SCION integration | Endpoint records carried by a specified SCION transport binding | Existing authenticated path machinery plus independent endpoint consent |
| Experimental native fabric | ASKA envelope and per-gate grants below | Mandatory local port authorization and packet binding inside an instrumented fabric |

The SCION integration uses SCION's specified header and hop fields. ASKA endpoint consent remains separate from transit capabilities; an endpoint grant does not acquire transit authority through encapsulation. [SCION header specification](https://docs.scion.org/en/latest/protocols/scion-header.html).

An overlay retains its underlay's availability and metadata exposure. The native protected fabric enforces the egresses included in its instrumented topology. Its physical-path guarantee ends at that topology's boundary.

## Existing-protocol comparison before native implementation

Compare the experimental native envelope with EPIC and COLIBRI before investing in a new forwarding implementation. EPIC offers several levels of path authorization, authentication, and path validation; stronger freshness claims depend on replay-suppression machinery. COLIBRI addresses bandwidth reservation and policing. Neither supplies ASKA's protected memory provenance or mandatory local transmit gate by itself. [EPIC](https://netsec.ethz.ch/publications/papers/Legner_Usenix2020_EPIC.pdf), [COLIBRI](https://netsec.ethz.ch/publications/papers/2021_conext_colibri.pdf).

| Property | Required comparison |
|---|---|
| Local crossing | Actual ingress/egress binding and controller-independent enforcement |
| Path intent | Binding the ordered path and preventing unauthorized recombination |
| Traversal evidence | Whether prior hops are proved, and against which corrupt participants |
| Authentication | Source, payload, and per-packet scope; key-holder authority |
| Replay | Suppression state, time assumptions, and work before rejection |
| Availability | Reserved bandwidth, admission, policing, and overuse behavior |
| Management | Key distribution, policy installation, reset, and bypass paths |
| Cost | Complete headers, processing, buffering, setup, and retained state |

The native scope digest binds path intent without proving traversal. Evaluate the 96-byte hop entry against an existing protocol with matching requirements, including its cost and security assumptions.

## Native grant acquisition

A path service proposes an ordered list of protected gates and port pairs. Each gate's separately protected admission service approves or rejects its part. The source presents the receiver's scoped consent and its own identity over authenticated control channels. Transit authorities independently decide whether to accept those credentials and what resource class to offer.

The source first collects gate-approved metadata, forms the complete path intent, and then obtains final grants bound to that intent. A changed path requires new grants. The control plane bounds setup state and public-key work. Forwarding lookups use the installed grants without repeating setup.

The native lab profile supports one direction, one record per datagram, and one to eight gates. Gates have unique 32-bit identifiers within the enrolled fabric. The fabric authority's signed inventory maps those identifiers to gate identities and physical ports. Identifier reuse retires affected grants and epochs.

## Experimental native encoding

All integers use network byte order. Reserved fields are zero and rejected otherwise. The envelope precedes the endpoint record defined in [0016](0016_records_and_receive_processing_gpt.md).

| Prefix offset | Bytes | Field |
|---:|---:|---|
| 0 | 1 | Native version, value 1 |
| 1 | 1 | Flags, zero |
| 2 | 2 | Hop count `h`, 1–8 |
| 4 | 4 | Envelope bytes, exactly `128 + 96h` |
| 8 | 16 | Receiver grant identifier |
| 24 | 32 | Source gate identity digest |
| 56 | 32 | Destination gate identity digest |
| 88 | 32 | Endpoint contract digest |
| 120 | 8 | Reserved |

Each following 96-byte hop entry contains:

| Hop offset | Bytes | Field |
|---:|---:|---|
| 0 | 4 | Gate key epoch |
| 4 | 4 | Actual ingress port identifier |
| 8 | 4 | Permitted egress port identifier |
| 12 | 2 | Resource class |
| 14 | 2 | Reserved |
| 16 | 8 | Gate-local expiry deadline |
| 24 | 4 | Maximum endpoint-record bytes |
| 28 | 4 | Fabric gate identifier |
| 32 | 32 | Scope digest |
| 64 | 16 | Grant authenticator |
| 80 | 16 | Per-record authenticator |

Call bytes 0–31 of entry `i` its metadata `M_i`. Define the scope digest as SHA-256 of the ASCII domain string `ASKA-NATIVE-SCOPE-1`, the complete 128-byte prefix, and the ordered concatenation of all `M_i`. Every entry carries that same digest. Fixed widths, explicit hop count, and fixed domain strings make these encodings unambiguous. Duplicate gate identifiers are forbidden in this lab profile.

For a gate-local 256-bit epoch key `K`, and the entry's 64-byte body `B`:

```text
grant_tag  = first16(HMAC-SHA256(K, "ASKA-NATIVE-GRANT-1" || B))
packet_key = HMAC-SHA256(K, "ASKA-NATIVE-KEY-1" || B)
record_tag = first16(HMAC-SHA256(packet_key,
             "ASKA-NATIVE-RECORD-1" || SHA256(endpoint_record)))
```

Strings are their ASCII bytes without a trailing NUL. `first16` takes the first 16 output bytes. The issuer returns the grant body, grant tag, and scoped packet key through the authenticated source-gate control channel. The packet key is installed only in protected source state. Transit epoch keys never leave their issuing gate.

The construction uses existing primitives with separate domain strings for each purpose. It still needs cryptographic review and test vectors. The scoped packet key lets the source gate authenticate records within the grant, while the grant tag prevents changes to its ports, class, expiry, or scope.

## Forwarding decision

The ordinary route controller proposes a local entry index and egress. The protected gate:

1. Validates bounded lengths and the complete scope digest.
2. Checks the chosen entry names this gate and its measured ingress, proposed physical egress, active epoch, allowed class, unexpired deadline, and maximum record size.
3. Verifies the grant tag and the record tag against the received endpoint-record digest.
4. Applies protected port policy and class scheduling.
5. Enables the permitted transmit path only after the required checks complete.

An entry for another gate or port pair is unusable locally. Prefix or path-intent changes invalidate the scope binding. Endpoint-record modification invalidates its per-record tags. The gate does not decrypt the endpoint payload and does not infer its confidentiality category.

The first implementation stores the complete bounded record before forwarding. It hashes the actual received bytes, verifies the entry, and holds those bytes unchanged through transmission. Cut-through is excluded. Independently authenticated chunks require a separate format and a claim limited to each authenticated chunk.

These checks authorize the local crossing. They supply no evidence that the record traversed every previous hop: a malicious forwarder can tunnel or drop bytes outside the monitored topology. Traversal evidence requires a separate chained path-validation construction or an existing reviewed protocol that supplies it.

## Remaining state and replay

Each gate holds epoch keys, a port inventory, neighbor policy, class queues, local time, and aggregate policing state. It need not hold an application-flow authorization table in the fast path. Admission services still retain bounded issuance and audit state.

A captured valid datagram can be replayed through transit until expiry. The destination's replay filter prevents repeated delivery, but transit capacity can still be consumed. This profile polices aggregate class and port use. Exact cumulative limits for each grant would require per-grant counters or another accounting mechanism.

No admission mechanism can prevent an attacker from saturating a link before the first participating gate. To protect a downstream bottleneck, admission and resource scheduling must occur upstream of it. Reserve management capacity, bound each ingress's queue use, and measure useful service under replay floods.

## Physical enforcement

The gate must own the final transmit enable or an equivalent unavoidable datapath control. Host raw queues, alternate virtual functions, firmware management queues, switch recirculation, debug, and reset recovery cannot bypass it. The route controller cannot replace the gate's epoch keys or port policy.

Reset or unreliable clock continuity invalidates grants before forwarding resumes. A gate that loses verification state closes the protected path. Any separate legacy interface has an explicit separate policy and cannot become an automatic fallback for protected traffic.

Board wiring and inventory must establish physical port identity. Cable jurisdiction needs evidence beyond the port number. Logically separate gates can still fail together through shared power or management.
