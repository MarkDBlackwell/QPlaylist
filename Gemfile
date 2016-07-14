# coding: utf-8
source 'https://rubygems.org'

# For confining local variables to a small scope, see:
#   http://stackoverflow.com/a/27469713/1136063

def scope() yield end

# For specifying the bundler gem's version, see:
#   http://stackoverflow.com/a/18384158/1136063

scope do
  bundler_version_required = '1.12.5'
  ::Kernel.abort "Bundler version #{bundler_version_required} is required" unless\
      (Gem::Version.new             bundler_version_required) ==
      (Gem::Version.new Bundler::VERSION)
end

scope do
  version_file = File.expand_path('../.ruby-version', __FILE__)
  ruby_version_required = ::File.open(version_file,'r'){|f| f.first.chomp}.prepend '='
#print 'Gemfile: ruby_version_required='; p ruby_version_required
  ruby                ruby_version_required,
      engine_version: ruby_version_required,
      engine:        'ruby',
      patchlevel: '319'
end

# Specify the gem dependencies in {anything}.gemspec.
gemspec

gem 'ffi', '1.9.10', platforms: :mswin
