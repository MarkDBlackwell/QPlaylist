# coding: utf-8
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_hash'
require 'quick_radio_playlist/my_mustache'

module ::QuickRadioPlaylist
  module SongCommon
    extend self
    using MyArray
    using MyHash

    def render(      selected, keys, filepath)
      hash = process selected, keys
      MyMustache.render hash,       (filepath.call 'mustache'),
                                    (filepath.call 'html'    )
    end

    private

    def process(selected,                                  keys)
      return    selected.                   to_h. trim     keys unless
                selected.respond_to? :map
      array =   selected.             map(&:to_h).trim_all keys
      {songs: array}
    end
  end
end
