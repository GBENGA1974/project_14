# variables

variable "region" {
    type = string
    description = "region where the infrastructure would be placed"
}

variable "cidr_block" {
    type = list(string)
    description = "vpc and subnet cidr block"
}
