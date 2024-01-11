# Obtaining account ID
data "aws_caller_identity" "account-id" {}

# Replicating repositorys
resource "aws_ecr_replication_configuration" "replication" {
  replication_configuration {
    rule {
      dynamic "destination" {
        for_each = toset(var.replication-regions)
        content {
          region      = destination.key
          registry_id = data.aws_caller_identity.account-id.account_id
        }
      }

      repository_filter {
        filter_type = "PREFIX_MATCH"
        filter      = var.prefix
      }
    }
  }
}