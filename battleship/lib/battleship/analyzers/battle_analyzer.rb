require 'battleship/server'

module Battleship
  module Analyzers

    class BattleAnalyzer

      def self.analyze(profile)
        begin
#          record = Server.profile(profile.name)
        rescue ServerException => e
          return 50, "50 : Couldn't retreive record"
        end
        return 50, "50 : No games recorded" if record.nil?

        games_played = record.games_played
        return 50, "50 : No games recorded" if games_played == 0
        wins = record.wins

        score = (wins.to_f / games_played.to_f * 100 + 0.5).to_i
        return score, "#{score} : won #{wins} of #{games_played} games played"
      end

    end

  end
end
