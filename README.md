## Description
This is initial level of project showing automation and the creation of the infrastructure on aws using terraform.

## Requirements
The infrastructure includes 6 web servers and 2 databases. The requirements are:
- High availability
- Installation of apache webserver on the instances

## Architecture 
There will be 6 web servers will be created in 2 public subnets in 2 different AZs while the database instances will be created in 2 private subnets in 2 availabilty zones as the web servers. 
