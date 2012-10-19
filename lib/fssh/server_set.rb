# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

module FSSH
  class ServerSet
    def initialize(instances)
      @instances = instances
    end

    def filter_group(group)
      ServerSet.new(@instances.select do |item|
        item.groupSet.item.any? do |set|
          set.groupId == group
        end
      end)
    end

    def filter_running
      ServerSet.new(@instances.select do |item|
        item.instancesSet.item.first.instanceState.name == "running"
      end)
    end

    def filter_tags(tags = {})
      ServerSet.new(@instances.select do |item|
        item.instancesSet.item.first.tagSet.item.any? do |instance_tag|
          tags.include?(instance_tag["key"]) && tags[instance_tag["key"]] == instance_tag["value"]
        end
      end)
    end

    def dns_names
      @instances.map { |instance| instance.instancesSet.item.first.dnsName }
    end

    def first
      Instance.new(@instances.first)
    end

    def [](index)
      Instance.new(@instances[index])
    end

    def size
      @instances.size
    end

    def -(arr)
      ServerSet.new(@instances - arr)
    end
  end
end
