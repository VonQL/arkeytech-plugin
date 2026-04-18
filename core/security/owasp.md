# OWASP Reference

## OWASP Top 10 (2021)

**Source:** owasp.org/Top10 | **Version:** 2021 (current stable as of 2025; next update in progress)

### Quick Reference

| ID | Risk | Description | Primary Control |
|---|---|---|---|
| A01 | Broken Access Control | Users act outside intended permissions | RBAC/ABAC, deny-by-default, test all roles |
| A02 | Cryptographic Failures | Weak/missing encryption for sensitive data | TLS 1.3, AES-256, no MD5/SHA1, no hardcoded secrets |
| A03 | Injection | Untrusted data sent to interpreter | Parameterized queries, input validation, ORM |
| A04 | Insecure Design | Missing or ineffective security controls in design | Threat modeling, secure design patterns, security requirements |
| A05 | Security Misconfiguration | Insecure defaults, unnecessary features enabled | Hardening, CIS Benchmarks, config review in CI |
| A06 | Vulnerable & Outdated Components | Using components with known vulnerabilities | SCA scanning, SBOM, automated dependency updates |
| A07 | Identification & Auth Failures | Weak authentication, credential exposure | MFA, strong passwords, secure session management |
| A08 | Software & Data Integrity Failures | Code/data not verified for integrity | CI/CD integrity, signed artifacts, update verification |
| A09 | Security Logging & Monitoring Failures | Insufficient logging to detect/respond | Audit logs, SIEM, alerting, IR process |
| A10 | SSRF | Server makes requests to unintended destinations | Allowlist outbound URLs, network egress controls |

---

## Detailed Controls per Risk

### A01: Broken Access Control

**Root causes:** Bypassing access checks via URL manipulation, elevation of privilege, CORS misconfiguration, force browsing to authenticated pages.

**Controls:**
- [ ] Deny access by default — require explicit grants
- [ ] Implement access control server-side (never trust client-side)
- [ ] Log access control failures, alert on repeated failures
- [ ] Invalidate tokens/sessions on logout
- [ ] Test access control in CI: verify each role cannot access other roles' data
- [ ] Rate limit API endpoints to minimize brute-force enumeration
- [ ] Disable directory listing on web servers

**Testing:** Attempt to access another user's resources by manipulating user ID in URL/body. Attempt to access admin routes without admin role.

### A02: Cryptographic Failures

**Root causes:** Transmitting sensitive data in cleartext, using deprecated algorithms (MD5, SHA1, DES, RC4), improper key management.

**Controls:**
- [ ] Classify all data: what is sensitive? (PII, financial, health, credentials)
- [ ] Encrypt all sensitive data at rest (AES-256)
- [ ] Enforce TLS 1.3 (minimum TLS 1.2); disable older versions
- [ ] No sensitive data in URLs (query strings logged in server logs)
- [ ] Hash passwords with bcrypt, Argon2, or scrypt (never MD5, SHA1, SHA256 unsalted)
- [ ] Use proper random number generators (cryptographically secure)
- [ ] No hardcoded secrets in source code (scan with secrets detection in CI)
- [ ] Certificate pinning for mobile apps accessing sensitive APIs

### A03: Injection

**Root causes:** SQL injection, LDAP injection, OS command injection, template injection, XSS (HTML injection).

**Controls:**
- [ ] Use parameterized queries / prepared statements — never string concatenation
- [ ] Use an ORM with parameterized queries
- [ ] Validate and sanitize all user inputs on the server side
- [ ] Use allowlist input validation (not blocklist)
- [ ] Escape output based on context (HTML, SQL, JS, URL, CSS)
- [ ] Use CSP headers to mitigate XSS impact
- [ ] LIMIT SQL query results to prevent mass data extraction
- [ ] Use stored procedures only if they don't concatenate inputs

### A04: Insecure Design

**Root causes:** No threat modeling, missing security requirements, no secure design patterns applied.

**Controls:**
- [ ] Threat model every feature with security impact (use STRIDE)
- [ ] Define security requirements alongside functional requirements
- [ ] Apply security design patterns: defense in depth, least privilege, fail securely
- [ ] Use secure reference architectures as starting point
- [ ] Limit resource consumption by design (rate limits, quotas)
- [ ] Separate privileged operations from normal user flows

### A05: Security Misconfiguration

**Root causes:** Insecure defaults, unnecessary features enabled, default credentials, overly verbose error messages, missing security headers.

**Controls:**
- [ ] Hardening process for all environments (use CIS Benchmarks)
- [ ] Remove/disable all unnecessary features, ports, services
- [ ] Change all default credentials immediately
- [ ] Review and tighten cloud IAM permissions quarterly
- [ ] HTTP security headers: `Content-Security-Policy`, `X-Frame-Options`, `X-Content-Type-Options`, `Strict-Transport-Security`, `Referrer-Policy`
- [ ] Disable detailed error messages in production
- [ ] Automated config scanning in CI/CD pipeline
- [ ] Different credentials per environment (no shared prod/staging credentials)

### A06: Vulnerable & Outdated Components

**Root causes:** Unknown component inventory, no patch process, using unmaintained libraries.

**Controls:**
- [ ] Maintain Software Bill of Materials (SBOM)
- [ ] Automated dependency scanning in CI (Dependabot, Snyk, OWASP Dependency-Check)
- [ ] Subscribe to CVE notifications for critical dependencies
- [ ] Remove unused dependencies
- [ ] Only obtain components from official sources over HTTPS
- [ ] Patch Critical CVEs within 24h, High within 7 days
- [ ] Monitor for end-of-life runtimes (Node.js, Python, Java)

### A07: Identification and Authentication Failures

**Root causes:** Weak passwords, no MFA, credential stuffing, exposed session tokens, insecure password reset.

**Controls:**
- [ ] Enforce MFA for all users (mandatory for privileged users)
- [ ] Minimum password length 12 characters; check against known-breached passwords (HaveIBeenPwned API)
- [ ] No default credentials
- [ ] Limit/lockout failed login attempts (10 attempts → 30min lockout)
- [ ] Use secure, random session IDs (min 128 bits)
- [ ] Invalidate session on logout, timeout, and privilege change
- [ ] Secure password reset: time-limited (15min), one-time tokens, verify identity first
- [ ] Don't expose user enumeration (same error for invalid user vs. wrong password)

### A08: Software and Data Integrity Failures

**Root causes:** Unsigned updates, insecure deserialization, unverified CI/CD pipelines, untrusted CDNs.

**Controls:**
- [ ] Sign all artifacts (containers, binaries, packages)
- [ ] Verify signatures before deployment (Binary Authorization, Sigstore)
- [ ] Protect CI/CD pipeline: minimal permissions, audit logs, branch protection
- [ ] Use Subresource Integrity (SRI) for external scripts/stylesheets
- [ ] Don't deserialize data from untrusted sources without validation
- [ ] SBOM for all deployable artifacts
- [ ] Pin dependency versions; use lockfiles

### A09: Security Logging and Monitoring Failures

**Root causes:** No logging, logs not monitored, logs tampered, no incident response process.

**Controls:**
- [ ] Log all authentication events (success and failure)
- [ ] Log all access control failures
- [ ] Log all input validation failures (potential attack signals)
- [ ] Log with: timestamp, user ID, IP, action, outcome — no sensitive data (no passwords, tokens, PII)
- [ ] Protect logs from tampering (append-only, offsite copy)
- [ ] Alert on: repeated auth failures, access control violations, high error rates
- [ ] Incident response plan defined and tested
- [ ] Mean Time to Detect (MTTD) target: < 1 hour for critical events
- [ ] Log retention: minimum 90 days accessible, 1 year archived

### A10: Server-Side Request Forgery (SSRF)

**Root causes:** Application fetches remote resources based on user-supplied URL without validation.

**Controls:**
- [ ] Validate and sanitize all URLs before fetching
- [ ] Use allowlist of permitted domains/IPs for outbound requests
- [ ] Disable HTTP redirections for user-supplied URLs
- [ ] Block requests to internal IPs (RFC 1918: 10.x, 172.16.x, 192.168.x), loopback (127.0.0.1), metadata endpoints (169.254.169.254)
- [ ] Don't send raw error responses to clients when URL fetch fails
- [ ] Enforce egress firewall rules at network level

---

## OWASP ASVS 4.0 — Application Security Verification Standard

**Source:** owasp.org/ASVS | **Version:** 4.0 (5.0 in development)

### Assurance Levels

| Level | Name | Use Case |
|---|---|---|
| L1 | Opportunistic | All applications — minimum baseline |
| L2 | Standard | Applications handling sensitive data — recommended default |
| L3 | Advanced | High-value applications: banking, healthcare, critical infrastructure |

### Key ASVS Chapters and L2 Requirements (Abbreviated)

#### V2: Authentication
- [ ] L2: Passwords ≥ 12 chars; check against breached password list
- [ ] L2: MFA available for all users; mandatory for admins
- [ ] L2: Brute-force lockout (max 10 failed attempts)
- [ ] L2: Secure credential recovery (time-limited token, identity verified)
- [ ] L2: Re-authenticate before sensitive operations (password change, payment)

#### V3: Session Management
- [ ] L2: Session tokens are cryptographically random, ≥ 128 bits
- [ ] L2: Session invalidated on logout
- [ ] L2: Session timeout: 30 min idle, 8 hours absolute
- [ ] L2: New session token issued on login (prevent session fixation)

#### V4: Access Control
- [ ] L2: All endpoints enforce authorization — no endpoint is "open by default"
- [ ] L2: Vertical privilege escalation tested and prevented
- [ ] L2: Horizontal privilege escalation tested and prevented (can't access other users' data)
- [ ] L2: Directory traversal attacks mitigated

#### V5: Validation, Sanitization, Encoding
- [ ] L2: All inputs validated on server side (not just client side)
- [ ] L2: Allowlist input validation where possible
- [ ] L2: Output encoding context-appropriate (HTML, URL, JS, CSS)
- [ ] L2: Parameterized queries for all database calls

#### V6: Cryptography
- [ ] L2: No weak algorithms (MD5, SHA1, DES, RC4, RSA < 2048 bits)
- [ ] L2: Cryptographically secure random number generation
- [ ] L2: No hardcoded keys or passwords in source code

#### V7: Error Handling and Logging
- [ ] L2: No sensitive data in logs (passwords, tokens, PII)
- [ ] L2: Error messages don't expose stack traces or system internals to users
- [ ] L2: All auth and access control failures logged
- [ ] L2: Logs protected from unauthorized access and tampering

#### V8: Data Protection
- [ ] L2: Sensitive data not in HTTP GET parameters
- [ ] L2: Sensitive data not cached on client
- [ ] L2: All sensitive data encrypted at rest
- [ ] L2: No sensitive data in memory longer than needed

#### V9: Communications
- [ ] L2: TLS used for all connections handling sensitive data
- [ ] L2: TLS 1.2 minimum (TLS 1.3 preferred)
- [ ] L2: Certificate validity checked; invalid certificates fail closed

#### V10: Malicious Code
- [ ] L2: Source code scanned for backdoors and malicious code
- [ ] L2: All third-party components reviewed for unexpected behavior

#### V11: Business Logic
- [ ] L2: Business logic flows enforce expected sequence (anti-TOCTOU)
- [ ] L2: Rate limits on high-value business functions (purchases, transfers)

#### V13: API and Web Service
- [ ] L2: REST APIs: HTTP method enforcement (GET ≠ POST ≠ DELETE)
- [ ] L2: Input validated for all API parameters
- [ ] L2: API versioning enforced; deprecated versions removed

---

## Agent Instructions: OWASP

1. **L2 is the default** — apply ASVS Level 2 for all systems unless they are explicitly low-risk.
2. **Apply L3** for: payment processing, healthcare, financial services, critical infrastructure.
3. **Map every finding to an OWASP reference** — use both Top 10 ID (A01–A10) and ASVS chapter (V2–V13).
4. **Never accept "we'll add it later"** for A01 (Access Control) or A02 (Cryptography) — these are foundational.
5. **Scan in CI** — SAST, SCA, secrets detection must be automated; don't rely on manual review alone.
