variable "vpc_cidr_block" {
  type = string
}
variable "env" {
  type = string
}
variable "availability_zone" {
  type = list(string)
  default = ["us-east-1b", "us-east-1c", "us-east-1d", "us-east-1b", "us-east-1c", "us-east-1d"]
}
variable "public_subnet_cidr_blocks" {
  type = list(string)
}
variable "private_subnet_cidr_blocks" {
  type = list(string)
}