# hataldir_infra
hataldir Infra repository

bastion_IP = 35.210.206.2
someinternalhost_IP = 10.132.0.3

Конфигурация:

Созданы две виртуальные машины в GCP - bastion и someinternalhost.
У bastion два интерфейса с адресами 35.210.206.2 и 10.132.0.2, у someinternalhost - один, 10.132.0.3.
На bastion установлен VPN-сервер pritunl, работающий на порту 15586/udp. На сервере есть один пользователь test.
Подключение к серверу bastion можно осуществить с использованием конфигурационного файла cloud-bastion.ovpn.


Дополнительное задание 1:

Для подключения к серверу someinternalhost одной командой ssh someinternalhost достаточно создать файл ~/.ssh/config со следующим содержимым:
host someinternalhost
 HostName 10.132.0.3
 ProxyJump appuser@35.210.206.2:22
 User appuser
 IdentityFile ~/.ssh/appuser


Дополнительное задание 2:

 На сервер pritunl установлен сертификат от Let's Encrypt. Для проверки нужно заходить на адрес https://35.210.206.2.sslip.io
