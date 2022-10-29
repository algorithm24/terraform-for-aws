variable "env" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "vpc_zone_identifier" {
  type = list(string)
}
variable "instance_type" {
  type = string
}
variable "desired_capacity" {
  type = number
}