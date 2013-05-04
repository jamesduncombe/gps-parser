# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gps_parser/version', __FILE__)

Gem::Specification.new do |gem|
  
  gem.name        = 'gps_parser'
  gem.version     = GPS::VERSION

  gem.authors     = ["James Duncombe"]
  gem.email       = 'j@jdun.co'

  gem.description = "Little gem to parse NMEA GPS strings"
  gem.summary     = "Parse NMEA GPS strings"
  gem.homepage    = 'http://rubygems.org/gems/gps_parser'
  
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(spec)/})

end