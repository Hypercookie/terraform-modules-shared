variable "namespace" {
  type = string
  description = "The namespace to build labels under"
}

variable "stages" {
  type = set(string)
  description = "The different stages to build labels for"
}

variable "resources" {
  type = set(string)
  description = "What resources will be present on each stage"
}