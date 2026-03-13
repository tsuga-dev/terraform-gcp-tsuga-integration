locals {
  otel_config_rendered = templatefile(
    "${path.module}/templates/otel-config.yaml.tmpl",
    {
      project_id          = var.project_id
      subscription        = var.enable_logs ? "projects/${var.project_id}/subscriptions/${google_pubsub_subscription.logs_sub[0].name}" : ""
      collection_interval = var.collection_interval
      tsuga_intake_url    = var.tsuga_intake_url
      enable_logs         = var.enable_logs
      enable_metrics      = var.enable_metrics
    }
  )
}

check "collection_types_validation" {
  assert {
    condition     = var.enable_logs || var.enable_metrics
    error_message = "At least one collection type must be enabled. Set either enable_logs = true or enable_metrics = true (or both)."
  }
}
