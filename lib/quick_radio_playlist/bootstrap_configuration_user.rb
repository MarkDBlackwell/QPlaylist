# coding: utf-8
require 'quick_radio_playlist/bootstrap_configuration_common'

module ::QuickRadioPlaylist
  module BootstrapConfigurationUser
    extend self
    extend BootstrapConfigurationCommon

    def file_ensure() file_copy unless file_exist?; nil end

    private

    def app_data() ::File.expand_path ENV.fetch 'APPDATA' end

    def file_copy
      nodes = %w[ data  example  example_QuickRadioPlaylist.ini ]
      filepath = ::File.join(*nodes)
      s = ::IO.binread       filepath
      \
          ::IO.binwrite file_filepath, s
      nil
    end

    def file_exist?() ::File.exist? file_filepath end

    def file_filepath() dot = '.'; ::File.join app_data, "#{dot}#{our_name}" end
  end
end
