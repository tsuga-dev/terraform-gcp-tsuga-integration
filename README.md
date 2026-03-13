# Telemetry Collection Integration - Google Cloud Platform to Tsuga

This module creates an OTel collector running on Google Cloud Run to collect logs and/or metrics from your GCP account. It also creates a Pub/Sub topic and subscription if you set it to collect logs.

## Prerequisites

- Download `gcloud` CLI.
- Download `terraform` CLI.
- Perform `gcloud auth login` before performing terraform commands.
- Tsuga API Key.
- Tsuga Intake URL.

## Usage

Use the module from your own Terraform code and pin it to a published module version:

```hcl
module "tsuga_ingestion" {
  source  = "tsuga-dev/tsuga-ingestion/google"
  version = "<version>"

  project_id       = var.project_id
  region           = var.region
  tsuga_api_key    = var.tsuga_api_key
  tsuga_intake_url = var.tsuga_intake_url

  enable_logs    = true
  enable_metrics = true
}
```

You can configure the module to collect:

- **Logs only** - Set `enable_logs = true` and `enable_metrics = false`
- **Metrics only** - Set `enable_logs = false` and `enable_metrics = true`
- **Both logs and metrics** - Set `enable_logs = true` and `enable_metrics = true` (default)

### Configuration Variables

| Variable               | Description                                     | Type   | Default                                        | Required |
| ---------------------- | ----------------------------------------------- | ------ | ---------------------------------------------- | -------- |
| `project_id`           | GCP project ID where the collector runs         | string | -                                              | yes      |
| `region`               | GCP region for Cloud Run                        | string | -                                              | yes      |
| `tsuga_api_key`        | Tsuga API Key for integration                   | string | -                                              | yes      |
| `tsuga_intake_url`     | Tsuga OTLP/HTTP ingestion endpoint              | string | -                                              | yes      |
| `prefix`               | Base name for Cloud Run service and Secret      | string | "tsuga"                                        | no       |
| `collection_interval`  | How often to pull metrics from Cloud Monitoring | string | "300s"                                         | no       |
| `enable_logs`          | Enable log collection from GCP to Tsuga         | bool   | true                                           | no       |
| `enable_metrics`       | Enable metrics collection from GCP to Tsuga     | bool   | true                                           | no       |
| `min_instances`        | Minimum number of Cloud Run instances           | number | 1                                              | no       |
| `max_instances`        | Maximum number of Cloud Run instances           | number | 10                                             | no       |
| `cpu_always_allocated` | Keep CPU allocated when container is idle       | bool   | true                                           | no       |
| `otel_collector_image` | OTel Collector container image                  | string | "otel/opentelemetry-collector-contrib:0.145.0" | no       |

## Examples

See the `examples/` folder.

## Security

Note that for convenience, the Tsuga API key is passed in Terraform state: you can disable this by commenting out the `google_secret_manager_secret_version` resources in `secret.tf` files and create the secret versions separately. Alternatively, you can encrypt Terraform's state.
