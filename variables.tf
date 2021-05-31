variable "name" {
  description = "Linux Web Server"
  type        = string
}

variable "instance_type" {
  description = "t3.micro"
  default = "t3.micro"
  type        = string
}
