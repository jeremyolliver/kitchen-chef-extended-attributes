Gem::Specification.new do |s|
  s.name        = "kitchen-chef-extended-attributes"
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Olliver"]
  s.email       = ["jeremy.olliver@gmail.com"]
  s.homepage    = "https://github.com/jeremyolliver/kitchen-chef-extended-attributes"
  s.summary     = %q{test-kitchen chef-solo integrated with dna.json files from your repo}
  s.description = %q{TODO: also add a slightly longer description of the gem}

  s.files = Dir["{lib}/**/*"] + ["LICENSE.txt", "Rakefile", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["spec/**/*"]
  s.license = "MIT"

  s.add_runtime_dependency "test-kitchen"
  # s.add_development_dependency "rake", ">= 10.0.0"
  # s.add_development_dependency "minitest"
  # s.add_development_dependency "simplecov"
end
