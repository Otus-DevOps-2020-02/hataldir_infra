provider "google" {
  version = "~>2.15"
  project = var.project
  region  = var.region
  zone    = var.zone
}


module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  #  project = var.project
  zone             = var.zone
  private_key_path = var.private_key_path
  db_disk_image    = var.db_disk_image
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  #  project = var.project
  zone             = var.zone
  app_disk_image   = var.app_disk_image
  private_key_path = var.private_key_path
  db_ip_address    = module.db.db_static_ip
}

module "vpc" {
  source = "../modules/vpc"
  #  project = var.project
  # source_ranges = ["0.0.0.0/0"]
    source_ranges = ["85.235.46.178/32"]

}

data "template_file" "inventory" {
    template = "${file("inventory.tpl")}"

    vars = {
       app_ip = "${module.app.app_static_ip}"
       db_ip = "${module.db.db_static_ip}"
    }
}

resource "local_file" "save_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "../../ansible/environments/prod/inventory.yml"
}
