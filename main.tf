module "scheduler" {
  source = "./modules/components/scheduler"

  lambda_function_start_stop_rds_arn          = module.lambda_function.lambda_function_start_stop_rds_arn
  lambda_function_start_stop_rds_name         = module.lambda_function.lambda_function_start_stop_rds_name
  lambda_function_start_stop_non_asg_ec2_arn  = module.lambda_function.lambda_function_start_stop_non_asg_ec2_arn
  lambda_function_start_stop_non_asg_ec2_name = module.lambda_function.lambda_function_start_stop_non_asg_ec2_name
  lambda_function_update_scale_asg_ec2_arn    = module.lambda_function.lambda_function_udpate_scale_asg_arn
  lambda_function_update_scale_asg_ec2_name   = module.lambda_function.lambda_function_udpate_scale_asg_name
  lambda_function_update_scale_asg_ecs_arn    = module.lambda_function.lambda_function_udpate_ecs_scale_asg_arn
  lambda_function_update_scale_asg_ecs_name   = module.lambda_function.lambda_function_udpate_ecs_scale_asg_name
}

module "lambda_function" {
  source = "./modules/components/lambda"

  start_stop_rds_code         = data.archive_file.start_stop_rds_zip_file.output_path
  start_stop_non_asg_ec2_code = data.archive_file.start_stop_non-asg-ec2_zip_file.output_path
  update_asg_scale_code       = data.archive_file.update-asg-ec2_zip_file.output_path
  update_ecs_asg_scale_code   = data.archive_file.update-ecs-asg_zip_file.output_path
}

module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 3.2.0"

  name         = "asg_counts"
  hash_key     = "asg_name"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "asg_name"
      type = "S"
    },
    {
      name = "desired_counts"
      type = "S"
    },
    {
      name = "minimum_counts"
      type = "S"
    },
    {
      name = "maximum_counts"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      hash_key           = "desired_counts"
      name               = "desired_counts-index"
      non_key_attributes = ["asg_name"]
      projection_type    = "INCLUDE"
      range_key          = "asg_name"
      write_capacity     = 5
      read_capacity      = 5
    },
    {
      hash_key           = "minimum_counts"
      name               = "minimum_counts-index"
      non_key_attributes = ["asg_name"]
      projection_type    = "INCLUDE"
      range_key          = "asg_name"
      write_capacity     = 5
      read_capacity      = 5
    },
    {
      hash_key           = "maximum_counts"
      name               = "maximum_counts-index"
      non_key_attributes = ["asg_name"]
      projection_type    = "INCLUDE"
      range_key          = "asg_name"
      write_capacity     = 5
      read_capacity      = 5
    }
  ]
}

module "ecs_task_counts" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 3.2.0"

  name         = "ecs_task_counts"
  hash_key     = "cluster_name"
  range_key    = "service_name"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "cluster_name"
      type = "S"
    },
    {
      name = "service_name"
      type = "S"
    },
    {
      name = "desired_count"
      type = "S"
    },
    {
      name = "min_capacity"
      type = "S"
    },
    {
      name = "max_capacity"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      hash_key           = "service_name"
      name               = "service_name-index"
      non_key_attributes = ["cluster_name"]
      projection_type    = "INCLUDE"
      range_key          = "cluster_name"
      write_capacity     = 5
      read_capacity      = 5
    },
    {
      hash_key           = "desired_count"
      name               = "desired_count-index"
      non_key_attributes = ["service_name"]
      projection_type    = "INCLUDE"
      range_key          = "service_name"
      write_capacity     = 5
      read_capacity      = 5
    },
    {
      hash_key           = "min_capacity"
      name               = "min_capacity-index"
      non_key_attributes = ["service_name"]
      projection_type    = "INCLUDE"
      range_key          = "service_name"
      write_capacity     = 5
      read_capacity      = 5
    },
    {
      hash_key           = "max_capacity"
      name               = "max_capacity-index"
      non_key_attributes = ["service_name"]
      projection_type    = "INCLUDE"
      range_key          = "service_name"
      write_capacity     = 5
      read_capacity      = 5
    }
  ]
}
