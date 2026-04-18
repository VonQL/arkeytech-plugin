# Security Review Template

<!-- Agent: Use this for targeted security reviews of a specific component, feature, or PR -->
<!-- For full system validation, use validation-report.md instead -->

---

# Security Review: {{COMPONENT_OR_FEATURE_NAME}}

**Date:** {{DATE}}
**Reviewer:** {{REVIEWER}}
**Component:** {{component, service, feature, or PR being reviewed}}
**Review Type:** {{Design Review / Code Review / Pre-launch Review / Post-incident Review}}

---

## Scope

{{1-3 sentences: what is being reviewed and why}}

**Artifacts reviewed:**
- [ ] Architecture diagram / design doc
- [ ] Code (PR / repository)
- [ ] Infrastructure as Code (Terraform / CloudFormation / Bicep)
- [ ] API specification (OpenAPI / AsyncAPI)
- [ ] Configuration files

---

## STRIDE Threat Model

### System Decomposition

| Component | Type | Trust Level | Description |
|---|---|---|---|
| {{Component 1}} | Service / DB / Queue / UI | Trusted / Untrusted / Semi-trusted | {{What it does}} |
| {{Component 2}} | | | |

### Data Flows and Trust Boundaries

| Flow | From | To | Data | Protocol | Trust Boundary? |
|---|---|---|---|---|---|
| DF-01 | {{Source}} | {{Destination}} | {{Data type}} | {{Protocol}} | {{Yes/No}} |

### STRIDE Threat Table

| ID | Category | Threat | Likelihood | Impact | Mitigation | Status | Framework Ref |
|---|---|---|---|---|---|---|---|
| T-01 | Spoofing | {{Threat description}} | High/Med/Low | Critical/High/Med/Low | {{Mitigation}} | Open/Mitigated | {{OWASP A07, NIST PR.AA}} |
| T-02 | Tampering | | | | | | |
| T-03 | Repudiation | | | | | | |
| T-04 | Information Disclosure | | | | | | |
| T-05 | Denial of Service | | | | | | |
| T-06 | Elevation of Privilege | | | | | | |

**Open threats:** {{Count}} — see Findings section for details.

---

## Security Findings

| ID | Severity | Finding | STRIDE Category | Framework Ref | Remediation |
|---|---|---|---|---|---|
| SR-001 | 🔴 Critical | {{Finding}} | {{S/T/R/I/D/E}} | {{OWASP A01:2021}} | {{Remediation}} |
| SR-002 | 🟠 High | {{Finding}} | | | |
| SR-003 | 🟡 Medium | {{Finding}} | | | |

### Finding Details

**SR-001 — {{Title}}**

- **Severity:** Critical
- **Description:** {{Full description}}
- **Location:** {{file:line or component name}}
- **Evidence:** {{Code snippet, config, test result}}
- **Impact:** {{What an attacker can do}}
- **CVSS 4.0 Vector:** {{AV:N/AC:L/AT:N/PR:N/UI:N/VC:H/VI:H/VA:H/SC:N/SI:N/SA:N}}
- **Framework References:** {{OWASP A01:2021, NIST CSF PR.AA-1, ISO 27001 A.5.15}}
- **Remediation:**
  1. {{Step 1 — specific and actionable}}
  2. {{Step 2}}
  3. **Verify:** {{How to confirm the fix}}
- **Status:** Open

---

## Security Controls Check

### Authentication and Authorization
- [ ] All endpoints require authentication (no unauthenticated access to non-public data)
- [ ] Authorization checked server-side on every request (not just at login)
- [ ] No privilege escalation possible (tested: can user A access user B's data?)
- [ ] Token expiry appropriate: access token ≤ 15min, refresh token ≤ 24h
- [ ] MFA enforced for privileged operations

### Input Handling
- [ ] All user inputs validated on server side (allowlist, not blocklist where possible)
- [ ] Parameterized queries for all database calls (no string concatenation)
- [ ] Output encoded for rendering context (HTML, JS, URL, CSS)
- [ ] File upload: type validated, content scanned, size limited, stored outside webroot
- [ ] Request size limits enforced

### Cryptography
- [ ] No deprecated algorithms (MD5, SHA1, DES, RC4, RSA < 2048)
- [ ] TLS 1.3 (minimum 1.2) for all connections
- [ ] Secrets not hardcoded in source, environment variables, or container images
- [ ] Passwords hashed with bcrypt/Argon2/scrypt (cost factor appropriate)
- [ ] Encryption keys managed via KMS / Key Vault / Secrets Manager

### Error Handling and Logging
- [ ] Errors: generic messages to user; details logged server-side only
- [ ] No stack traces, SQL errors, or system paths in API responses
- [ ] Authentication failures logged with: IP, timestamp, username attempt
- [ ] Sensitive data (passwords, tokens, PII, card numbers) not in logs
- [ ] Audit trail for: access to sensitive data, privilege changes, config changes

### API Security
- [ ] HTTP methods enforced (GET ≠ POST for state-changing operations)
- [ ] CORS policy restricts allowed origins (not `*`)
- [ ] Rate limiting on authentication endpoints (max 10/min)
- [ ] Rate limiting on API endpoints (appropriate to use case)
- [ ] HTTP security headers: CSP, HSTS, X-Frame-Options, X-Content-Type-Options
- [ ] OpenAPI spec present and accurate (if REST API)
- [ ] Auth scheme documented in spec (not "to be added later")

### Infrastructure / IaC
- [ ] No hardcoded credentials in IaC files
- [ ] Resources use private networking (no unnecessary public IPs)
- [ ] Security groups / NSGs: deny-all default
- [ ] Encryption at rest enabled on all storage resources
- [ ] Logging enabled on all security-relevant services
- [ ] IAM roles: least privilege (no `*:*` permissions)

---

## Zero Trust Compliance Check

| Principle | Status | Notes |
|---|---|---|
| Every connection authenticated | ✅ / ❌ / ⚠️ | |
| Least privilege access | | |
| Per-session authorization (not session-wide) | | |
| Encrypted in transit (internal + external) | | |
| Access logged for all sensitive resources | | |
| Device/workload identity verified | | |

---

## Decision

| Outcome | Notes |
|---|---|
| ✅ Approved | No critical or high findings; proceed |
| ⚠️ Approved with conditions | Merge/deploy after resolving: {{finding IDs}} |
| ❌ Rejected | Critical findings must be resolved and re-reviewed |

**Decision:** {{Choose one and remove others}}

**Required before merge/deploy:**
- [ ] {{Finding SR-001 resolved}}
- [ ] {{Finding SR-002 resolved}}

---

*Generated by architect:validate agent | Frameworks: STRIDE, OWASP ASVS 4.0, NIST SP 800-207, CVSS 4.0*
