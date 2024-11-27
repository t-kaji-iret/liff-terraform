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

    api = {
      domain_name = "d8gk9sqzv5.execute-api.ap-northeast-1.amazonaws.com"
      origin_id   = "api"
      custom_origin_config = {
        http_port = "80"
        https_port = "443"
        origin_protocol_policy = "match-viewer" // TODO: APIGatewayに証明書設定したらhttps-onlyにする
        origin_ssl_protocols   = ["TLSv1.2"]
      }
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
    },
    {
      path_pattern           = "/prod/api/*"
      target_origin_id       = "api"
      allowed_methods = ["GET", "POST", "PUT", "DELETE", "PATCH", "HEAD", "OPTIONS"]
      cached_methods = ["HEAD", "GET", "OPTIONS"]
      viewer_protocol_policy = "redirect-to-https"
      compress               = true
    }
  ]
}