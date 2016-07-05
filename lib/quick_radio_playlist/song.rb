# coding: utf-8
require 'pp'
require 'quick_radio_playlist/hour_current'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_hash'
require 'quick_radio_playlist/song_initialize'

module ::QuickRadioPlaylist
  class Song
    using MyArray
    using MyHash

    attr_reader :to_h

    def initialize(hash)
      h     =      hash.convert_to_symbols
      h.store_all_same keys_same
# On Windows (almost always), system time is local time:
      time = ::Time.now.round
# Avoid clobbering the implications of keys already set. Avoid
#   that possibility, by proceeding from coarser to finer keys:
      h.safe_set :date, (HourCurrent.year_month_day_string time)
      h.safe_set :time, (      hour_minute_meridian_string time)
      h.store_all_same keys_same
      \
          SongInitialize.set_from :clock, ( \
          SongInitialize.set_from :time,  ( \
          SongInitialize.set_from :date,  ( \
                   h)))
#puts             'h='; pp h
      check_length h
      @to_h =      h.freeze
    end

    def fetch(key) @to_h.fetch key end

    def store(key, value) @to_h.store key, value end

    def values() @to_h.values end

    def values_at(*keys) @to_h.values_at(*keys) end

    private

    def check_length(hash)
      unless        [hash, keys_desired].map(&:length).all_same?
        message = "When creating song #{
            ::PP.pp  hash, $stderr}, number of keys should be #{
                           keys_desired.       length}."
        raise message
      end
    end

    def hour_minute_meridian_string(time) time.strftime '%-H:%M %p' end

    def keys_desired
      %i[ artist  clock  current_time  date  day  hour  meridian  minute  month  start_time  time  title  year ]
    end

    def keys_same() %i[ current_time  start_time  time ] end
  end
end
