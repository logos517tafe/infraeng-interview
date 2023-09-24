# Output the list of VM hostnames as a map, keyed by the instance name.
output "vm_hostnames" {
  value = { for instance_name, instance_data in var.instances :
    instance_name => "${instance_name}-${var.instances[instance_name].zone}.asx.com.au"
  }
}

# Bonus: Output the IP addresses assigned to each instance, keyed by instance FQDN.
output "vm_ip_addresses" {
  value = { for instance_name, instance_data in var.instances :
    "${instance_name}-${var.instances[instance_name].zone}.asx.com.au" => google_compute_instance.vm[instance_name].network_interface[0].access_config[0].nat_ip
  }
}
