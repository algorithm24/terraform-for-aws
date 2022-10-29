resource "aws_key_pair" "key" {
  key_name   = "${var.env}-key"
  public_key = var.key_file
}