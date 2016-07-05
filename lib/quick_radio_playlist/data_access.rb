# coding: utf-8
require 'quick_radio_playlist/my_array'

module ::QuickRadioPlaylist
  module DataAccess
    extend self
    using MyArray

    def append(         filepath,       s)   write_in_mode   filepath, 'ab', s              end

    def filepath(name, extension         ) ::File.join(*dirname + ["#{name}.#{extension}"]) end

    def read(           filepath         )  (read_array      filepath).terminate_join       end

    def write(          filepath,       s)   write_in_mode   filepath, 'wb', s              end

    def read_array(     filepath         )   readlines_chomp filepath                       end

    private

# Using relative path:
    def dirname(                         )  %w[ var ]                                       end

    def read_whole(     filepath         ) ::File.open(      filepath, 'rb') {|f| f.read  } end

# Splitting on "\n" fails on old Macintosh systems (using "\r"):
    def readlines_chomp(filepath         )  (read_whole      filepath).lines.map(&:chomp)   end

    def write_in_mode(  filepath, mode, s) ::File.open(      filepath, mode){|f| f.write s} end
  end
end
