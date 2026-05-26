output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "key_arn" {
  description = "ARN of the KMS key"
  value       = try(aws_kms_key.this[0].arn, null)
}

output "key_id" {
  description = "ID of the KMS key"
  value       = try(aws_kms_key.this[0].key_id, null)
}
