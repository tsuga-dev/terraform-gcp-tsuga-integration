# Telemetry Collection Integration - Google Cloud Platform to Tsuga

This module deploys two OTel collectors on Google Cloud Run to collect logs and/or metrics from your GCP account:

- **Logs service** - pulls from a Pub/Sub subscription and scales horizontally based on CPU load. Also creates the Pub/Sub topic, subscription, and log sink.
- **Metrics service** - polls GCP Cloud Monitoring on a configurable interval. Pinned to a single instance to prevent duplicate metric collection.

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

| Variable                      | Description                                                                                      | Type   | Default                                        | Required |
| ----------------------------- | ------------------------------------------------------------------------------------------------ | ------ | ---------------------------------------------- | -------- |
| `project_id`                  | GCP project ID where the collectors run                                                          | string | -                                              | yes      |
| `region`                      | GCP region for Cloud Run                                                                         | string | -                                              | yes      |
| `tsuga_api_key`               | Tsuga API Key for integration                                                                    | string | -                                              | yes      |
| `tsuga_intake_url`            | Tsuga OTLP/HTTP ingestion endpoint                                                               | string | -                                              | yes      |
| `prefix`                      | Base name for Cloud Run services and Secrets                                                     | string | "tsuga"                                        | no       |
| `enable_logs`                 | Enable log collection from GCP to Tsuga                                                          | bool   | true                                           | no       |
| `enable_metrics`              | Enable metrics collection from GCP to Tsuga                                                      | bool   | true                                           | no       |
| `collection_interval`         | How often to pull metrics from Cloud Monitoring                                                  | string | "300s"                                         | no       |
| `logs_min_instances`          | Minimum number of logs collector instances to keep warm                                          | number | 1                                              | no       |
| `logs_max_instances`          | Maximum number of logs collector instances. The metrics service is always fixed at 1 instance.   | number | 10                                             | no       |
| `pubsub_ack_deadline_seconds` | Pub/Sub ack deadline in seconds (10–600). Increase if messages are redelivered under heavy load. | number | 60                                             | no       |
| `otel_service_account_email`  | Existing service account email for the collectors. If unset, one is created automatically.      | string | null                                            | no       |

### Outputs

| Output                  | Description                              |
| ----------------------- | ---------------------------------------- |
| `logs_service_url`      | URL of the Cloud Run logs service        |
| `metrics_service_url`   | URL of the Cloud Run metrics service     |
| `service_account_email` | Service account used by both collectors  |

## Examples

See the `examples/` folder.

## Security

Note that for convenience, the Tsuga API key is passed in Terraform state: you can mitigate this by encrypting the Terraform state.
