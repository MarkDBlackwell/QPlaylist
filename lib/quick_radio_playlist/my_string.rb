# coding: utf-8
require 'quick_radio_playlist/my_array'

module ::QuickRadioPlaylist
  module MyString

    refine ::String do
      using MyArray

      def prepend_unless_same(array, string) array.all_same? ? self : (prepend string) end
    end
  end
end
