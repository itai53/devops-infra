# ─────────────────────────────────────────────
# StatusPage App Deployment (via Helm Chart)
# ─────────────────────────────────────────────
resource "helm_release" "statuspage_app" {
  name             = "statuspage"
  chart            = "${path.module}/../../statuspage"
  namespace        = "default"
  create_namespace = true
  set {
    name  = "image.repository"
    value = local.app_image_repo
  }
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.name"
    value = "statuspage-ingress"
  }
  set {
    name  = "ingress.namespace"
    value = "default"
  }
  set {
    name  = "ingress.scheme"
    value = "internet-facing"
  }
  set {
    name  = "ingress.targetType"
    value = "ip"
  }
  set {
    name  = "ingress.listenPorts"
    value = "[{\"HTTP\":80}]"
  }
  set {
    name  = "ingress.loadBalancerName"
    value = "my-statuspage-alb"
  }
  set {
    name  = "ingress.externalDnsHostname"
    value = "app.imlinfo.xyz"
  }
  set {
    name  = "ingress.className"
    value = "alb"
  }
  set {
    name  = "ingress.host"
    value = "app.imlinfo.xyz"
  }
  set {
    name  = "ingress.serviceName"
    value = "statuspage-service"
  }
  set {
    name  = "ingress.servicePort"
    value = "80"
  }
depends_on = [
  module.eks,
  null_resource.update_kubeconfig
]
}
