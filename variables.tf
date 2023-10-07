variable "region" {
  default = "us-west-1"
}

variable "env" {
  description = "Environment to be managed by Terraform"
  default     = "prod"
}

variable "DMK" {
  description = "Customer to be managed by Terraform"
  default     = "dmk"
}
