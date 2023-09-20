module "vpc" {
  source   = "../Z.modules/vpc"
  vpc_cidr = "10.10.0.0/16"
  zones    = ["a", "b", "c"]
  DMK     = var.DMK
  env      = var.env

  public_subnet_cidr_blocks = {zone0 = "10.10.0.0/24",zone1 = "10.10.1.0/24",zone2 = "10.10.2.0/24"
  }
  private_subnet_cidr_blocks = {zone0 = "10.10.3.0/24",zone1 = "10.10.4.0/24",zone2 = "10.10.5.0/24"
  }
  db_private_subnet_cidr_blocks = {zone0 = "10.10.6.0/24",zone1 = "10.10.7.0/24",zone2 = "10.10.8.0/24"
  }
}
