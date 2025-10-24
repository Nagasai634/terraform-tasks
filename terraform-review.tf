provider "google" {
    project = "terraform-471709"  # Replace with your actual GCP project ID
    region  = "us-central1"
}

resource "google_compute_network" "vpc" {
    name                    = "vpc-1"
    auto_create_subnetworks = false
}

locals {
  subnets = {
    subnet-1 = "10.0.0.0/24"
    subnet-2 = "192.168.0.0/24"
  }
}

resource "google_compute_subnetwork" "subnet" {
    for_each = local.subnets
    
    name          = each.key
    network       = google_compute_network.vpc.name
    ip_cidr_range = each.value
    region        = "us-central1"
}

locals {
  vms = {
    "vm-subnet-1" = {
      subnet = "subnet-1"
      zone   = "us-central1-a"
    }
    "vm-subnet-2" = {
      subnet = "subnet-2" 
      zone   = "us-central1-b"
    }
  }
}

resource "google_compute_instance" "vm" {
    for_each = local.vms
    name = each.key
    zone = each.value.zone
    machine_type = "e2-medium"
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
      }
    }
    network_interface {

      subnetwork = google_compute_subnetwork.subnet[each.value.subnet].self_link
      network = google_compute_network.vpc.name
      access_config {
        
      }
    }
  
}
