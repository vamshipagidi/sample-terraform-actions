variable "region" {
  default = "us-east-1"
}

variable "env" {
  description = "Environment to be managed by Terraform"
  default     = "dev"
}

variable "DMK" {
  description = "Customer to be managed by Terraform"
  default     = "dmk"
}