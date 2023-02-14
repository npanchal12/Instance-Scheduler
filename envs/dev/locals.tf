locals {
  name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  region = "ap-southeast-1"

  standard_tags = merge(
    { for k, v in var.standard_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
    { map-migrated = var.map_migrated },
  )
}
