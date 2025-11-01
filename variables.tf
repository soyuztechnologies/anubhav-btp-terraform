#Here we have put a fix value for the global account that should certainly be a variable.

variable "globalaccount" {
  description = "Subdomain of the global account"
  type        = string
  default     = "e3f183dbtrial-ga"
}

variable "subaccount_name" {
  description = "Name of the subaccount"
  type        = string
  default     = "Anubhav terraform 2"
}

variable "subaccount_subdomain" {
  description = "Subdomain of the subaccount"
  type        = string
  default     = "dev-anubhav-terraform2"
}

variable "subaccount_region" {
  description = "Region of the subaccount"
  type        = string
  default     = "us10"
}

variable "subaccount_beta_enabled" {
  description = "Beta feaatures enabled on subaccount"
  type        = bool
  default     = true
}

variable "subaccount_stage" {
  description = "Stage of the subaccount"
  type        = string
  default     = "DEV"
}

variable "project_costcenter" {
  description = "Cost center of the project"
  type        = string
  default     = "12345"
}


# variable "subaccount_region" {
#   description = "Region of the subaccount"
#   type        = string
#   default     = "us10"
#   validation {
#     condition     = contains(["us10", "ap21"], var.subaccount_region)
#     error_message = "Region must be one of us10 or ap21"
#   }
# }

# variable "subaccount_stage" {
#   description = "Stage of the subaccount"
#   type        = string
#   default     = "DEV"
#   validation {
#     condition     = contains(["DEV", "TEST", "PROD"], var.subaccount_stage)
#     error_message = "Stage must be one of DEV, TEST or PROD"
#   }
# }

variable "project_name" {
  description = "Anubhav Terraform"
  type        = string
  default     = "Anubhav Trainings"
}