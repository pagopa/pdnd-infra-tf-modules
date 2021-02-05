resource "aws_vpn_gateway" "this" {
  vpc_id = var.vpc_id
}

resource "aws_customer_gateway" "this" {
  ip_address = var.customer_gateway.ip
  bgp_asn = "65000"
  type = "ipsec.1"
  tags = var.tags
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this.id
  static_routes_only  = true
  type = var.aws_vpn_connection_type
  tags = {}

  #àlocal_ipv4_network_cidr = var.aws_connection_local_ipv4_netw_cidr
  #remote_ipv4_network_cidr = var.aws_connection_remote_ipv4_netw_cidr

  tunnel1_ike_versions = var.aws_connection_tunnel.ike
  tunnel2_ike_versions = var.aws_connection_tunnel.ike

  tunnel1_phase2_dh_group_numbers = var.aws_connection_tunnel.dh_group
  tunnel2_phase2_dh_group_numbers = var.aws_connection_tunnel.dh_group
  tunnel1_phase1_dh_group_numbers = var.aws_connection_tunnel.dh_group
  tunnel2_phase1_dh_group_numbers = var.aws_connection_tunnel.dh_group

  tunnel1_phase2_encryption_algorithms = var.aws_connection_tunnel.enc_alg
  tunnel1_phase1_encryption_algorithms = var.aws_connection_tunnel.enc_alg

  tunnel2_phase2_encryption_algorithms = var.aws_connection_tunnel.enc_alg
  tunnel2_phase1_encryption_algorithms = var.aws_connection_tunnel.enc_alg

  tunnel1_phase2_integrity_algorithms = var.aws_connection_tunnel.int_alg
  tunnel2_phase2_integrity_algorithms = var.aws_connection_tunnel.int_alg
  tunnel1_phase1_integrity_algorithms = var.aws_connection_tunnel.int_alg
  tunnel2_phase1_integrity_algorithms = var.aws_connection_tunnel.int_alg

  tunnel1_dpd_timeout_action = var.aws_connection_tunnel.dpd_timeout_action
  tunnel1_startup_action = var.aws_connection_tunnel.startup_action

  tunnel2_dpd_timeout_action = var.aws_connection_tunnel.dpd_timeout_action
  tunnel2_startup_action = var.aws_connection_tunnel.startup_action


}



