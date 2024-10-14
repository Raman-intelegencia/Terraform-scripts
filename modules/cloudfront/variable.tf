variable "origin_domain_name" {
  description = "The domain name of the S3 bucket to use as origin"
  type        = string
}

variable "alias" {
  description = "The alias for the CloudFront distribution"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function for CloudFront"
  type        = string
}
