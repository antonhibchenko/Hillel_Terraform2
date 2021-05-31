variable "name" {
  description = "Linux Web Server"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "ami_id" {
  default = "ami-0502e817a62226e03"
  description = "UbuntuServer"
}

variable "availability_zone" {
  default = "eu-central-1b"
  description = "UbuntuServer"
}

variable "eip_attach" {
  type = bool
  default = true
  description = "Attach Elastic IP to instance"
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = "stop"
}

variable "instance_type" {
  description = "t3.micro"
  default = "t3.micro"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

//variable "subnet_ids" {
//  description = "A list of VPC Subnet IDs to launch in"
//  type        = list(string)
//  default     = []
//}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
