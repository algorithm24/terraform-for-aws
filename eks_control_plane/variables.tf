variable "env" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "vpc_zone_identifier" {
  type = list(string)
}
variable "eks_data_plane_security_group_id" {
  type = string
}