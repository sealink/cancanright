$:.push File.expand_path('../lib', __FILE__)

require 'cancanright/version'

Gem::Specification.new do |s|
  s.name        = 'cancanright'
  s.version     = CanCanRight::VERSION
  s.date        = '2016-11-22'
  s.authors     = ['Grant Colegate']
  s.email       = ['support@travellink.com.au']
  s.homepage    = ''
  s.summary     = 'Database driven rules for CanCan'
  s.description = 'Database driven rules for CanCan'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md']

  s.add_dependency 'rails'
  s.add_dependency 'cancancan', '~> 1.15.0'

  s.add_development_dependency 'bundler', '>= 1.12.5'
  s.add_development_dependency 'rake', '~> 11.3.0'
  s.add_development_dependency 'rspec', '~> 3.5.0'
  s.add_development_dependency 'coverage-kit', '~> 0.1'
  s.add_development_dependency 'simplecov-rcov', '~> 0.2'
  s.add_development_dependency 'coveralls', '~> 0.8'
end
