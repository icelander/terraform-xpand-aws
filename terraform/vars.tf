## License Settings
variable "mariadb_es_token" {
  description = "Your MariaDB enterprise token"
  default = "TOKEN VALUE"
}

variable "xpand_license" {
  description = "Your Xpand license string"
  default = "{\"expiration\":\"2022-10-11 12:13:14\",\"company\":\"Some Corp.\",\"email\":\"some.person@somecorp.com\",\"person\":\"Some Person\",\"signature\":\"THISISNOTAREALSIGNATURE\"}"
}

## SSH Settings
variable "ssh_key_path" {
  description = "The full path to the keyfile that corresponds to the aws_key_name"
  default = "/Users/someperson/.ssh/terraform-key.pem"
}

variable "ssh-location" {
  description = "IP address to allow access from"
  default = "YOUR IP ADDRESS"
}

variable "aws_key_name" {
  description = "The name of the AWS key to use"
  default = "terraform-key"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "aws_availability_zone" {
  default = "us-east-2a"
}

variable "aws_profile" {
  description = "The name of the profile in aws_creds to use"
  default = "566086542069_AWS-Profile"
}


## Jumpbox Settings
variable "jump_instance_type" {
  default = "t2.micro"
}


## Xpand Settings
variable "db_instance_type" {
  default = "c5d.2xlarge"
}

variable "db_instance_count" {
  type = number
  default = 3
}

variable "xpand_root_password" {
  default = "really_secure_password"
}

## MaxScale Settings
variable "maxscale_instance_type" {
  default = "r5.large"
}

variable "maxscale_instance_count" {
  type = number
  default = 2
}

variable "ssh_username" {
  default = "centos"
}

variable "xpand_archive_filename" {
  default = "xpand-6.0.5.el7.tar.bz2"
}

## VPC Settings
variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
}

variable "Public_Subnet_1" {
  default = "10.0.0.0/24"
  description = "Public_Subnet_1"
}

variable "Private_Subnet_1" {
  default = "10.0.2.0/24"
  description = "Private_Subnet_1"
}