# hataldir_infra
hataldir Infra repository


Домашнее задание № 5

Установлены Packer, ADC
Для Packer создан шаблон ubuntu16.json для создания образа ВМ из предыдущего ДЗ со всеми зависимостями но без приложения.
В шаблоне часть параметров вынесена в переменные, добавлены новые параметры.

Дополнительное задание 1:

Создан шаблон immutable.json, в котором добавлено также и приложение reddit (для которого написан systemd unit).

Дополнительное задание 1:

Написан скрипт create-reddit-vm.sh для создания ВМ из образа с помощью gcloud


testapp_IP = 35.195.223.202
testapp_port = 9292

Домашнее задание № 4

Установлен gcloud, с его помощью создана ВМ reddit-app, на нее поставлены ruby, bundler, mongodb и тестовое приложение. К ВМ предоставлен доступ на порт 9292.
Для установки пакетов и запуска приложения написаны скрипты.

Дополнительное задание 1:

Написан скрипт startup_script, добавлен в команду создания ВМ:

gcloud compute instances create reddit-app2  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata-from-file startup-script=startup_script.sh


Дополнительное задание 2:

Создано правило фаерволла с помощью gcloud:

gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server



bastion_IP = 35.210.206.2
someinternalhost_IP = 10.132.0.3

Домашнее задание № 3

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
