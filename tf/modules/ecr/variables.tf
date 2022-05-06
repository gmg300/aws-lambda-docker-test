
variable "name" {
  description = "Name of the ECR repo"
  type        = string
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default     = false
  type        = bool
}

variable "mutable" {
    description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE."
    default = "MUTABLE"
    type = string
}
