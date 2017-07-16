#! /bin/bash
#might need to kill if HDMI not working
#pulseaudio -k
#get list of ports
#pacmd list-sinks | awk '/device.icon_name/ {print}'
listofsinks=$(pacmd list-sinks | awk '/index/ {print}')
echo "$listofsinks"
#activeport=$(echo "$listofsinks" | grep -e '* index: [0-9]')
echo "$activeport"

case "$activeport" in
	*0*)
		echo "currently on speaker output, switching now..."
		pacmd set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
		newSink="alsa_output.pci-0000_00_1f.3.analog-stereo"
		;;
	*)
		echo "currently on headphone output, switching now..."
		pacmd set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
		newSink="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
		;;
esac	

pactl list short sink-inputs|while read stream; do
    streamId=$(echo $stream|cut '-d ' -f1)
    echo "moving stream $streamId to $newSink"
    pactl move-sink-input "$streamId" "$newSink"
done

	
