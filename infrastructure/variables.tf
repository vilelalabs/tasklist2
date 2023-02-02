variable "aws-config" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}
