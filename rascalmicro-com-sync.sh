#!/bin/bash

rsync -av --delete --exclude '*cache/*' ./_site/ root@rascalmicro.com:/var/www/rascalmicro.com/

ssh root@rascalmicro.com "chown -R www-data:www-data /var/www/*"
