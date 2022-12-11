#! usr/bin/env bash

# NAME: launch_app.sh
#
# BRIEF: This script runs the rails commands needed to launch the BUY Stuff web
# app vs. having it as 1 very long line in the Dockerfile's CMD directive.
#
# AUTHOR: Kim Lew

set -ex

rails db:migrate RAILS_ENV=development
rails db:seed
rails server -b 0.0.0.0
