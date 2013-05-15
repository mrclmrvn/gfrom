# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'google_form'
  s.version           = '1.0'
  s.description       = 'Retrieve Google form and fields from a given form URL into hash'
  s.date              = '2013-05-16'
  s.summary           = 'Google Forms Renderer'
  s.require_paths     = %w(lib)
  s.files             = Dir["{lib}/**/*"] + ["readme.md"]
  s.authors           = ['Marvin Marcelo']
  s.email             = ['mrclmrvn@gmail.com']

  # Runtime dependencies
  s.add_dependency             'curb'
  s.add_dependency             'nokogiri'
  s.add_dependency             'json'


  # Development dependencies (usually used for testing)
  s.add_development_dependency 'rspec'
end
