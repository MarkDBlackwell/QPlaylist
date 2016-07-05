# coding: utf-8
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/song_common'

module ::QuickRadioPlaylist
  module SongNowPlaying
    extend self
    using MyArray

    def output(  song)
      selected = song
      SongCommon.render selected, keys_view, (method :filepath)
    end

    def same?(song) (build_string song) == txt_read end

    def txt_update(song) DataAccess.write (filepath 'txt'), (build_string song) end

    def xml_read() DataAccess.read filepath 'xml' end

    private

    def build_string(song) song.values_at(*ordered_keys).terminate_join end

    def filepath(extension) DataAccess.filepath 'now_playing', extension end

    def keys_view() %i[ artist  current_time  title ] end

    def ordered_keys() %i[ artist  title ] end

    def txt_read() DataAccess.read_array filepath 'txt' end
  end
end
