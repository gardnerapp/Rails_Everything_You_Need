# All Your Favorite Gems
gem 'tailwindcss-rails'
gem 'devise'
gem 'devise-tailwinded'
gem 'simple_form'
gem 'simple_form-tailwind'
gem 'stripe'
gem 'friendly_id', '~> 5.4.0'

gem_group :production do
  gem 'pg'
end

if yes?("Install Capistrano ?")
  cap_installed = true
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
end

if yes?("Configure Cloud Provider(s) ?")
  gem("aws-sdk-s3", require: false )if yes?("AWS S3 ?")
  gem("azure-storage-blob", "~> 2.0", require: false) if yes?("Azure Blobs ?")
  gem("google-cloud-storage", "~> 1.11", require: false) if yes?("Google Cloud ?")
  run "echo \"Dont forget to configure your ENV(s)-> config/storage.yml\" "
end

after_bundle do
  rails_command "tailwindcss:install"
  rails_command "g devise:install"
  rails_command "g devise:views:tailwinded"
  rails_command "g simple_form:install"
  rails_command "g simple_form:tailwind:install"
  rails_command "active_storage:install"
  rails_command "action_text:install"
  rails_command "db:migrate"
  run 'cap install STAGES=production' if cap_installed
  rails_command 'db:encryption:init' if yes?("Active Record Encryption ?")
  run "echo \"!*!*!* Don't forget to add the encryption seeds tou your ENV(s) !*!*!* \""
end
