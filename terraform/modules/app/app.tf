resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.zone
  #  project = var.project
  tags = ["reddit-app"]
  boot_disk {
    initialize_params { image = var.app_disk_image }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  # Provisioners connection
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
  # Create service
#  provisioner "file" {
#    source      = "${path.module}/puma.service"
#    destination = "/tmp/puma.service"
# }

#  provisioner "file" {
#    source      = "${path.module}/var.sh"
#    destination = "/tmp/var.sh"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/var.sh",
#      "/tmp/var.sh ${var.db_ip_address}",
#    ]
# }


#  # Deploy app
#  provisioner "remote-exec" {
#    script = "${path.module}/deploy.sh"
#  }

}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
  #  project = var.project
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_nginx" {
  name    = "allow-nginx-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
