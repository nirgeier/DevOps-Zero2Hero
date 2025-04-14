variable "region" {
  type    = string
  default = "il-central-1"
}

variable "unique_bucket_prefix" {
  type    = string
  default = "devopszero2hero"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.unique_bucket_prefix))
    error_message = "s3 bucket names must be lowercase and contain only letters, numbers, and hyphens."
  }
}