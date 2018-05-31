require "the_rules/version"
require 'the_rules/concern'
require 'the_rules/rule'

module TheRules
  extend Concern
  included do
    class_attribute :rules
    self.rules = []
  end

  module ClassMethods

    # rule :name_of_rule,
    #       priority: 10,
    #       validate: lambda {|o| # do something with o}
    #       fail: lambda {|o| o.fail!}}
    def rule(name, options = {}, &block)
      Rule.new(name, options.merge(bind_klass: self)).tap do |rule|
        rule.instance_exec(&block) if block
        self.rules << rule
      end
    end

  end

  #
  # @param [Object] data
  # @return [Array]
  #
  def process_rules(data, rules = self.class.rules)
    rules.sort_by(&:priority).reduce(nil) do |result, rule|
      rule.bind_object = self
      result ||= rule.run(data)
    end
  end

end
