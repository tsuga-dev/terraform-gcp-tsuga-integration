# --- Enable required APIs ---
resource "google_project_service" "apis" {
  project = var.project_id

  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "serviceusage.googleapis.com",
  ])
  service            = each.key
  disable_on_destroy = false
}
