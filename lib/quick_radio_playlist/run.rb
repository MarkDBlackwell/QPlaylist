# coding: utf-8

## Stages, or modules, or states:

# ? WindowsService
#   HandlerXmlEvent
#   HandlerSongChange
#   HandlerHourChange
# ? Afterward

module ::QuickRadioPlaylist
  module Run
    extend self

    def run
      return unless xml_event?
      require 'quick_radio_playlist/handler_xml_event'
      HandlerXmlEvent.run
    end

    private

    def xml_event?() true end
  end
end
