provider "google" {
  credentials = file("/home/michal/.config/gcloud/application_default_credentials.json")
  region      = "europe-west1"
  project     = "loyal-semiotics-335017"

}
# Virtual Private Network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "default" {
  name         = "terraform-test"
  metadata     = {
    "serial-port-enable" = "true"
  }
  machine_type = "e2-micro"
  zone         = "europe-west1-b"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2110-impish-v20211014"
    }
  }
  network_interface {
    network = "default"

    access_config {
      network_tier = "STANDARD"
    }
  }
  network_interface {
  }
}

/*provisioner "remote-exec" {
  inline = [
     "touch hello.txt",
    "echo helloworld remote provisioner >> hello.txt",
      "sudo apt-get -y update",
     "sudo apt-get -y install nginx",
     "sudo service nginx start",
   ]
 }*/

/*resource "google_compute_firewall" "ssh-rule" {
  name = "demo-ssh"
  network = google_compute_network.vpc_network.name
  allow {
    # protocol = "tcp"
    # ports = ["22"]
    protocol = "all"

  }
  target_tags = ["demo-vm-instance"]
 # source_ranges = ["0.0.0.0/0"]
}*/
