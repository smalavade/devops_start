# This block creates the web servers using the "aws_instance" resource. 



resource "aws_instance" "web_az1" {
  count = 3
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.release_admin.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id = aws_subnet.web_subnet_1.id
  associate_public_ip_address = true
  provisioner "local-exec" {
    command = "printf '\n${self.public_ip}' >> hosts_1 && sleep 2m"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sed -i '/^[0-9]/d' hosts_1"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      

    ]
  }
  connection {
    host = self.public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = "${file("/home/id_rsa")}"
  }

  tags = {
    Name = "web-server-${count.index+1}"
  }
}


resource "aws_instance" "web_az2" {
  count = 3
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.release_admin.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id = aws_subnet.web_subnet_2.id
  associate_public_ip_address = true
  provisioner "local-exec" {
    command = "printf '\n${self.public_ip}' >> hosts_2 && sleep 2m"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sed -i '/^[0-9]/d' hosts_2"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
    ]
  }
  connection {
    host = self.public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = "${file("/home/id_rsa")}"
  }

  tags = {
    Name = "web-server-${count.index+3}"
  }
}


resource "aws_key_pair" "release_admin" {
  key_name   = "id_rsa"
  public_key = file("/home/id_rsa.pub")
}
  

