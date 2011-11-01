#!/bin/bash

rsync -av --delete --exclude-from './exclude.txt' ./_site/ root@rascalmicro.com:/var/www/rascalmicro.com/

ssh root@rascalmicro.com "chown -R www-data:www-data /var/www/*"
