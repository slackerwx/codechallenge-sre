variable "environment_tag" {
  description = "Environment tag"
  default     = "dev"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "cidr_subnet_public" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"

}
