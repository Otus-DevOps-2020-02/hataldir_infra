terraform {
  required_version = ">0.12.8"
}

provider "google" {
  version = "2.15"

  project = var.project

  region = var.region
  zone   = var.zone

}

# VM reddit-app
resource "google_compute_instance" "app" {
  count        = var.app-count
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  #  metadata = {
  #    ssh-keys = "appuser:${file(var.public_key_path)}"
  #  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
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
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  # Deploy app
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}


# Firewall rules
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
