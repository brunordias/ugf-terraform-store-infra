resource "aws_iam_policy" "policy" {
  name = var.name
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sns:CreateTopic",
          "sns:ListTopics",
          "sqs:GetQueueAttributes",
          "sns:Subscribe",
          "sqs:CreateQueue",
          "sqs:SetQueueAttributes"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}