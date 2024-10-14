resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = "${var.alias}-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for ${var.origin_domain_name}"
  price_class         = "PriceClass_100" # Use only North America and Europe
  default_root_object = "index.html"

  aliases = [var.alias]

  default_cache_behavior {
    target_origin_id       = "${var.alias}-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = var.lambda_function_arn
    }
    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = var.lambda_function_arn
    }

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:555520255237:certificate/f3aa9c7b-57d4-453d-8615-7345bef3a700"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name        = var.alias
    Environment = "Dev"
  }
}