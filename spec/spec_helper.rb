require_relative '../lib/domoscio_rails'
require_relative './lib/domoscio_rails/shared_resources'

require 'capybara/rspec'
require 'capybara-webkit'
require 'fileutils'
require 'pp'
require 'active_support/all'

Capybara.default_driver = :webkit

# def reset_domoscio_rails_configuration
#   DomoscioRails.configure do |c|
#     c.preproduction = true
#     c.client_id = 4#13#
#     c.client_passphrase = '7ea9eb050b16f560413ec539ad29dbba' #'ecd72119a3e5e93fd83413d54ce7c0e6'#
#     c.temp_dir = File.expand_path('../tmp', __FILE__)
#     FileUtils.mkdir_p(c.temp_dir) unless File.directory?(c.temp_dir)
#   end
# end
def reset_domoscio_rails_configuration
  DomoscioRails.configure do |c|
    c.preproduction = false
    c.client_id = 14#
    c.client_passphrase = '748add958564718f6d7add299655f95c'#
    c.temp_dir = File.expand_path('../tmp', __FILE__)
    FileUtils.mkdir_p(c.temp_dir) unless File.directory?(c.temp_dir)
  end
end
reset_domoscio_rails_configuration
