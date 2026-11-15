resource "aws_iam_role" "terraform_ec2_import" {
  name        = "Terraform-EC2-Import-Role"
  description = "Allows EC2 instance to inspect existing AWS resources for Terraform import."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "terraform_ec2_import" {
  name = "Terraform-EC2-Import-Role"
  role = aws_iam_role.terraform_ec2_import.name
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.terraform_ec2_import.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
