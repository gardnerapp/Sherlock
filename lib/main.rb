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
  opts.banner = "\nGreetings ! It's time to Investigate\n\n"

  opts.on('-f', '-file log_file',
    "The log file you would like to Investigate.") { |v| options[:file] = v }

  ops.on('-d', '-directory my_dir',
    'Directory holding your log files') {|v| options[:directory] = v}
  opts.on('-h', '-help', 'Display this screen.') {puts opts; exit!}

  opts.on_tail "Examples:"
  opts.on_tail "#{__FILE__} -d ~/investigation -m integrity\n\n"
end

opts.order!

if options.empty?
  puts opts; exit!
end

puts "Your options are..."
puts options



# scan -> Search your logs against predefined malicous & irregulat traffic.

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
