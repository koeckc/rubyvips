
# README

#build container
docker build -t rubyvips .
docker run -it -t rubyvips
docker run -v /Users/const/develop/viennarb/rubyvips:/app -it -t rubyvips

#run and time rake
/usr/bin/time -f "%U seconds %M kbs" rake viennarb:shrink_vips
/usr/bin/time -f "%U seconds %M kbs" rake viennarb:shrink_magick

#create pyramid
vips dzsave big_plan.jpg mydz --suffix .jpg[Q=90]