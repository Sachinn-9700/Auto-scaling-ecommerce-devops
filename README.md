
# 🛒 Auto-Scaling E-Commerce Application on AWS EKS

**An end-to-end DevOps project demonstrating infrastructure automation, CI/CD, Kubernetes orchestration, and autoscaling on AWS.**

This project represents my hands-on DevOps journey where I designed, built, broke, fixed, and stabilized a complete pipeline from AWS infrastructure provisioning to containerized application deployment on EKS with monitoring and autoscaling.

---

## 🧰 Technologies Used

### Infrastructure & Cloud

* AWS (VPC, EC2, IAM, EKS)
* Terraform (Infrastructure as Code)

### CI/CD

* Jenkins
* Docker & Docker Hub

### Container Orchestration

* Kubernetes (EKS)
* Horizontal Pod Autoscaler (HPA)

### Monitoring

* Prometheus
* Grafana

### Scripting & Automation

* Bash (user data, tooling, EKS access)
* Helm (used for monitoring stack setup)

---

## ✨ Features Implemented

* Infrastructure provisioning using Terraform (VPC, NAT, IAM, EKS, Jenkins EC2)
* Separate frontend and backend Docker images
* Jenkins pipeline to:
  * Build Docker images
  * Push images to Docker Hub
  * Apply Kubernetes manifests directly to EKS
* Kubernetes deployments and services for frontend & backend
* Horizontal Pod Autoscaling based on resource usage
* Prometheus metrics scraping via ServiceMonitor
* Grafana dashboard integration
* Namespace-based resource isolation

---

## 🔁 The Process

1. **Infrastructure Provisioning**

   * Terraform provisions VPC, subnets, NAT Gateway, IAM roles, EKS cluster, and Jenkins EC2 instance.
   * EC2 use_data.sh installs required tools (Docker, Jenkins, kubectl, AWS CLI).

2. **CI Pipeline (Jenkins)**

   * Source code pulled from GitHub.
   * Docker images built for frontend and backend.
   * Images pushed to Docker Hub.
   * Kubernetes manifests applied directly to the EKS cluster.

3. **Application Deployment**

   * Frontend and backend deployed as separate Kubernetes deployments.
   * Services expose the applications internally/externally.

4. **Autoscaling**

   * HPA configured for frontend and backend workloads.
   * Pods scale automatically based on resource utilization.

5. **Monitoring**

   * Prometheus scrapes application metrics using ServiceMonitor.
   * Grafana visualizes metrics and cluster/application health.

---

## 🧪 Real Issues Faced & How I Solved Them

This project involved **multiple real-world issues**, which significantly improved my troubleshooting skills thoose issue  as fllows:

### Terraform Execution Challenges

* Faced long apply times and dependency-related issues.
* Resolved by:
  * Structuring Terraform modules logically
  * Ensuring correct resource dependencies
  * Re-running targeted applies where needed

### EKS Authentication & Access

* Initial issues accessing the cluster due to IAM and kubeconfig setup.
* Fixed by:
  * Correct IAM role mapping
  * Using custom EKS access scripts to validate cluster access

### Jenkins & EC2 Configuration

* Jenkins initially lacked permissions to run Docker commands.
* Resolved by:
  * Adjusting user permissions
  * Verifying Docker daemon access on EC2

### Monitoring Stack Setup

* Helm-based Prometheus and Grafana setup required namespace and permission fixes.
* Validated ServiceMonitor labels and scraping configuration.

### Terraform State Management (Important Learning)

* Learned why state files should never be version-controlled.
* Plan to remove them and move to remote state management in future iterations.

---

## 📚 What I Learned

* Writing Terraform that survives multiple applies and failures
* Understanding AWS IAM deeply in the context of EKS
* Building CI pipelines that interact directly with Kubernetes
* Debugging real Jenkins + Docker + Kubernetes integration issues
* Designing autoscaling behavior using HPA

---

## 📈 Overall Growth

This project marked a shift from **tool usage** to **system understanding**.
Instead of just “making things work,” I learned how to **debug, redesign, and stabilize** DevOps pipelines under real constraints.

---

## 🔮 Future Improvements

The following are **intentionally left out** and planned as future scope:

* GitHub Actions for CI
* ArgoCD for GitOps-based CD
* Helm-based application deployments
* Secure secret management (AWS Secrets Manager / Vault)
* Remote Terraform state backend (S3 + DynamoDB)

---

## ▶️ Running the Project

1. Provision AWS infrastructure using Terraform.
2. Access Jenkins on the EC2 instance.
3. Trigger the Jenkins pipeline to build, push, and deploy the application.
4. Verify application access via Kubernetes services.
5. Monitor scaling and metrics via Prometheus and Grafana.

---