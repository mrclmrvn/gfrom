# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = "gfrom"
  spec.version       = "0.1.6"
  spec.authors       = ["Marvin Marcelo"]
  spec.email         = ["mrclmrvn@gmail.com"]
  spec.description   = %q{Wrap Google Form within your site}
  spec.summary       = %q{From Google Form}
  spec.homepage      = "https://bitbucket.org/mrclmrvn/gfrom/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.require_path = "lib"

  spec.add_dependency             "curb", ">= 0"
  spec.add_dependency             "nokogiri", ">= 0"
  spec.add_dependency             "json", ">= 0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

