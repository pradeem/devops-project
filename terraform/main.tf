provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0731becbf832f281e"
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "DevOpsWebServer"
  }

  provisioner "file" {
    source      = "../app/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo service apache2 restart"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
}
