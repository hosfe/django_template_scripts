#!/bin/bash

cd ../..

# Dateipfad
ini_file="./_scripts/config.ini"

# Variablen auslesen
git_user_name=$(crudini --get "$ini_file" github git_user_name)
rebo_name=$(crudini --get "$ini_file" github rebo_name)

# rebopath url
git_url=$"https://github.com/${git_user_name}/${rebo_name}.git"
echo "git remote add origin ${git_url}"

echo "# django_template" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin ${git_url}
git push -u origin main