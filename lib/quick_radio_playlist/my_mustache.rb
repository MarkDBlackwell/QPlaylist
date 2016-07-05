# coding: utf-8
require 'mustache'
require 'quick_radio_playlist/data_access'

module ::QuickRadioPlaylist
  module MyMustache
    extend self

    def render(hash,      f_in, f_out)
      ::Mustache.raise_on_context_miss = true
      view = ::Mustache.new
      view.template =
          DataAccess.read f_in
# Mustache provides no verbal alternative to the notation, '[]=':
      hash.each_pair{|k,v| view[k] = v}
      DataAccess.write          f_out, view.render
    rescue   ::Mustache::ContextMiss
      alert               f_in
    end

    private

    def alert(file) puts "At line #{__LINE__} of file #{__FILE__}, file '#{file}' contains an extra mustache tag."; raise end
  end
end
