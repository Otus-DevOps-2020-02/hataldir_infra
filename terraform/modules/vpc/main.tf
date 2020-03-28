terraform {
  required_version = ">0.12.8"
}

provider "google" {
  version = "~>2.15"
  project = var.project

}
