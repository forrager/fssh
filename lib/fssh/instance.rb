# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

module FSSH
  class Instance
    def initialize(instance)
      @instance = instance
    end

    def base
      @instance
    end

    def dns_name
      base.instancesSet.item.first.dnsName
    end

    def private_dns_name
      base.instancesSet.item.first.privateDnsName
    end
  end
end