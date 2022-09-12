output "jumpbox_ip" {
  value = aws_instance.jumpbox.public_ip
}

output "xpand_ips" {
  value = join(",", aws_instance.xpand_db[*].private_ip)
}

output "maxscale_ips" {
  value = join(",", aws_instance.maxscale[*].private_ip)
}