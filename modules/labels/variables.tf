variable "namespace" {
  type = string
}

variable "stages" {
  type = set(string)
}

variable "resources" {
  type = set(string)
}