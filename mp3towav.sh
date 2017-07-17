#!/bin/bash
for file in *.mp3; do
   ffmpeg -i "$file" -acodec pcm_s16le -ac 1 -ar 44100 "${file%.mp3}".wav
done
