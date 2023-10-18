module "vpc" {
  source   = "./z.modules/vpc"
  vpc_cidr = "10.10.0.0/16"
  zones    = ["a", "b", "c"]
  DMK     = var.DMK
  env      = var.env

  public_subnet_cidr_blocks = {zone0 = "10.10.110.0/24",zone1 = "10.10.11.0/24",zone2 = "10.10.12.0/24"
  }
  private_subnet_cidr_blocks = {zone0 = "10.10.13.0/24",zone1 = "10.10.14.0/24",zone2 = "10.10.15.0/24"
  }
  db_private_subnet_cidr_blocks = {zone0 = "10.10.16.0/24",zone1 = "10.10.17.0/24",zone2 = "10.10.18.0/24"
  }
}
