require 'digest'
require './file_helpers'

module Sherlock
  module Integrity
    HASH_ALGORITHIMS = %i[md5 sha1 sha2]

    class Hashing

      # todo add methods for quickly hashing and comparing two files
      # once these methods are written DRY up the code

      class << self
        HASH_ALGORITHIMS.each do |hash_alg|
          define_method "compute_#{hash_alg}" do |data|
            h = eval("Digest::#{hash_alg.upcase}.hexdigest(data)")
          end
        end

        # walks a directory and hashes all of the files in it 
        def hash_dir(dir, hash_alg, output_file)
          file_hashes = {} # {file: hash}

          files = Sherlock::FileHelpers.get_files(dir)

          files.each do |file|
            hash = self.send("compute_#{hash_alg.downcase}", File.read("#{file}"))

            file_hashes[file]= hash
          end

          Sherlock::FileHelpers.write_and_format(output_file,file_hashes) do {|data| JSON.pretty_generate(data)}
          # The above line experimentally replaces:
          # File.open( output_file, "w" ) { |f| f.write( JSON.pretty_generate(file_hashes) ) }

          puts "Hashed #{file_hashes.length} files"
          puts "Output written to: #{output_file}"
        end

        # fileA & fileB both store JSON data of computed hashes, either calculate by this module or from an outside src
        # this method will extract the json data into a Hash object (not to be confused with a file hash). The format of this hash obj is {file, path} etc.
        # Next the key/value objects will be iterated over, if the key does not exist or the resulting hashes are unequal there is a mismatch in the hashing logs
        # only mismatches and inequalities will be logged to the provided logfile or STDOUT.

        def compare_hash_logs(fileA,fileB)

          hashA = Shelock::FileHelper.f_to_j
          hashB = Sherlock::FileHelper.f_to_j

          if hashA == hashB # All keys are eql, don't provide out put
            puts "Both hash logs are equal, everything looks alright. Exiting..."
            exit(1)
          end

          puts "Where would you like to write your output to? (stdout/file)"
          answer = nil
          until answer == "stdout" || answer == "file"
            answer = gets.chomp.downcase
          end

          output_file = gets.chomp if answer == 'file'


          # compares keys/values of two Hashes and returns a Hash of the differences
          # TODO monkey patch and add to Hash class ?
          find_diff = -> (h1,h2) {h1.reject! {|k,v| h2[k] == v}}

          hashA_diffs = find_diff hashA, hashB
          hashB_diffs = find_diff hashB, hashA

          # format the data
          data = "FileA = #{fileA}\n\n\n#{JSON.pretty_generate(hashA_diffs)}\n\n"
          data += "FileB = #{fileB}\n\n\n#{JSON.pretty_generate(hashB_diffs)}\n\n"

          output_file ? Sherlock::FileHelpers.write_and_format(output_file, data) : puts data

        end # End compare_hashing_data

      end # End Singleton Class
    end # End Hashing Class
  end # Integrity Module
end #  Sherlock module
