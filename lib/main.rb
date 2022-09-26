require 'json'
# require "./sherlock"
require 'optparse'
require "./integrity/integrity.rb"

# modify your nginx log format so that -ENDgzipon\n isn't there
# login bruteforce, non-home ip login/ login request
# TODO write brute force dector up, run detector on the logs you created
# fix regexs

options = {}

opts = OptionParser.new do |opts|
  opts.banner = "\nGreetings Friend ! It's time to save the world\n\n"
  opts.on('-m', '-mode InvestigationMode', "The Mode you would like to Investigate for.
    Currently Supported Modes:
    Honey -- Find Known Malicous Actors/Traffic
    Integrity -- Validate File Authenticity by creating and comparing file Hashes. Currently Supports SHA1, SHA2, MD5 Algorithims
    Malware -- Scan Files For Malware Like Behavior (MacOS Support Coming Soon !)") do |v|
    options[:mode] = v.capitalize
    # scan -> Search your logs against predefined malicous & irregulat traffic.

    # TODO add more modes/subcommands ->
    # Keyword search from another file,
    # request within certian time ranges/ from certian actors
    # Bot net mode -> find all botnets, where they are and count exploit types
    # black v white v gray listed traffic
    # failed logins
    # Comparission/Integrity Check -> is one logfile different from copy. Are Rails logs same as NGINX?
    # XSS, SQL attempts etc.
    # TODO spam collect -> get all very obvious botnet request searching for wordpress and php exploits
    # Evntually come up with a syntax for more modular and dynamic searching ex. find bad IP @ this time & with this User Agent
    # Start with simplest and most usefull slim this list down. Goal will be finding out what they want, how they are doing it.
  end
  opts.on('-h', '-help', 'Display this screen.') do
    puts opts; exit!
  end
  opts.on_tail "Examples:"
  opts.on_tail "#{__FILE__} -d ~/investigation -m integrity\n\n"
end

opts.order!

if options.empty?
  puts opts; exit!
end

puts "Your options are..."
puts options

case options[:mode]
when "Integrity"
  Sherlock::Integrity::Integrity.select_mod
when "Malware"
  puts "MacOS Malware Reverse Engineering Module Coming Soon !"; exit(0)
  # Sherlock::Malware::MacOS.start(dir)
when "Detect"
  puts "Detection Module Coming Soon !"; exit(0)
else
  puts "#{Sherlock::Errors.e_str} Invalid Mode Specified see -help for more details"; exit(-1)
end
