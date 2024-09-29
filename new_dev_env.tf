provider "aws" {
  region = "us-east-1"
}

# Create the first S3 bucket
resource "aws_s3_bucket" "bucket_1" {
  bucket = "example-bucket-1-123456"
  acl    = "private"

  tags = {
    Name        = "ExampleBucket1"
    Environment = "Dev"
  }
}

# Create the second S3 bucket
resource "aws_s3_bucket" "bucket_2" {
  bucket = "example-bucket-2-123456"
  acl    = "private"

  tags = {
    Name        = "ExampleBucket2"
    Environment = "Dev"
  }
}

# Create a Security Group for the EC2 instance
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-xxxxxxxx"  # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

# Create an EC2 instance
resource "aws_instance" "example_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "my-key-pair"            # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.example_sg.id]

  tags = {
    Name = "ExampleEC2"
  }
}

