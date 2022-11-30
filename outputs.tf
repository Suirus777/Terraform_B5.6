# Вывод IP адресов серверов

output "internal_ip_address_vm_1" {
  value = module.ya_instance_1.internal_ip_address_vm
}

output "external_ip_address_vm_1" {
  value = module.ya_instance_1.external_ip_address_vm
}

output "internal_ip_address_vm_2" {
  value = module.ya_instance_2.internal_ip_address_vm
}

output "external_ip_address_vm_2" {
  value = module.ya_instance_2.external_ip_address_vm
}

# Вывод данных о баласировщике нагрузки

output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.lb-web.listener
}

