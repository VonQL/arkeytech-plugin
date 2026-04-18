# NIST Security Frameworks Reference

## NIST Cybersecurity Framework (CSF) 2.0

**Source:** NIST | nist.gov/cyberframework | **Version:** 2.0 (February 2024)
**Document:** NIST CSWP 29

CSF 2.0 added a sixth function — **Govern** — as an overarching organizational layer. The framework is technology- and sector-agnostic.

### The Six Core Functions

```
                    ┌─────────────────────────────────────────────────────┐
                    │                    GOVERN                           │
                    │  (Risk strategy, policies, roles, accountability)   │
                    └─────────────────────────────────────────────────────┘
              ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
              │ IDENTIFY │  │ PROTECT  │  │  DETECT  │  │ RESPOND  │  │ RECOVER  │
              └──────────┘  └──────────┘  └──────────┘  └──────────┘  └──────────┘
```

### Function 1: GOVERN (GV)

New in CSF 2.0. Establishes cybersecurity risk management strategy, expectations, and policy.

| Category | Description | Key Practices |
|---|---|---|
| GV.OC: Organizational Context | Understand organizational mission and risk environment | Document risk appetite, regulatory requirements, stakeholder expectations |
| GV.RM: Risk Management Strategy | Define and communicate cybersecurity risk priorities | Risk tolerance defined, risk register maintained |
| GV.RR: Roles & Responsibilities | Assign cybersecurity roles and accountabilities | CISO/security owner designated, RACI documented |
| GV.PO: Policy | Establish cybersecurity policies aligned with strategy | Written policies for access, data handling, incident response |
| GV.OV: Oversight | Conduct reviews to ensure risk management is effective | Quarterly risk reviews, board reporting on cyber risk |
| GV.SC: Cybersecurity Supply Chain | Manage supply chain risks | Third-party risk assessments, vendor security requirements |

### Function 2: IDENTIFY (ID)

| Category | Description | Key Practices |
|---|---|---|
| ID.AM: Asset Management | Inventory of all assets (hardware, software, data, people) | CMDB maintained, cloud asset inventory automated |
| ID.RA: Risk Assessment | Identify and prioritize risks to assets | Annual risk assessment, threat intelligence integrated |
| ID.IM: Improvement | Identify improvements to cybersecurity posture | Post-incident improvements tracked, security metrics reviewed |

### Function 3: PROTECT (PR)

| Category | Description | Key Practices |
|---|---|---|
| PR.AA: Identity Management & Auth | Manage identities, credentials, access | IAM, MFA, least privilege, PAM for privileged access |
| PR.AT: Awareness & Training | Security awareness and training | Annual security training, phishing simulations |
| PR.DS: Data Security | Protect data at rest and in transit | Encryption (AES-256, TLS 1.3), DLP, data classification |
| PR.PS: Platform Security | Secure configuration of platforms | Hardening (CIS Benchmarks), patch management, SBOM |
| PR.IR: Technology Infrastructure Resilience | Protect infrastructure against disruption | Backups, redundancy, DR tested |

### Function 4: DETECT (DE)

| Category | Description | Key Practices |
|---|---|---|
| DE.CM: Continuous Monitoring | Monitor assets and environment for anomalies | SIEM, IDS/IPS, EDR, cloud-native threat detection |
| DE.AE: Adverse Event Analysis | Analyze anomalies to detect incidents | Alert correlation, threat hunting, behavioral analytics |

### Function 5: RESPOND (RS)

| Category | Description | Key Practices |
|---|---|---|
| RS.MA: Incident Management | Execute and maintain incident response | IR plan documented, tested annually, retainer in place |
| RS.AN: Incident Analysis | Investigate incidents to understand scope | Forensic capability, root cause analysis |
| RS.CO: Incident Response Reporting & Communication | Coordinate response activities | Escalation paths, customer notification procedures, regulator notification |
| RS.MI: Incident Mitigation | Contain and mitigate incidents | Containment playbooks, isolation procedures |

### Function 6: RECOVER (RC)

| Category | Description | Key Practices |
|---|---|---|
| RC.RP: Incident Recovery Plan | Execute recovery plans after incidents | RTO/RPO defined, recovery runbooks tested |
| RC.CO: Incident Recovery Communication | Coordinate restoration with stakeholders | Status page, customer comms, post-incident report |

---

## CSF 2.0 Assessment Checklist

Use for self-assessment or architecture review:

```markdown
## CSF 2.0 Assessment: [System/Organization Name]

**Date:** YYYY-MM-DD | **Scope:** [system or org-wide]

### GOVERN
- [ ] GV.OC: Cybersecurity risk appetite documented and approved by leadership
- [ ] GV.RM: Risk register maintained and reviewed quarterly
- [ ] GV.RR: Security owner (CISO/equivalent) designated with authority and budget
- [ ] GV.PO: Written security policies exist for: access control, data handling, incident response, acceptable use
- [ ] GV.OV: Board/leadership receives cybersecurity risk reports at least annually
- [ ] GV.SC: Third-party/vendor security requirements defined and assessed annually

### IDENTIFY
- [ ] ID.AM: Complete asset inventory maintained (hardware, software, cloud, data)
- [ ] ID.AM: Data classification scheme applied to all data assets
- [ ] ID.RA: Annual risk assessment completed, findings tracked
- [ ] ID.RA: Threat intelligence feeds integrated into risk assessment

### PROTECT
- [ ] PR.AA: MFA enforced for all users; hardware tokens for privileged access
- [ ] PR.AA: Least privilege enforced; access reviewed quarterly
- [ ] PR.AT: Annual security awareness training completed by all staff
- [ ] PR.DS: All sensitive data encrypted at rest (AES-256) and in transit (TLS 1.3)
- [ ] PR.PS: CIS Benchmark hardening applied to all production systems
- [ ] PR.PS: Patch management: Critical patches within 24h, High within 7 days
- [ ] PR.IR: Automated backups tested monthly; DR tested annually

### DETECT
- [ ] DE.CM: SIEM deployed and receiving logs from all critical systems
- [ ] DE.CM: EDR deployed on all endpoints and servers
- [ ] DE.CM: Cloud-native threat detection enabled (GuardDuty/Defender/SCC)
- [ ] DE.AE: Alert triage process defined; on-call rotation established
- [ ] DE.AE: Mean Time to Detect (MTTD) target defined and measured

### RESPOND
- [ ] RS.MA: Incident Response Plan documented and approved
- [ ] RS.MA: IR plan tested via tabletop exercise in past 12 months
- [ ] RS.CO: Customer breach notification procedure defined (72h GDPR requirement)
- [ ] RS.CO: Regulatory notification procedure defined
- [ ] RS.MI: Containment playbooks for: malware, data breach, DDoS, insider threat

### RECOVER
- [ ] RC.RP: RTO/RPO defined for all critical systems
- [ ] RC.RP: Recovery runbooks tested in past 12 months
- [ ] RC.CO: Post-incident review (PIR) process defined; PIRs completed within 5 days
```

---

## NIST SP 800-53 Rev 5 — Security and Privacy Controls

**Source:** nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf
**Use:** Federal systems (mandatory FedRAMP), also widely adopted in enterprise

### Control Families (20 families)

| ID | Family | Key Controls |
|---|---|---|
| AC | Access Control | AC-2 (Account management), AC-3 (Access enforcement), AC-6 (Least privilege), AC-17 (Remote access) |
| AT | Awareness & Training | AT-2 (Security awareness), AT-3 (Role-based training) |
| AU | Audit & Accountability | AU-2 (Event logging), AU-9 (Protection of audit info), AU-12 (Audit record generation) |
| CA | Assessment, Authorization | CA-7 (Continuous monitoring), CA-8 (Penetration testing) |
| CM | Configuration Management | CM-2 (Baseline configuration), CM-6 (Config settings), CM-7 (Least functionality) |
| CP | Contingency Planning | CP-2 (Contingency plan), CP-9 (System backup), CP-10 (System recovery) |
| IA | Identification & Auth | IA-2 (ID and auth for users), IA-5 (Authenticator management), IA-8 (Non-org users) |
| IR | Incident Response | IR-4 (Incident handling), IR-5 (Incident monitoring), IR-6 (Incident reporting) |
| MA | Maintenance | MA-2 (Controlled maintenance), MA-5 (Maintenance personnel) |
| MP | Media Protection | MP-2 (Media access), MP-6 (Media sanitization), MP-7 (Media use) |
| PE | Physical & Environmental | PE-2 (Physical access authorizations), PE-6 (Monitoring physical access) |
| PL | Planning | PL-2 (System security plan), PL-8 (Security and privacy architecture) |
| PM | Program Management | PM-9 (Risk management strategy), PM-28 (Risk framing) |
| PS | Personnel Security | PS-3 (Personnel screening), PS-4 (Personnel termination) |
| PT | PII Processing & Transparency | PT-1 (Policy), PT-2 (Authority to process PII) |
| RA | Risk Assessment | RA-3 (Risk assessment), RA-5 (Vulnerability monitoring and scanning) |
| SA | System & Services Acquisition | SA-11 (Developer testing), SA-15 (Development process) |
| SC | System & Communications | SC-5 (DoS protection), SC-7 (Boundary protection), SC-8 (Transmission confidentiality), SC-28 (Protection at rest) |
| SI | System & Info Integrity | SI-2 (Flaw remediation), SI-3 (Malicious code protection), SI-7 (Software integrity) |
| SR | Supply Chain Risk | SR-3 (Supply chain controls), SR-11 (Component authenticity) |

### Key Controls Checklist (Baseline)

```markdown
## NIST 800-53 Rev 5 — Baseline Controls Check

### Access Control (AC)
- [ ] AC-2: User accounts managed (provisioning, review, deprovisioning process)
- [ ] AC-3: Access enforcement — least privilege applied to all roles
- [ ] AC-6: Least privilege — no shared accounts, no standing privileged access
- [ ] AC-17: Remote access secured (VPN + MFA or Zero Trust Network Access)

### Audit & Accountability (AU)
- [ ] AU-2: Events logged: auth, privilege changes, failed access, data access
- [ ] AU-9: Audit logs protected from modification and unauthorized access
- [ ] AU-12: All systems generate audit records for defined events

### Configuration Management (CM)
- [ ] CM-2: Baseline configuration documented for all system components
- [ ] CM-6: Security configuration settings enforced and monitored
- [ ] CM-7: Least functionality — all unused ports, protocols, services disabled

### Identification & Authentication (IA)
- [ ] IA-2: MFA enforced for all users accessing the system
- [ ] IA-5: Passwords meet complexity, length, and rotation requirements
- [ ] IA-8: Non-organizational users (contractors, partners) authenticated

### System & Communications Protection (SC)
- [ ] SC-5: DoS protection — rate limiting, WAF, DDoS mitigation service
- [ ] SC-7: Boundary protection — firewall, security groups, network segmentation
- [ ] SC-8: Transmission confidentiality — TLS 1.3 for all data in transit
- [ ] SC-28: Protection at rest — encryption for all sensitive data stores

### System & Information Integrity (SI)
- [ ] SI-2: Vulnerability scanning and patch process in place
- [ ] SI-3: Anti-malware deployed on all endpoints and servers
- [ ] SI-7: Software, firmware integrity verified before use
```

---

## NIST SP 800-207 — Zero Trust Architecture

**Source:** nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-207.pdf
**Version:** 1.0

### Zero Trust Tenets (7 Principles)

1. **All data sources and computing services are resources** — devices not owned by the enterprise can be resources
2. **All communication is secured regardless of network location** — no trusted network; internal network ≠ safe
3. **Access to resources is granted per-session** — trust must be established before access is granted each time
4. **Access is determined by dynamic policy** — based on identity, device health, behavior, and other attributes
5. **The enterprise monitors and measures integrity and security posture of all owned and associated assets** — continuous monitoring
6. **Authentication and authorization are dynamic and strictly enforced** — constantly re-evaluated
7. **The enterprise collects as much information as possible about assets, network infrastructure, and communication** — used to improve security posture

### Zero Trust Architecture Checklist

```markdown
## Zero Trust Architecture Assessment

### Identity-Centric Controls
- [ ] Every user and service has a unique identity (no shared accounts)
- [ ] MFA enforced for all human users
- [ ] Workload identity for service-to-service auth (mTLS, SPIFFE/SPIRE, or IAM roles)
- [ ] Just-in-time (JIT) privileged access — no standing admin access
- [ ] Continuous identity risk assessment (anomaly detection on auth patterns)

### Device Health
- [ ] Device posture checked before granting access (MDM enrollment, patch level)
- [ ] Unmanaged/BYOD devices restricted to limited access or isolated environment
- [ ] Certificate-based device authentication where possible

### Network Segmentation
- [ ] Microsegmentation applied — no flat internal network
- [ ] East-west traffic inspected and controlled (not just north-south)
- [ ] Explicit deny-all default: traffic only permitted by explicit rule
- [ ] Private endpoints for cloud services (no public exposure of internal APIs)

### Application Access
- [ ] Applications verify identity at the application layer (not just network)
- [ ] Per-request authorization (not session-wide trust after login)
- [ ] mTLS between all internal services
- [ ] API gateway enforces authentication and authorization before routing

### Data
- [ ] Data classification applied to all data assets
- [ ] Access to data logged with: who, when, what, from where
- [ ] DLP controls prevent sensitive data exfiltration
- [ ] Encryption keys managed separately from encrypted data

### Monitoring & Analytics
- [ ] All traffic logged (network flows + application logs)
- [ ] UEBA (User & Entity Behavior Analytics) for anomaly detection
- [ ] Security events correlated in SIEM
- [ ] Automated response playbooks for common threat patterns
```

---

## Agent Instructions: NIST Frameworks

1. **CSF 2.0 is the enterprise default** — use for organizational security posture assessment.
2. **SP 800-53** applies to: government systems, FedRAMP, or enterprise environments requiring formal control catalogs.
3. **Zero Trust (SP 800-207)** applies to every system — flag any design that assumes internal network trust.
4. **Map NIST controls to other frameworks** when relevant: CSF PR.DS-1 ↔ OWASP A02 ↔ ISO 27001 A.8.24.
5. **Govern first** — before designing technical controls, verify GV.OC (risk appetite) and GV.RR (ownership) are defined.
6. **Never design a system without defining:** RTO/RPO (RC.RP), incident response owner (RS.MA), and logging (DE.CM).
