#!/usr/bin/env bash

# http://bjuenger-homepage.heroku.com/
heroku config:add PROFILE=bjuenger --app bjuenger-homepage
git push heroku-bjuenger master --force

# http://blindgaenger-homepage.heroku.com/
heroku config:add PROFILE=blindgaenger --app blindgaenger-homepage
git push heroku-blindgaenger master --force

