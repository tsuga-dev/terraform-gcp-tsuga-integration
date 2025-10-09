resource "google_service_account" "otel" {
  account_id   = "${var.prefix}-otel"
  display_name = "OTel Collector for GCP telemetry"
}

resource "google_project_iam_member" "otel_roles" {
  project = var.project_id
  for_each = toset([
    "roles/pubsub.subscriber",
    "roles/monitoring.viewer",
    "roles/secretmanager.secretAccessor"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.otel.email}"
}
