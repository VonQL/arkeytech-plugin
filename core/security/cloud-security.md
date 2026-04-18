# Cloud Security Reference

## CIS Benchmarks

**Source:** Center for Internet Security | cisecurity.org
**Use:** Infrastructure hardening for cloud, OS, containers, databases

### CIS Benchmark Levels

| Level | Description |
|---|---|
| Level 1 | Essential security — minimal performance impact, widely applicable |
| Level 2 | Defense-in-depth — may affect performance/usability; for high-security environments |

### CIS Controls v8 — Top 18 Controls

| CIG | Control | Priority | Description |
|---|---|---|---|
| 1 | Inventory and Control of Enterprise Assets | Critical | Know every asset in your environment |
| 2 | Inventory and Control of Software Assets | Critical | Know every piece of software running |
| 3 | Data Protection | Critical | Classify, protect, and manage data lifecycle |
| 4 | Secure Configuration of Enterprise Assets | Critical | Harden all assets (CIS Benchmarks) |
| 5 | Account Management | Critical | Manage full lifecycle of all accounts |
| 6 | Access Control Management | Critical | Least privilege, MFA, access reviews |
| 7 | Continuous Vulnerability Management | Critical | Scan, prioritize, remediate |
| 8 | Audit Log Management | Critical | Collect, protect, retain, and review logs |
| 9 | Email and Web Browser Protections | Important | Filter, scan, block malicious content |
| 10 | Malware Defenses | Important | Anti-malware, application allowlisting |
| 11 | Data Recovery | Important | Automated backups, tested recovery |
| 12 | Network Infrastructure Management | Important | Secure network devices, manage configs |
| 13 | Network Monitoring and Defense | Important | Traffic monitoring, IDS/IPS, NDR |
| 14 | Security Awareness and Skills Training | Important | Regular training, phishing simulation |
| 15 | Service Provider Management | Important | Third-party risk assessment |
| 16 | Application Software Security | Important | SDLC security, SAST, DAST, SCA |
| 17 | Incident Response Management | Important | IR plan, team, practice |
| 18 | Penetration Testing | Important | External pen test annually |

---

## AWS Security Checklist

**Reference:** AWS Security Pillar (Well-Architected) + AWS Foundational Security Best Practices

### Identity and Access Management

```markdown
## AWS IAM Security Checks

- [ ] Root account has MFA enabled; root account keys deleted
- [ ] No human users with permanent IAM access keys — use SSO/IAM Identity Center
- [ ] IAM roles used for EC2/ECS/Lambda (no hardcoded credentials in code)
- [ ] IAM policies use least privilege — no `*:*` permissions
- [ ] Service Control Policies (SCPs) applied at Organization level for guardrails
- [ ] IAM Access Analyzer enabled in all regions
- [ ] Permission boundaries applied to delegated administration
- [ ] Access reviews: unused credentials/permissions rotated/removed (90-day threshold)
- [ ] CloudTrail enabled in all regions with log file validation
```

### Network Security

```markdown
## AWS Network Security Checks

- [ ] VPC per environment (dev/staging/prod separated)
- [ ] Public subnets contain only load balancers and NAT gateways — no app servers
- [ ] Application servers in private subnets — no direct internet access
- [ ] Databases in isolated private subnets — only accessible from app tier
- [ ] Security groups: deny all by default, allow only required ports from required sources
- [ ] No 0.0.0.0/0 inbound on port 22 (SSH) or 3389 (RDP) to production
- [ ] VPC Flow Logs enabled and sent to centralized logging
- [ ] AWS Network Firewall or equivalent for east-west inspection
- [ ] AWS WAF on all public-facing ALBs and CloudFront distributions
- [ ] AWS Shield Advanced for DDoS protection on critical workloads
```

### Data Protection

```markdown
## AWS Data Protection Checks

- [ ] S3 buckets: Block Public Access enabled at account level
- [ ] S3 encryption: SSE-S3 or SSE-KMS; never unencrypted
- [ ] S3 versioning enabled for critical data buckets
- [ ] KMS Customer Managed Keys (CMK) for all sensitive data encryption
- [ ] Key rotation enabled for all KMS keys (annual)
- [ ] RDS encryption at rest enabled; automated backups enabled
- [ ] Secrets Manager (not environment variables) for all credentials
- [ ] Macie enabled for S3 PII discovery
- [ ] DynamoDB encryption at rest (AWS-managed or CMK)
```

### Threat Detection and Monitoring

```markdown
## AWS Threat Detection Checks

- [ ] GuardDuty enabled in all regions and member accounts
- [ ] Security Hub enabled; AWS Foundational Security Best Practices standard active
- [ ] AWS Config enabled with compliance rules in all regions
- [ ] CloudTrail: management events + data events for sensitive S3 buckets and Lambda
- [ ] CloudWatch Alarms for: root account use, unauthorized API calls, MFA changes
- [ ] AWS Inspector for EC2 vulnerability scanning
- [ ] Amazon Detective for investigation (if GuardDuty findings require deep analysis)
- [ ] EventBridge rules for automated response to high-severity GuardDuty findings
```

### Container Security (ECS/EKS)

```markdown
## AWS Container Security Checks

- [ ] ECR image scanning enabled (on push and continuous)
- [ ] No containers running as root
- [ ] Read-only root filesystem for containers where possible
- [ ] ECS Task Roles used — no hardcoded credentials in container environment
- [ ] EKS: RBAC enabled; OIDC provider configured for IAM roles for service accounts (IRSA)
- [ ] EKS: Network Policies enforced (Calico or VPC CNI)
- [ ] EKS: Pod Security Standards (restricted profile) applied
- [ ] ECR image immutability enabled; image signing with Cosign/Notation
- [ ] No privileged containers in production
```

---

## Azure Security Checklist

**Reference:** Azure Security Benchmark v3 + Microsoft Defender for Cloud

### Identity and Access (Azure)

```markdown
## Azure Identity Security Checks

- [ ] Azure AD (Entra ID) MFA enforced for all users via Conditional Access
- [ ] Privileged Identity Management (PIM): JIT access for all privileged roles
- [ ] Global Administrator role: ≤ 5 accounts, all with hardware MFA
- [ ] No service principals with certificates older than 1 year
- [ ] Managed Identities used for Azure services — no client secrets in code
- [ ] Conditional Access: block legacy authentication protocols
- [ ] Azure AD Identity Protection: risk-based policies enabled
- [ ] Access reviews for privileged roles: monthly; regular users: quarterly
```

### Network Security (Azure)

```markdown
## Azure Network Security Checks

- [ ] NSGs on all subnets; deny-all default, explicit allow rules only
- [ ] No NSG rules with source 0.0.0.0/0 to port 22/3389 in production
- [ ] Azure Firewall or NVA for centralized egress control
- [ ] Private Endpoints for all PaaS services (Storage, SQL, Key Vault, etc.)
- [ ] Azure DDoS Protection Standard on production VNets
- [ ] Azure Front Door + WAF for global HTTP/S entry points
- [ ] Application Gateway WAF for regional applications
- [ ] VNet Flow Logs enabled; forwarded to Log Analytics
```

### Data Protection (Azure)

```markdown
## Azure Data Protection Checks

- [ ] Azure Key Vault for all secrets, certificates, and keys
- [ ] Customer-Managed Keys (CMK) for sensitive data encryption
- [ ] Key rotation policy configured in Key Vault
- [ ] Azure Storage: secure transfer required, minimum TLS 1.2, no public blob access
- [ ] Azure SQL: Transparent Data Encryption (TDE) enabled
- [ ] Azure Defender for SQL: enabled on all SQL instances
- [ ] Azure Purview or Microsoft Purview for data classification
- [ ] Soft delete and purge protection enabled on Key Vault
```

### Monitoring (Azure)

```markdown
## Azure Monitoring Security Checks

- [ ] Microsoft Defender for Cloud: all plans enabled for in-scope resources
- [ ] Log Analytics Workspace receiving logs from all resources
- [ ] Azure Sentinel (Microsoft Sentinel) configured as SIEM
- [ ] Diagnostic settings: all Management Plane operations logged to Log Analytics
- [ ] Azure Monitor Alerts: unauthorized access, privilege escalation, policy violations
- [ ] Security Score in Defender for Cloud reviewed and improved monthly
```

---

## GCP Security Checklist

**Reference:** GCP Security Foundations Blueprint + Security Command Center

### Identity and Access (GCP)

```markdown
## GCP Identity Security Checks

- [ ] Workspace MFA enforced for all users
- [ ] Service accounts: no user-managed keys where avoidable; use Workload Identity Federation
- [ ] Service accounts not bound to all users in project
- [ ] Principle of least privilege: no project-level Owner/Editor for service accounts
- [ ] Organization Policy: restrict service account key creation
- [ ] Organization Policy: restrict resource locations to approved regions
- [ ] VPC Service Controls around sensitive data perimeters
- [ ] IAM Recommender reviewed and applied regularly
```

### Network Security (GCP)

```markdown
## GCP Network Security Checks

- [ ] VPC Firewall: default deny-all; explicit allow rules only
- [ ] No firewall rules with 0.0.0.0/0 source for SSH (22) or RDP (3389)
- [ ] Private Google Access enabled; resources don't need public IPs
- [ ] Cloud Armor WAF on external load balancers
- [ ] Cloud NAT for outbound internet from private instances
- [ ] VPC Flow Logs enabled for all subnets
- [ ] Cloud DNS DNSSEC enabled
```

### Monitoring (GCP)

```markdown
## GCP Monitoring Security Checks

- [ ] Security Command Center Premium enabled at Organization level
- [ ] Cloud Audit Logs: Admin Activity + Data Access logs for sensitive services
- [ ] Cloud Logging: logs exported to centralized sink (BigQuery/SIEM)
- [ ] Cloud Monitoring Alerts: unauthorized IAM changes, firewall rule changes
- [ ] Event Threat Detection enabled in Security Command Center
- [ ] Container Threat Detection for GKE workloads
- [ ] Chronicle SIEM (if available) or third-party SIEM receiving GCP logs
```

---

## Container and Kubernetes Security

**Reference:** CIS Kubernetes Benchmark, NSA/CISA Kubernetes Hardening Guide

```markdown
## Container and Kubernetes Security Checks

### Image Security
- [ ] Use minimal base images (distroless, Alpine)
- [ ] Images scanned for CVEs before deployment (Trivy, Grype, or registry scanning)
- [ ] No critical CVEs in production images
- [ ] Image signing enforced (Cosign, Notation)
- [ ] Image immutability: no `latest` tag in production
- [ ] SBOM generated for all production images

### Pod Security
- [ ] Pod Security Standards: `restricted` profile enforced in production namespaces
- [ ] No containers running as root (UID 0)
- [ ] Read-only root filesystem (`readOnlyRootFilesystem: true`)
- [ ] No privileged containers (`privileged: false`)
- [ ] Capabilities dropped (`drop: ["ALL"]`); only add what's required
- [ ] No hostNetwork, hostPID, hostIPC unless explicitly justified
- [ ] Resource limits set on all containers (CPU and memory)
- [ ] Liveness and readiness probes configured

### Network Policy
- [ ] Default deny-all NetworkPolicy in each namespace
- [ ] Explicit NetworkPolicies for all required pod-to-pod communication
- [ ] Egress restricted: pods cannot reach arbitrary internet endpoints

### Secrets Management
- [ ] No secrets in environment variables (use mounted secrets or external secret manager)
- [ ] External Secrets Operator or Vault Agent for secret injection
- [ ] etcd encrypted at rest
- [ ] Secrets not in container image layers

### RBAC
- [ ] Least-privilege RBAC: no ClusterAdmin for application workloads
- [ ] ServiceAccounts per workload (no default ServiceAccount)
- [ ] `automountServiceAccountToken: false` where not needed
- [ ] RBAC audit: review quarterly

### Supply Chain
- [ ] Admission controller: OPA Gatekeeper or Kyverno for policy enforcement
- [ ] Only approved registries permitted (OCI policy)
- [ ] Dependency review in CI before image build
```

---

## Agent Instructions: Cloud Security

1. **Cloud-specific checks before generic** — apply the checklist for the cloud the system actually uses.
2. **Container security always applies** if the system uses containers — whether on EKS, AKS, GKE, or self-hosted.
3. **CIS Benchmarks level** — use Level 1 for all systems; Level 2 for CDE (PCI-DSS scope) and PHI systems.
4. **Every Critical CIS finding is a blocker** — do not approve architecture that fails Level 1 CIS Benchmark controls for the applicable cloud.
5. **Shared responsibility** — explicitly document what the cloud provider handles and what the customer must implement.
6. **Zero Trust overlay** — apply NIST SP 800-207 checks after cloud-specific checks; cloud hardening ≠ Zero Trust.
