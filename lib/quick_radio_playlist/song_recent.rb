# coding: utf-8
require 'quick_radio_playlist/song_common'

module ::QuickRadioPlaylist
  module SongRecent
    extend self

    def output(  songs)
      selected = songs
      SongCommon.render selected, keys_view, (method :filepath)
    end

    private

    def filepath(extension) DataAccess.filepath 'recent_songs', extension end

    def keys_view() %i[ artist  day  hour  meridian  minute  month  title ] end
  end
end
