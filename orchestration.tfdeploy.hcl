orchestrate "auto_approve" "dev" {
  check {
    condition = context.plan.deployment == deployment.dev
    reason = "Dev deployments are auto approved"
  }
}