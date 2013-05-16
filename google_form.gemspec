# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_form/version'

Gem::Specification.new do |spec|
  spec.name          = "google_form"
  spec.version       = GoogleForm::VERSION
  spec.authors       = ["Marvin Marcelo"]
  spec.email         = ["mrclmrvn@gmail.com"]
  spec.description   = %q{Retrieve Google form and fields from a given form URL into array of hashes}
  spec.summary       = %q{Google Forms Renderer}
  spec.homepage      = ""
  spec.license       = "MIT"
  specs.date         = '2013-05-01'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             'curb'
  spec.add_dependency             'nokogiri'
  spec.add_dependency             'json'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

