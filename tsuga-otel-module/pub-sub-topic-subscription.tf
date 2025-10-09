data "google_project" "project" {
  project_id = var.project_id
}

resource "google_pubsub_topic" "logs_topic" {
  count   = var.enable_logs ? 1 : 0
  project = var.project_id
  name    = "${var.prefix}-logs-topic"
}

resource "google_pubsub_subscription" "logs_sub" {
  count   = var.enable_logs ? 1 : 0
  project = var.project_id
  name    = "${var.prefix}-logs-push-sub"
  topic   = google_pubsub_topic.logs_topic[0].name
}

resource "google_pubsub_topic_iam_member" "logs_sa_publishing_permissions" {
  count   = var.enable_logs ? 1 : 0
  project = var.project_id

  topic  = google_pubsub_topic.logs_topic[0].name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-logging.iam.gserviceaccount.com"
}
