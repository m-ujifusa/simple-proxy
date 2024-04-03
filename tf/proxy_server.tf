resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.name_prefix}-key-pair"
  public_key = tls_private_key.main.public_key_openssh
}


resource "aws_instance" "proxy_server" {
  ami           = var.ami_id
  instance_type = "t2.nano"
  key_name      = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.proxy_server.id]


  user_data = <<-EOF
              #!/bin/bash
              
              # Update packages
              sudo apt update -y
              
              # Install Squid proxy
              sudo apt install squid -y
              
              # Create a new Squid configuration file
              sudo tee /etc/squid/squid.conf > /dev/null <<EOT
              acl allowed_ip src ${local.source_ip}/32
              http_access allow allowed_ip
              http_access deny all
              
              http_port ${var.proxy_port}
              
              # Allow CONNECT requests
              acl SSL_ports port 443
              acl Safe_ports port 80
              acl Safe_ports port 21
              acl Safe_ports port 443
              acl Safe_ports port 70
              acl Safe_ports port 210
              acl Safe_ports port 1025-65535
              acl Safe_ports port 280
              acl Safe_ports port 488
              acl Safe_ports port 591
              acl Safe_ports port 777
              acl CONNECT method CONNECT
              http_access allow CONNECT SSL_ports
              http_access allow CONNECT Safe_ports
              
              # Enable SSL/TLS tunneling
              ssl_bump server-first all
              EOT
              
              # Restart Squid service
              sudo systemctl restart squid
              EOF
  tags = {
    Name = "${var.name_prefix}-proxy"
  }
}

resource "aws_eip_association" "main" {
  instance_id   = aws_instance.proxy_server.id
  allocation_id = aws_eip.proxy_ip.id
}