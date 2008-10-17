require 'rubygems'
require 'spec'
require File.expand_path(File.dirname(__FILE__) + "/../../limelight/lib/init")
require 'limelight/scene'
require 'limelight/producer'

$producer = nil

module Spec
  module Example
    class ExampleGroup

      after(:suite) do
        $producer.theater.stages.each { |stage| stage.close }
      end

      def producer
        if $producer.nil?
          Limelight::Main.initializeContext
          $producer = Limelight::Producer.new(File.expand_path(File.dirname(__FILE__) + "/../"))
          $producer.load
        end
        return $producer
      end

    end
  end
end
