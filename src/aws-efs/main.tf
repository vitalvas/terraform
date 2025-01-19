resource "aws_security_group" "main" {
  name   = "efs-${var.name}"
  vpc_id = var.vpc_id


  ingress = {
    description = "EFS mount target"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "EFS mount target"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description      = "EFS mount target"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_efs_file_system" "main" {
  encrypted = true

  tags = {
    Name = var.name
  }

  dynamic "lifecycle_policy" {
    for_each = length(var.transition_to_ia) > 0 ? [1] : []
    content {
      transition_to_ia = try(var.transition_to_ia[0], null)
    }
  }

  dynamic "lifecycle_policy" {
    for_each = length(var.transition_to_archive) > 0 ? [1] : []
    content {
      transition_to_archive = try(var.transition_to_archive[0], null)
    }
  }

  dynamic "lifecycle_policy" {
    for_each = length(var.transition_to_primary_storage_class) > 0 ? [1] : []
    content {
      transition_to_primary_storage_class = try(var.transition_to_primary_storage_class[0], null)
    }
  }
}

resource "aws_efs_mount_target" "main" {
  count = length(var.subnet_ids)

  file_system_id = aws_efs_file_system.main.id
  subnet_id      = var.subnet_ids[count.index]

  security_groups = [
    aws_security_group.main.id
  ]
}
