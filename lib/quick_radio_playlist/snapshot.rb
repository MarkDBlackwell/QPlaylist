# coding: utf-8
require 'quick_radio_playlist/my_xml'
require 'quick_radio_playlist/song_now_playing'

module ::QuickRadioPlaylist
  module Snapshot
    extend self

    def capture() MyXml.to_h xml_string, root_element, descent_array, keys end

    private

    def descent_array() %i[ events  ss32event ] end

    def keys() %i[ artist  title ] end

    def root_element() :nowplaying end

    def xml_string() SongNowPlaying.xml_read end
  end
end
