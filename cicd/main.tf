module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-tf"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0cab6b9e7e0937b11"] #replace your SG
  subnet_id = "subnet-003f9e3a9ec29d47a" #replace your Subnet
  ami = data.aws_ami.ami_info.id
  user_data = file("jenkins.sh")
  tags = {
    Name = "jenkins-tf"
  }
}

module "jenkins_agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-agent"

  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0cab6b9e7e0937b11"]
  # convert StringList to list and get first element
  subnet_id = "subnet-003f9e3a9ec29d47a"
  ami = data.aws_ami.ami_info.id
  user_data = file("jenkins-agent.sh")
  tags = {
    Name = "jenkins-agent"
  }
}

resource "aws_key_pair" "tools" {
  key_name   = "tools"
  # you can paste the public key directly like this
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/EYXhkubgb3WuAjDsaTWNcuF76fP24dApVykLRJvql Usha@DESKTOP-09GJKR9"
  public_key = file("~/.ssh/nexus.pub")
  # ~ means windows home directory
}


# module "nexus" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#   name = "nexus"

#   instance_type          = "t3.small"
#   vpc_security_group_ids = ["sg-0cab6b9e7e0937b11"] #replace your SG
#   subnet_id = "subnet-003f9e3a9ec29d47a" #replace your Subnet
#   ami = data.aws_ami.nexus_ami_info.id
#   key_name = aws_key_pair.tools.key_name
#   root_block_device = {
#       volume_type = "gp3"
#       volume_size = 30
#     }
  
  
#   instance_tags = {
#   Name = "nexus"
# }

  
  
#}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "jenkins"
      type    = "A"
      ttl     = 1
      records = [
        module.jenkins.public_ip
      ]
      allow_overwrite = true
    },
    {
      name    = "jenkins-agent"
      type    = "A"
      ttl     = 1
      records = [
        module.jenkins_agent.private_ip
      ]
      allow_overwrite = true
    },
    # {
    #   name    = "nexus"
    #   type    = "A"
    #   ttl     = 1
    #   allow_overwrite = true
    #   records = [
    #     module.nexus.private_ip
    #   ]
    #   allow_overwrite = true
    # }
  ]

}