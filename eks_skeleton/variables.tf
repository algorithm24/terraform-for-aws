variable "env_nonprod" {
  type = string
}
variable "vpc_id_nonprod" {
  type = string
}
variable "vpc_zone_identifier_nonprod" {
  type = list(string)
}
variable "instance_type_nonprod" {
  type = string
}
variable "desired_capacity_nonprod" {
  type = number
}
variable "env_prod" {
  type = string
}
variable "vpc_id_prod" {
  type = string
}
variable "vpc_zone_identifier_prod" {
  type = list(string)
}
variable "instance_type_prod" {
  type = string
}
variable "desired_capacity_prod" {
  type = number
}