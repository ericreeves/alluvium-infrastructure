#---------------------------------------------------------------------------------------
# Packer Plugins
#---------------------------------------------------------------------------------------
packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


#---------------------------------------------------------------------------------------
# Common Image Metadata
#---------------------------------------------------------------------------------------
variable "hcp_bucket_name" {
  default = "alluvium-base"
}

variable "image_name" {
  default = "alluvium-base"
}

variable "version" {
  default = "1.0.0"
}


#--------------------------------------------------
# AWS Image Config and Definition
#--------------------------------------------------
variable "aws_region" {
  default = "us-west-2"
}

data "amazon-ami" "aws_base" {
  region = var.aws_region
  filters = {
    name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "alluvium-base" {
  region         = var.aws_region
  source_ami     = data.amazon-ami.aws_base.id
  instance_type  = "t3.micro"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_aws_{{timestamp}}_${var.image_name}_v${var.version}"
}


#---------------------------------------------------------------------------------------
# Common Build Definition
#---------------------------------------------------------------------------------------
build {

  hcp_packer_registry {
    bucket_name = "alluvium-base"
    description = <<EOT
This is the base Ubuntu image + Our "Platform" (nginx)
    EOT
    bucket_labels = {
      "owner"          = "platform-team"
      "os"             = "Ubuntu"
      "ubuntu-version" = "Focal 20.04"
      "image-name"     = var.image_name
    }

    build_labels = {
      "build-time"        = timestamp()
      "build-source"      = basename(path.cwd)
      "alluvium-base-version" = var.version
    }
  }

  sources = [
    "sources.amazon-ebs.alluvium-base"
  ]

  provisioner "shell" {
    inline = [
      "sleep 10",
      "sudo apt -y update",
      "sudo apt -y install nginx",
      "sudo ufw allow 'Nginx HTTP'",
      "sudo systemctl enable nginx",
      "sudo systemctl status nginx",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
    ]

  }
}