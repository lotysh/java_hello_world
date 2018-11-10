1. Deploy infrastructure using terraform
create S3 bucket to store tfstate name "terraform-state-testtask"
after that:
cd /terrafrom/stack
terraform plan -var-file=env/env.tfvars
terraform apply -var-file=env/env.tfvars

Checked  on:
$ terraform --version
Terraform v0.11.7

2. Go to AWS CodeBuild and start build (you also can add triger to that project)
3. Deploy app using Ansible
ansible-playbook test.yml

Checked  on:
$ ansible --version
ansible 2.6.0 (devel 3d06ce245a) last updated 2018/02/20 18:27:30 (GMT +300)

4. Application will be available on:
http://yourlb.region.elb.amazonaws.com/sparkjava-hello-world-1.0/hello