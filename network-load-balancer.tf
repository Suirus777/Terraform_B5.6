# Создаём балансировщик сети LB-WEB

resource "yandex_lb_network_load_balancer" "lb-web" {
  name = "lb-web" # Название балансировщика

  # Создаём обработчик

  listener {
    name = "listener-web-servers" # Название обработчика
    port = 80                     # Какой порт слушать, в нашем случаи порт HTTP 
    external_address_spec {
      ip_version = "ipv4" # присваиваем внешний IP адрес нашему болансировщику
    }
  }

  # Создаём целевую группу 

  attached_target_group {
    target_group_id = yandex_lb_target_group.web-servers.id # Даём название как в описании ресурса ниже: - web-servers-target-group

    healthcheck {   # указываем что проверять на отзывчевость на серверах в группе 
      name = "http" # Проверка будет проверять доступнос HTTP порта серверов в группе
      http_options {
        port = 80 # Порт для проверки
        path = "/"
      }
    }
  }
}

# Создаём группу серверов

resource "yandex_lb_target_group" "web-servers" {
  name = "web-servers-target-group" # Даём название группе

  target {
    subnet_id = yandex_vpc_subnet.subnet1.id                # Указываем внутренний IP адрес сервера LEMP из зоны А  
    address   = module.ya_instance_1.internal_ip_address_vm # Добавляем сервер LEMP из зоны А в группу
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet2.id                # Указываем внутренний IP адрес сервера LАMP из зоны B
    address   = module.ya_instance_2.internal_ip_address_vm # Добавляем сервер LAMP из зоны B в группу
  }
}
