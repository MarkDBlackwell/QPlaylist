# coding: utf-8
require 'quick_radio_playlist/bootstrap_configuration_common'
require 'quick_radio_playlist/error'

module ::QuickRadioPlaylist
  module BootstrapConfigurationAirstream
    extend self
    extend BootstrapConfigurationCommon

    def file_ensure(airstream) file_copy airstream unless file_exist? airstream; nil end

    private

    def airstream_parent_dirname() ::File.join drive, our_name end

    def file_copy(                     airstream)
      nodes = %w[ data  example  example_QuickRadioPlaylist_airstream.ini ]
      filepath = ::File.join(*nodes)
      s = ::IO.binread        filepath
      \
          ::IO.binwrite (file_filepath airstream), s
      nil
    end

    def file_exist?(airstream) ::File.exist? file_filepath airstream end

    def file_filepath(  airstream)
      raise if          airstream.empty?
      dot, underscore = %w[ .  _ ]
      name = [our_name, airstream].join underscore
      basename = [name,     'ini'].join dot
      ::File.join       airstream_parent_dirname, basename
    end

    def drive
      drive = ((::File.expand_path ::Dir.pwd).split ::File::Separator).first
      raise PlatformNotSupportedError unless 2 == drive.length && (drive.end_with? ':')
      drive
    end
  end
end
