# coding: utf-8
require 'quick_radio_playlist/data_access'
require 'quick_radio_playlist/hour_current'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/song'

module ::QuickRadioPlaylist
  module SongRecentDatabase
    extend self
    using MyArray

    def filter() DataAccess.write filepath, (stringify reduce songs) end

    def merge(song) DataAccess.append filepath, (stringify song) end

    def songs() song_enumerator.map{|values| Song.new ::Hash[ordered_keys.zip values]} end

    private

    def comparison_time() two_weeks = 60 * 60 * 24 * 7 * 2; HourCurrent.time - two_weeks end

    def filepath() DataAccess.filepath 'recent_songs', 'txt' end

    def ordered_keys() %i[ date  start_time  artist  title ] end

    def ordered_values(object)
      return           object.map{|e| ordered_values e} if
                       object.respond_to? :map
      object.values_at(              *ordered_keys)
    end

    def per_song() ordered_keys.length end

    def reduce(         songs)
#puts 'comparison_time='; pp comparison_time
      songs.select  do |song|
#puts       'song='; pp song
        date      =     song.fetch :date
        year, month, day =         (date.split ' ').map(&:to_i)
        song_time = ::Time.new year, month, day
#puts  'song_time='; pp song_time
        song_time > comparison_time
      end
    end

    def song_enumerator
      lines = DataAccess.read_array filepath
      song_enumerator_verify lines
      cardinality =          lines.length.div per_song
      ::Enumerator.new cardinality do |yielder|
        (lines.length.times.to_a.each_slice   per_song).each do |indices|
          yielder.yield      lines.values_at(*                   indices)
        end
      end
    end

    def song_enumerator_verify(lines)
      length  =                lines.length
      message =       "Bad number '#{length}' of recent song lines; fix #{filepath}."
      raise message unless 0 ==      length % ordered_keys.length
    end

    def stringify(object) (ordered_values object).terminate_join end
  end
end
