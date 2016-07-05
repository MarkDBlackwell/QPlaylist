# coding: utf-8
require 'quick_radio_playlist/hour_current'
require 'quick_radio_playlist/song_recent_database'

module ::QuickRadioPlaylist
  module HandlerHourChange
    extend self

    def run() history_filter end

    private

    def history_filter
      HourCurrent.txt_update
      SongRecentDatabase.filter
    end
  end
end

