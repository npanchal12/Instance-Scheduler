data "archive_file" "start_stop_rds_zip_file" {

  output_path = "${path.module}/common/lambda/start-stop-rds/start-stop-rds.zip"
  source_dir  = "${path.module}/common/lambda/start-stop-rds"
  type        = "zip"
}

data "archive_file" "start_stop_non-asg-ec2_zip_file" {

  output_path = "${path.module}/common/lambda/start-stop-non-asg-ec2/start-stop-non-asg-ec2.zip"
  source_dir  = "${path.module}/common/lambda/start-stop-non-asg-ec2"
  type        = "zip"
}

data "archive_file" "update-asg-ec2_zip_file" {

  output_path = "${path.module}/common/lambda/update-asg-scale-ec2/update-asg-ec2.zip"
  source_dir  = "${path.module}/common/lambda/update-asg-scale-ec2"
  type        = "zip"
}

data "archive_file" "update-ecs-asg_zip_file" {

  output_path = "${path.module}/common/lambda/update-asg-scale-ecs/update-asg-ecs.zip"
  source_dir  = "${path.module}/common/lambda/update-asg-scale-ecs"
  type        = "zip"
}
