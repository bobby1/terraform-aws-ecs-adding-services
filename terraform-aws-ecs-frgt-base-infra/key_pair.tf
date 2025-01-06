########################################################################################################################
## Create a public and private key pair for login to the EC2 Instances
########################################################################################################################
resource "aws_key_pair" "default" {
  key_name   = "id_rsa_b1_1"
  public_key = var.public_ec2_key
}