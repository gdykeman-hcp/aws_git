variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "hashicorp"
}
variable "name" {
  description = "your name"
}
variable "org" {
  description = "your org"
}
variable "vpc_vars" {
}

variable "instances" {
  description = "This instances to include."
}

variable "amis" {
  type = map(string)
  default = {
    rhel   = "ami-06640050dc3f556bb"
    ubuntu = "ami-06640050dc3f556bb"
    amazon = "ami-09d3b3274b6c5d4aa"
  }
}

variable "ami_gitlab" {
  description = "gitlab ami for deployment"
}

variable "ami_hashi" {
  description = "gitlab ami for deployment"
  type        = string
  default     = "ami-08d616b7fbe4bb9d0"
}

variable "rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = -1
      to_port     = -1
      proto       = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 5432
      to_port     = 5432
      proto       = "tcp"
      cidr_blocks = ["10.10.10.10/32"]
    }
  ]
}