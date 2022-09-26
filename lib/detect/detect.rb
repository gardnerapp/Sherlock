module Sherlock
  module Detect
    # Find OWASP Top 10 vulns, test them. Other common rails exploits

    WORDPRESS = 'SOME REGEX HERE' # contains 'wp | wordpress etc'
    PHP = 'SOME OTHER REGEX HERE' # contains 'php'
    SHELLCODE = /0x[a-fA-F0-9].*/ # contains '0x[A-F]||[0-9]'
    RUBY_OBJECTS = %q[Gem GemRequestSet GemRequest TarReader TarWriter Kernel IO [] {} => : .new # #{} eval send]
    UNIX_COMMANDS =  %q[ls cd id pwd whoami sudo ping grep cat head echo rm rf ./ ../ / docker nc - env]
    SQL = %q[AND OR = ` ` ' ' \ / FOR DROP_TABLE]
    XSS = %q[<script> </script> console.log alert ( ) \"\' ]
    CLOUD =%q[aws s3 azure digitial ocean S3 bucket blob] # TODO add cloud methods


    # TODO for each of these constants find base64, hex, utf whatever translations and
    # detect those as well, loop through each char and change to one, trying different
    # combinations
    # ie. change one letter in payload to b64, keep everything the same and loop thorugh
    # regex matches or faints

    # TODO test regexs and methods

    # exploits matching single regex or string
    %i[wordpress php shellcode].each do |exp|
      define_method "contains_#{exp}?" do |str|
        if str.match?(eval("#{exp.capitalize}"))
          puts "{!!} Potential Exploit Found:\n\t '#{exp}' in '#{str}''"
        else
          false
        end
      end
    end

    # exploit detection for list of things
    # maybe capitalize these so that I don't need to run capitalize on method
    %i[unix_commands ruby_objects sql xss].each do |method|
      define_method "contains_#{method}? " do |str|
        # eval("
        # #{method.capitalize}.each do |param|
          # if str.contains? param
          # =>   puts "{!!} Potential Exploit Found:\n\t '#{str}' contains a #{method}: '#{cmd}' "
          # end
        # end
        #")
      end
    end

    def is_known_ruby_exploit?(payload, str)
      exploit_payloads = []
      exploit_payloads.each do |pay|
        if str.match(payload)?
          puts "Known Ruby exploit attempted:"
          puts "CVE_WHatve in {str}"
        else
          false
        end
    end


    class Detect
      def initialize(log)
        @log = log
        @request_detect = RequestDetection.new log[:request]
        @request_detect.query_all
      end
    end
  end
end
