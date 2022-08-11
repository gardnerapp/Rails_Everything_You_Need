# All Your Favorite Gems
gem 'tailwindcss-rails'
gem 'devise'
gem 'devise-tailwinded'
gem 'simple_form'
gem 'simple_form-tailwind'
gem 'stripe'

# TODO run installation & generate commands for these gems
gem 'capistrano', '~> 3.11'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

gem_group :production do
  gem 'pg'
end


after_bundle do
  rails_command "tailwindcss:install"
  rails_command "g devise:install"
  rails_command "g devise:views:tailwinded"
  rails_command "g simple_form:install"
  rails_command "g simple_form:tailwind:install"
  rails_command "active_storage:install"
  rails_commmand "railg g devise User"
  route "root to: 'users#sign_up'"
  rails_command "db:migrate"
end
