require "./integrity/hashing.rb"

module Sherlock
  module Integrity
    class Integrity

      # Lets the use decide what they would like to do
      def self.select_mod
        puts "Welcome To Integrity Mode !"
        puts "Press CTRL-C To Exit At Anytime"
        puts "This mode is primarily used to: "
        puts "\t - Check the integrity of system vs back-up log files"
        puts "\t - Find abnormalities in a file system by cross referencing it against a baseline"
        puts "The currently supported hashing algorithims are: "
        puts "\t| SHA1 | SHA2 | MD5 |"

        puts "What would you like to do today? (A/B/C)"
        puts "A) Create File Hashes of a collection of files"
        puts "B) Compare Hashes collections (Use option A first on your file collections)"
        puts "C) Quickly calculate and compare the hashes of two files"

        m = gets.chomp.capitalizeß

        case m
        when 'A'
          create_file_hashes
        when 'B'
          compare_hash_collections
        when 'C'
          quick_hash
        else
          puts "#{Sherlock::FileHelpers.e_str} #{choice} is an invalid option."
        end # END CASE
        puts "Thank You For Choosing Sherlock Now Exiting !"
        exit 1
      end # end self.start method

      private

      # create file hashes for all files in a directory option A from above
      # returns JSON data of {file: hash written to a logfile}
      def create_file_hashes
        hash_alg = select_hash_alg

        puts "Output will be written in JSON format."
        puts "Example:
        {
          dir1:
          {
            some_file: its_hash,
            another_file: another_hash ... etc.
          }
        }
        "
        # todo get directory with the files that the user would like to hash
        puts "Where would you like to write your output ? (provide full path with ~/ )"
        output_file = gets.chomp
        puts "In which directory are your investigation files located ?"

        # make sure the directory exists with proper permissions
        dir = FileHelpers.rescue_file_operation {File.open(gets.chomp)}

        Sherlock::Integrity::Hashing.hash_dir(dir, hash_algorithim, output_file)
      end

      # Compares two files containing JSON data of {file: hash}
      def compare_hash_collections
        puts "You've chosen to compare hashing results from a collection of files."
        puts "If you haven't computed the hashes for your collection(S) of files please enter CTRL-C to exit and select option A to create create Hashes of your investigation logs"

        puts "Please select which files you'd like to compare today. (Provide Full Path)"

        # begin parsing hash data
        set_files {|a,b| Sherlock::Integrity::Hashing.compare_hash_logs a, b }
      end

      # user wants to quickly hash and compare two files
      def quick_hash
        hash_alg = select_hash_alg
        puts "Hash Algorithim: #{hash_alg.upcase}"

        method = "compute_#{hash_alg}"
        files = set_files do |file|
          hash = Sherlock::Integrity::Hashing.send method, file
          puts "#{file} -> \t #{hash}\n"
        end
      end

      # selects two files from user input and calls a block on them, returns files within a list
      def set_files(&block)
        files = []
        puts "fileA: "
        fileA = gets.chomp
        puts "fileB: "
        fileB = gets.chomp
        files << fileA, fileB
        files.each {|file| yield file} if block_given?
        return files
      end

      def select_hash_alg
        hash_alg = nil
        while( hash_alg == nil || !HASH_ALGORITHIMS.include?(hash_alg))
          puts "Which Hashing algorithim(s) would you like to use today? (Please Use Uppercase)"
          h = gets.chomp.downcase
          hash_alg = h
        end
      end

      # END PRIVATE METHODS

    end # end Integrity class
  end # End Integrity mod
end # End Sherlock mod
