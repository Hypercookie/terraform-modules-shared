terraform {
  required_providers {
    inwx = {
      source  = "inwx/inwx"
      version = "1.6.1"
    }
    dns-validation = {
      source = "bendrucker/dns-validation"
      version = "0.0.1"
    }
    portainer = {
      source = "portainer/portainer"
      version = "1.15.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.5"
    }
  }
}
