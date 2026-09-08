variable "project_id" {
  description = "GCP project ID where the collector runs"
  type        = string
}

variable "region" {
  description = "GCP region for Cloud Run"
  type        = string
}

variable "prefix" {
  description = "Base name for Cloud Run service and Secret"
  type        = string
  default     = "tsuga"
}

variable "tsuga_api_key" {
  description = "Tsuga API Key for integration"
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "tsuga_intake_url" {
  description = "Tsuga OTLP/HTTP ingestion endpoint"
  type        = string
}

variable "vpc_network" {
  description = "VPC network to route collector egress through"
  type        = string
}

variable "vpc_subnetwork" {
  description = "Subnetwork (in the Cloud Run region) for the collectors' Direct VPC egress"
  type        = string
}
