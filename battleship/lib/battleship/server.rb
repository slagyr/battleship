require 'drb'
require 'battleship/player_profile'
require 'battleship/battleship_exceptions'

module Battleship

  class Server

    #TODO Need a timeout on the connection
    class << self

      def api
        if @api.nil?
          DRb.start_service
          @api = DRbObject.new(nil, 'druby://micahmartin.com:9696')
        end
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
          api.submit_profile(profile.simple_hash)
        end
      end

      def submit_game(game)
        try do
          api.submit_battle(:player1 => game.player1_name, :player2 => game.player2_name, :winner => game.player1_winner? ? game.player1_name : game.player2_name, :disqualification => game.disqualification_reason != nil)
        end
      end

      private #############################################

      def try
        return if !$USE_SERVER
        begin
          yield
        rescue Exception => e
          puts e
          puts e.backtrace
          raise ServerException.new(e.message)
        end
      end

    end

  end

end