# coding: utf-8
require 'quick_radio_playlist/data_access'

module ::QuickRadioPlaylist
  module HourCurrent
    extend self

    def same?(song) (hour song) == time end

    def time
      values = (read_safe.split ' ').map(&:to_i)
      ::Time.new(*values)
    end

    def txt_update() write time_string ::Time.now end

    def year_month_day_string(time)
      array = ordered_keys.reject{|e| :hour == e}
      join                    time, array
    end

    private

    def filepath() DataAccess.filepath 'current_hour', 'txt' end

    def hour(song) ::Time.new(*song.to_h.values_at(*ordered_keys)) end

    def join(time, keys) keys.map{|e| time.send e}.map(&:to_s).join ' ' end

    def ordered_keys() %i[ year  month  day  hour ] end

    def read() (DataAccess.read_array filepath).push('').first end

    def read_safe
      unix_epoch_beginning = 0
      default = time_string ::Time.at unix_epoch_beginning
      read_string = read
      read_string.empty? ? default : read_string
    end

    def time_string(time) join time, ordered_keys end

    def write(string)
      s = "#{ string}\n"
      DataAccess.write filepath, s
    end
  end
end
