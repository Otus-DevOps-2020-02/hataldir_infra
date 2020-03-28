terraform {
  required_version = ">0.12.8"
  backend "gcs" {
    bucket = "sbttest"
    prefix = "stage"

  }
}
