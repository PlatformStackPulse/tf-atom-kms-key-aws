# Unit tests for tf-atom-kms-key-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Assertions target plan-KNOWN values (the tf-label id, resource counts,
# input pass-throughs) rather than computed arn/id, which are unknown
# under a mock provider.
#
# Run with:      terraform test -test-directory=tests/unit
# Run verbose:   terraform test -test-directory=tests/unit -verbose
# Run specific:  terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  # tf-label ID elements
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module inputs (valid sample values)
  description             = "unit-test KMS key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  key_usage               = "ENCRYPT_DECRYPT"
  multi_region            = false
}

# ---------------------------------------------------------------------------
# Test: module creates the KMS key when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be 'eg-test-thing' for namespace=eg, stage=test, name=thing"
  }

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_kms_key.this) == 1
    error_message = "exactly one aws_kms_key should be planned when enabled"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }

  assert {
    condition     = length(aws_kms_key.this) == 0
    error_message = "no aws_kms_key should be planned when disabled"
  }

  assert {
    condition     = output.key_arn == null
    error_message = "key_arn output should be null when the module is disabled"
  }
}
