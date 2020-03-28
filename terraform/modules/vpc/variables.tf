variable project {
  description = "Project ID"
  default     = "infra-271003"

}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
  #  default = ["81.91.58.14/32"]
}
