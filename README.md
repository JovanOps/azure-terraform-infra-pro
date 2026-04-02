# Azure Terraform Infrastructure (Linux VM + Nginx)

## 📌 Project Overview
This project demonstrates a complete Infrastructure as Code (IaC) workflow on Azure, from provisioning to deployment and cleanup.
This project demonstrates provisioning a complete Azure infrastructure using **Terraform modules**, including:

- Resource Group
- Virtual Network (VNet)
- Subnet
- Public IP
- Network Interface (NIC)
- Network Security Group (NSG)
- Linux Virtual Machine (Ubuntu)
- Nginx Web Server

The VM is accessible via SSH and serves a web page over HTTP.

---

## 🧱 Architecture

Terraform Modules:

- `resource_group` → Creates Azure Resource Group
- `network` → Creates VNet, Subnet, Public IP, NIC
- Root module → Creates NSG, VM, and associations

```

Internet → Public IP → NIC → VM (Ubuntu + Nginx)
↓
NSG (SSH + HTTP)

````

---

## ⚙️ Technologies Used

- Terraform
- Microsoft Azure
- Linux (Ubuntu 22.04)
- Nginx
- Azure CLI

---

## 🚀 Deployment Steps

### 1. Clone repository

```bash
git clone https://github.com/JovanOps/azure-terraform-infra-pro.git
cd azure-terraform-infra-pro
````

---

### 2. Initialize Terraform

```bash
terraform init
```

---

### 3. Configure variables

Edit `terraform.tfvars`:

```hcl
resource_group_name = "rg-terraform-pro"
location            = "westeurope"
vm_size             = "Standard_D2s_v3"
admin_username      = "azureuser"
ssh_public_key      = "YOUR_PUBLIC_KEY"
```

---

### 4. Deploy infrastructure

```bash
terraform apply
```

---

### 5. Connect to VM

```bash
ssh azureuser@<PUBLIC_IP>
```

---

### 6. Install Nginx (optional step)

```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
```

---

### 7. Access in browser

```
http://public ip /
```

---

## 🔐 Security

NSG rules configured:

* SSH (port 22)
* HTTP (port 80)

---

## 🧹 Cleanup

```bash
terraform destroy
```

---

## 📸 Proof of Work

* Terraform deployment successful
* SSH connection established
* Nginx running on VM
* Web server accessible via public IP

---

## 💡 Key Learning Outcomes

* Modular Terraform architecture
* Azure networking basics
* VM provisioning via IaC
* Security group configuration
* Remote server management via SSH

---
## 📸 Screenshots

### Terraform Deployment
<img width="1920" height="1080" alt="Screenshot (1591)" src="https://github.com/user-attachments/assets/1e4c828e-c14e-45b9-b0b2-0951f7b8c8fb" />

### SSH Connection
<img width="1920" height="1080" alt="Screenshot (1593)" src="https://github.com/user-attachments/assets/1e794abb-a8d7-472d-9716-500a6c4eb884" />

### Nginx Running
<img width="1920" height="901" alt="Screenshot (1595)" src="https://github.com/user-attachments/assets/fa3f018d-e92c-49a3-ba96-838c1bbe074d" />

## 👤 Author

Jovan Ljusic
Cloud / DevOps Enthusiast

````
