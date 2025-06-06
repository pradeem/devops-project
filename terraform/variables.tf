variable "key_name" {
  default = "devopsuser-ec2-key"
}

variable "private_key_path" {
  description = "Path to the SSH private key file"
  type        = string
}

