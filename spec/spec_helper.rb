require 'rubygems'
require 'spec'
require File.expand_path(File.dirname(__FILE__) + "/../../limelight/lib/init")
require 'limelight/scene'
require 'limelight/producer'

Limelight::Main.initializeContext

#module Limelight
#  module UI
#    module Model
#      class Frame
#        def open
#
#        end
#      end
#    end
#  end
#end

module Spec
  module Example
    class ExampleGroup


      def load_scene(name)
        Limelight::Production.clear_index
        producer = Limelight::Producer.new(File.expand_path(File.dirname(__FILE__) + "/../"))
        producer.load
        return producer.open_scene(name, producer.theater["default"])
      end
      
    end
  end
end
