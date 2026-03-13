module "tsuga_metrics_integration" {
  source           = "../.."
  project_id       = var.project_id
  region           = var.region
  prefix           = var.prefix
  tsuga_api_key    = var.tsuga_api_key
  tsuga_intake_url = var.tsuga_intake_url

  enable_logs    = false
  enable_metrics = true

  collection_interval  = var.collection_interval
  min_instances        = var.min_instances
  max_instances        = var.max_instances
  cpu_always_allocated = var.cpu_always_allocated
}
