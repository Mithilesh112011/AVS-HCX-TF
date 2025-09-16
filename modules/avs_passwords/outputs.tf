output "nsxt_password" {
  value     = random_password.nsxt.result
  sensitive = true
}

output "vcenter_password" {
  value     = random_password.vcenter.result
  sensitive = true
}