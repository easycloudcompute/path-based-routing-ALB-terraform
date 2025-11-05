output "lb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb.target_groups
}

