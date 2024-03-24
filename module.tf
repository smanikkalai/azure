locals {
  tenant_id = "2a731c61-a2b2-4661-849-5b861cf4dc"
  subscription_id    = "/subscriptions/${var.azure_subscription_id}"
}

module "msp" {
  source  = "lighthouse"

  name                    = "MSP"
  description             = "Lighthouse delegation to let manage resources."
  managing_tenant_id      = local.tenant_id
  managed_subscription_id = local.subscription_id

  authorizations = [
    {
      principal_id   = "bdd6d653-e0dc-48a1-9bce-8f35cf44f7cf"
      principal_name = "L1 CORE Team"
      role_name      = "Contributor"
    },
    {
      principal_id   = "bdd6d653-e0dc-48a1-9bce-8f35cf44f7cf"
      principal_name = "L2 OnCall Build Team"
      role_name      = "Contributor"
    },
    {
      principal_id   = "bdd6d653-e0dc-48a1-9bce-8f35cf44f7cf"
      principal_name = "SDM"
      role_name      = "Reader"
    },
    {
      principal_id   = "bdd6d653-e0dc-48a1-9bce-8f35cf44f7cf"
      principal_name = "MSI Admin"
      # https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
      role_name            = "User Access Administrator"
      delegated_role_names = ["Contributor", "AcrPull", "AcrPush"]
    },
  ]

  scopes = {
    "Production Subscription" = local.subscription_id
  }
}
