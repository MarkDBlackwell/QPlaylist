# coding: utf-8

module ::QuickRadioPlaylist
  module MyArray

    refine ::Array do

      def all_same?() 1 >= group_by{|e| e}.length end

      def lengths() map(&:length) end

      def only() raise 'Should be just one.' unless 1 == length; first end

      def terminate() flatten.map{|e| "#{e}\n"} end

      def terminate_join() terminate.join '' end

# Don't require 'my_hash'. (That produces a warning, regarding circularity.):
      def trim_all(keys) map{|e| e.select{|k,v| keys.include? k}} end
    end
  end
end
