output "logs_service_url" {
  description = "The Cloud Run logs service URL."
  value       = var.enable_logs ? google_cloud_run_v2_service.otel_logs[0].uri : null
}

output "metrics_service_url" {
  description = "The Cloud Run metrics service URL."
  value       = var.enable_metrics ? google_cloud_run_v2_service.otel_metrics[0].uri : null
}

output "service_account_email" {
  description = "Service account used by the OTel collectors."
  value       = local.otel_service_account_email
}
