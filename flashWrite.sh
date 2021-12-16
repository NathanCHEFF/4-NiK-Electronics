#!/bin/bash
#
#	чтобы сделать исполняемым файлом
#	sudo chmod +x ~/Desktop/flashWrite.sh
#	
#	start 
#	sh fleshWrite.sh
#	or 
#	./fleshWrite.sh
#
#
#df -h (посмотреть, какие устройства подключены к каким папкам)
#
#
#Я думаю, что было бы лучше использовать файл запуска для вашего сценария, создав ~/Desktop/ssh_home.desktopфайл со следующим содержимым:

# [Desktop Entry]
# Version=1.0
# Exec=/home/yourname/bin/ssh_home.sh
# Name=SSH Server
# GenericName=SSH Server
# Comment=Connect to My Server
# Encoding=UTF-8
# Terminal=true
# Type=Application
# Categories=Application;Network;
# Таким образом, вы получите кликабельную иконку, которая запустит ваш скрипт.
# Возможно, вам также придется установить флаг исполняемого файла с помощью chmod:
# chmod +x ~/Desktop/ssh_home.desktop
#
#
#
VFILE=/home/smart/Downloads/libzavod-sd-image-master-1845.img
echo 'Запуск программы записи флешки'
echo ''
echo ''
echo ''
echo 'путь к файлу образа '$VFILE
echo ''
echo 'Размонтируем'
#sudo umount /dev/sdb
echo 'Форматировать флешку?(Y/n)?'
read NAME
echo $NAME
#sudo mkfs -t ext4 -L FLASH /dev/sdb 
echo $VFILE
#sudo dd if=/home/smart/Downloads/libzavod-sd-image-master-1845.img of=/dev/sdb status=progress
#sudo dd if=/home/smart/Downloads/libzavod-sd-image-master-1845.img of=/dev/sdb
#sudo dd if=/home/smart/Downloads/libzavod-sd-image-master-1845.img of=/dev/sdb | watch -n1 'sudo kill -USR1 $(pgrep ^dd)'
sudo sync
