require 'drb'
require 'battleship/player_profile'
require 'battleship/battleship_exceptions'

module Battleship

  class Server

    #TODO Need a timeout on the connection
    class << self

      def api
        @api = DRbObject.new(nil, 'druby://micahmartin.com:9696') if @api.nil?
        return @api
      end

      def profile(name)
        try do
          profile_hash = api.profile(name)
          return nil if profile_hash.nil?
          return PlayerProfile.new(profile_hash)
        end
      end

      def register_profile(profile)
        try do
          api.register_profile(profile.simple_hash)
        end
      end

      private #############################################

      def try
        begin
          yield
        rescue Exception => e
          raise ServerException.new(e.message)
        end
      end

    end

  end

end