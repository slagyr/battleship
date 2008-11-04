require 'rubygems'
require 'digest/sha1'
require 'drb'

module BattleshipTournament

  class Submit

    def initialize(gem_name)
      @gem_name = gem_name
      @input = $stdin
      @output = $stdout
    end

    def submit
      data = collect_data
      password = get_password
      password = Digest::SHA1.hexdigest(password)
      data[:password] = password

      begin
        server = DRbObject.new(nil, 'druby://micahmartin.com:9696')
        authorized = server.authorize(data[:name], password)
        quit "Incorrect password.  You are not authorized to submit this player." unless authorized
        result = server.submit_profile(data)
        quit "Failed to submit: #{result}" if result != true
        puts "Player #{data[:name]} has been submitted."
      rescue DRb::DRbConnError => e
        quit "Could not connect to battleship server!"
      end
    end

    def collect_data
      spec = gem_spec
      data = {}
      data[:name] = spec.summary[18..-1]
      data[:author] = spec.author
      data[:description] = spec.description
      data[:gem_file_name] = spec.file_name     
      gem_file_path = File.expand_path(File.join(spec.full_gem_path, "..", "..", 'cache', spec.file_name))
      data[:gem_content] = IO.read(gem_file_path)
      return data
    end

    def gem_spec
      if @spec.nil?
        @spec = Gem.source_index.latest_specs.find do |spec|
          spec.name == @gem_name
        end
      end
      quit "Could not find installed gem named '#{@gem_name}'" if @spec.nil?
      return @spec
    end

    def get_password
      @output.puts "Password?"
      @output.print "> "

      password = @input.readline.strip
      return password
    end

    def quit(message)
      puts message
      exit -1
    end

  end

end
