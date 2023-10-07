variable "DMK" {
  type    = string
  default = null
}

variable "env" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "zones" {
  type    = list(string)
  default = ["a", "b", "c"]
}

variable "vpc_cidr" {
  type    = string
  default = null
}

variable "public_subnet_cidr_blocks" {
  type    = map(string)
  default = {}
}

variable "private_subnet_cidr_blocks" {
  type    = map(string)
  default = {}
}
variable "db_private_subnet_cidr_blocks" {
  type    = map(string)
  default = {}
}
