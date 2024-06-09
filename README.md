# Minecraft Server using Terraform

## Requirements
1. A personal computer with internet connection and Python and Git installed.
2. An AWS account (AWS Academy is used here)
3. Terraform CLI installed [Install Instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
4. AWS CLI installed [Install Instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
5. nmap installed (for checking if the server is running) [Install Instructions](https://nmap.org/download)
6. If you want to play the game, a Minecraft client (not shown in this tutorial)

## Stages of Pipeline
All the stages are automated using Terraform scripts and an Ansible playbook.
 
The stages are:
1. Provisioning the EC2 instance
2. Installing dependencies on the EC2 instance
3. Downloading the Minecraft server jar file
4. Creating the script to run the server
5. Setting up the End User License Agreement
6. Creating the service to run the server
7. Starting the server

The stages are completed by first running the Terraform scripts and then running the Ansible playbook.


## How to run the scripts
1. Clone the repository
2. Configure your AWS credentials
    ```bash
    aws configure set aws_access_key_id "<youraccesskey>"
    aws configure set aws_secret_access_key "<yoursecretkey>"
    aws configure set aws_session_token "<yourtoken>"
    ```
3. Run the Terraform scripts
    ```bash
    terraform init
    terraform apply
    ```
4. Confirm the IP address that is outputted after running `terraform apply` is the same as the IP address in the `hosts` file (replace if needed).
5. Run the Ansible playbook
    ```bash
    ansible-playbook -i hosts minecraft_server.yml
    ```
6. Confirm the server is running with the following command:
      ```bash
      nmap -sV -Pn -p T:25565 <public_ip>
      ```
  - Replace `<public_ip>` with the public IP of the EC2 instance that is displayed in the Terraform output.


## Resources
- Terraform Docs: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- AWS Docs: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- mineOps - Part 2: Automation with Ansible: https://blog.kywa.io/mineops-part-2/
- Deploying (Minecraft) Servers Automatically with Terraform: https://www.endpointdev.com/blog/2020/07/automating-minecraft-server/
- The above articles got me started, but pretty much every question I had was resolved in office hours. Thanks!


