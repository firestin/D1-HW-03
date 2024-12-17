data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2204-lts"
}


resource "yandex_compute_instance" "server-1" {
  name                      = "server-1"
  allow_stopping_for_update = true
  hostname                  = "server-1"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
    ssh-keys = "firestin:${file("~/.ssh/id_rsa.pub")}"
  }


  scheduling_policy {
    preemptible = true
  }

}

resource "yandex_compute_instance" "server-2" {
  name                      = "server-2"
  allow_stopping_for_update = true
  hostname                  = "server-2"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }

}


resource "yandex_vpc_network" "network_terraform" {
  name = "network_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "subnet_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}
