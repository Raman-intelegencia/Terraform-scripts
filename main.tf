
module "account_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "dev1-cloudfront-account-ams"
  tags = {
    Name        = "dev1-cloudfront-account-ams"
    Environment = "Dev"
  }
}

module "admin_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "dev1-cloudfront-admin-ams"
  tags = {
    Name        = "dev1-cloudfront-admin-ams"
    Environment = "Dev"
  }
}

module "extmsg_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "dev1-cloudfront-extmsg-ams"
  tags = {
    Name        = "dev1-cloudfront-extmsg-ams"
    Environment = "Dev"
  }
}

module "messenger_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "dev1-cloudfront-messenger-ams"
  tags = {
    Name        = "dev1-cloudfront-messenger-ams"
    Environment = "Dev"
  }
}

# CloudFront Distribution Module
module "cloudfront_distribution_account" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.account_bucket.bucket_name
  alias               = "dev-account.intelegencia.in"
  lambda_function_arn = "arn:aws:lambda:us-east-1:555520255237:function:dev1-webapps-CloudFrontEdge:9"
}

module "cloudfront_distribution_admin" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.admin_bucket.bucket_name
  alias               = "dev-admin.intelegencia.in"
  lambda_function_arn = "arn:aws:lambda:us-east-1:555520255237:function:dev1-webapps-CloudFrontEdge:9"
}

module "cloudfront_distribution_extmsg" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.extmsg_bucket.bucket_name
  alias               = "dev-extmsg.intelegencia.in"
  lambda_function_arn = "arn:aws:lambda:us-east-1:555520255237:function:dev1-webapps-CloudFrontEdge:9"
}

module "cloudfront_distribution_messenger" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.messenger_bucket.bucket_name
  alias               = "dev-messenger.intelegencia.in"
  lambda_function_arn = "arn:aws:lambda:us-east-1:555520255237:function:dev1-webapps-CloudFrontEdge:9"
}
