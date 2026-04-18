# Validation Report Template

<!-- Agent: Complete all sections. Severity: Critical / High / Medium / Low / Informational -->
<!-- Every finding MUST have: framework reference + remediation path -->

---

# Technical Validation Report: {{SYSTEM_NAME}}

**Date:** {{DATE}}
**Reviewer:** {{REVIEWER}}
**Scope:** {{SCOPE — e.g., "API layer security", "Full system", "IaC review"}}
**Applicable Frameworks:** {{list all: OWASP, NIST CSF 2.0, CIS, ISO 27001, PCI-DSS, HIPAA, SOC 2}}

---

## Executive Summary

{{3-5 sentences: overall security posture, critical findings count, highest risks, recommended immediate actions}}

### Summary Scores

| Domain | Score | Status |
|---|---|---|
| Application Security (OWASP ASVS) | {{0-100}} | 🔴 Critical / 🟠 High / 🟡 Medium / 🟢 Low Risk |
| Enterprise Security Posture (NIST CSF 2.0) | {{0-100}} | |
| Infrastructure Hardening (CIS) | {{0-100}} | |
| Compliance Readiness | {{0-100}} | |

### Finding Counts by Severity

| Severity | Count | Blockers? |
|---|---|---|
| 🔴 Critical | {{N}} | Yes — must resolve before go-live |
| 🟠 High | {{N}} | Recommended before go-live |
| 🟡 Medium | {{N}} | Resolve within 30 days |
| 🟢 Low | {{N}} | Resolve within 90 days |
| ℹ️ Informational | {{N}} | Advisory only |

---

## Findings

### Critical Findings

| ID | Finding | Affected Component | Framework Ref | Remediation |
|---|---|---|---|---|
| V-001 | {{Finding description}} | {{Component}} | {{e.g., OWASP A01, NIST PR.AA}} | {{Specific remediation steps}} |

**Detail — V-001:**
- **Description:** {{Full description of the vulnerability or gap}}
- **Evidence:** {{What was observed — config, code snippet, test result}}
- **Impact:** {{What an attacker could do, or what compliance gap this creates}}
- **Remediation:**
  1. {{Step 1}}
  2. {{Step 2}}
  3. {{Validation: how to verify the fix}}
- **Framework References:** {{OWASP A01:2021, NIST CSF PR.AA-1, ISO 27001 A.8.2}}

---

### High Findings

| ID | Finding | Affected Component | Framework Ref | Remediation |
|---|---|---|---|---|
| V-002 | {{Finding description}} | {{Component}} | {{Framework ref}} | {{Remediation}} |

**Detail — V-002:**
- **Description:** {{Full description}}
- **Evidence:** {{Evidence}}
- **Impact:** {{Impact}}
- **Remediation:**
  1. {{Step 1}}
  2. {{Step 2}}
- **Framework References:** {{refs}}

---

### Medium Findings

| ID | Finding | Affected Component | Framework Ref | Remediation |
|---|---|---|---|---|
| V-003 | {{Finding description}} | {{Component}} | {{Framework ref}} | {{Remediation}} |

---

### Low Findings

| ID | Finding | Affected Component | Framework Ref | Remediation |
|---|---|---|---|---|
| V-004 | {{Finding description}} | {{Component}} | {{Framework ref}} | {{Remediation}} |

---

### Informational

| ID | Observation | Notes |
|---|---|---|
| V-005 | {{Observation}} | {{Context or recommendation}} |

---

## Security Checklist Results

### OWASP ASVS {{LEVEL}} Checklist

| Ref | Requirement | Status | Notes |
|---|---|---|---|
| V2.1 | Passwords ≥ 12 characters | ✅ Pass / ❌ Fail / ⚠️ Partial | {{Notes}} |
| V2.2 | MFA available for all users | | |
| V3.1 | Session tokens cryptographically random ≥ 128 bits | | |
| V4.1 | All endpoints enforce authorization | | |
| V5.1 | All inputs validated server-side | | |
| V6.1 | No weak cryptographic algorithms | | |
| V7.1 | No sensitive data in logs | | |
| V9.1 | TLS used for all sensitive connections | | |
| V13.1 | REST API: HTTP method enforcement | | |

### NIST CSF 2.0 Checklist

| Function | Category | Status | Gap |
|---|---|---|---|
| GOVERN | GV.OC: Risk appetite documented | ✅ / ❌ / ⚠️ | {{Gap description}} |
| GOVERN | GV.RM: Risk register maintained | | |
| IDENTIFY | ID.AM: Asset inventory complete | | |
| PROTECT | PR.AA: MFA enforced | | |
| PROTECT | PR.DS: Data encrypted at rest and in transit | | |
| PROTECT | PR.PS: CIS hardening applied | | |
| DETECT | DE.CM: SIEM deployed | | |
| RESPOND | RS.MA: IR plan tested | | |
| RECOVER | RC.RP: RTO/RPO defined and tested | | |

### CIS Benchmark Checklist ({{CLOUD_PROVIDER}})

| Control | Description | Status | Notes |
|---|---|---|---|
| {{CIS_REF}} | {{Description}} | ✅ / ❌ / ⚠️ / N/A | {{Notes}} |

---

## Compliance Gap Analysis

### Applicable Regulations Detected

{{List detected regulations and detection signals}}

### Gap Table

| ID | Regulation | Control Ref | Gap Description | Severity | Remediation | Target |
|---|---|---|---|---|---|---|
| CF-001 | {{ISO 27001}} | {{8.5}} | {{MFA not enforced}} | Critical | {{Enable MFA}} | {{Date}} |
| CF-002 | {{PCI-DSS}} | {{Req 3.5}} | {{PAN stored unencrypted}} | Critical | {{Encrypt/tokenize PAN}} | {{Date}} |

---

## Well-Architected Review ({{CLOUD}})

| Pillar | Score | Key Findings |
|---|---|---|
| Security | {{0-100}} | {{Key gaps}} |
| Reliability | {{0-100}} | {{Key gaps}} |
| Operational Excellence | {{0-100}} | {{Key gaps}} |
| Performance Efficiency | {{0-100}} | {{Key gaps}} |
| Cost Optimization | {{0-100}} | {{Key gaps}} |
| Sustainability | {{0-100}} | {{Key gaps}} |

---

## Remediation Roadmap

| Priority | Finding ID | Action | Owner | Target Date | Effort |
|---|---|---|---|---|---|
| 1 | V-001 | {{Action}} | {{Owner}} | {{Date}} | {{S/M/L}} |
| 2 | V-002 | {{Action}} | {{Owner}} | {{Date}} | {{S/M/L}} |

---

## Validation Sign-off

| Role | Name | Date | Decision |
|---|---|---|---|
| Architect | | | ✅ Approved / ❌ Requires remediation |
| Security Lead | | | |
| Engineering Lead | | | |

**Decision:** {{Approved for production / Approved pending remediation of Critical findings / Rejected — remediate and re-review}}

---

*Generated by architect:validate agent | Frameworks: OWASP ASVS 4.0, NIST CSF 2.0, NIST SP 800-207, CIS Benchmarks, ISO 27001:2022, SOC 2, PCI-DSS 4.0.1, HIPAA*
