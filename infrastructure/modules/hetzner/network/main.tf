resource "hcloud_network" "rails_starter_private_network" {
  name = "Rails Starter Private Network"
  ip_range =  "10.0.0.0/16"
}

resource "hcloud_network_subnet" "rails_starter_private_network_subnet" {
  type = "cloud"
  network_id = hcloud_network.rails_starter_private_network
  network_zone = "us-west"
  ip_range = "10.0.1.0/24" // 10.0.1.0 - 10.0.1.255
}