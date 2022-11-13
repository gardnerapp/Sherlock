# frozen_string_literal: true

require_relative "sherlock/version"
require 'request/request'

module Sherlock
  class Error < StandardError; end
  class Sherlock
    class << self
      # todo call methods and test for output

      # Sherlock.parse_log
      # parses a single log file to a collection of Request objs
      def parse_file(file); end

      # Sherlock.parse_dir
      # walks a directory and parses all of the files into Request objs
      def parse_dir(dir); end
    end
  end
end
