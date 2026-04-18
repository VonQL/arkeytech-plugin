# Well-Architected Framework Reference

## AWS Well-Architected Framework (6 Pillars)

**Source:** AWS | docs.aws.amazon.com/wellarchitected | **Version:** Current 2025

### Pillar 1: Operational Excellence

**Design principles:** Operations as code, frequent small reversible changes, anticipate failure, learn from operations events.

| Question | Best Practice | Check |
|---|---|---|
| How do you determine what your priorities are? | Define business and customer outcomes, evaluate trade-offs | [ ] |
| How do you structure your organization to support workload ops? | Team ownership, on-call, runbooks defined | [ ] |
| How do you reduce defects and implement right processes? | CI/CD, automated testing, peer review | [ ] |
| How do you mitigate deployment risks? | Canary / blue-green deploys, automated rollback | [ ] |
| How do you know workload health? | Health checks, dashboards, SLOs defined | [ ] |
| How do you manage workload events? | Runbooks, escalation paths, post-mortems | [ ] |

### Pillar 2: Security

**Design principles:** Implement a strong identity foundation, enable traceability, apply security at all layers, automate security best practices, protect data in transit and at rest, keep people away from data, prepare for security events.

| Question | Best Practice | Check |
|---|---|---|
| How do you securely operate your workload? | Threat model updated, security training | [ ] |
| How do you manage identities for people and machines? | Least privilege IAM, MFA enforced, no long-lived keys | [ ] |
| How do you manage permissions for people and machines? | Attribute-based access control, permission boundaries | [ ] |
| How do you detect and investigate security events? | CloudTrail/audit logs, GuardDuty/Defender, SIEM | [ ] |
| How do you protect your network resources? | VPC isolation, private subnets, security groups, WAF | [ ] |
| How do you protect your compute resources? | Patching, EDR, no SSH in prod, IMDSv2 | [ ] |
| How do you classify your data? | Data classification tags, encryption per class | [ ] |
| How do you protect your data at rest? | AES-256 encryption, KMS/key management | [ ] |
| How do you protect your data in transit? | TLS 1.3 everywhere, certificate management | [ ] |
| How do you anticipate, respond to, and recover from incidents? | IR runbook, tabletop exercises, automated containment | [ ] |
| How do you incorporate and validate the security properties of applications throughout the design, development, and deployment lifecycle? | SAST/DAST in CI, dependency scanning, secrets scanning | [ ] |

### Pillar 3: Reliability

**Design principles:** Automatically recover from failure, test recovery procedures, scale horizontally, stop guessing capacity, manage change through automation.

| Question | Best Practice | Check |
|---|---|---|
| How do you manage service quotas and constraints? | Monitor quotas, request increases proactively | [ ] |
| How do you plan your network topology? | Multi-AZ, no single points of failure | [ ] |
| How do you design your workload service architecture? | Loosely coupled, retry with backoff, timeouts | [ ] |
| How do you design interactions to mitigate or withstand failures? | Circuit breakers, bulkheads, graceful degradation | [ ] |
| How do you monitor workload resources? | Health endpoints, synthetic monitoring, alerting | [ ] |
| How do you design your workload to adapt to changes in demand? | Auto-scaling, load balancing, stateless services | [ ] |
| How do you implement change? | Automated deployments, change windows, rollback | [ ] |
| How do you back up data? | Automated backups, backup testing, cross-region | [ ] |
| How do you use fault isolation to protect your workload? | Availability zones, cell-based architecture | [ ] |
| How do you design your workload to withstand component failures? | Redundancy, failover tested regularly | [ ] |
| How do you test reliability? | Chaos engineering, game days, DR drills | [ ] |
| How do you plan for disaster recovery? | RTO/RPO defined, DR tested, runbooks | [ ] |

### Pillar 4: Performance Efficiency

**Design principles:** Democratize advanced technologies, go global in minutes, use serverless architectures, experiment more often, consider mechanical sympathy.

| Question | Best Practice | Check |
|---|---|---|
| How do you select the best performing architecture? | Benchmarked multiple approaches | [ ] |
| How do you select your compute solution? | Right-sized, use managed services where possible | [ ] |
| How do you select your storage solution? | Storage class matches access pattern | [ ] |
| How do you select your database solution? | DB engine matches workload (OLTP/OLAP/cache) | [ ] |
| How do you configure your networking solution? | Latency-aware routing, CDN for static assets | [ ] |
| How do you evolve your workload to take advantage of new releases? | Technology radar process, upgrade cadence | [ ] |
| How do you monitor your resources to ensure they are performing? | p95/p99 latency tracked, SLOs defined | [ ] |
| How do you use tradeoffs to improve performance? | Cache vs. consistency, async vs. sync documented | [ ] |

### Pillar 5: Cost Optimization

**Design principles:** Implement cloud financial management, adopt a consumption model, measure overall efficiency, stop spending money on undifferentiated heavy lifting, analyze and attribute expenditure.

| Question | Best Practice | Check |
|---|---|---|
| How do you implement cloud financial management? | FinOps ownership assigned, cost reviews monthly | [ ] |
| How do you govern usage? | Budget alerts, tagging policy enforced | [ ] |
| How do you monitor usage and cost? | Cost anomaly detection, per-service cost dashboards | [ ] |
| How do you decommission resources? | Resource lifecycle process, cleanup automation | [ ] |
| How do you evaluate cost when selecting services? | Cost modeled before adoption | [ ] |
| How do you meet cost targets for existing architecture? | Right-sizing reviews, savings plans/reserved instances | [ ] |
| How do you manage demand and supply resources? | Auto-scaling aligned to demand patterns | [ ] |
| How do you optimize your pricing model? | Spot/preemptible for fault-tolerant workloads | [ ] |
| How do you plan for future costs? | Capacity planning tied to growth projections | [ ] |

### Pillar 6: Sustainability

**Design principles:** Understand your impact, establish sustainability goals, maximize utilization, anticipate and adopt new efficient offerings, use managed services, reduce downstream impact.

| Question | Best Practice | Check |
|---|---|---|
| How do you select regions to support your sustainability goals? | Prefer regions with renewable energy commitments | [ ] |
| How do you align cloud resource utilization with user load? | Scale to zero when idle, right-size always | [ ] |
| How do you take advantage of software patterns and architecture for sustainability? | Async processing, caching to reduce compute | [ ] |
| How do you take advantage of data management policies? | Lifecycle policies, archive cold data | [ ] |
| How do you minimize the sustainability impact of hardware changes? | Extend hardware life, use cloud managed | [ ] |
| How do your development and deployment processes support your sustainability goals? | Efficient CI/CD, test in lower environments | [ ] |

---

## Azure Well-Architected Framework (5 Pillars)

**Source:** Microsoft | learn.microsoft.com/azure/well-architected | **Version:** Current 2025

| Pillar | Key Questions | Top Checks |
|---|---|---|
| **Reliability** | How do you design for failure? What are your RTO/RPO targets? | Availability zones, health probes, retry policies, DR tested |
| **Security** | How do you protect identity, data, network? | Azure AD / Entra ID, RBAC, NSGs, Azure Defender, encryption |
| **Cost Optimization** | How do you manage spend? | Azure Cost Management, Reserved instances, right-sizing |
| **Operational Excellence** | How do you deploy and monitor? | Azure DevOps/GitHub Actions, Azure Monitor, Log Analytics |
| **Performance Efficiency** | How do you scale and optimize? | Auto-scale, Azure CDN, caching (Redis), App Insights profiling |

### Azure Security Checklist

| Control | Service/Feature | Check |
|---|---|---|
| Identity & Access | Azure AD / Entra ID + MFA | [ ] |
| Privileged Access | PIM (Privileged Identity Management) | [ ] |
| Network Isolation | VNet, Private Endpoints, NSGs | [ ] |
| Threat Detection | Microsoft Defender for Cloud | [ ] |
| Key Management | Azure Key Vault | [ ] |
| Data Encryption | Storage Service Encryption, TDE for SQL | [ ] |
| Logging & SIEM | Azure Monitor + Sentinel | [ ] |
| Vulnerability Management | Defender for Servers | [ ] |
| DDoS Protection | Azure DDoS Protection Standard | [ ] |
| WAF | Azure Application Gateway WAF | [ ] |

---

## GCP Architecture Framework (6 Pillars)

**Source:** Google Cloud | cloud.google.com/architecture/framework | **Version:** Current 2025

| Pillar | Key Focus | Top Checks |
|---|---|---|
| **Operational Excellence** | Automation, SRE practices | Cloud Operations Suite, SLO monitoring, IaC (Terraform) |
| **Security, Privacy, Compliance** | IAM, data protection, compliance | IAM least privilege, VPC Service Controls, CMEK, DLP API |
| **Reliability** | Resilience, DR | Multi-region, Cloud Spanner, Load Balancing, chaos testing |
| **Cost Optimization** | FinOps, efficiency | Committed use discounts, Budget Alerts, Recommender |
| **Performance Optimization** | Scalability, efficiency | Cloud CDN, Cloud Spanner, Memorystore, profiling |
| **System Design** | Architecture patterns | Microservices, event-driven (Pub/Sub), serverless (Cloud Run) |

### GCP Security Checklist

| Control | Service/Feature | Check |
|---|---|---|
| Identity | Cloud Identity + MFA | [ ] |
| Access Control | IAM + Workload Identity | [ ] |
| Network | VPC, Private Google Access, Firewall rules | [ ] |
| Secrets | Secret Manager | [ ] |
| Logging | Cloud Audit Logs + Security Command Center | [ ] |
| Threat Detection | Security Command Center Premium | [ ] |
| Encryption | CMEK + Cloud KMS | [ ] |
| Binary Authorization | Container image signing | [ ] |

---

## Well-Architected Review Output Template

```markdown
# Well-Architected Review: [System Name]

**Date:** YYYY-MM-DD | **Reviewer:** [Name] | **Cloud:** AWS / Azure / GCP

## Summary Scores

| Pillar | Score | Status |
|---|---|---|
| Operational Excellence | [0-100] | 🔴 High Risk / 🟡 Medium Risk / 🟢 Low Risk |
| Security | [0-100] | |
| Reliability | [0-100] | |
| Performance Efficiency | [0-100] | |
| Cost Optimization | [0-100] | |
| Sustainability | [0-100] | |

## High Priority Findings

| ID | Pillar | Finding | Severity | Recommendation |
|---|---|---|---|---|
| WAR-01 | Security | No MFA enforced on IAM users | Critical | Enable MFA; use hardware tokens for privileged users |
| WAR-02 | Reliability | No automated failover tested | High | Implement and test automated failover monthly |

## Improvement Plan

| Priority | Action | Owner | Target Date |
|---|---|---|---|
| 1 | [WAR-01 remediation] | Security team | [date] |
| 2 | [WAR-02 remediation] | Platform team | [date] |
```

---

## Agent Instructions: Well-Architected Reviews

1. **Always run the Security pillar first** — security findings affect all other pillars.
2. **Score each pillar 0-100** based on check completion and severity of gaps.
3. **Every Critical finding must have a remediation** before the review is considered complete.
4. **Cloud-specific:** Apply the framework for the cloud the system actually runs on. For multi-cloud, run all three.
5. **Executive summary:** Produce a 1-page summary with pillar scores + top 3 findings for leadership.
