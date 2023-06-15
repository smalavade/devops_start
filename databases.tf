# This block creates the databases using the "aws_db_instance" resource.
# The MySQL engine is used and the instance class is set to "db.t2.micro", and 5GB of storage is allocated for each instance. 
# The instances are deployed in the "ap-south-1" availability zone, and each instance is named using the "name" parameter with a unique index number.
# A default username and password for the databases is set using the "username" and "password" parameters.


resource "aws_db_instance" "db_1" {
  count = 1
  engine = "mysql"
  instance_class = "db.t2.micro"
  allocated_storage = 4
  availability_zone = "ap-south-1"
  db_name = "database${count.index+1}"
  username = "admin"
  password = "password"
  apply_immediately         = true
  skip_final_snapshot       = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

}


resource "aws_db_instance" "db_2" {
  count = 1
  engine = "mysql"
  instance_class = "db.t2.micro"
  allocated_storage = 5
  availability_zone = "ap-south-2"
  db_name = "database${count.index+1}"
  username = "admin"
  password = "password"
  apply_immediately         = true
  skip_final_snapshot       = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

}
