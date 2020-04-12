provider "google" {
  version = "~>2.15"
  project = var.project
  region  = var.region
  zone    = var.zone
}


resource "google_compute_instance" "empty" {
  name = "empty"
  #  project = var.project
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-db"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
#      nat_ip = google_compute_address.db_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }

#  # Deploy app
#  provisioner "remote-exec" {
#    script = "${path.module}/change.sh"
#  }

}
