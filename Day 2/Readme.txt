# Terraform AWS Infrastructure Project 🚀

## Project Overview

This project demonstrates how to **provision AWS infrastructure using Terraform** and deploy a simple static webpage on an **Apache server running on an EC2 instance**.

The infrastructure is created using **modular Terraform architecture**, where networking resources and compute resources are separated into reusable modules.

Once the infrastructure is provisioned, **Terraform provisioners** automatically configure the EC2 instance, install Apache, and deploy a static HTML file.

---

## Architecture

The project creates the following AWS resources:

* Custom **VPC**
* **Public Subnet**
* **Internet Gateway**
* **Route Table**
* **Security Group**
* **EC2 Instance**
* **Apache Web Server**

### Infrastructure Flow

```
Terraform Root Module
        │
        ├── VPC Module
        │       ├── VPC
        │       ├── Subnet
        │       ├── Internet Gateway
        │       └── Route Table
        │
        └── EC2 Module
                ├── Security Group
                ├── EC2 Instance
                └── Provisioners
                        ├── Install Apache
                        └── Deploy HTML file
```

---

## Project Structure

```
Day1/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── app.html
│
└── modules
    │
    ├── vpc
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── ec2
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Terraform Concepts Used

This project demonstrates the following Terraform concepts:

* **Terraform Modules**
* **AWS Provider Configuration**
* **Infrastructure as Code (IaC)**
* **Variable Management**
* **Output Values**
* **Remote Provisioners**
* **File Provisioners**
* **SSH Connection Blocks**

---

## Provisioner Tasks

The EC2 instance is automatically configured using Terraform provisioners.

### Steps executed on EC2

1. Update packages
2. Install Apache
3. Start Apache service
4. Enable Apache service
5. Copy HTML file to the server
6. Deploy webpage to Apache directory

Example:

```
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
```

---

## Static Webpage Deployment

Terraform uploads the file **app.html** to the EC2 instance using a **file provisioner**, then moves it to the Apache web directory.

```
/var/www/html/index.html
```

Once deployed, the webpage is accessible using the **EC2 public IP**.

---

## How to Run This Project

### 1. Initialize Terraform

```
terraform init
```

### 2. Validate Configuration

```
terraform validate
```

### 3. Preview Infrastructure

```
terraform plan
```

### 4. Create Infrastructure

```
terraform apply
```

Type:

```
yes
```

---

## Access the Webpage

After the deployment completes, Terraform will output the **EC2 public IP**.

Open the IP in a browser:

```
http://<EC2_PUBLIC_IP>
```

You should see the deployed webpage.

---

## Example Output

```
Outputs:

ec2_public_ip = 13.xx.xx.xx
```

---

## Key Features of This Project

* Modular Terraform design
* Automated infrastructure provisioning
* Automated server configuration
* Static website deployment
* Clean and reusable Terraform modules

---

## Technologies Used

* Terraform
* AWS EC2
* AWS VPC
* Apache Web Server
* Linux
* Git

---

## Future Improvements

Possible enhancements for this project:

* Add **private subnet**
* Deploy using **Application Load Balancer**
* Use **Terraform remote backend (S3 + DynamoDB)**
* Implement **CI/CD pipeline using Jenkins or GitHub Actions**
* Deploy containerized applications using **Docker**

---

## Author

**Ragam Sony**

DevOps enthusiast passionate about Infrastructure Automation and Cloud Technologies.

