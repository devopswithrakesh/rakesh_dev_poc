module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

     cluster_name = local.name 
     cluster_endpoint_public_access=true
      
      cluster_addons = {
         coredns                = {
            most_recent=true
         }
    
    kube-proxy             = {
        most_recent=true
    }
    vpc-cni                = {
        most_recent=true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
    
    eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      
      min_size = 1
      max_size = 2
      desired_size = 1

      instance_types = [t2.medium"]
      capacity_type = "SPOT"
    }
  }

  tags = local.tags
}
}
