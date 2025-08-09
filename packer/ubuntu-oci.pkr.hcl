packer {
  required_plugins {
    oracle-oci = {
      version = ">=1.0.0"
      source  = "github.com/hashicorp/oracle"
    }
  }
}

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "base_image_ocid" {}
variable "ssh_username" { default = "ubuntu" }

source "oracle-oci" "ubuntu" {
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  region               = var.region
  compartment_ocid     = var.compartment_ocid
  base_image_ocid      = var.base_image_ocid
  shape                = "VM.Standard.E4.Flex"
  ssh_username         = var.ssh_username
  ssh_private_key_file = var.private_key_path
}

build {
  sources = ["source.oracle-oci.ubuntu"]

  provisioner "file" {
    source      = "../build/todoapp.tar.gz"
    destination = "/tmp/todoapp.tar.gz"
  }

  provisioner "shell" {
    script = "install_app.sh"
  }
}
