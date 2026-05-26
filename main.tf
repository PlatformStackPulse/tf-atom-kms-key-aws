resource "aws_kms_key" "this" {
  count = module.this.enabled ? 1 : 0

  description              = coalesce(var.description, "KMS key: ${module.this.id}")
  deletion_window_in_days  = var.deletion_window_in_days
  enable_key_rotation      = var.enable_key_rotation
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region

  tags = local.tags
}
