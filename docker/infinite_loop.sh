#!/bin/bash
set -e
NODE_ENV=production RAILS_ENV=production bundle exec rails webpacker:binstubs
NODE_ENV=production RAILS_ENV=production bundle exec rake assets:precompile
NODE_ENV=production RAILS_ENV=production bundle exec rake db:migrate
NODE_ENV=production RAILS_ENV=production rails s
