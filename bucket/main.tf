# Объявляем провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

# Данные для подключения к провайдеру

provider "yandex" {
  token     = "AQAAAA--my-key--ATuwSEmNDt7vkvhg2ACS5PYbyw"
  cloud_id  = "b1g18--my-key--qhn1i833k"
  folder_id = "b1gvbt--my-key--oooi5e9"
  zone      = "ru-central1-a"
}

# Создаем сервис-аккаунт SA

resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "sa-skillfactory"
}

# Даем права на запись для этого SA

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создаем ключи доступа Static Access Keys

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

# Создаем хранилище tf-state-stateb1g18cs713kqh

resource "yandex_storage_bucket" "state" {
  bucket     = "tf-state-stateb1g18cs713kqh"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
}

