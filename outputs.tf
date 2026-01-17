output "greenops" {
  description = "GreenOps module outputs"
  value = {
    prometheus          = module.greenops.prometheus
    keda                = module.greenops.keda
    opencost            = module.greenops.opencost
    kepler              = module.greenops.kepler
    deployed_components = module.greenops.deployed_components
  }
}

output "demo_app_deployed" {
  description = "Whether the demo application was deployed"
  value       = var.deploy_demo_app
}
