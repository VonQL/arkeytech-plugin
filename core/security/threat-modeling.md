# Threat Modeling Reference

## STRIDE Methodology

**Origin:** Microsoft | **Use:** Application and system threat modeling

STRIDE is a mnemonic for six categories of security threats. Apply it per component in C4 diagrams and per API endpoint in design reviews.

### STRIDE Categories

| Threat | Definition | Security Property Violated | Example |
|---|---|---|---|
| **S**poofing | Attacker impersonates another user or system | Authentication | Stolen JWT token used to call API as another user |
| **T**ampering | Unauthorized modification of data or code | Integrity | Attacker modifies request payload in transit |
| **R**epudiation | Actor denies performing an action | Non-repudiation | User claims they never placed an order |
| **I**nformation Disclosure | Unauthorized exposure of data | Confidentiality | Stack trace exposes database schema in error response |
| **D**enial of Service | Making a system unavailable | Availability | Flood of requests exhausts API rate limits |
| **E**levation of Privilege | Gaining unauthorized capabilities | Authorization | Regular user accesses admin endpoint |

### STRIDE Threat Table Template

Use this for every component/service in the system:

```markdown
## STRIDE Analysis: [Component Name]

| ID | Threat Category | Threat Description | Likelihood | Impact | Mitigation | Status | Framework Ref |
|---|---|---|---|---|---|---|---|
| T-01 | Spoofing | Attacker reuses expired JWT token | Medium | High | Short token expiry (15min) + refresh token rotation | Mitigated | OWASP A07 |
| T-02 | Tampering | Request body modified in transit | Low | High | TLS 1.3, request signing (HMAC) | Mitigated | NIST PR.DS-2 |
| T-03 | Repudiation | No audit log of sensitive operations | Medium | Medium | Immutable audit log with user ID, timestamp, action | Open | ISO 27001 A.8.15 |
| T-04 | Information Disclosure | Error response exposes stack trace | High | Medium | Generic error messages in prod; log details server-side | Mitigated | OWASP A05 |
| T-05 | Denial of Service | No rate limiting on auth endpoint | High | High | Rate limit: 10 attempts/min per IP, exponential backoff | Open | NIST PR.PT-3 |
| T-06 | Elevation of Privilege | Missing authorization check on admin route | Medium | Critical | RBAC middleware on all admin routes, tested in CI | Mitigated | OWASP A01 |
```

**Likelihood:** Critical / High / Medium / Low
**Impact:** Critical / High / Medium / Low / Informational
**Status:** Open / Mitigated / Accepted / Transferred

### STRIDE by Component Type

**Web/API Layer:**
- S: Authentication bypass, token theft, session hijacking
- T: Request tampering, parameter pollution, mass assignment
- R: Missing audit logs, insufficient logging
- I: Verbose error messages, debug endpoints in prod, CORS misconfiguration
- D: No rate limiting, no request size limits, ReDoS
- E: Broken access control, privilege escalation via role manipulation

**Database:**
- S: Connection string exposure, credential reuse
- T: SQL injection, ORM injection, schema manipulation
- R: No query logging for sensitive operations
- I: Unencrypted data at rest, backup exposure, excessive column permissions
- D: Connection pool exhaustion, lock escalation attacks
- E: Overprivileged DB user (should never have DROP, TRUNCATE in prod)

**Message Queue / Event Bus:**
- S: Unauthenticated message submission, spoofed producer identity
- T: Malicious message payload, schema injection
- R: No message provenance tracking
- I: Sensitive data in message payload (PII, card data)
- D: Queue flooding, poison pill messages
- E: Consumer processes messages it shouldn't have access to

**Internal Service (microservice):**
- S: No mTLS — any service can call any other service
- T: Request body not validated — assumes upstream sanitized
- R: Calls not logged between services
- I: Service returns more data than the caller is authorized to see
- D: No circuit breaker — cascading failures
- E: Service-to-service auth not scoped — "all or nothing" trust

---

## PASTA Methodology

**Process for Attack Simulation and Threat Analysis** — risk-centric, 7-stage.

Use PASTA for high-risk systems (payments, healthcare, critical infrastructure) where STRIDE alone is insufficient.

### PASTA 7 Stages

| Stage | Name | Output |
|---|---|---|
| I | Definition of Objectives | Business objectives, compliance requirements, risk appetite |
| II | Definition of Technical Scope | Technical boundary, asset inventory, technology stack |
| III | Application Decomposition | DFDs (Data Flow Diagrams), trust boundaries, entry/exit points |
| IV | Threat Analysis | Threat intelligence, attack patterns (CAPEC, ATT&CK) |
| V | Vulnerability Analysis | Vulnerability scan results, code review findings, CVEs |
| VI | Attack Modeling | Attack trees, attack scenarios mapped to assets |
| VII | Risk and Impact Analysis | Risk register with business impact, residual risk |

### Data Flow Diagram (DFD) Template

DFDs are the foundation of PASTA — map all data flows before analyzing threats.

```markdown
## Data Flow Diagram: [System Name]

### External Entities (untrusted)
- User (browser/mobile app)
- Third-party API (payment gateway, email provider)

### Processes (transform data)
- Web Application (serves UI)
- API Service (business logic)
- Worker Service (async processing)

### Data Stores (persist data)
- PostgreSQL Database (user data, orders)
- Redis Cache (session tokens, rate limit counters)
- S3/Blob Storage (uploaded files)

### Data Flows and Trust Boundaries

| Flow ID | From | To | Data | Protocol | Trust Boundary Crossed? |
|---|---|---|---|---|---|
| DF-01 | User | Web App | HTTP requests | HTTPS/TLS 1.3 | Yes — external to internal |
| DF-02 | Web App | API Service | API calls | HTTPS internal | No — internal network |
| DF-03 | API Service | Database | SQL queries | TCP/TLS | No — internal network |
| DF-04 | API Service | Payment Gateway | Payment data | HTTPS | Yes — internal to external |
| DF-05 | API Service | Email Provider | User email, name | HTTPS | Yes — internal to external |

### Trust Boundaries
- **Boundary 1:** Internet ↔ DMZ (WAF, Load Balancer)
- **Boundary 2:** DMZ ↔ Application Tier (VPC/VNET)
- **Boundary 3:** Application Tier ↔ Data Tier (private subnet)
- **Boundary 4:** Internal ↔ Third-party services (egress firewall)
```

---

## Threat Modeling Process (Recommended Steps)

1. **Scope:** Define what you're modeling (one service, one feature, or the whole system)
2. **Decompose:** Draw DFD or C4 diagram — identify all components, data stores, data flows, trust boundaries
3. **Apply STRIDE:** For each component and data flow, enumerate threats per STRIDE category
4. **Score:** Rate each threat by Likelihood and Impact (use CVSS 4.0 language)
5. **Mitigate:** For each threat, decide: Mitigate / Accept / Transfer / Avoid
6. **Document:** Complete the STRIDE Threat Table
7. **Review cadence:** Re-run threat model when: new feature added, new integration, after incident, annually

---

## Threat Modeling Trigger Checklist

Run or update the threat model when:
- [ ] New external integration (API, third-party service, payment processor)
- [ ] New authentication or authorization mechanism
- [ ] Change in data classification (new PII, financial data, health data)
- [ ] New deployment environment or cloud region
- [ ] Security incident or near-miss occurred
- [ ] Annual review (minimum)
- [ ] New developer joins and will work on security-sensitive areas

---

## Agent Instructions: Threat Modeling

1. **Always produce a STRIDE table** for every C4 Level 2 component in the design.
2. **Every ADR with security implications** must reference the affected STRIDE categories.
3. **Use PASTA** when: payment processing, healthcare data, critical infrastructure, or any system requiring formal risk analysis.
4. **DFDs before STRIDE** — you can't find threats without knowing the data flows.
5. **Every Open threat is a risk** — document it in arc42 section 11 (Risks).
6. **Never mark a Critical threat as Accepted** without explicit written approval from security owner.
7. **Framework references required** — every threat row must cite at least one: OWASP, NIST CSF, ISO 27001.
