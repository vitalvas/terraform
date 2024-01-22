resource "aws_ecr_repository" "this" {
  name                 = var.image_name
  image_tag_mutability = var.image_tag_immutable ? "IMMUTABLE" : "MUTABLE"

  encryption_configuration {
    encryption_type = "KMS"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 20 images"
        selection = {
          tagStatus   = "tagged"
          countType   = "imageCountMoreThan"
          countNumber = 20
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 50
        description  = "Only keep untagged images for 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  depends_on = [
    aws_ecr_repository.this
  ]
}
