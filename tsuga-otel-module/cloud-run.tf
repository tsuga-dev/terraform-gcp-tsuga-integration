resource "google_cloud_run_v2_service" "otel" {
  name                = "${var.prefix}-otel"
  location            = var.region
  deletion_protection = false

  template {
    service_account = google_service_account.otel.email

    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    containers {
      image = "otel/opentelemetry-collector-contrib:0.132.0"
      args  = ["--config=file:/etc/otel/config.yaml"]

      env {
        name = "TSUGA_API_KEY"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.tsuga_secret.name
            version = "latest"
          }
        }
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
        cpu_idle = var.cpu_always_allocated ? false : true
      }

      volume_mounts {
        name       = "otel-config"
        mount_path = "/etc/otel"
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 8080
        }
        initial_delay_seconds = 30
        period_seconds        = 30
        timeout_seconds       = 5
        failure_threshold     = 3
      }

      startup_probe {
        http_get {
          path = "/"
          port = 8080
        }
        initial_delay_seconds = 10
        period_seconds        = 5
        timeout_seconds       = 3
        failure_threshold     = 30
      }
    }

    volumes {
      name = "otel-config"
      secret {
        secret = google_secret_manager_secret.otel_config.name
        items {
          version = "latest"
          path    = "config.yaml"
        }
      }
    }
  }

  depends_on = [
    google_project_service.apis,
    google_secret_manager_secret_version.otel_config_version
  ]
}
