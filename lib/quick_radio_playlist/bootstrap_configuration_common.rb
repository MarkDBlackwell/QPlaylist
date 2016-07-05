# coding: utf-8

module ::QuickRadioPlaylist
  module BootstrapConfigurationCommon
    extend self

    private

    def our_name() (ancestors.first.name.split '::').first end # QuickRadioPlaylist
  end
end
