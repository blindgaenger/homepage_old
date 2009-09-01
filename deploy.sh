#!/usr/bin/env bash

heroku config:add PROFILE=bjuenger --app bjuenger-homepage
git push heroku-bjuenger master

heroku config:add PROFILE=blindgaenger --app blindgaenger-homepage
git push heroku-blindgaenger master

