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

### Basic

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

  rule "married" do
    when? do |data|
      data[:married]
    end

    then! do
      'Bye!'
    end
  end

  def call
    process_rules {name: 'joe', age: 25, married: true}
  end

end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/falm/the_rules.
