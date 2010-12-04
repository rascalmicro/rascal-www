#!/bin/bash

rsync -av --delete --exclude '*cache/*' ./_site/ root@69.164.219.36:/var/www/rascalmicro.com/

ssh root@69.164.219.36 "chown -R www-data:www-data /var/www/*"
