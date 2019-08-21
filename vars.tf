variable "AWS_REGION" {}
variable "VPC_CIDR" { default = [] }
variable "ENV" {
	default = "Security"
}
variable "PublicSubnetAZ1CIDR" { default = [] }
variable "PublicSubnetAZ2CIDR" { default = [] }
variable "PrivateSubnetAZ1CIDR" { default = [] }
variable "PrivateSubnetAZ2CIDR" { default = [] }


