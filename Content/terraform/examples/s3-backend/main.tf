terraform {
  backend "s3" {
    bucket = "devopszero2hero-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
  required_version = ">= 1.9.0"
}
resource "local_file" "test_file" {
  filename = "TestS3Backend.txt"
  content  = "Hello, World! (my terraform state is in the cloud!)"
}