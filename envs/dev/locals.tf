locals {
  name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  region = "ap-southeast-1"
}
