
#
# README

#build container
docker build -t rubyvips .
docker run -it -t rubyvips
docker run -v /Users/const/develop/viennarb/rubyvips:/app -it -t rubyvips 


time rake viennarb:shrink_vips
18  time rake viennarb:shrink_magick
time rake viennarb:shrink_magick
time rake viennarb:shrink_vips

/usr/bin/time -f "%P %M" rake viennarb:shrink_magick

4.02 seconds 130912 kbs

 /usr/bin/time -f "%U seconds %M kbs" rake viennarb:shrink_vips