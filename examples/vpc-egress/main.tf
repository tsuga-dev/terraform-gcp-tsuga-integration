module "tsuga_vpc_egress" {
  source           = "../.."
  project_id       = var.project_id
  region           = var.region
  prefix           = var.prefix
  tsuga_api_key    = var.tsuga_api_key
  tsuga_intake_url = var.tsuga_intake_url

  # ALL_TRAFFIC (the default egress mode) sends every outbound packet through this
  # subnetwork, where your VPC firewall rules decide what the collectors may reach.
  vpc_access = {
    network    = var.vpc_network
    subnetwork = var.vpc_subnetwork
  }
}
