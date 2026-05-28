data "hcloud_ssh_key" "review_app_ssh_key" {
  name = "Review App Deploy Key"
}

resource "hcloud_server" "rails_starter" {
  name = "Rails Starter"
  server_type = "cpx21"
  location = "hil"
  image = "ubuntu-22.04"
  ssh_keys = [data.hcloud_ssh_key.review_app_ssh_key.id]
  firewall_ids = [hcloud_firewall.web_server_and_ssh.id]
 
  network {
    network_id = hcloud_network.rails_starter_private_network.id
  }

  depends_on = [ 
    hcloud_network_subnet.rails_starter_private_network_subnet
  ]
}