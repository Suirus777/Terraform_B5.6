# Объявляем переменные

variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"

}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "zone" {                                # Используем переменную для передачи в конфиг инфраструктуры
  description = "Use specific availability zone" # Опционально описание переменной
  type        = string                           # Опционально тип переменной
  default     = "ru-central1-b"                  # Опционально значение по умолчанию для переменной
}
