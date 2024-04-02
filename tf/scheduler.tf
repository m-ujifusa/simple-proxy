resource "aws_iam_role" "automation_role" {
  name = "automation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ssm.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "automation_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
  role       = aws_iam_role.automation_role.name
}

resource "aws_ssm_maintenance_window" "start_time" {
  name     = "${var.name_prefix}-start-time"
  schedule = var.turn_on_proxy_schedule # Runs at 11:00 AM CST (16:00 UTC) every day
  cutoff = 1
  duration = 2
  tags = {
    Name = "${var.name_prefix}-start-time"
  }
}

resource "aws_ssm_maintenance_window" "stop_time" {
  name     = "${var.name_prefix}-stop-time"
  schedule = var.turn_off_proxy_schedule  # Runs at 11:00 PM CST (04:00 UTC) every day
  cutoff = 1
  duration = 2
  tags = {
    Name = "${var.name_prefix}-stop-time"
  }
}

resource "aws_ssm_maintenance_window_task" "start_instance_task" {
  window_id        = aws_ssm_maintenance_window.start_time.id
  task_type        = "AUTOMATION"
  task_arn         = "AWS-StartEC2Instance"
  priority         = 1
  max_concurrency  = "1"
  max_errors       = "1"
  service_role_arn = aws_iam_role.automation_role.arn

  task_invocation_parameters {
    automation_parameters {
      parameter {
        name   = "InstanceId"
        values = [aws_instance.proxy_server.id]
      }
    }
  }
}

resource "aws_ssm_maintenance_window_task" "stop_instance_task" {
  window_id        = aws_ssm_maintenance_window.stop_time.id
  task_type        = "AUTOMATION"
  task_arn         = "AWS-StopEC2Instance"
  priority         = 1
  max_concurrency  = "1"
  max_errors       = "1"
  service_role_arn = aws_iam_role.automation_role.arn

  task_invocation_parameters {
    automation_parameters {
      parameter {
        name   = "InstanceId"
        values = [aws_instance.proxy_server.id]
      }
    }
  }
}