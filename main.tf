# Указываем провайдер Yandex

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex" # URL: yandex-cloud/yandex
    }
  }
  required_version = ">= 0.61.0" # Версия клиента больше или равно 0.61.0


  # Переносим state файл в bucket хранилище которое создали в ресурсе \bucket

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-stateb1g18cs713kqh"              # Название соданного Bucket в Yandex-cloud                 
    region     = "ru-central1-a"                            # зона хранения
    key        = "issue1/lemp.tfstate"                      # Папка\название state файла терраформа
    access_key = "YCAJEs--my-key--AZaumu31G"                # Access key который был создан при создание бакета
    secret_key = "YCPfVh--my-key--345UqmFMXxtsRWoXa3xJHZX-" # Secret key который был создан при создание бакета

    skip_region_validation      = true
    skip_credentials_validation = true
  }

}

# обязательные данные для подключения к провайдеру яндекса, к облаку

provider "yandex" {
  token     = "AQAAAAACzeA7AA--my-key--vkvhg2ACS5PYbyw" # для запроса AUTH-Token использовать ссылку: https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb      
  cloud_id  = "b1g--my-key--n1i833k"                    # Скопировать с главной страницы облака
  folder_id = "b1g--my-key--oooi5e9"                    # Скопировать с станницы Folder, моя страница по умолчанию Default
  zone      = "ru-central1-a"                           # Указать зону по умолчанию
}

# Создаём сеть "network"

resource "yandex_vpc_network" "network" {
  name = "network"
}

# Создаём подсеть subnet1 для LEMP сервера в зоне А 

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"                     # Название подсети
  zone           = "ru-central1-a"               # Зона где она будет находиться
  network_id     = yandex_vpc_network.network.id # Помещаем подсеть в сеть network которую создали выше
  v4_cidr_blocks = ["192.168.10.0/24"]           # IP range для подсети subnet1
}

# Создаём подсеть subnet1 для LAMP сервера в зоне B

resource "yandex_vpc_subnet" "subnet2" {
  name           = "subnet2"                     # Название подсети
  zone           = "ru-central1-b"               # Зона где она будет находиться
  network_id     = yandex_vpc_network.network.id # Помещаем подсеть в сеть network которую создали выше
  v4_cidr_blocks = ["192.168.11.0/24"]           # IP range для подсети subnet1
}

# Описание модулей

# Описание модуля создания сервеа LEMP

module "ya_instance_1" {
  source                = "./modules/instance"         # Путь где лежит файл модуль, с параметрами для сервера(Cores, RAMM, HDD)
  instance_family_image = "lemp"                       # Тип сервера, в нашем случаи NGINX WEB сервер
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id # Помещаем сервер в созданную выше подсеть зоны А (subnet1) 
}

# Описание модуля создания сервеа LAMP

module "ya_instance_2" {
  source                = "./modules/instance"         # Путь где лежит файл модуль, с параметрами для сервера(Cores, RAMM, HDD)
  instance_family_image = "lamp"                       # Тип сервера, в нашем случаи APACHE WEB сервер
  vpc_subnet_id         = yandex_vpc_subnet.subnet2.id # Помещаем сервер в созданную выше подсеть зоны B (subnet2)
}
