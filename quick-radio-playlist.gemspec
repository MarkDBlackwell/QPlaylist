# coding: utf-8
lib = ::File.expand_path '../lib', __FILE__
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include? lib
require 'quick_radio_playlist/version'

# See: http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/

# By its very nature, this is a gem for "direct use". Unlike most gems, it:
#  1. Is standalone;
#  2. Shouldn't be a component for other projects;
#  3. Doesn't attempt to be flexible in its dependencies; and
#  4. Locks its requirements minutely and totally.

version_file = File.expand_path('../.ruby-version', __FILE__)
ruby_version_required = ::File.open(version_file,'r'){|f| f.first.chomp}

name = 'quick-radio-playlist'
::Gem::Specification.new do |s|
  s.author      = 'Mark D. Blackwell'
  s.bindir      = 'exe'
  s.description = <<-HERE.split.join ' '
        A 64-bit Windows Ruby gem that provides
        customizable, live lists
        of multiple streams
        of recent songs
        and includes them on website(s),
        for any radio station
        which uses WideOrbit automation software.
        HERE
  s.email       = 'markdblackwell01@example.com'
  s.executables = (::Dir.glob 'exe/**/*').map{|e| ::File.basename e}
  s.extra_rdoc_files += ::Dir.glob '**/*.md'
  s.extra_rdoc_files += ::Dir.glob '**/example*'
  s.files += ::Dir.glob '{data,lib,license}/**/*'
  s.files += ::Dir.glob 'Gemfile*' # Include Gemfile.lock.
  s.files += ::Dir.glob 'Rakefile'
  s.files += ::Dir.glob '*.gemspec'
  s.files += ::Dir.glob '.[^.]*' # Root dotfiles.
  s.files -= ::Dir.glob '**/.gitkeep'
  s.files = s.files.sort
  s.homepage                      = 'https://will-be-on-GitHub.example.com'
  s.license                       = 'GPL-3.0'
  s.metadata['allowed_push_host'] = 'https://rubygems.org'
  s.name                          = name
  s.platform                      = 'x64-mingw32'
  s.post_install_message          = "#{name} installation complete. Next, do 'setup'."
  s.rdoc_options                 << "--title #{name}"
  s.rdoc_options                 += %w[--main README.md]
  s.require_paths                 = %w[lib]

# Ruby version quad breaks Bundler (version 1.12.5); see:
##   https://github.com/bundler/bundler/issues/2845
##   https://github.com/bundler/bundler/issues/4593
##   For example:
##s.required_ruby_version         = '2.2.4.230'
##
#print '*.gemspec: ruby_version_required='; p ruby_version_required
  s.required_ruby_version         =  ruby_version_required
# s.required_rubygems_version     = '2.4.5.1'
  s.required_rubygems_version     = '2.6.4'
  s.requirements                 << 'WideOrbit Automation'
  s.requirements                 << 'Windows NT family'
  s.requirements                 << 'Windows 7 (maybe)'
# s.rubygems_version # Don't set this: it's automatic.
  s.specification_version         = 1
  s.summary    = 'A quick playlist for radio station websites'
  s.test_files = ::Dir.glob '{features,spec,test,tests}/**/*'
  s.version    = ::QuickRadioPlaylist::VERSION

## Base-level dependencies:
##   Running on WTMD since circa 2013:
##     mustache,    0.99.5
##     xml-simple,  1.1.2
##
##   New with development in 2016:
##     bundler
##     inifile
##     logging
##     minitest
##     rake
##     win32-service

# Gem rdoc versions after 4.0.0 seem broken on Ruby 2.0.0.

# Dependencies:
  s.add_dependency 'bundler', '1.12.5'
  s.add_dependency 'ffi', '1.9.10'
  s.add_dependency 'inifile', '3.0.0'
  s.add_dependency 'little-plugger', '1.1.4'
  s.add_dependency 'logging', '2.1.0'
  s.add_dependency 'minitest', '5.9.0'
  s.add_dependency 'minitest-stub-const', '0.5'
  s.add_dependency 'multi_json', '1.12.1'
  s.add_dependency 'mustache', '1.0.3' # At WTMD: 0.99.5
  s.add_dependency 'os', '0.9.6'
  s.add_dependency 'rake', '11.1.2'
  s.add_dependency 'win32-service', '0.8.7'
  s.add_dependency 'xml-simple', '1.1.5' # At WTMD: 1.1.2

  s.add_development_dependency 'yard', '0.9.12'

# Per:
# https://github.com/bundler/bundler/issues/4131
# http://stackoverflow.com/questions/17717529/teamcity-rake-runner-incompatible-with-test-unit-2-0-0-0

# If we need a gem which is built in to Ruby, then:
#  1. Specify the latest version; and
#  2. Run `bundle install --no-cache`.

# Or, we can:
#  1. Download its .gem file from RubyGems.org;
#  2. Place that file in /vendor/cache/ (that is, if we're caching); and
#  3. Run `bundle install`.
end
