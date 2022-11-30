# Модуль с параметрами для серверов

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

# Параметры сервера (cores, RAMM)

resource "yandex_compute_instance" "vm" {
  name = "terraform-${var.instance_family_image}"

  resources {
    cores  = 2
    memory = 2
  }

  # Указываем какой будем использовать образ

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  # создаём сетевой интерфейс 

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  # Указываем путь к сгенерированному ключу ssh для подключения к созданым серверам

  metadata = {
    ssh-keys = "ubuntu:${file("/home/odmin/.ssh/user.pub")}"
  }
}
