#!/bin/bash

bin/rake db:drop db:create db:migrate RAILS_ENV=development
bin/rake test:initialize RAILS_ENV=development
