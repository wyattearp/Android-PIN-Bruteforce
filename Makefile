default: pi-install

hid-keyboard: hid-keyboard.c
	$(CC) -g -o hid-keyboard hid-keyboard.c

pi-install: hid-keyboard
#scripted crap from here: https://randomnerdtutorials.com/raspberry-pi-zero-usb-keyboard-hid/
	echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
	echo "dwc2" | sudo tee -a /etc/modules
	sudo echo "libcomposite" | sudo tee -a /etc/modules
	sed -i 's/exit\ 0/\
	\/usr\/bin\/isticktoit_usb\
	exit 0/' /etc/rc.local
	sudo cp ./isticktoit_usb /usr/bin/isticktoit_usb
	sudo chmod +x /usr/bin/isticktoit_usb
	echo "stuff installed, if it didn't work, it's probably a typo"
	echo "this is the part where you reboot"

clean:
	rm -f hid-keyboard

