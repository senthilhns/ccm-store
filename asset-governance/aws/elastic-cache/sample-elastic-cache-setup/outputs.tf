output "cluster_id" {
  value = aws_elasticache_cluster.sample.id
}

output "cluster_endpoint" {
  value = aws_elasticache_cluster.sample.cache_nodes[0].address
}

output "node_type" {
  value = aws_elasticache_cluster.sample.node_type
}
