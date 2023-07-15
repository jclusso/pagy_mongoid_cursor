# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), 'lib'))

require 'pagy_mongoid_cursor/version'

Gem::Specification.new do |s|
  s.name = 'pagy_mongoid_cursor'
  s.version = PagyMongoidCursor::VERSION
  s.summary = 'Pagy Mongoid Cursor'
  s.description = 'Pagy Extra to do cursor based pagination for Mongoid.'
  s.homepage = 'https://github.com/jclusso/pagy_mongoid_cursor/'
  s.author = 'Jarrett Lusso'
  s.email = 'jclusso@gmail.com'
  s.license = 'MIT'
  s.metadata = {
    "bug_tracker_uri" => "https://github.com/jclusso/pagy_mongoid_cursor/issues",
    "documentation_uri" => "https://github.com/jclusso/pagy_mongoid_cursor/README.md",
    "source_code_uri" => "https://github.com/jclusso/pagy_mongoid_cursor"
  }

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
    ::File.basename(f)
  end
  s.require_paths = ['lib']
  s.add_dependency "pagy", ">= 6", "< 7"
  s.add_dependency "mongoid"
end
