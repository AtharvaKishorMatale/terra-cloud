#variables
variable "cidr_block"{
    default = "10.0.0.0/16"
}

variable "web-cidr_block"{
     default = "10.0.0.0/20"
}
variable "app-cidr_block"{
      default = "10.0.16.0/20"
}
variable "db-cidr_block"{
     default = "10.0.32.0/20"

}
