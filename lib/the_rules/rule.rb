
module TheRules
  class Rule

    include ClassMethods

    attr_accessor :priority
    attr_accessor :name

    # proc to test
    attr_accessor :validate

    # if valid
    attr_accessor :success

    # if invalid
    attr_accessor :fail

    # nested
    attr_accessor :children

    # service object
    attr_accessor :bind_object


    NO_OP = lambda {|o| true }
    FAIL_OP = lambda {|o| nil}

    def initialize(name, options={})
      self.name = name
      self.priority = options[:priority] || 10
      self.validate = options[:validate] || NO_OP
      self.fail = options[:fail] || FAIL_OP
      self.success = options[:success] || FAIL_OP
      self.children = {}
    end

    def self.factory(name, options = {}, &block)
      self.new(name, options).tap do |rule|
        rule.instance_exec(&block) if block
      end
    end

    def when?(&block)
      self.validate = block
    end

    def then!(&block)
      self.success = block
    end

    def run(data)

      if validate.call(data)
        process_rules(data, rules: children.values) || success.call(data)
      else
        fail.call(data)
      end

    end

    def rule(name, options = {}, &block)
      self.children[name] = self.class.factory(name, options, &block)
    end

    #
    # block执行方法查找代理给宿主对象
    #
    def method_missing(name, *args)
      if bind_object.respond_to? name
        bind_object.__send__(name, *args)
      else
        raise NoMethodError
      end
    end
  end
end