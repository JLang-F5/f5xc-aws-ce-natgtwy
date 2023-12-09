# # Initialize availability zone data from AWS
data "aws_availability_zones" "available" {}

resource "volterra_aws_vpc_site" "example" {
  name = var.name
  namespace  = "system"
  aws_region = var.aws_region

  vpc {
    vpc_id = var.vpc
  }

  default_blocked_services = true
  ssh_key                  = var.ssh_key

  aws_cred {
    name      = var.cred
    namespace = "system"
    tenant    = var.tenant
  }

  egress_nat_gw {
    nat_gw_id = var.natgtwy
  }

  direct_connect_disabled = true
  instance_type           = var.instance
  disable_internet_vip = true
  logs_streaming_disabled = true
  custom_security_group {
    inside_security_group_id  = var.sec_group
    outside_security_group_id = var.sec_group
  }
  offline_survivability_mode {
    enable_offline_survivability_mode = true
  }

  ingress_egress_gw {
    sm_connection_pvt_ip = true
    allowed_vip_port {

      use_http_port = true

    }

    aws_certified_hw = "aws-byol-multi-nic-voltmesh"
    az_nodes {
      aws_az_name = var.az1
      disk_size   = "80"

      inside_subnet {
        existing_subnet_id = var.SecurityServiceInsideCIDRAZ1
      }
      outside_subnet {
        existing_subnet_id = var.SecurityServiceOutsideCIDRAZ1
      }
      workload_subnet {
        existing_subnet_id = var.SecurityServiceWorkloadCIDRAZ1
      }
    }
  }
}

resource "volterra_tf_params_action" "aws-vpc-site-terraform-params-action" {
  site_name = var.name
  site_kind = "aws_vpc_site"
  action = "apply"
  depends_on = [ volterra_aws_vpc_site.example ]
  wait_for_action = true
}