# Below code block tells Terraform what providers are required for the 
# application of the configuration that we will build during this learning. 

# As we will need the Terraform provider for SAP BTP we specify:

# The source attribute tells Terraform where to fetch the provider from. 
# We set SAP/btp as value. This will advice Terraform to look for this provider 
# in the public Terraform registry.

# The version attribute lets us define a version constraint for the provider. 
# This constraint is especially useful to avoid unwanted upgrades of the provider version. 
# We set it to the latest available version and make sure that only patch versions are considered in upgrades by specifying ~> as operator.

terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.17.0"
    }
  }
}

# In addition to telling Terraform which provider to use, the provider usually also 
# needs a provider-specific configuration. This configuration mainly comprises the 
# authentication information needed for Terraform to communicate with the platform.
# We see that the only required parameter is the subdomain of the global account we are using.
# provider "btp" {
#   globalaccount = "e3f183dbtrial-ga"
# }

provider "btp" {
  globalaccount = var.globalaccount
}

