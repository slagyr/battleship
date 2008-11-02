require 'limelight/templates/templater'
require 'limelight/string'

module Limelight
  module Templates

    class PlayerTemplater < Templater

      attr_reader :filename, :tokens

      def initialize(player_name)
        super(".")
        @tokens = {}
        @tokens[:PLAYER_NAME] = player_name
        clean_name = player_name.gsub(/[\?\*!'\-.;:]/, "").gsub(" ", "_").downcase
        @filename = @tokens[:FILENAME] = clean_name
        @tokens[:CLASSNAME] = clean_name.camalized
      end

      # Generates the files
      #
      def generate
        file(File.join(filename, "Rakefile"), "Rakefile.template", @tokens)
        file(File.join(filename, "Battleship.Rakefile"), "Battleship.Rakefile.template", @tokens)
        file(File.join(filename, "lib", filename, "#{filename}.rb"), "player.template", @tokens)
        file(File.join(filename, "spec", "spec_helper.rb"), "spec_helper.template", @tokens) 
        file(File.join(filename, "spec", filename, "#{filename}_spec.rb"), "player_spec.template", @tokens)
      end

    end

  end
end