
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "the_rules/version"

Gem::Specification.new do |spec|
  spec.name          = "the_rules"
  spec.version       = TheRules::VERSION
  spec.authors       = ["Jason Hou"]
  spec.email         = ["hjj1992@gmail.com"]

  spec.summary       = %q{ruby simple rules engine}
  spec.description   = %q{the_rules is simple rules engine that has nested expression test and evaluate}
  spec.homepage      = "https://github.com/falm/the_rules"

  spec.files         = Dir['{lib}/**/*'] + %w{README.md}

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
