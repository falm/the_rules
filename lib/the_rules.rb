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
    def rule(*args, &block)
      self.rules << SimpleRulesEngine::Rule.factory(*args, &block)
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

  include ClassMethods


end
