variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The vpc id"
}

variable "customer_gateway" {

  description = "customer gateway properties"
  type = object({
    ip = string
  })
  default = null
}


variable "aws_vpn_connection_type" {

  description = "aws vpn connection type"
  type = string
  default = "ipsec.1"
}

//variable "aws_connection_local_ipv4_netw_cidr" {
//  type = string
//}
//
//variable "aws_connection_remote_ipv4_netw_cidr" {
//  type = string
//}

variable "aws_connection_tunnel" {
  description = "vpn connection tunnel configs"
  type = object({
    ike = list(string)
    dh_group = list(number)
    enc_alg = list(string)
    int_alg = list(string)
    dpd_timeout_action = string
    startup_action = string
  })

}