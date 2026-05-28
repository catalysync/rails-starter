terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.49.1"
    }
  } 
}

provider "hcloud" {
  token = var.hetzner_cloud_api_token
}

data "hcloud_ssh_key" "review_app_ssh_key" {
  name = "Review App Deploy Key"
}

data "hcloud_firewall" "review_app_firewall" {
  name = "firewall-1"
}

resource "hcloud_server" "review_app_server" {
  server_type = "cpx11"
  location = "ash"
  image = "ubuntu-24.04"
  name = var.server_name
  ssh_keys = [data.hcloud_ssh_key.review_app_ssh_key.id]
  firewall_ids = [data.hcloud_firewall.review_app_firewall.id]
}