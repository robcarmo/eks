# Define required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Specify your desired version constraint
    }
  }
}

# Configure the provider
provider "aws" {
  region = "us-west-1"  # Specify your desired region
  # Add any other provider-specific configuration here
}



module "eks" {
  source  = "./modules/eks"

  cluster_name = "my-eks-cluster"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
}

module "vpc" {
  source = "./modules/vpc"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
