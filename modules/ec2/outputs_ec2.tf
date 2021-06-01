output "instance_id" {
  value = aws_instance.UbuntuServer.*.id
}

//output "elastic_ip" {
//  value     = var.eip_attach == true ? aws_eip.UbuntuServer.0.public_ip : "eip not attached or defined" //
//  depends_on = [aws_eip.UbuntuServer]
//}

output "public_ip" {
  value     = var.eip_attach == true ? aws_eip.UbuntuServer.0.public_ip : aws_instance.UbuntuServer.0.public_ip // "eip not attached or defined" //
  depends_on = [aws_eip.UbuntuServer]
}
