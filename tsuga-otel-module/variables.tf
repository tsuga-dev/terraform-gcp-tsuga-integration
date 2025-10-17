variable "project_id" {
  description = "GCP project ID where the collector runs."
  type        = string
}

variable "region" {
  description = "GCP region for Cloud Run."
  type        = string
}

variable "prefix" {
  description = "Base name for Cloud Run service and Secret."
  type        = string
  default     = "tsuga"
}

variable "collection_interval" {
  description = "How often to pull metrics from Cloud Monitoring (e.g., 60s)."
  type        = string
  default     = "300s"
}

variable "tsuga_intake_url" {
  description = "TSUGA OTLP/HTTP ingestion endpoint."
  type        = string
}

variable "tsuga_api_key" {
  description = "Tsuga API Key for integration."
  type        = string
  sensitive   = true
}

variable "enable_logs" {
  description = "Enable log collection from GCP to Tsuga."
  type        = bool
  default     = true
}

variable "enable_metrics" {
  description = "Enable metrics collection from GCP to Tsuga."
  type        = bool
  default     = true
}

variable "min_instances" {Add a comment on lines R46 to R56Add diff commentMarkdown input:  edit mode selected.WritePreviewAdd a suggestionHeadingBoldItalicQuoteCodeLinkUnordered listNumbered listTask listMentionReferenceSaved repliesAdd FilesPaste, drop, or click to add filesCancelCommentStart a reviewReturn to code
  description = "Minimum number of Cloud Run instances to keep warm."
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of Cloud Run instances to allow."
  type        = number
  default     = 10
}

variable "cpu_always_allocated" {
  description = "If true, CPU remains allocated when the container is idle (no throttling)."
  type        = bool
  default     = true
}