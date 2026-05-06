# 🔐 Secure Containerized Application Deployment on AWS using ECS Fargate

## 📌 Project Overview

This project demonstrates the secure deployment of a containerized Flask web application on AWS using Amazon ECS Fargate.

The project focuses on implementing cloud security best practices throughout the deployment lifecycle, including container hardening, vulnerability scanning, secure networking, IAM access control, centralized logging, and monitoring.

The application was containerized using Docker, scanned using Trivy for vulnerabilities, stored in Amazon ECR, and deployed using ECS Fargate without managing EC2 servers manually.

---

## 🔁 Architecture

```text
Flask Application
        ↓
Docker Container
        ↓
Trivy Vulnerability Scanning
        ↓
Amazon ECR
        ↓
Amazon ECS Fargate
        ↓
Public Access via Public IP
        ↓
CloudWatch Monitoring & Logs
```

---

## 🏗️ AWS Services & Tools Used

* **Docker** – Containerization of the Flask application
* **Trivy** – Vulnerability scanning for container images
* **Amazon ECR** – Secure container image registry
* **Amazon ECS Fargate** – Serverless container deployment
* **AWS VPC** – Network isolation
* **Security Groups** – Firewall and traffic control
* **AWS IAM** – Access control and permissions
* **Amazon CloudWatch** – Logging and monitoring
* **Python Flask** – Web application framework

---

## 📂 Project Structure

```text
.
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
├── screenshots/
└── README.md
```

---

# ⚙️ Docker Configuration

## 🔹 Original Dockerfile

The initial Dockerfile used a standard Python image before security hardening.

```dockerfile
FROM python:3.12

WORKDIR /app

COPY . .

RUN pip install flask

EXPOSE 5000

CMD ["python", "app.py"]
```

---

## 🔹 Secured Dockerfile

The Docker image was hardened using Alpine Linux and non-root user execution.

```dockerfile
FROM python:3.12-alpine

WORKDIR /app

RUN adduser -D appuser

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
```

---

# 🐳 Docker Commands

## Build Docker Image

```bash
docker build -t secure-flask-app .
```

---

## Run Docker Container

```bash
docker run -p 5000:5000 secure-flask-app
```

---

## Access Application Locally

```text
http://localhost:5000
```

---

# 🔍 Vulnerability Scanning using Trivy

The Docker image was scanned using Trivy to identify vulnerabilities before deployment.

## 🔹 Scan Command

```bash
trivy image secure-flask-app
```

---

## 🔹 Vulnerabilities Before Hardening

| Severity | Count |
|---|---|
| CRITICAL | 1 |
| HIGH | 6 |
| MEDIUM | 5 |
| LOW | 2 |

---

## 🔹 Vulnerabilities After Hardening

| Severity | Status |
|---|---|
| CRITICAL | Fixed |
| HIGH | Fixed |
| MEDIUM | Fixed |
| LOW | Fixed |

---

# ☁️ AWS Infrastructure Configuration

The following AWS infrastructure components were configured for secure deployment:

* VPC
* Public Subnet
* Internet Gateway
* Route Tables
* Security Groups
* IAM Roles & Policies

---

# 🚀 ECS Fargate Deployment Workflow

1. Build Docker image locally
2. Scan image using Trivy
3. Create Amazon ECR repository
4. Push Docker image to ECR
5. Create ECS Cluster
6. Create ECS Task Definition
7. Configure ECS Service
8. Enable Public IP
9. Deploy application using Fargate
10. Monitor logs using CloudWatch

---

# 📦 Amazon ECR Commands

## Authenticate Docker to ECR

```bash
aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-2.amazonaws.com
```

---

## Tag Docker Image

```bash
docker tag secure-flask-app:latest <ecr-uri>
```

---

## Push Docker Image

```bash
docker push <ecr-uri>
```

---

# 🔐 Security Implementations

The following security best practices were implemented in this project:

* Used lightweight Alpine Linux image
* Removed unnecessary packages
* Executed container as non-root user
* Performed vulnerability scanning
* Configured least privilege IAM permissions
* Implemented secure VPC networking
* Restricted traffic using Security Groups
* Enabled centralized logging using CloudWatch

---

# 📊 Monitoring & Logging

Amazon CloudWatch was used to monitor container activity and logs.

CloudWatch features used:

* Container log streams
* Request monitoring
* ECS task monitoring
* Alarm configuration
* Error tracking and debugging

---

# 📸 Screenshots

## 🔹 Original Dockerfile

```md
![Original Dockerfile](screenshots/dockerfile-before.png)
```

---

## 🔹 Secured Dockerfile

```md
![Secured Dockerfile](screenshots/dockerfile-after.png)
```

---

## 🔹 Docker Image Build

```md
![Docker Build](screenshots/docker-build.png)
```

---

## 🔹 Application Running Locally

```md
![Local Application](screenshots/localhost-app.png)
```

---

## 🔹 Trivy Scan Before Hardening

```md
![Trivy Before](screenshots/trivy-before.png)
```

---

## 🔹 Trivy Scan After Hardening

```md
![Trivy After](screenshots/trivy-after.png)
```

---

## 🔹 AWS VPC Dashboard

```md
![VPC Dashboard](screenshots/vpc-dashboard.png)
```

---

## 🔹 Subnet Configuration

```md
![Subnet Configuration](screenshots/subnet-configuration.png)
```

---

## 🔹 Route Table Configuration

```md
![Route Table](screenshots/route-table.png)
```

---

## 🔹 Security Group Rules

```md
![Security Group](screenshots/security-group.png)
```

---

## 🔹 Amazon ECR Repository

```md
![ECR Repository](screenshots/ecr-repository.png)
```

---

## 🔹 ECS Task Definition

```md
![Task Definition](screenshots/task-definition.png)
```

---

## 🔹 ECS Service Running

```md
![ECS Running](screenshots/ecs-service-running.png)
```

---

## 🔹 ECS Public IP

```md
![Public IP](screenshots/public-ip.png)
```

---

## 🔹 Application Running in Browser

```md
![Application Browser](screenshots/application-browser.png)
```

---

## 🔹 CloudWatch Logs

```md
![CloudWatch Logs](screenshots/cloudwatch-logs.png)
```

---

## 🔹 CloudWatch Alarm Configuration

```md
![CloudWatch Alarm](screenshots/cloudwatch-alarm.png)
```

---

## 🔹 Example Error Output

```md
![Error Output](screenshots/error-output.png)
```

---

# ⚠️ Issues Faced & Resolution

## Issue: IAM Permission Errors

* ECS tasks failed because required permissions were missing.

### Resolution:

* Updated IAM policies
* Attached correct ECS execution roles
* Verified least privilege access

---

## Issue: Public IP Not Accessible

* Application could not be accessed through browser.

### Resolution:

* Enabled auto-assign public IP
* Verified Security Group inbound rules
* Checked subnet routing configuration

---

## Issue: Docker Port Mapping Problems

* Container was running but application was inaccessible.

### Resolution:

* Corrected container port mappings in ECS task definition
* Verified Flask application listening port

---

## Issue: Vulnerabilities in Docker Image

* Trivy detected HIGH and CRITICAL vulnerabilities.

### Resolution:

* Switched to Alpine Linux image
* Removed unnecessary packages
* Rebuilt hardened Docker image

---

# 🎯 Key Learnings

* Docker containerization
* Container image hardening
* Vulnerability assessment using Trivy
* ECS Fargate deployment
* AWS VPC networking
* IAM role and permission management
* CloudWatch logging and monitoring
* Troubleshooting cloud deployment issues
* Secure cloud-native deployment workflows

---

# 👨‍💻 Author

**Soloman Antony**

Cloud & DevOps Project  
LEAD College (Autonomous)
