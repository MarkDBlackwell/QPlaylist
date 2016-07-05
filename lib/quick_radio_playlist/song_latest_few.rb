# coding: utf-8
require 'quick_radio_playlist/song_common'

module ::QuickRadioPlaylist
  module SongLatestFew
    extend self
    include SongCommon

    def cardinality() 5 end

    def output(   songs)
      selected = (songs.reverse!.take cardinality)
      SongCommon.render selected, keys_view, (method :filepath)
    end

    private

    def filepath(extension) DataAccess.filepath 'latest_five', extension end

    def keys_view() %i[ artist  start_time  title ] end
  end
end
