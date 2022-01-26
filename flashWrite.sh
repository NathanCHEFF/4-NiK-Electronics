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
echo 'https://github.com/NathanCHEFF/flashWriter-4-NiK-Electronics-/'
echo 'У меня работало без форматирования и отмонтирования устройства.'
echo 'Просто вводи "n"'
echo ''
echo ''
echo ''
echo 'путь к файлу образа '$VFILE' ?'
read RESP
if [ "$RESP" != "y" ] && [ "$RESP" != "Y" ] && [ "$RESP" != "д" ] && [ "$RESP" != "Д" ] ; then
    echo "введите путь к файлу:"
	read VFILE

fi

if [ ! -f $VFILE ] ; then
	echo "неправильная директория или нет файла"
	exit
fi

echo 'Форматировать флешку?(Y/n)?'
read RESP
if [ "$RESP" != "y" ] && [ "$RESP" != "Y" ] && [ "$RESP" != "д" ] && [ "$RESP" != "Д" ] ; then
	echo  "форматирование отменено!"
else
	echo 'Размонтируем'
	sudo umount /dev/sdb
	sudo mkfs -t ext4 -L FLASH /dev/sdb
  echo "Если окно закроеться - программу нужно доработать!"
fi
echo 'Записать данные на носитель?(Y/n)?'
read RESP
if [ "$RESP" != "y" ] && [ "$RESP" != "Y" ] && [ "$RESP" != "д" ] && [ "$RESP" != "Д" ] ; then
  echo "Запись отменена."
else
  clear
  echo  "Write partition data:"
  sudo dd if=/home/smart/Downloads/libzavod-sd-image-master-1845.img of=/dev/sdb status=progress
fi

#sudo dd if=$VFILE of=/dev/sdb  
#sudo dd if=$VFILE of=/dev/sdb  status=progress
#sudo dd if=$VFILE of=/dev/sdb  | echo  $(sudo kill -USR1 $(pgrep ^dd))
#sudo dd if=/home/smart/Downloads/libzavod-sd-image-master-1845.img of=/dev/sdb | watch -n1 'sudo kill -USR1 $(pgrep ^dd)'
clear
sudo sync
echo 'screen clear'
echo "Синхронизация прошла с кодом "$RANDOM
echo 'Создание файла interfaces'
##lsblk
#blkid -s UUID -o value /dev/sdb1
#
#
#
#
UUID=$(sudo blkid -s UUID -o value /dev/sdb1)
VFILE=/media/smart/"$UUID"/interfaces
echo " метка тома : "$UUID
if [ ! -f $VFILE ] ; then
	echo  "файла нет!"
	sudo cat > $VFILE
fi
if [ ! -f $VFILE ] ; then
	echo  "ошибка создания файла"
	exit 0
fi

#
# 10.3.33.[60~92] (E32)
#	60+RESP
#
#

echo "Ведите номер места(или КС)"
read RESPI

IPADR=$(( RESPI + 59 ))

CONST_ADD=212
if [ $RESPI -ge 27 ]
  CONST_ADD = $((CONST_ADD + 1))
fi

MACADR= MACADR=$(echo $(echo "obase=16; "$(( RESPI + CONST_ADD )) | bc)| tr '[:upper:]' '[:lower:]')
echo "Ip адрес устройства  10.3.33."$IPADR
echo "Mac адрес устройства b6:d0:5e:0f:"$MACADR":16"
echo ""
echo "Запись данных"
sudo mount -o remount,rw /media/smart/"$UUID"/
echo '# INTERFACES ###############################'$'\r' > $VFILE
echo '# USE_BRANCH master ########################'$'\r' >> $VFILE
echo ''$'\r' >> $VFILE
echo '# '$RESPI' mountplace'$'\r' >> $VFILE
echo ''$'\r' >> $VFILE
echo 'auto lo'$'\r' >> $VFILE
echo 'iface lo inet loopback'$'\r' >> $VFILE
echo ''$'\r' >> $VFILE
echo '#auto eth1'$'\r' >> $VFILE
echo 'allow-hotplug eth1'$'\r' >> $VFILE
echo 'iface eth1 inet static'$'\r' >> $VFILE
echo $'\t''hwaddress ether 02:fb:85:37:a5:fa'$'\r' >> $VFILE
echo $'\t''address 10.2.33.240'$'\r' >> $VFILE
echo $'\t''netmask 255.255.255.0'$'\r' >> $VFILE
echo $'\t''metric 2'$'\r' >> $VFILE
echo ''$'\r' >> $VFILE
echo '#auto eth0'$'\r' >> $VFILE
echo 'allow-hotplug eth0'$'\r' >> $VFILE
echo 'iface eth0 inet static'$'\r' >> $VFILE
echo $'\t''hwaddress ether b6:d0:5e:0f:'$MACADR':16'$'\r' >> $VFILE
echo $'\t''address 10.3.33.'$IPADR$'\r' >> $VFILE
echo $'\t''netmask 255.255.255.0'$'\r' >> $VFILE
echo $'\t''gateway 10.3.33.250'$'\r' >> $VFILE
echo $'\t''metric 3'$'\r' >> $VFILE
echo ""
sudo sync
echo 'синхронизация...'
echo "Синхронизация прошла с кодом "$RANDOM
echo "$(cat $VFILE)"
read -t 8 -p "Окно зароеться через 7 секунд"
