# coding: utf-8
require 'pp'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_hash'
require 'quick_radio_playlist/my_string'

module ::QuickRadioPlaylist
  module SongInitialize
    extend self
    using MyArray
    using MyHash
    using MyString

    def set_from(    key,       hash)
      h = {key_from: key, hash: hash}
      case           key
      when :clock
        key_split h.merge \
            ordered_keys: %i[ hour  minute ],
            default: '0:00',
            separator: ':'
        %i[ hour ].each{|k| remove_leading_zeros hash, k}
      when :date
        key_split h.merge \
            ordered_keys: %i[ year  month  day ],
            default: '0 0 0',
            separator:  ' '
        %i[ day  month  year ].each{|k| remove_leading_zeros hash, k}
      when :time
        key_split h.merge \
            ordered_keys: %i[ clock  meridian ],
            default: '0:00 AM',
            separator: ' '
      else raise
      end
      hash
    end

    def key_split(     default:, hash:, separator:, ordered_keys:, key_from:)
      key_split_verify default,         separator,  ordered_keys,  key_from
      key_split_massage                                            key_from,
                       default,  hash,  separator
      string =                   hash.fetch                        key_from
      string_split = string.split       separator, keep_trailing_null_fields
      hash.safe_set                                 ordered_keys,
                     string_split
    end

    def key_split_massage(key_from,      default,    hash, separator)
      default_split =                    default.split     separator, keep_trailing_null_fields
      hash.safe_set       key_from,      default
      hash.store          key_from,      default if (hash.fetch \
                          key_from).empty?
      string =                                       hash.fetch \
                          key_from
      long = string.split                                  separator, keep_trailing_null_fields
      string_split = long.take [long,    default_split].lengths.min
      (string_split.length...            default_split.length).
          each {|i| string_split[   i] = default_split.at i}
      string_split.each{|e| e = e.strip}
      string_split.length.
          times{|i| string_split[   i] = default_split.at i if
                   (string_split.at i).empty?}
      hash.store          key_from,
                   (string_split.join                      separator)
    end

    def key_split_verify(default,          separator, ordered_keys, key_from)
      default =          default.strip
# ::Kernel.binding.local_variables includes those generated later; so can't use it.
#(puts 'ordered_keys='; pp ordered_keys) if           ordered_keys.empty?
#(puts     'key_from='; pp     key_from) if                         key_from.empty?
      raise 'Empty required parameter.' if [          ordered_keys, key_from].any?{|e| e.empty?}
      raise_message_must                   separator, 'not be empty'\
                                         ' separator' if
                                           separator.empty?
      raise_message_must default, 'not be empty' if
                         default.empty?
      raise_message_must default, 'not be an array' if
                         default.respond_to? :map
      default_split =    default.split     separator, keep_trailing_null_fields
      raise_message_must default, "contain separators '#{
                                           separator}'" if
                         default_split.length < 2
      default_split.each{|e| e = e.strip}
      raise_message_must default, 'not include a field containing whitespace' if
                         default_split.any?{|e| e.empty?}
    end

    private

    def keep_trailing_null_fields() -1 end

    def remove_leading_zeros(hash, key) hash.store key, (hash.fetch key).to_i.to_s end
  end
end
