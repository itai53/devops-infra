# ─────────────────────────────────────────────
# External Secrets Operator
# ─────────────────────────────────────────────
resource "helm_release" "external_secrets_operator" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true
  version          = "0.9.10"
  values = []
depends_on = [
  module.eks,
  null_resource.update_kubeconfig
]
}
# ─────────────────────────────────────────────
# External DNS (IRSA + Helm)
# ─────────────────────────────────────────────
module "external_dns_irsa" {
  source              = "../../modules/external_dns_irsa"
  cluster_name        = var.cluster_name
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  oidc_provider_arn   = module.eks.oidc_provider_arn
  default_tags        = var.default_tags
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = "1.14.4"
  namespace  = "external-dns"
  create_namespace = true
  values = [
    file("${path.module}/../../externaldns/values.yaml")
  ]
  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_dns_irsa.externaldns_role_arn
  }
depends_on = [
  module.eks,
  null_resource.update_kubeconfig
]
}
# ─────────────────────────────────────────────
# Fluent Bit (Centralized Logging)
# ─────────────────────────────────────────────
resource "helm_release" "fluentbit" {
  name             = "fluentbit"
  repository       = "https://fluent.github.io/helm-charts"
  chart            = "fluent-bit"
  version          = "0.46.3"
  namespace        = "logging"
  create_namespace = true

  values = [
    file("${path.module}/../../fluentbit/values.yaml")
  ]
# Dynamically inject OpenSearch output config
set {
  name  = "extraOutputPlugin"
  value = <<EOT
[OUTPUT]
    Name  es
    Match *
    Host  ${module.opensearch.domain_endpoint}
    Port  443
    Index fluentbit
    Type  _doc
    Logstash_Format On
    Retry_Limit False
    tls On
    HTTP_User admin
    HTTP_Passwd ${var.opensearch_admin_password}
EOT
}
depends_on = [
  module.eks,
  null_resource.update_kubeconfig
]
}
# ─────────────────────────────────────────────
# Prometheus Monitoring Stack
# ─────────────────────────────────────────────
resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "56.6.0"
  namespace        = "monitoring"
  create_namespace = true
  values = [
    file("${path.module}/../../prometheus/values.yaml") 
  ]
  depends_on = [
  module.eks,
  null_resource.update_kubeconfig
]
}