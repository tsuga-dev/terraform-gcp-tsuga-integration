module "tsuga_logs_integration" {
  source           = "../.."
  project_id       = var.project_id
  region           = var.region
  prefix           = var.prefix
  tsuga_api_key    = var.tsuga_api_key
  tsuga_intake_url = var.tsuga_intake_url

  enable_logs    = true
  enable_metrics = false

  logs_min_instances = var.logs_min_instances
  logs_max_instances = var.logs_max_instances
}
