output "rds_address" {
  value = element(concat(aws_db_instance.rds[*].address, [""]), 0)
}

output "rds_port" {
  value = element(concat(aws_db_instance.rds[*].port, [""]), 0)
}

output "rds_username" {
  value = element(concat(aws_db_instance.rds[*].username, [""]), 0)
}

output "rds_password" {
  sensitive = true
  value     = element(concat(aws_db_instance.rds[*].password, [""]), 0)
}

output "rds_db_name" {
  value = element(concat(aws_db_instance.rds[*].name, [""]), 0)
}

