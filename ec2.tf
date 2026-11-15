resource "aws_instance" "nginx_server" {
  ami                    = "ami-03b7abd930e847268"
  instance_type          = "t3.micro"
  key_name               = "nginx-api-security-key"
  subnet_id              = "subnet-0e91558350b8b07cd"
  vpc_security_group_ids = [aws_security_group.nginx_api_security.id]

  iam_instance_profile = "Terraform-EC2-Import-Role"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tags = {
    Name = "Nginx-API-Security-Assignment"
  }
}
