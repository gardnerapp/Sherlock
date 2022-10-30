require "thor"
module Sherlock
  class CLI < Thor
    desc "analyze", "Analyze web logs for malicous activity"
    method_option :file, aliases: "-f"
    method_option :directory, aliases: "-d"
    def analyze

      cli_error("Must specify a file or directory to analyze") unless options[:file] || options[:directory]
        
      Sherlock::Sherlock.parse_file options[:file] if options[:file]
      Sherlock::Sherlock.parse_dir options[:dir] if options[:dir]
    end # end analyze

    private

    def cli_error(msg)
      puts msg
      exit(-1)
    end

  end
end
