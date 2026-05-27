variable "description" {
  description = "Description of the KMS key"
  type        = string
  default     = null
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction (7-30)"
  type        = number
  default     = 30
  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30."
  }
}

variable "enable_key_rotation" {
  description = "Whether to enable automatic annual key rotation"
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Intended use of the key (ENCRYPT_DECRYPT or SIGN_VERIFY)"
  type        = string
  default     = "ENCRYPT_DECRYPT"
  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY", "GENERATE_VERIFY_MAC"], var.key_usage)
    error_message = "key_usage must be ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC."
  }
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric or asymmetric key"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "multi_region" {
  description = "Whether to create a multi-region key"
  type        = bool
  default     = false
}
