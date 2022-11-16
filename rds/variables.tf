variable "env" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "cidr_block_access" {
  type = list(string) 
}