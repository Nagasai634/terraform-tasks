provider "google" {
  project = "emerald-spring-465406-s1"
  region  = "us-west4"
}

# //Question:1. Create multiple VM instances at once using count
# resource "google_compute_instance" "tf_vm" {
#     count = length(var.vm_config)
#     name = var.vm_config[count.index].name
#     zone =  var.vm_config[count.index].zone
#     machine_type =  var.vm_config[count.index].machine_type
#     boot_disk {
#       initialize_params {
#         image =  var.vm_config[count.index].image
#       }
#     }
#     network_interface {
#       network = "default"
#       access_config {

#       }
#     }


# }

# //Question:2 Create a Cloud Storage bucket, push a local file into it and make show all files must access.

# resource "google_storage_bucket" "tf_bucket" {
#     name = "peak-in-bucket"
#     storage_class = "standard"
#     location = "US"
#     versioning {
#       enabled = true
#     }
#     force_destroy = true
# }

# resource "google_storage_bucket_object" "tf_object" {
#     bucket = google_storage_bucket.tf_bucket.name
#     name = "new.txt"
#     source = "./new.txt"

# }
# resource "google_storage_bucket_iam_member" "tf_member" {
#     bucket = google_storage_bucket.tf_bucket.name
#     role = "roles/storage.objectViewer"
#     member = "allUsers"

# }


# //Question:3  Create a VM that must deploy the website at time of creation.

# resource "google_compute_instance" "tf_vme" {
#     name = "vardhan"
#     zone = "us-central1-a"
#     machine_type = "e2-medium"
#     boot_disk {
#       initialize_params {
#         image = "debian-11"
#       }
#     }
#     network_interface {
#       network = "default"
#       access_config {

#       }
#     }
#     provisioner "remote-exec" {
#         inline = [  
#             "sudo apt update -y",
#             "sudo apt install apache2 -y"
#         ]

#     }
#     metadata = {
#       ssh-keys = "admin:${file("~/.ssh/id_rsa.pub")}"
#     }
#     connection {
#       type = "ssh"
#       user = "admin"
#       private_key = file("~/.ssh/id_rsa")
#       host = self.network_interface[0].access_config[0].nat_ip
#     }

# }


# //Question:4  Create a custom VPC and firewall rule, then attach to a VM.
# resource "google_compute_network" "tf_net" {
#     name = "sai-vpc"
#     auto_create_subnetworks = false
# }
# resource "google_compute_subnetwork" "tf_sub" {
#     name = "subnet-sai"
#     network = google_compute_network.tf_net.name
#     ip_cidr_range = "172.0.0.0/12"
#     region = "us-central1"
# }
# resource "google_compute_firewall" "name" {
#     name = "allow-ssh-http"
#     network = google_compute_network.tf_net.name
#     allow {
#       ports = ["22","80"]
#       protocol = "tcp"
#     }
#     direction = "INGRESS"
#     source_ranges = ["0.0.0.0/0"]
# }
# resource "google_compute_instance" "tf_nms" {
#     name = "vm-1"
#     zone = "us-central1-a"
#     machine_type = "e2-micro"
#     boot_disk {
#       initialize_params {
#         image = "debian-12"
#       }
#     }
#     network_interface {
#       network = google_compute_network.tf_net.name
#       subnetwork = google_compute_subnetwork.tf_sub.name
#       access_config {

#       }
#     }

# }


//Question:5 While creating the VM, the local files should be pushed into it. Software like Docker and Nginx should
//be installed, and the Docker service should be started
# resource "google_compute_instance" "tf_vme" {
#   name         = "nsv"
#   zone         = "us-central1-a"
#   machine_type = "e2-medium"
#   boot_disk {
#     initialize_params {
#       image = "debian-11"
#     }
#   }
#   network_interface {
#     network = "default"
#     access_config {

#     }
#   }
#   provisioner "file" {
#     source      = "./variable.tf"
#     destination = "./variables"

#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install docker.io -y",
#       "sudo apt install nginx -y",
#       "sudo apt install apache2 -y"
#     ]

#   }
#   metadata = {
#     ssh-keys = "admin:${file("~/.ssh/id_rsa.pub")}"
#   }
#   connection {
#     type        = "ssh"
#     user        = "admin"
#     private_key = file("~/.ssh/id_rsa")
#     host        = self.network_interface[0].access_config[0].nat_ip
#   }
#   # metadata_startup_script = file("./startupscript.sh")

# }

//Question:6 How get the state file of existing resource in gcp.

resource "google_compute_instance" "tf_vmre" {
  name = "nagasai-vm"
  zone = "us-central1-a"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
      
    }
  }
  
}




