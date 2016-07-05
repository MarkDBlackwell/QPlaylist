# coding: utf-8
require 'pp'
require 'quick_radio_playlist/my_array'

module ::QuickRadioPlaylist
  module MyHash

    refine ::Hash do
      using MyArray

      def convert_to_symbols
        result = dup
        keys   =             result.      keys
        keys.each                     do |key|
          next if                         key.respond_to? :to_sym
          sym =                           key.             to_sym
          raise "Cannot convert string '#{key  }' to symbol:" \
                                  " hash already has symbol #{sym}." if
                             result.  has_key?                sym
          result.store sym, (result.fetch key)
          result.delete                   key
        end
        result
      end

      def safe_set(     keys,    values)
        return          keys.zip(values).each{|k,v| safe_set k, v} if keys.
            respond_to?     :zip
        safe_set_scalar keys,    values
      end

      def store_all_same(      keys)
        indices =              keys.length.times.to_a
        indices.map{|i| indices.partition{|e| e == i}}.
            each                   do |single, rest|
          key   =              keys.at single.only
          next unless has_key? key
          value =       fetch  key
          rest.each{|i| store (keys.at i), value}
        end
      end

      def trim(keys) select{|k,v| keys.include? k} end

      private

# Changes from plural to singular:
      def safe_set_scalar(key, value) store key, value unless has_key? key end
    end
  end
end
