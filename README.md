# PagyMongoidCursor

[![Gem](https://img.shields.io/gem/v/pagy_mongoid_cursor)](https://rubygems.org/gems/pagy_mongoid_cursor)

[Pagy](https://github.com/ddnexus/pagy) Extra to do cursor based pagination for
Mongoid.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pagy_mongoid_cursor'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pagy_mongoid_cursor

## Usage

Require and configure in your pagy initializer:

```ruby
require "pagy_mongoid_cursor/pagy/extras/cursor"
# Requires an extra query to show the last page link. Disable by setting to false.
# Pagy::DEFAULTS[:cursor_last_page_link] = true
```

Use in your controller:

```ruby
pagy_cursor(User.all)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jclusso/pagy_mongoid_cursor.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
