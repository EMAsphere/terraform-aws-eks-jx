// ----------------------------------------------------------------------------
// Query necessary data for the module
// ----------------------------------------------------------------------------


data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "aws_caller_identity" "current" {}

// ----------------------------------------------------------------------------
// Define K8s cluster configuration
// ----------------------------------------------------------------------------
provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "1.11.1"
}

// ----------------------------------------------------------------------------
// Create the AWS VPC
// See https://github.com/terraform-aws-modules/terraform-aws-vpc
// ----------------------------------------------------------------------------
// Removed

// ----------------------------------------------------------------------------
// Create the EKS cluster with extra EC2ContainerRegistryPowerUser policy
// See https://github.com/terraform-aws-modules/terraform-aws-eks
// ----------------------------------------------------------------------------
// Removed

// ----------------------------------------------------------------------------
// Update the kube configuration after the cluster has been created so we can
// connect to it and create the K8s resources
// ----------------------------------------------------------------------------
// Removed

// ----------------------------------------------------------------------------
// Create the necessary K8s namespaces that we will need to add the
// Service Accounts later
// ----------------------------------------------------------------------------
resource "kubernetes_namespace" "jx" {

  metadata {
    name = "jx"
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels,
      metadata[0].annotations,
    ]
  }
}

resource "kubernetes_namespace" "cert_manager" {

  metadata {
    name = "cert-manager"
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels,
      metadata[0].annotations,
    ]
  }
}
