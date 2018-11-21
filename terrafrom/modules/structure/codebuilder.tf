resource "aws_iam_role" "codebuilder_role" {
  name = "codebuilder"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codebuilder_policy" {
  name = "codebuild-policy-codebuilder"
  path = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "arn:aws:kms:us-west-2::alias/aws/ssm"
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "ssm:*",
        "s3:*",
        "route53:*",
        "lambda:*",
        "kms:*",
        "iam:*",
        "codebuild:*",
        "cloudfront:*",
        "apigateway:*",
        "acm:*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "codebuilder_policy_attachment" {
  name = "codebuild-policy-attachment-codebuilder"
  policy_arn = "${aws_iam_policy.codebuilder_policy.arn}"
  roles = ["${aws_iam_role.codebuilder_role.id}"]
}



resource "aws_codebuild_project" "codebuild" {
  name = "${var.project_name}"

  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuilder_role.arn}"

  source {
    type     = "GITHUB"
    location = "https://github.com/lotysh/java_hello_world.git"
    buildspec =  "version: 0.2\n\nphases:\n  build:\n    commands:\n      - cd sparkjava-war-example/\n      - mvn package\n      - ls -la target/\nartifacts:\n    files:\n     - sparkjava-war-example/target/sparkjava-hello-world-1.0.war"
  }

  environment {
    compute_type = "${var.codebuild_compute_type}"
    type         = "LINUX_CONTAINER"
    image        = "${var.codebuild_image}"
  }

  artifacts {
    type           = "S3"
    location       = "testtask-artifacts"
    namespace_type = "NONE"
  }
}