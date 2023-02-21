data "archive_file" "stop_ec2_zip_file" {

  output_path = "${path.module}/../../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
  source_dir  = "${path.module}/../../../common/lambda/stop-non-asg-ec2-instances"
  type        = "zip"
}

data "archive_file" "start_ec2_zip_file" {

  output_path = "${path.module}/../../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
  source_dir  = "${path.module}/../../../common/lambda/start-non-asg-ec2-instances"
  type        = "zip"
}

data "archive_file" "stop_rds_zip_file" {

  output_path = "${path.module}/../../../common/build/stop-rds/stop-rds.zip"
  source_dir  = "${path.module}/../../../common/lambda/stop-rds"
  type        = "zip"
}

data "archive_file" "start_rds_zip_file" {

  output_path = "${path.module}/../../../common/build/start-rds/start-rds.zip"
  source_dir  = "${path.module}/../../../common/lambda/start-rds"
  type        = "zip"
}
