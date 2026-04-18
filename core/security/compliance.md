# Compliance Frameworks Reference

## Auto-Detection Signals

The validation agent uses these signals to identify applicable compliance frameworks:

| Signal Keywords | Framework Triggered |
|---|---|
| "payments", "cardholder", "credit card", "debit card", "PCI", "merchant", "acquiring bank" | PCI-DSS 4.0.1 |
| "health", "PHI", "patient", "medical", "clinical", "HIPAA", "healthcare", "EHR", "EMR" | HIPAA Security Rule |
| "ISO 27001", "ISMS", "certification", "audit", "27001" | ISO 27001:2022 |
| "SOC 2", "SOC2", "Type II", "trust services", "audit report", "AICPA" | SOC 2 |
| "GDPR", "personal data", "EU", "data subject", "right to erasure" | GDPR (Note: legal/privacy, reference only) |

---

## ISO 27001:2022

**Source:** International Organization for Standardization
**Version:** ISO/IEC 27001:2022 (updated from 2013)
**Structure:** Management system standard + Annex A (93 controls across 4 themes)

### Annex A Control Themes

#### Theme 1: Organizational Controls (37 controls: 5.1–5.37)

| Control | Title | Key Requirement |
|---|---|---|
| 5.1 | Policies for information security | Written IS policy, approved by management, communicated to all |
| 5.2 | Information security roles and responsibilities | Security roles defined, owner for each information asset |
| 5.3 | Segregation of duties | Conflicting duties identified and segregated |
| 5.5 | Contact with authorities | Contacts maintained with law enforcement, regulators |
| 5.7 | Threat intelligence | Threat intelligence collected, analyzed, acted upon |
| 5.8 | Information security in project management | IS integrated into project management |
| 5.9 | Inventory of information and other assets | Asset inventory maintained and owned |
| 5.10 | Acceptable use of assets | Rules for acceptable use documented and communicated |
| 5.12 | Classification of information | Information classified by confidentiality |
| 5.13 | Labelling of information | Labelling scheme implemented |
| 5.14 | Information transfer | Transfer policies for email, removable media, verbal |
| 5.15 | Access control | Access control policy based on need-to-know and least privilege |
| 5.16 | Identity management | Full lifecycle of identities managed |
| 5.17 | Authentication information | Password requirements, MFA, no shared credentials |
| 5.18 | Access rights | Formal provisioning, review, and revocation of access rights |
| 5.19 | Information security in supplier relationships | Supplier security requirements defined |
| 5.20 | Addressing security in supplier agreements | Security clauses in all supplier contracts |
| 5.23 | Information security for cloud services | Cloud-specific controls (NEW in 2022) |
| 5.24 | Information security incident management planning | IR plan, roles, procedures |
| 5.25 | Assessment and decision on information security events | Triage and classification of events |
| 5.26 | Response to information security incidents | Containment, eradication, recovery |
| 5.27 | Learning from information security incidents | Post-incident review, lessons learned |
| 5.28 | Collection of evidence | Evidence preservation for legal/disciplinary proceedings |
| 5.30 | ICT readiness for business continuity | BCM for ICT systems |
| 5.36 | Compliance with policies | Regular review for compliance |
| 5.37 | Documented operating procedures | Documented procedures for security-relevant operations |

#### Theme 2: People Controls (8 controls: 6.1–6.8)

| Control | Title | Key Requirement |
|---|---|---|
| 6.1 | Screening | Background checks on staff (proportional to role) |
| 6.2 | Terms and conditions of employment | Security responsibilities in employment agreements |
| 6.3 | Information security awareness, education, training | Regular security training for all staff |
| 6.4 | Disciplinary process | Process for IS policy violations |
| 6.5 | Responsibilities after employment termination | Access revoked immediately on termination |
| 6.6 | Confidentiality or non-disclosure agreements | NDAs in place for staff and contractors |
| 6.7 | Remote working | Security requirements for remote work documented |
| 6.8 | Information security event reporting | Easy reporting mechanism for staff to report events |

#### Theme 3: Physical Controls (14 controls: 7.1–7.14)

| Control | Title | Key Requirement |
|---|---|---|
| 7.1 | Physical security perimeters | Secure areas defined and protected |
| 7.2 | Physical entry | Entry controls to secure areas (badge, visitor log) |
| 7.4 | Physical security monitoring | CCTV or equivalent in secure areas |
| 7.6 | Working in secure areas | Rules for working in secure areas |
| 7.8 | Equipment siting and protection | Equipment protected from environmental threats |
| 7.9 | Security of assets off-premises | Devices taken off-site subject to same controls |
| 7.10 | Storage media | Media managed, sanitized, and disposed securely |
| 7.14 | Secure disposal or re-use of equipment | Data wiped before disposal or reuse |

#### Theme 4: Technological Controls (34 controls: 8.1–8.34)

| Control | Title | Key Requirement |
|---|---|---|
| 8.2 | Privileged access rights | Privileged access managed, reviewed, minimized |
| 8.3 | Information access restriction | Access to systems restricted based on access control policy |
| 8.4 | Access to source code | Source code access controlled |
| 8.5 | Secure authentication | Secure authentication technologies (MFA) |
| 8.6 | Capacity management | Resources monitored and managed |
| 8.7 | Protection against malware | Anti-malware controls deployed |
| 8.8 | Management of technical vulnerabilities | Vuln scanning, patch management |
| 8.9 | Configuration management | Secure configurations managed (NEW in 2022) |
| 8.10 | Information deletion | Data deleted when no longer required |
| 8.11 | Data masking | PII and sensitive data masked (NEW in 2022) |
| 8.12 | Data leakage prevention | DLP controls (NEW in 2022) |
| 8.13 | Information backup | Backup policy, tested |
| 8.15 | Logging | Activity logs for security events |
| 8.16 | Monitoring activities | Networks, systems monitored for anomalies |
| 8.17 | Clock synchronization | Synchronized time across all systems |
| 8.18 | Use of privileged utility programs | Privileged utilities controlled |
| 8.19 | Installation of software | Rules and controls for software installation |
| 8.20 | Networks security | Network controls, segmentation |
| 8.21 | Security of network services | Security requirements for network services |
| 8.22 | Segregation of networks | Networks segregated by trust level |
| 8.23 | Web filtering | Filtering of malicious web content (NEW in 2022) |
| 8.24 | Use of cryptography | Policy on use of cryptography |
| 8.25 | Secure development life cycle | Security integrated into SDLC |
| 8.26 | Application security requirements | Security requirements defined for applications |
| 8.27 | Secure system architecture and engineering | Security principles applied in architecture |
| 8.28 | Secure coding | Secure coding practices (NEW in 2022) |
| 8.29 | Security testing in development and acceptance | Security testing in dev and before acceptance |
| 8.30 | Outsourced development | Security requirements for outsourced development |
| 8.31 | Separation of development, test and production | Environments separated |
| 8.32 | Change management | Change control process for IS-relevant changes |
| 8.33 | Test information | Test data managed and protected |
| 8.34 | Protection of information systems during audit testing | Audit testing controlled to prevent production impact |

### ISO 27001 Architecture Checklist

```markdown
## ISO 27001:2022 Architecture Controls Check

- [ ] 5.9: Asset inventory complete (all systems, data stores, integrations documented)
- [ ] 5.12: Data classification scheme implemented (Public / Internal / Confidential / Restricted)
- [ ] 5.15: Access control policy (least privilege, need-to-know, role-based)
- [ ] 5.23: Cloud security controls documented (shared responsibility model understood)
- [ ] 8.2: Privileged access managed (no standing admin, JIT access)
- [ ] 8.5: MFA enforced for all users
- [ ] 8.8: Vulnerability management process (scan cadence, patch SLAs)
- [ ] 8.9: Secure configuration baseline documented (CIS Benchmarks)
- [ ] 8.11: PII and sensitive data masked in non-production environments
- [ ] 8.12: DLP controls prevent unauthorized data exfiltration
- [ ] 8.15: Audit logging for all authentication and access control events
- [ ] 8.22: Network segmentation applied (production isolated from dev/test)
- [ ] 8.24: Cryptography policy: approved algorithms, key management
- [ ] 8.25: Security requirements defined in SDLC (design, dev, test, deploy)
- [ ] 8.27: Security architecture principles documented (Zero Trust, Defense in Depth)
- [ ] 8.28: Secure coding standards documented and training provided
- [ ] 8.29: Security testing in CI/CD (SAST, DAST, dependency scan)
```

---

## SOC 2

**Source:** AICPA | **Criteria:** Trust Services Criteria (TSC)

SOC 2 Type II is an audit report demonstrating that an organization's controls were operating effectively over a period (typically 6–12 months). Architecture must support the control evidence.

### Trust Services Categories

| Category | Code | Description |
|---|---|---|
| Security (required) | CC | Common Criteria — foundation for all SOC 2 reports |
| Availability | A | System available for operation and use per commitment |
| Processing Integrity | PI | System processes complete, valid, accurate, timely |
| Confidentiality | C | Information designated confidential is protected |
| Privacy | P | Personal information collected, used, retained, disclosed per privacy notice |

### Common Criteria (CC) — Architecture Requirements

| CC | Requirement | Architecture Controls |
|---|---|---|
| CC6.1 | Logical access controls | RBAC, MFA, least privilege |
| CC6.2 | Access provisioning/deprovisioning | Automated account lifecycle |
| CC6.3 | Role-based access management | Access reviews quarterly |
| CC6.6 | Protection against security threats | WAF, IDS/IPS, DDoS protection |
| CC6.7 | Data transmission controls | TLS 1.3 for all sensitive data |
| CC6.8 | Protection against unauthorized access | Network segmentation, private subnets |
| CC7.1 | Anomaly detection | SIEM, behavioral analytics |
| CC7.2 | Monitoring for security events | 24/7 monitoring, on-call |
| CC7.3 | Evaluation of security events | Alert triage, escalation process |
| CC7.4 | Incident response | IR plan documented and tested |
| CC8.1 | Change management | Change control process, approval gates |
| CC9.1 | Risk management | Risk assessment, risk register |
| CC9.2 | Vendor risk management | Third-party assessments |

### SOC 2 Architecture Checklist

```markdown
## SOC 2 Architecture Readiness Check

- [ ] CC6.1: All system access requires authentication (no anonymous access to data)
- [ ] CC6.1: MFA enforced for all users accessing systems in scope
- [ ] CC6.2: User provisioning and deprovisioning process documented and automated
- [ ] CC6.3: Access reviews conducted quarterly; access rights match job function
- [ ] CC6.6: WAF deployed; DDoS mitigation in place
- [ ] CC6.7: All data in transit encrypted (TLS 1.3)
- [ ] CC6.7: All data at rest encrypted (AES-256)
- [ ] CC6.8: Production environment isolated (no developer direct access to prod data)
- [ ] CC7.1: SIEM deployed and receiving logs from all in-scope systems
- [ ] CC7.2: 24/7 monitoring with defined escalation paths
- [ ] CC7.4: Incident Response Plan documented, tested in past 12 months
- [ ] CC8.1: Change management process — all changes reviewed and approved
- [ ] CC9.2: Vendor risk assessments completed for all service providers
```

---

## PCI-DSS 4.0.1

**Source:** PCI Security Standards Council | pcisecuritystandards.org
**Version:** PCI-DSS 4.0.1 — all requirements mandatory as of March 31, 2025

**Cardholder Data Environment (CDE):** The people, processes, and technology that store, process, or transmit cardholder data. Scope reduction is the primary security strategy — minimize CDE scope.

### 12 Requirements Summary

| Req | Title | Key Controls |
|---|---|---|
| 1 | Install and maintain network security controls | Firewall rules, deny-all default, DMZ |
| 2 | Apply secure configurations | CIS Benchmarks, change defaults, disable unnecessary services |
| 3 | Protect stored account data | Don't store SAD, encrypt PAN, mask PAN in display |
| 4 | Protect cardholder data in transit | TLS 1.3, no cardholder data over end-user messaging |
| 5 | Protect all systems against malware | Anti-malware on all systems in CDE |
| 6 | Develop and maintain secure systems | SDLC with security, patches within 1 month, WAF |
| 7 | Restrict access by business need | Least privilege, deny-all default for CDE access |
| 8 | Identify users and authenticate access | Unique IDs, MFA for all access to CDE, no group accounts |
| 9 | Restrict physical access to cardholder data | Physical controls on CDE |
| 10 | Log and monitor all access to network resources | Audit logs, tamper-evident, 12-month retention |
| 11 | Test security of systems and networks | ASV scans quarterly, pen test annually, internal scans |
| 12 | Support information security with policies | Security policy, awareness training, risk assessment |

### PCI-DSS Architecture Checklist

```markdown
## PCI-DSS 4.0.1 Architecture Controls Check

### Scope Reduction (Most Important)
- [ ] CDE scope minimized — cardholder data only where absolutely necessary
- [ ] Tokenization used: replace PAN with non-sensitive tokens outside CDE
- [ ] Segmentation: CDE isolated from all other networks with strict firewall rules
- [ ] Third-party payment processor used to reduce PCI scope (e.g., Stripe, Braintree)

### Requirement 1 & 2: Network and Config Security
- [ ] Req 1.2: Network security controls (firewalls) at each CDE boundary
- [ ] Req 1.3: Inbound and outbound traffic restricted — deny all except required
- [ ] Req 2.2: System components configured using CIS Benchmarks or vendor hardening guides
- [ ] Req 2.3: All default passwords changed; no vendor-supplied defaults in use

### Requirement 3 & 4: Data Protection
- [ ] Req 3.3: Sensitive Authentication Data (SAD) not stored after authorization
- [ ] Req 3.5: PAN protected (encrypted, truncated, or tokenized) wherever stored
- [ ] Req 3.7: Key management process: key generation, distribution, storage, rotation, destruction
- [ ] Req 4.2: Strong cryptography (TLS 1.3) for PAN in transit; no weak protocols

### Requirement 6: Secure Development
- [ ] Req 6.2: All software developed per secure coding guidelines
- [ ] Req 6.3: Security vulnerabilities identified and addressed (SAST, DAST, SCA)
- [ ] Req 6.4: WAF deployed for all web-facing applications in CDE
- [ ] Req 6.5: Payment page scripts managed: inventory, integrity monitored, changes alerted

### Requirement 7 & 8: Access Control
- [ ] Req 7.2: Least privilege for all CDE access; role-based access
- [ ] Req 8.2: All users have unique IDs — no shared accounts in CDE
- [ ] Req 8.4: MFA required for all access to CDE (remote and console)
- [ ] Req 8.6: System/application accounts managed with strong authentication

### Requirement 10 & 11: Logging and Testing
- [ ] Req 10.2: Audit logs capture: all user access to CHD, admin actions, log access, auth failures
- [ ] Req 10.5: Log tamper protection — logs cannot be modified or deleted
- [ ] Req 10.7: Audit log retention: 12 months (3 months immediately available)
- [ ] Req 11.3: External vulnerability scans by ASV (Approved Scanning Vendor) quarterly
- [ ] Req 11.4: Penetration test at least annually and after significant changes
```

---

## HIPAA Security Rule

**Source:** U.S. Department of Health & Human Services (HHS)
**Applies to:** Covered entities and business associates handling Protected Health Information (PHI)

### Three Safeguard Categories

#### Administrative Safeguards (45 CFR § 164.308)

| Standard | Key Requirements |
|---|---|
| Security Management Process | Risk analysis, risk management, sanction policy, information activity review |
| Workforce Security | Authorization, supervision, workforce clearance, termination procedures |
| Information Access Management | Access authorization, access establishment and modification |
| Security Awareness Training | Security reminders, protection from malware, log-in monitoring, password management |
| Security Incident Procedures | Response and reporting procedures |
| Contingency Plan | Data backup, disaster recovery, emergency mode operations, testing |
| Evaluation | Periodic technical and non-technical evaluation |
| Business Associate Contracts | BAA required with all business associates handling PHI |

#### Physical Safeguards (45 CFR § 164.310)

| Standard | Key Requirements |
|---|---|
| Facility Access Controls | Contingency operations, facility security plan, access control and validation |
| Workstation Use | Policies for workstations accessing PHI |
| Workstation Security | Physical safeguards for workstations |
| Device and Media Controls | Disposal, media re-use, accountability, data backup |

#### Technical Safeguards (45 CFR § 164.312)

| Standard | Key Requirements |
|---|---|
| Access Control | Unique user IDs, emergency access, automatic logoff, encryption/decryption |
| Audit Controls | Hardware/software/procedural mechanisms to record and examine access |
| Integrity | PHI not improperly altered or destroyed; electronic transmission integrity |
| Transmission Security | PHI encrypted in transit (TLS); guard against unauthorized interception |

### HIPAA Architecture Checklist

```markdown
## HIPAA Security Rule Architecture Check

### PHI Identification and Scope
- [ ] All PHI identified and classified (structured DB, unstructured files, backups, logs)
- [ ] Business Associate Agreements (BAA) in place with all vendors handling PHI
- [ ] PHI minimized — collect only what is required for treatment/payment/operations

### Technical Safeguards
- [ ] Unique user IDs for all workforce members — no shared accounts
- [ ] MFA for all access to systems containing PHI
- [ ] Automatic logoff after inactivity (max 15 min recommended)
- [ ] PHI encrypted at rest (AES-256)
- [ ] PHI encrypted in transit (TLS 1.3)
- [ ] Audit logs for all PHI access: who, when, what action
- [ ] Logs protected from modification; retained minimum 6 years

### Administrative Safeguards
- [ ] Risk analysis completed and documented (risk assessment of PHI systems)
- [ ] Risk management plan implemented to reduce identified risks
- [ ] Security awareness training provided to all workforce annually
- [ ] Incident response procedure documented and tested
- [ ] Business continuity plan includes PHI system recovery (RTO/RPO defined)

### PHI Handling in Architecture
- [ ] PHI never in application logs (mask before logging)
- [ ] PHI never in URLs or query strings (POST body only)
- [ ] PHI never in non-production environments (mask/synthesize test data)
- [ ] PHI de-identified before use in analytics/ML pipelines
- [ ] De-identification method: Safe Harbor (18 identifiers removed) or Expert Determination
```

---

## Compliance Gap Report Template

```markdown
# Compliance Gap Report: [System Name]

**Date:** YYYY-MM-DD | **Assessor:** [Name]
**Applicable Frameworks:** [list detected frameworks]

## Summary

| Framework | Total Controls | Compliant | Partial | Gap | N/A |
|---|---|---|---|---|---|
| ISO 27001:2022 | 93 | 0 | 0 | 0 | 0 |
| SOC 2 (CC only) | 15 | 0 | 0 | 0 | 0 |
| PCI-DSS 4.0.1 | 12 req | 0 | 0 | 0 | 0 |
| HIPAA | ~45 | 0 | 0 | 0 | 0 |

## Findings

| ID | Framework | Control Ref | Finding | Severity | Remediation | Owner | Target Date |
|---|---|---|---|---|---|---|---|
| CF-01 | ISO 27001 | 8.5 | MFA not enforced for all users | Critical | Enable MFA for all accounts; hardware tokens for admins | Security | [date] |
| CF-02 | PCI-DSS | Req 3.5 | PAN stored in cleartext in legacy table | Critical | Encrypt PAN using AES-256; consider tokenization | Engineering | [date] |
| CF-03 | SOC 2 | CC7.4 | IR plan not tested in past 12 months | High | Schedule tabletop exercise within 30 days | Security | [date] |
| CF-04 | HIPAA | 164.312(a)(1) | No automatic logoff on PHI systems | High | Configure 15-min idle timeout on all PHI-bearing systems | Platform | [date] |
```

---

## Agent Instructions: Compliance

1. **Auto-detect applicable frameworks** from context signals — never ask "which compliance framework?"
2. **Scope reduction first** — for PCI-DSS and HIPAA, the first recommendation is always: reduce scope by tokenizing/masking sensitive data.
3. **BAAs for HIPAA** — if the system touches PHI and uses any cloud service, a BAA is required. Flag it explicitly.
4. **Gap = finding** — every gap produces a finding in the Compliance Gap Report with severity, framework reference, and remediation.
5. **Critical gaps block** — Critical and High compliance gaps should be flagged as blockers, not recommendations.
6. **Map controls cross-framework** when possible — many controls satisfy multiple frameworks simultaneously.
