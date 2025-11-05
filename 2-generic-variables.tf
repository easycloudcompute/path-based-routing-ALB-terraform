variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ca-central-1"
}

variable "environment" {
  description = "environment"
  type        = string
  default     = "dev"
}

variable "application" {
  description = "application"
  type        = string
  default     = "test-app"
}