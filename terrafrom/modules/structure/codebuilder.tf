resource "aws_codebuild_project" "codebuild" {
  name = "${var.project_name}"

  build_timeout = "5"
  service_role  = "${var.codebuild_arn}"

  source {
    type     = "GITHUB"
    location = "https://github.com/lotysh/java_hello_world.git"
    buildspec = "spec.yaml"
  }

  environment {
    compute_type = "${var.codebuild_compute_type}"
    type         = "LINUX_CONTAINER"
    image        = "${var.codebuild_image}"
  }

  artifacts {
    type           = "S3"
    location       = "testtask-artifacts"
    namespace_type = "BUILD_ID"
  }
}