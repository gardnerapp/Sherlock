# frozen_string_literal: true

require_relative "lib/sherlock/version"

Gem::Specification.new do |spec|
  spec.name = "sherlock"
  spec.version = Sherlock::VERSION
  spec.authors = ["gardnerapp"]
  spec.email = ["example@example.com"]

  spec.summary = "Log Processing Utility"
  spec.description = "Understand Malicous Request On Your Web Server"
  spec.homepage = "https://github.com/gardnerapp/sherlock.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gardnerapp/sherlock.git"
  spec.metadata["changelog_uri"] = "https://github.com/gardnerapp/sherlock.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
