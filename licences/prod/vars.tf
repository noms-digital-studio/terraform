variable "app-name" {
  type    = "string"
  default = "licences-prod"
}

variable "tags" {
  type = "map"

  default {
    Service     = "Licences"
    Environment = "Prod"
  }
}

variable "pdf-gen-app-name" {
  type    = "string"
  default = "licences-pdf-generator-prod"
}

variable "pdf-gen-tags" {
  type = "map"

  default {
    Service     = "licences-pdf-generator"
    Environment = "Prod"
  }
}


# Instance and Deployment settings
locals {
  instances = "3"
  mininstances = "2"
  instance_size = "t2.medium"
  db_multi_az = "true"
  db_backup_retention_period = "30"
  db_maintenance_window = "Mon:00:00-Sun:11:59"
  db_apply_immediately = "true"
}

# App settings
locals {
  nomis_api_url       = "https://gateway.prod.nomis-api.service.hmpps.dsd.io/elite2api/api"
  nomis_auth_url      = "https://gateway.prod.nomis-api.service.hmpps.dsd.io/auth"
  api_client_id       = "licences"
  domain              = "https://licences.service.hmpps.dsd.io"
  authStrategy        = "local"
}

# Azure config
locals {
  azurerm_resource_group = "licences-prod"
  azure_region           = "ukwest"
}

locals {
  allowed-list = [
    "${var.ips["office"]}/32",
    "${var.ips["quantum"]}/32",
    "${var.ips["health-kick"]}/32",
    "${var.ips["mojvpn"]}/32",
    "${var.ips["digitalprisons1"]}/32",
    "${var.ips["digitalprisons2"]}/32",
    "${var.ips["j5-phones-1"]}/32",
    "${var.ips["j5-phones-2"]}/32",
    "${var.ips["sodexo-northumberland"]}/32",
    "${var.ips["sodexo-northumberland"]}/32",
    "${var.ips["durham-tees-valley"]}/32",
    "${var.ips["ark-nps-hmcts-ttp1"]}/24",
    "${var.ips["ark-nps-hmcts-ttp2"]}/25",
    "${var.ips["ark-nps-hmcts-ttp3"]}/25",
    "${var.ips["ark-nps-hmcts-ttp4"]}/25",
    "${var.ips["ark-nps-hmcts-ttp5"]}/25",
  ]
}
