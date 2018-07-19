
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'common_indexer/version'

Gem::Specification.new do |spec|
  spec.name          = 'common_indexer'
  spec.version       = CommonIndexer::VERSION
  spec.authors       = ['Michael Klein', 'Brendan Quinn']
  spec.email         = ['mbklein@gmail.com', 'brendan-quinn@northwestern.edu']

  spec.summary       = 'Common Indexing mixin for NUL Digital Collections'
  spec.description   = 'Common Indexing mixin for NUL Digital Collections'
  spec.homepage      = 'https://github.com/nulib/common-indexer'
  spec.license       = 'Apache2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'active-fedora'
  spec.add_dependency 'aws-sdk-elasticsearchservice'
  spec.add_dependency 'config'
  spec.add_dependency 'elasticsearch'
  spec.add_dependency 'rails'
  spec.add_development_dependency 'bixby'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'docker-stack'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails'
end
