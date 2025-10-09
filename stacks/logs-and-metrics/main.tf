module "tsuga_full_integration" {
  source           = "../../tsuga-otel-module"
  project_id       = "{{Your GCP Project ID}}"
  region           = "{{Your GCP Region}}"
  tsuga_api_key    = "{{Your Tsuga API Key}}"
  tsuga_intake_url = "{{Your Tsuga intake URL}}"

  enable_logs    = true
  enable_metrics = true
}
