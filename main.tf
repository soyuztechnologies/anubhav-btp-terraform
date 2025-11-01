resource "random_uuid" "uuid" {}
data "btp_globalaccount" "this" {}

# resource "btp_subaccount" "project_subaccount" {
#   name         = "Anubhav Terraform"
#   subdomain    = "dev-anubhav-terraform"
#   region       = "us10"
#   beta_enabled = true
#   labels = {
#     "stage"      = ["DEV"]
#     "costcenter" = ["12345"]
#   }
# }

resource "btp_subaccount" "project_subaccount" {
  name         = var.subaccount_name
  subdomain    = var.subaccount_subdomain
  region       = var.subaccount_region
  beta_enabled = var.subaccount_beta_enabled
  labels = {
    "stage"      = [var.subaccount_stage]
    "costcenter" = [var.project_costcenter]
  }
}

#According to the naming convention the subaccount name must the combination of the stage and project name. 
# locals {
#   subaccount_name      = "${var.subaccount_stage} ${var.project_name}"
# }

# resource "btp_subaccount" "project_subaccount" {
#   name         = local.subaccount_name
#   subdomain    = var.subaccount_subdomain
#   region       = var.subaccount_region
#   beta_enabled = var.subaccount_beta_enabled
#   labels = {
#     "stage"      = [var.subaccount_stage]
#     "costcenter" = [var.project_costcenter]
#   }
# }


# locals {
#   subaccount_name      = "${var.subaccount_stage} ${var.project_name}"
#   subaccount_subdomain = join("-", [lower(replace("${var.subaccount_stage}-${var.project_name}", " ", "-")), random_uuid.uuid.result])
#   beta_enabled         = var.subaccount_stage == "PROD" ? false : true
# }

# resource "btp_subaccount" "project_subaccount" {
#   name         = local.subaccount_name
#   subdomain    = local.subaccount_subdomain
#   region       = var.subaccount_region
#   beta_enabled = local.beta_enabled
#   labels = {
#     "stage"      = [var.subaccount_stage]
#     "costcenter" = [var.project_costcenter]
#   }
# }

# Enable Cloud Foundry Environment in Subaccount
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.project_subaccount.id
  name             = var.subaccount_name
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "trial"
  landscape_label  = "us10-001"
  
  parameters = jsonencode({
    instance_name = var.subaccount_name
  })
}

resource "btp_subaccount_entitlement" "alert_notification_service_standard" {
  subaccount_id = btp_subaccount.project_subaccount.id
  service_name  = "alert-notification"
  plan_name     = "standard"
}

resource "btp_subaccount_entitlement" "feature_flags_service_lite" {
  subaccount_id = btp_subaccount.project_subaccount.id
  service_name  = "feature-flags"
  plan_name     = "lite"
}

resource "btp_subaccount_entitlement" "feature_flags_dashboard_app" {
  subaccount_id = btp_subaccount.project_subaccount.id
  service_name  = "feature-flags-dashboard"
  plan_name     = "dashboard"
}

data "btp_subaccount_service_plan" "alert_notification_service_standard" {
  subaccount_id = btp_subaccount.project_subaccount.id
  name          = "standard"
  offering_name = "alert-notification"
  depends_on    = [btp_subaccount_entitlement.alert_notification_service_standard]
}

resource "btp_subaccount_subscription" "feature_flags_dashboard_app" {
  subaccount_id = btp_subaccount.project_subaccount.id
  app_name      = "feature-flags-dashboard"
  plan_name     = "dashboard"
  depends_on    = [btp_subaccount_entitlement.feature_flags_dashboard_app]
}