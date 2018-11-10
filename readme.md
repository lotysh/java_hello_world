# Hello world on AWS (Maven + Terraform + Ansible)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Test project which realize :

  - AWS via Terraform (EC2, Autoscalling, Health check, Loadbalancing CodeBuild)
  - Build war file on CodeBuild
  - Deploy war using Ansible on EC2 ( dynamic inventory ec2.py)

### Installation
1. Deploy infrastructure using terraform
create S3 bucket to store tfstate name "terraform-state-testtask"
after that:
```sh
cd /terrafrom/stack
terraform plan -var-file=env/env.tfvars
terraform apply -var-file=env/env.tfvars
```
Checked  on:
```sh
terraform --version
Terraform v0.11.7
```
2. Go to AWS CodeBuild and start build (you also can add triger to that project)
3. Deploy app using Ansible
First of all change ssh config to allow ansible to connect instances
```sh
TCPKeepAlive    yes
ServerAliveInterval 10
ServerAliveCountMax 5
CheckHostIP     no
Compression     yes
ForwardX11      no
StrictHostKeyChecking no
ForwardAgent    no


Host  !insert public ip your nat!
  User ec2-user
  IdentityFile /home/iloty/ansible/hello-world-instances.pem

Host 10.170.*.*
  User ec2-user
  ForwardAgent yes
  StrictHostKeyChecking no
  IdentityFile /home/iloty/ansible/hello-world-instances.pem
  ProxyCommand ssh -i /home/iloty/ansible/hello-world-instances.pem  -o StrictHostKeyChecking=no ec2-user@18.222.182.165 nc %h %p
```
And after that run:
```sh
ansible-playbook test.yml
```
Checked  on:
```sh
ansible --version
ansible 2.6.0 (devel 3d06ce245a) last updated 2018/02/20 18:27:30 (GMT +300)
```
4. Application will be available on:
http://yourlb.region.elb.amazonaws.com/sparkjava-hello-world-1.0/hello

