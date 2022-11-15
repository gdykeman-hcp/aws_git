# #Generate private key
# resource "tls_private_key" "workshop_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# #Create key pair in AWS
# resource "aws_key_pair" "workshop_key" {
#   key_name   = "workshop_key"
#   public_key = tls_private_key.workshop_key.public_key_openssh
# }

# #Store key file
# resource "local_file" "ssh_key" {
#   filename = "${aws_key_pair.workshop_key.key_name}.pem"
#   content  = tls_private_key.workshop_key.private_key_pem
# }