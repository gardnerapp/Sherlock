require "json"
require "../errors/errors.rb"

module Sherlock
  module FileHelpers
    include Sherlock::SherlockError

    extend self # makes methods available in form of Sherlock::FileHelpers.my_method

    # Returns a list of all of the files in the directory

    def get_files(dir)
      # make sure this returns correctly and use a lambda
      files = rescue_file_operation { Dir[File.join(dir, "**", "*")].reject {|f| !File.file? f } }
    end

    # Returns a list of all sub-directories within a directory

    def get_dirs(dir)
      dirs = rescue_file_operation { Dir[File.join(dir, "**", "*")].reject {|f| !File.directory? f} }
    end

    # TODO make walking method with the functions listed above
    # block gets called on each file in the directory

    def walk_dir(dir, &block)
      if !block_given?
        puts "Error No block provided to Sherlock::FileHelpers.walk_dir... Exiting"
        exit -1
      end
    end

    # Writes data to a file, data is optionally formated with a block
    # example call write_to_file(myfile, somedata) do {|d| JSON.pretty_generate d}
    def write_and_format(file, data,  &block)
      rescue_file_operation do
        File.open(output_file, "w") do |f|
          if block_given? # call block on data
            f.write(yield data)
          else
            f.write(data)
          end
        end
      end
    end

    # returns a ruby object from the JSON file
    # Can probablly meta-program this with xml, yml libraries etc

    def file_to_json(file)
      data = rescue_file_operation {File.read(file)}
      begin
        d = JSON.parse(data, { object_class: Hash, symbolize_names: true})
      rescue JSON::ParserError => e
        puts "#{e_str} Invlaid JSON syntax in #{file} "; puts e
      end
      d
    end

    %i[f_to_j  file_to_j ].each {|a| alias_method a, :file_to_json }

    # Runs a function inside of a begin/raise statement
    # ideally used to rescue if a file/dir does not exist or does not have the proper permissions

    def rescue_file_operation(&block)
      begin
        yield if block_given?
      rescue Errno::ENOENT => e
        puts "#{e_str} the file or directory you are trying to access may not exist"; puts e
      rescue Errno::EACCE => e
        puts "#{e_str} the file or directory you're trying to access has incorrect permissions"; puts e
      end
    end

  end
end
