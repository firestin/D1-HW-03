terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  folder_id = "b1gk8b5sot87s8ri5lmc"
  cloud_id  = "ajei51h7artibn8ejf0h"
}

provider "yandex" {
  zone                     = "ru-central1-a"
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  service_account_key_file = "/home/firestin/Документы/default_tf/authorized_key.json"
}
