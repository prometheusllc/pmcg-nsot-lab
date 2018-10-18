# Flow Logs

resource "aws_flow_log" "vpc" {
  log_group_name = "${aws_cloudwatch_log_group.vpc-flowlog-group.name}"
  iam_role_arn   = "${aws_iam_role.flowlog-role.arn}"
  vpc_id         = "${var.vpc_id}"
  traffic_type   = "ALL"
}


resource "aws_cloudwatch_log_group" "vpc-flowlog-group" {
  name = "/cosmosnsot-${var.environment}/${var.vpc_id}/flowlog"
  retention_in_days = "${var.flow_log_retention_in_days}"
}

resource "aws_iam_role" "flowlog-role" {
  name = "${var.environment}-flowlog-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flowlogs-policy" {
  name = "${var.environment}-flowlogs-policy"
  role = "${aws_iam_role.flowlog-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}