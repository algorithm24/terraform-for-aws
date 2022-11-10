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
variable "eks_control_plane_security_group_id" {
  type = string
}
variable "eks_control_plane_version" {
  type = string
}
variable "eks_control_plane_certificate_authority" {
  type = string
}
variable "eks_control_plane_endpoint" {
  type = string
}