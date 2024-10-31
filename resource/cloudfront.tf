#########################
# Cloud Front
# NOTE: Multi OriginにしてBehaviorのパスペースで振り分ける設計
#########################
module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  create_origin_access_control = true
  origin_access_control = {
    "s3" : {
      "description" : "",
      "origin_type" : "s3",
      "signing_behavior" : "always",
      "signing_protocol" : "sigv4"
    }
  }

  origin = {
    frontend = {
      domain_name = module.frontend-source-private-bucket.s3_bucket_bucket_regional_domain_name
      origin_id   = "frontend"
      origin_access_control_id = module.cloudfront.cloudfront_origin_access_controls_ids[0]
    }

    photo = {
      domain_name = module.photo-private-bucket.s3_bucket_bucket_regional_domain_name
      origin_id   = "photo"
      origin_access_control_id = module.cloudfront.cloudfront_origin_access_controls_ids[0]
    }
  }

  default_root_object = "index.html"

  default_cache_behavior = {
    allowed_methods = ["HEAD", "GET", "OPTIONS"]
    cached_methods = ["HEAD", "GET", "OPTIONS"]
    target_origin_id       = "frontend"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/photo/*"
      target_origin_id       = "photo"
      allowed_methods = ["GET", "POST", "PUT", "DELETE", "PATCH", "HEAD", "OPTIONS"]
      cached_methods = ["HEAD", "GET", "OPTIONS"]
      viewer_protocol_policy = "redirect-to-https"
      compress               = true
    }
  ]
}