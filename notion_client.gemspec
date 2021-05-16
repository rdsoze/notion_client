lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'notion_client'
  s.version     = '0.0.2'
  s.summary     = "Ruby wrapper for Notion APIs"
  s.authors     = ["Raison Dsouza"]
  s.email       = 'raisondsouzagmail.com'
  s.files       = ["lib/notion.rb"]
  s.homepage    =
    'https://rubygems.org/gems/notion_client'
  s.license       = 'MIT'

  s.add_development_dependency 'faraday'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
end