# coding: utf-8

module ::QuickRadioPlaylist
  Error = Class.new ::StandardError

  class PlatformNotSupportedError < Error
    def initialize(message='Requires Microsoft Windows') super message end
  end
end
