# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

module FSSH
  class CLI
    attr_reader :server_name, :config, :config_file
    attr_reader :instances, :server, :gateway

    def initialize(server_name)
      @server_name = server_name
      load_config
    end

    def find_instances
      @instances = FSSH::ServerManager.instances
      !!@instances
    end

    def find_gateway
      running = @instances.filter_running
      @gateway_config = @config.resolve_gateway(server_name)

      if @gateway_config
        @gateway = running.filter_group(@gateway_config[:name]).first
        true
      else
        false
      end
    end

    def find_server
      if !@gateway_config || @gateway_config[:name] != @server_name
        running = @instances.filter_running
        @server = running.filter_tags("Name" => @server_name).first
        !!@server.base
      else
        true
      end
    end

    def private_key_exists?
      File.exist?(File.expand_path(@config.local_private_key_file))
    end

    def hops
      @hops ||= [@gateway, @server].compact
    end

    protected

    def load_config
      @config_file = File.expand_path("~/.fssh")

      if File.exist?(@config_file)
        @config = FSSH::Config.load_file(@config_file)
      else
        raise "Couldn't find .fssh config file at #{@config_fie}"
      end
    end
  end
end