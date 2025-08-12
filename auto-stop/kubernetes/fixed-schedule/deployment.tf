resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("deployment.yaml"))
}
resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("service.yaml"))
}
resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("ingress.yaml"))
}
