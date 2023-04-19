## Creates SSH key locally ##
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "${path.module}/outputs/id_rsa"

  provisioner "local-exec" {
    command = "chmod 600 ${path.module}/outputs/id_rsa"
  }
}

resource "local_file" "public_key" {
  content  = tls_private_key.ssh.public_key_openssh
  filename = "${path.module}/outputs/id_rsa.pub"

  provisioner "local-exec" {
    command = "chmod 644 ${path.module}/outputs/id_rsa.pub"
  }
}

## Make the full keypair needed by AWS ##
resource "aws_key_pair" "ssh" {
  key_name = "wg_${formatdate(var.date_format, timestamp())}_"
  public_key = tls_private_key.ssh.public_key_openssh
  tags       = var.default_tags
}

resource "aws_secretsmanager_secret" "wireguard_secret" {
  name = "${var.default_tags.Team}/ssh_keys/${aws_key_pair.ssh.id}_${formatdate(var.date_format, timestamp())}_"
  tags = var.default_tags
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.wireguard_secret.id
  secret_string = tls_private_key.ssh.private_key_pem
}