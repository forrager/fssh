# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

module FSSH
  class ServerManager
    class << self
      def client
        @client ||= AWS::EC2::Base.new(
          :access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
          :secret_access_key => ENV["AMAZON_ACCESS_SECRET"]
        )
      end

      def instances
        @instances ||= ServerSet.new(client.describe_instances.reservationSet.item)
      end
    end
  end
end
