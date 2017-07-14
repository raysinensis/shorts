#! /bin/bash
#get list of ports
#pacmd list-sinks | awk '/device.icon_name/ {print}'

activeport=$(pacmd list-sinks | awk '/active port: <analog-output-headphones>/ {print}')
echo $activeport

case "$activeport" in
	*headphone*)
		echo "currently on headphone output, switching now..."
		pactl set-sink-port 1 analog-output-speaker
		;;
	*)
		echo "currently on speaker output, switching now..."
		pactl set-sink-port 1 analog-output-headphones
		;;
esac
	
