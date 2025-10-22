output "cloud_run_url" {
  description = "The Cloud Run service URL (useful for health/debug)."
  value       = google_cloud_run_v2_service.otel.uri
}

output "service_account_email" {
  description = "Service account used by the OTel collector."
  value       = google_service_account.otel.email
}
