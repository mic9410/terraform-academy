terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
    required_version = ">= 0.14.9"
}
resource "google_compute_network" "vpc_network" {
    auto_create_subnetworks         = true
    delete_default_routes_on_create = false
    id                              = "projects/loyal-semiotics-335017/global/networks/terraform-network"
    name                            = "terraform-network"
    project                         = "loyal-semiotics-335017"
    routing_mode                    = "REGIONAL"
    self_link                       = "https://www.googleapis.com/compute/v1/projects/loyal-semiotics-335017/global/networks/terraform-network"
}

resource "google_project" "my_project" {

}

