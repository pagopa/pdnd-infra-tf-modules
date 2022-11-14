output "data" {
  value     = data.vault_generic_secret.this.data
  sensitive = true
}

output "data_json" {
  value     = data.vault_generic_secret.this.data_json
  sensitive = true
}
