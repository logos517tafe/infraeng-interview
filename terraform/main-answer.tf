# Define a Google Compute Engine instance resource.
resource "google_compute_instance" "vm" {
    project      = var.project_id          # Project ID where the instance will be created.
    name         = var.instance_name       # Name of the instance.
    description  = var.description         # Description of the instance.
    machine_type = var.machine_type        # Machine type (e.g., c3-standard-4).
    zone         = var.zone                # Zone where the instance will be located.
    hostname     = var.hostname            # Hostname for the instance.

    # Define a dynamic block for configuring the service account.
    dynamic "service_account" {
        # Use dynamic for_each to conditionally include the block only if a service account is specified.
        for_each = var.service_account != "" ? [1] : []

        content {
            email  = var.service_account  # Service account email address.
            scopes = var.scopes           # List of scopes for the service account.
        }
    }
}
