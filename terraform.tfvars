prefix = "gdykeman-hashicorp"

vpc_vars = {
  az      = "us-east-2a"
  cidr    = "10.2.0.0/16"
  region  = "us-east-2"
  rt_cidr = "0.0.0.0/0"
  subnet  = "10.2.2.0/24"
}

instances = {
  dev_server1 = {
    ami           = "ami-08d616b7fbe4bb9d0"
    instance_type = "t2.small"
    key_name      = "gdykeman"
  }
  dev_server2 = {
    ami           = "ami-08d616b7fbe4bb9d0"
    instance_type = "t2.small"
    key_name      = "gdykeman"
  }
}