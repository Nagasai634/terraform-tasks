# variable "vm_config" {
#     type = list(object({
#       name = string
#       zone = string
#       machine_type = string
#       image = string
#     }))
#     default = [ {
#       name = "sai-vm"
#       zone = "us-west4-b"
#       machine_type = "e2-medium"
#       image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
#     },{
#         name = "teja-vm"
#         zone = "us-west4-a"
#         machine_type = "e2-micro"
#         image = "debian-cloud/debian-11"
#     } ]

# }