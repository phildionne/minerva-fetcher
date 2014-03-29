# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'minerva-fetcher/version'

Gem::Specification.new do |s|
  s.name          = "minerva_fetcher"
  s.version       = Minerva::Fetcher::VERSION
  s.authors       = ["Philippe Dionne"]
  s.email         = ["dionne.phil@gmail.com"]
  s.homepage      = "https://github.com/phildionne/minerva-fetcher"
  s.summary       = "TODO: summary"
  s.description   = "TODO: description"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
  s.add_dependency 'activesupport'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
end
