locals {
  well-known-cidrs = [
    "61.135.194.0/24",
  ]

  well-known-ports = ["80", "443"]
}
module "security_groups" {
  source  = "../../modules/rule_set"
  # source = "git::https://github.com/terraform-tencentcloud-modules-tmigrate/terraform-tencentcloud-security-group.git?ref=master"
  name = "demo"
#  create = false
#  security_group_id = "sg-o4dqhkya"
  ingress = concat(
    [
      for port in range(8000, 8001): {
        action      = "ACCEPT"
        cidr_block  = "0.0.0.0/0"
        protocol    = "TCP" # "TCP"  # TCP, UDP and ICMP
        port        = port # "80-90" # 80, 80,90 and 80-90
        description = ""
      }
    ]
  )
  default_ingress_deny_all = true

}