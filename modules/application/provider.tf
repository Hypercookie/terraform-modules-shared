terraform {
  required_providers {
    inwx = {
      source  = "inwx/inwx"
      version = "1.6.1"
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
