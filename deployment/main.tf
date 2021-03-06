provider "vra7" {
  username = var.vra_username
  password = var.vra_password
  tenant   = var.vra_tenant
  host     = var.vra_host
  insecure = true
}

resource "vra7_deployment" "this" {
  count             = 1
  catalog_item_name = "Ubuntu 20.04 x64"
  description       = "this description"
  reasons           = "this reason"
  lease_days        = 10

  deployment_configuration = {
    "blueprint_custom_property" = "This is a blueprint custom property"
    "businessGroups"            = <<EOF
        [
          "bgTest1",
          "bgTest2"
        ]
        EOF
  }

  resource_configuration {
    component_name = "Linux 1"
    cluster        = 2
    configuration = {
      cpu             = 2
      memory          = 2048
      custom_property = "VM custom property"
      security_tag    = <<EOF
        [
          "dev_sg",
          "prod_sg"
        ]
        EOF
    }
  }

  resource_configuration {
    component_name = "Linux 2"
    configuration = {
      cpu     = 2
      memory  = 1024
      storage = 8
    }
  }
}
