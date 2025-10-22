resource "google_secret_manager_secret" "tsuga_secret" {
  secret_id = "${var.prefix}-api-key"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  depends_on = [google_project_service.apis]
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.tsuga_secret.id
  secret_data = var.tsuga_api_key
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  secret_id = google_secret_manager_secret.tsuga_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.otel.email}"
}

resource "google_secret_manager_secret" "otel_config" {
  secret_id = "${var.prefix}-otel-config"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  depends_on = [google_project_service.apis]
}

resource "google_secret_manager_secret_version" "otel_config_version" {
  secret      = google_secret_manager_secret.otel_config.id
  secret_data = local.otel_config_rendered
}

resource "google_secret_manager_secret_iam_member" "otel_config_access" {
  secret_id = google_secret_manager_secret.otel_config.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.otel.email}"
}
