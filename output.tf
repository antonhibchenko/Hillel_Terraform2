output "instance_id" {
  value = module.ec2.instance_id
}

//output "ElasticIP" {
//  value = module.ec2.elastic_ip
//}

output "instance_pub_ip" {
  value     = module.ec2.public_ip
  sensitive = false
}