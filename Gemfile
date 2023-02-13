source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
#gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Para le cifrado de datos / firma electrónica
gem 'encryption'
# Para las cuentas de usuario
gem 'devise', '~> 4.7.1'
# Para los permisos del sistema
gem "pundit"
# Para la localización en español
gem 'rails-i18n'
# Para la localización de Devise
gem 'devise-i18n'
# Para la paginación del sistema
gem 'kaminari'
# Para los estilos de la paginación con kaminari
gem 'bootstrap4-kaminari-views'
# Para el filtrado de los registros
gem 'filterrific'
# Para realizar consultas más legibles en la consola
gem 'awesome_rails_console'
# Para generar pdf a partir de html
gem 'wicked_pdf'
# Biblioteca para crear pdf
gem 'wkhtmltopdf-binary'
# Para utilizar jQuery en rails
gem 'jquery-rails'
# Última versión de bootstrap para el diseño de la página
gem 'bootstrap', '~> 4.3.1'
# Para geneara los id únicos para las constancias
gem 'uuidable'
# Para la autenticación de dos factores
gem 'active_model_otp'
# Para la generación de códigos QR
gem 'rqrcode'
# SVG inline
gem 'rqrcode_png'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'passenger'
# Para el consumo del webservice de la DAE/RENAPO
gem 'rest-client'
# Para la conexion a la base de datos
gem "mysql2"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.14.2'
  gem 'pry-byebug', '~> 3.7'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
