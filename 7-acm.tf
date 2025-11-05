# ACM Module - To create and Verify SSL Certificates
module "myacm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".") # Removes the last . from domain name like devops4fun.site.
  zone_id     = data.aws_route53_zone.mydomain.zone_id

  subject_alternative_names = [
    "*.devops4fun.site"
  ]

  validation_method   = "DNS" # Which method to use for validation. DNS or EMAIL are valid. This parameter must not be set for certificates that were imported into ACM and then into Terraform.
  wait_for_validation = true  # Whether to wait for the validation to complete
}

# ACM Certificate ARN output
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.myacm.acm_certificate_arn
}

