variable "region" {
  type        = string
  description = "Region to be set either in an environment specific file or default values to come from terraform.tfvars file"
}

variable "instance_type" {
  type        = string
  description = "Define EC2 instance type"
}

variable "DnsZoneName" {
  type        = string
  description = "DnsZoneName"
}

variable "public_key" {
  description = "This value is set in cloud-init in data.tf file. This variable will be set in terraform commandline. See README"
}