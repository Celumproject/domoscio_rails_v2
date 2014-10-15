require_relative '../lib/domoscio_rails'
require_relative './lib/domoscio_rails/shared_resources'

require 'capybara/rspec'
require 'capybara-webkit'
require 'fileutils'
require 'pp'
require 'active_support/all'

Capybara.default_driver = :webkit

def reset_domoscio_rails_configuration
  DomoscioRails.configure do |c|
    c.preproduction = true
    c.client_id = 1
    c.client_passphrase = '00c21bd543b6094c5206f3eaba8b4046'
    c.temp_dir = File.expand_path('../tmp', __FILE__)
    FileUtils.mkdir_p(c.temp_dir) unless File.directory?(c.temp_dir)
  end
end
reset_domoscio_rails_configuration
