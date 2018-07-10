provider "aws" {
  access_key  = "${var.aws_access_key_id}"
  secret_key  = "${var.aws_secret_access_key}"
  region      = "${var.aws_region}"
}

resource "aws_elasticache_subnet_group" "demo_redis_subnet_group" {
  name       = "demo-redis-subnet-group"
  subnet_ids = ["${var.vpc_public_sn_id}"]
}

resource "aws_elasticache_cluster" "redisInstance" {
  cluster_id           = "demo-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis4.0"
  port                 = 6379
  subnet_group_name    = "${aws_elasticache_subnet_group.demo_redis_subnet_group.name}"
  security_group_ids   = ["${var.vpc_private_sg_id}"]
}

output "subnet_id" {
  value = "${var.vpc_public_sn_id}"
}

output "subnet_group_name" {
  value = "${aws_elasticache_subnet_group.demo_redis_subnet_group.name}"
}

output "engine_version" {
  value = "${aws_elasticache_cluster.redisInstance.engine_version}"
}

output "port" {
  value = "${aws_elasticache_cluster.redisInstance.port}"
}

output "cache_node_0_address" {
  value = "${aws_elasticache_cluster.redisInstance.cache_nodes.0.address}"
}

output "cache_nodes_0_availability_zone" {
  value = "${aws_elasticache_cluster.redisInstance.cache_nodes.0.availability_zone}"
}
