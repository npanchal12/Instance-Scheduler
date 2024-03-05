locals {
  standard_tags = merge(
    { for k, v in var.standard_tags : "abc:${replace(k, "_", "-")}" => try(join(":", v), v) if v != null && v != "" && length(v) != 0 },
  )
}
