variable project {
  description = "Project ID"
  default     = "infra-271003"

}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app-count {
  description = "Number of apps"
  default     = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base"
}
