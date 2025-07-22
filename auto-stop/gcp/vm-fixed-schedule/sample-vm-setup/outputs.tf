output "vm_id" {
  value = google_compute_instance.ubuntu_vm.id
}

output "vm_public_ip" {
  value = google_compute_instance.ubuntu_vm.network_interface[0].access_config[0].nat_ip
}

output "vm_name" {
  value = google_compute_instance.ubuntu_vm.name
}

output "project" {
  value = google_compute_instance.ubuntu_vm.project
}

output "zone" {
  value = google_compute_instance.ubuntu_vm.zone
}
