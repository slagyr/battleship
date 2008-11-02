require 'drb'
require 'battleship/player_profile'

module Battleship

  class Server

    class << self

      def api
        @api = DRbObject.new(nil, 'druby://micahmartin.com:9696') if @api.nil?
        return @api
      end

      def profile(name)
        profile_hash = api.profile(name)
        return nil if profile_hash.nil?
        return PlayerProfile.new(profile_hash)
      end

      def register_profile(profile)
        api.register_profile(profile.simple_hash)
      end

    end

  end

end