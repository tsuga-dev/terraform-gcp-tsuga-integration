module "tsuga_logs_integration" {
  source           = "../../tsuga-otel-module"
  project_id       = var.project_id
  region           = var.region
  prefix           = var.prefix
  tsuga_api_key    = var.tsuga_api_key
  tsuga_intake_url = var.tsuga_intake_url

  enable_logs    = true
  enable_metrics = false

  min_instances        = var.min_instances
  max_instances        = var.max_instances
  cpu_always_allocated = var.cpu_always_allocated
}
