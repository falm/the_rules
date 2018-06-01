# TheRules

**the_rules** is ruby simple rules engine

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'the_rules'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install the_rules

## Usage

###

```ruby
require 'the_rules'
class ServiceObject
  include TheRules
  rule "age > 18 should be works" do
    when? do |data|
      data[:age] >= 18
    end

    then! do |data|
      do_something(data[:name])
    end

  end

  rule "students" do
    when? do |data|
      data[:student]
    end


  end

  def call
    process_rules {name: 'joe', age: 18, student: true}
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/falm/the_rules.
