#terraform {
#  required_version = ">0.12.8"
#}

#provider "google" {
#  version = "2.15"
#  project = var.project
#  region = var.region
#}




# Main port and link to proxy
resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  target     = google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "80"
  name       = "reddit-forwarding-rule"
}

# Link to urlmap
resource "google_compute_target_http_proxy" "target_http_proxy" {
  url_map = google_compute_url_map.url_map.self_link
  name    = "reddit-proxy"
}


# Link to instance group and healthcheck
resource "google_compute_backend_service" "backend_service" {
  name          = "reddit-backend-service"
  port_name     = "puma"
  protocol      = "HTTP"
  health_checks = ["${google_compute_health_check.healthcheck.self_link}"]
  backend {
    group                 = google_compute_instance_group.reddit-vm-group.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }
}

# Instance group
resource "google_compute_instance_group" "reddit-vm-group" {
  name        = "reddit-vm-group"
  description = "Web servers instance group"
  instances = [
    google_compute_instance.app[0].self_link,
    google_compute_instance.app[1].self_link
  ]
  named_port {
    name = "puma"
    port = "9292"
  }
}

# Healthcheck on port 9292
resource "google_compute_health_check" "healthcheck" {
  name               = "reddit-healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = 9292
  }
}

# Link to backend service
resource "google_compute_url_map" "url_map" {
  name            = "reddit-url-map"
  default_service = google_compute_backend_service.backend_service.self_link
}

# Main address
output "load-balancer-ip-address" {
  value = google_compute_global_forwarding_rule.global_forwarding_rule.ip_address
}
