require "benchmark"
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'yard'))
require 'logger'

PATH_ORDER = [
  'lib/yard/autoload.rb',
  'lib/yard/code_objects/base.rb',
  'lib/yard/code_objects/namespace_object.rb',
  'lib/yard/handlers/base.rb',
  'lib/yard/generators/helpers/*.rb',
  'lib/yard/generators/base.rb',
  'lib/yard/generators/method_listing_generator.rb',
  'lib/yard/serializers/base.rb',
  'lib/**/*.rb'
]

Benchmark.bmbm do |x|
  x.report("infer types") do
    YARD::Registry.clear
    YARD.parse PATH_ORDER, [], Logger::ERROR
    YARD::TypeInference::Processor.new.process_ast_list(YARD::Registry.ast)
  end
end