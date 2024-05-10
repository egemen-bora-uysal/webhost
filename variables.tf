variable "name" {
  type        = string
  description = "Name of the work being worked on with terraform"
}
variable "project_id" {
  type        = string
  description = "ID of the Google Cloud project resources will created under"
}
variable "zone" {
  type        = string
  description = "Zone of the resources created in given Google Cloud region"
}
variable "region" {
  type        = string
  description = "Google Cloud region the resources will be created in"
}
variable "ip_range" {
  type        = string
  description = "IP range of the created subnet"
}
variable "state-bucket" {
  type        = string
  description = "Google storage bucket name for terraform backend configuration"
}
variable "min-replica-count" {
  type        = string
  description = "Minimum number of Google Compute instances for managed instance group autoscaler"
}
variable "max-replica-count" {
  type        = string
  description = "Maximum number of Google Compute instances for managed instance group autoscaler"
}
variable "cpu-target" {
  type        = string
  description = "Cpu target utilization for managed instance group autoscaler"
}
variable "machine_type" {
  type        = string
  description = "Google compute machine type for instance template"
}
variable "cloud_armor_allowed_ips" {
  type        = list(string)
  description = "IP adresses and/or ranges to be allowed traffic by the Google Cloud Armor"
}
variable "email_addresses" {
  type        = list(string)
  description = "Email addresses that will recieve Cloud Monitoring alerts"
}
variable "subnet_pod_ip_range" {
  type = string
}
variable "subnet_svc_ip_range" {
  type = string
}
variable "master_ip_range" {
  type = string
}
