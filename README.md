# cosmos-terraform-NSOT

The Cosmos Terraform NSOT template will build out a higly available, dedicated NSOT environment including:
<br /> i. Dedicated NSOT VPC within the region you specify
<br /> ii. public subnets/routing tables for DMZ access to environment via a public facing bastion/management host as well as NGWs for                private subnet internet access.
<br />iii. private routing table/subnets for isolated backend app servers only accessible via the management/bastion host and through the            ELBs for the WebUI.
<br />iv.  Redundant/dedicated private RDS MySQL Database cluster for NSOT DB.
<br />v.   ASG configured to always run 2 instances of the NSOT frontend servers. The actual NSOT frontend application runs within a                  container which is pulled down automatically when the instances build out.
<br />vi.  Route53 DNS entry pointing to the NSOT frontend app ELB.

<br /> In order to run the template, please follow the instructions below using an ubuntu 16.04 instance/box.

<br /> 1. Clone this Repo.
<br /> 2. Create a new SSH public/private key pair and place the files in your /home/.ssh/ directory. They will be used to login to the NSOT instances once the build is complete. By default, the ssh key variables in the variables.tf are named "cosmos-admin" so when you generate your keys, use this name if possible.
<br /> 3. open the main.tf file in the top-level directory and change the variable values for the terraform modules to the region, subnets, ubuntu ami for the region you specify as required in each module. 
<br /> 4. once complete, run terraform init && terraform get && terraform plan. This will compile the necessary modules with the variable           values you added, and check for issues. if no issues, run terraform apply to build out the environment.
<br /> 3. Once the environment is built, SSH in to the bastion host and then jump from there via ssh to one of the NSOT APP frontend                 servers and run the following command to create a super user account which you will use to login to the NSOT webui in the next s           tep: sudo docker exec -it nsot /bin/bash
<br />         sudo nsot-server createsuperuser
<br />
<br />   Once complete, open a browser and go to http://<dns name you specified for the DNS var in the NSOT module>.shared.prsn-dev.io.            This will take you to the NSOT webui where you can log in w/ your NSOT username/password set in the previous step.
