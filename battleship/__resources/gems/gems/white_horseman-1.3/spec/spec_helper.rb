$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'spec'

DATA_DIR = File.expand_path(File.dirname(__FILE__)) + "/../test_data" unless defined?(DATA_DIR)
