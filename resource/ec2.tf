#########################
# EC2
#########################
resource "aws_instance" "bastion" {
  ami                  = "ami-03f584e50b2d32776"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  subnet_id            = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.ec2-sg.security_group_id]

  tags = {
    Name = "gourmet-liff-app-bastion-ec2"
    Terraform = "true"
    Project = "gourmet-liff-app"
  }
}
resource "aws_iam_instance_profile" "bastion" {
  name = "gourmet-liff-app-bastion-ec2-profile"
  role = aws_iam_role.bastion.name
}