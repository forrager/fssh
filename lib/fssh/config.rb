# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

module FSSH
  class Config
    attr_reader :data

    class << self
      def load_file(file)
        result = Config.new
        result.instance_variable_set(:'@data', YAML.load_file(file))
        result
      end

      def load(content)
        result = Config.new
        result.instance_variable_set(:'@data', YAML.load(content))
        result
      end
    end

    def [](key)
      @data[key]
    end

    def method_missing(method)
      @data[method]
    end

    def resolve_gateway(server)
      @data[:gateway].find do |rules|
        passed = true
        passed &&= rules[:except].none? { |rule| server == rule } if rules[:except]
        passed &&= rules[:only].include?(server) if rules[:only]
        passed
      end
    end
  end
end