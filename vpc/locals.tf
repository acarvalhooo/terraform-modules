# Mapping availability zone of nat gateways
locals {
  nat_gateway_availability_zones = {
    "ngw-01" = var.az-1
    "ngw-02" = var.az-2
  }
}

# Mapping nat gateways of elastic ips
locals {
  elastic_ips_association = {
    "eip-01" = "ngw-01"
    "eip-02" = "ngw-02"
  }
}
