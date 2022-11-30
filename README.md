## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.82.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ya_instance_1"></a> [ya\_instance\_1](#module\_ya\_instance\_1) | ./modules/instance | n/a |
| <a name="module_ya_instance_2"></a> [ya\_instance\_2](#module\_ya\_instance\_2) | ./modules/instance | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_lb_network_load_balancer.lb-web](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer) | resource |
| [yandex_lb_target_group.web-servers](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group) | resource |
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet1](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.subnet2](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | External IP address vm-1 |
| <a name="output_external_ip_address_vm_2"></a> [external\_ip\_address\_vm\_2](#output\_external\_ip\_address\_vm\_2) | External IP address vm-2 |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | Internal IP address vm-1 |
| <a name="output_internal_ip_address_vm_2"></a> [internal\_ip\_address\_vm\_2](#output\_internal\_ip\_address\_vm\_2) | Internal IP address vm-2 |
| <a name="output_lb_ip_address"></a> [lb\_ip\_address](#output\_lb\_ip\_address) | Data about load balancer LB-WEB |
