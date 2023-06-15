# Define AWS provider.

provider "aws" {
  region = "ap-south-1"
  shared_credentials_files = ["/home/sourabh/.aws/credentials"]
}



