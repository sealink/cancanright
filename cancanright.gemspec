$:.push File.expand_path('../lib', __FILE__)

require 'cancanright/version'

Gem::Specification.new do |s|
  s.name        = 'blush'
  s.version     = CanCanRight::Version
  s.date        = '2016-11-22'
  s.authors     = ['Grant Colegate']
  s.email       = ['blaknite@thelanbox.com.au']
  s.homepage    = ''
  s.summary     = 'Database driven rules for CanCan'
  s.description = 'Database driven rules for CanCan'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'rails'
  s.add_dependency 'cancancan'
end
