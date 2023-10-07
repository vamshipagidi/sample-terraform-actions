variable "region" {
  default = "us-west-2"
}

variable "env" {
  description = "Environment to be managed by Terraform"
  default     = "dev"
}

variable "DMK" {
  description = "Customer to be managed by Terraform"
  default     = "dmk"
}
