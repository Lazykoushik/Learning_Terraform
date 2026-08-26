variable "user_definition" {
  description = "List of users to be created"
  type = map(object({
    user_principal_name = string
    display_name        = string
    mail_nickname       = string
    password            = string
    city                = string
    company_name        = string
    mobile_phone        = number
  }))
}
