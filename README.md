# CommonIndexer
[![Build Status](https://travis-ci.com/nulib/common-indexer.svg?branch=master)](https://travis-ci.com/nulib/common-indexer)

Indexes metadata into a central AWS Elasticsearch instance. The gem indexes based on a hash returned by the method `#to_common_index` defined in your model using an `after_save` hook. The indexer also sanitizes the input by only allowing pre-configured hash keys.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'common_indexer', github: 'nulib/common-indexer', branch: 'master'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install common_indexer
    
## Configuration

Add `common_indexer` to the appropriate Rails config file (e.g. `config/settings.yml`, `config/settings/development.yml`):

```yml
# config/settings/development.yml
common_indexer:
  endpoint: http://localhost:9201/ # default 'http://localhost:9200'
  index_name: new-index # default 'common'
  allowed_keys: # default ['title']
    - title
    - creator
```

Add an initializer to configure the CommonIndexer gem with the app settings:

```ruby
# config/initializers/common_indexer_config.rb
::CommonIndexer.config do |config|
  config.endpoint = Settings.common_indexer.endpoint
  config.index_name = Settings.common_indexer.index_name
  config.allowed_keys = Settings.common_indexer.allowed_keys
end
```

## Usage

Include the CommonIndexer into your model that you want to index with `include ::CommonIndexer::Base`, and define a `#to_common_index` method in that model. `#to_common_index` should return a hash with metadata key/values that conform to the allowed keys defined in the local configuration or fall back to the defaults.

```ruby
class Example < ActiveFedora::Base
  include ::CommonIndexer::Base
  
  property :title,   ::RDF::URI('http://example.org/ns#title')
  property :creator, ::RDF::URI('http://example.org/ns#creator')
  
  def to_common_index
    { 
      title: title, 
      creator: creator
    }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/common_indexer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
