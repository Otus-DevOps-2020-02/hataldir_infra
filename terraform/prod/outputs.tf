output "app_external_ip" {
  #  value = module.app.app_external_ip
  #   value = "${google_compute_instance.app.network_interface.0.access_config.0.assigned_nat_ip}"
  #   value = google_compute_instance.app.network_interface.0.access_config.0.assigned_nat_ip
  value = module.app.app_external_ip
}

output "db_external_ip" {
  #  value = module.db.db_external_ip
  value = module.db.db_external_ip
}
output "db_static_ip" {
  value = module.db.db_static_ip
}
output "app_static_ip" {
  value = module.app.app_static_ip
}


#output "app_external_ip_1" {
#  value = google_compute_instance.app[0].network_interface[0].access_config[0].nat_ip
#}
#output "app_external_ip_2" {
#  value = google_compute_instance.app[1].network_interface[0].access_config[0].nat_ip
#}
