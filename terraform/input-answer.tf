variable "project_id" {
    type = string
}

variable "instances" {
    type = map(object({
        machine_type = string
        zone         = string
        description  = string
    }))
}

variable "service_account" {
    type    = string
    default = ""
}

variable "scopes" {
    type    = list(string)
    default = []
}

resource "google_compute_instance" "vm2" {
    for_each = var.instances  # Create an instance for each entry in the "instances" map.

    project      = var.project_id
    name         = each.key            # Set the resource name from the map keys.
    machine_type = each.value.machine_type
    zone         = each.value.zone     # Set the zone from the properties of the map values.
    description  = each.value.description

    # Set the hostname using the instance name and zone.
    hostname = "${each.key}-${each.value.zone}.asx.com.au"

    # Include the dynamic block for the service account here.
    dynamic "service_account" {
        for_each = var.service_account != "" ? [1] : []

        content {
            email  = var.service_account
            scopes = var.scopes
        }
    }
}