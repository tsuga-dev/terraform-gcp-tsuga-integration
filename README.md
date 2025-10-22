# Telemetry Collection Integration - Google Cloud Platform to Tsuga

## Prerequisites

- Download `gcloud` CLI.
- Download `terraform` CLI.
- Perform `gcloud auth login` before performing terraform commands.
- Tsuga API Key.
- Tsuga Intake URL.

## Usage

The `tsuga-otel-module` folder contains our OTel Tsuga terraform module for logs and/or metrics ingestion. You can configure the module to collect:

- **Logs only** - Set `enable_logs = true` and `enable_metrics = false`
- **Metrics only** - Set `enable_logs = false` and `enable_metrics = true`
- **Both logs and metrics** - Set `enable_logs = true` and `enable_metrics = true` (default)

### Configuration Variables

| Variable              | Description                                     | Type   | Default | Required |
| --------------------- | ----------------------------------------------- | ------ | ------- | -------- |
| `project_id`          | GCP project ID where the collector runs         | string | -       | yes      |
| `region`              | GCP region for Cloud Run                        | string | -       | yes      |
| `tsuga_api_key`       | Tsuga API Key for integration                   | string | -       | yes      |
| `tsuga_intake_url`    | Tsuga OTLP/HTTP ingestion endpoint              | string | -       | yes      |
| `prefix`              | Base name for Cloud Run service and Secret      | string | "tsuga" | no       |
| `collection_interval` | How often to pull metrics from Cloud Monitoring | string | "300s"  | no       |
| `enable_logs`         | Enable log collection from GCP to Tsuga         | bool   | true    | no       |
| `enable_metrics`      | Enable metrics collection from GCP to Tsuga     | bool   | true    | no       |

## Examples

### Logs Only

Fill the `stacks/logs-only/main.tf` file with your input variables and from the `stacks/logs-only/` directory, run the **terraform init, plan, and apply** commands.

### Metrics Only

Fill the `stacks/metrics-only/main.tf` file with your input variables and from the `stacks/metrics-only/` directory, run the **terraform init, plan, and apply** commands.

### Both Logs and Metrics

Fill the `stacks/logs-and-metrics/main.tf` file with your input variables and from the `stacks/logs-and-metrics/` directory, run the **terraform init, plan, and apply** commands.

## Security

Note that for convenience, the Tsuga API key is passed in Terraform state: you can disable this by commenting out the `google_secret_manager_secret_version` resources in `secret.tf` files and create the secret versions separately. Alternatively, you can encrypt Terraform's state.
