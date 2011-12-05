require 'yaml'
require File.join('.', 'lib', 'm5ecompact.rb')
require File.join('.', 'lib', 'crc16.rb')

include Crc16

settings = YAML::load(File.open('settings.yaml'))

reader = M5ECompact.new(settings['device_path'])
reader.get_firmware_version
reader.close
