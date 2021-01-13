variable "container_name" {
  description = "(Required) The name of the Container which should be created within the Storage Account."
}

variable "storage_account_name" {
  description = "(Required) The name of the Storage Account where the Container should be created."
}

variable "container_access_type" {
  description = "(Optional) The Access Level configured for this Container.)"
  default     = "private"
  validation {
    condition     = var.container_access_type == "private" || var.container_access_type == "container" || var.container_access_type == "blob"
    error_message = "Possible values are blob, container or private."
  }
}
