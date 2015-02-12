Gem::Specification.new do |s|
  s.name        = "kitchen-chef-extended-attributes"
  s.version     = '0.2.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Olliver"]
  s.email       = ["jeremy.olliver@gmail.com"]
  s.homepage    = "https://github.com/jeremyolliver/kitchen-chef-extended-attributes"
  s.summary     = %q{test-kitchen chef-solo integrated with dna.json files from your repo}
  s.description = %q{Plugin for test-kitchen that extends the chef_solo provisioner with
                     chef_extended_attributes to use pre-existing dna.json files, and
                     optionally, to merge those with attributes in .kitchen.yml}

  s.require_paths = ['lib']
  s.files = Dir["{lib}/**/*"] + ["LICENSE.txt", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["test/**/*"]
  s.license = "MIT"

  s.add_runtime_dependency 'test-kitchen'

  s.add_development_dependency 'kitchen-docker'
  s.add_development_dependency 'berkshelf'
  s.add_development_dependency 'cane'
end
