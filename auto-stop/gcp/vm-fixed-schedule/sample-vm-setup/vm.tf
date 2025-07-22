resource "tls_private_key" "gcp_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.gcp_key.private_key_pem
  filename        = "${path.module}/${var.stack_prefix}-gcp-key.pem"
  file_permission = "0600"
}

resource "google_compute_instance" "ubuntu_vm" {
  name         = "${var.stack_prefix}-ubuntu-vm"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-noble-amd64-v20250709"
    }
  }

  network_interface {
    network       = "default"
    access_config {} # This gives a public IP
  }

  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.gcp_key.public_key_openssh}"
  }

  labels = {
    "${var.schedule_tag_key}" = var.schedule_tag_name
  }
}
