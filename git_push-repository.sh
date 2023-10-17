#!/bin/bash

cd ../..

DATE=`date +"%d.%m.%Y %H:%M:%S"`
git add .
git commit -m DATE
git push -u origin main