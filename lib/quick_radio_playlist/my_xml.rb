# coding: utf-8
require 'xmlsimple'

module ::QuickRadioPlaylist
  module MyXml
    extend self

    def to_h(         string, root, array, keys)
      all = tree_full string
# Because KeepRoot is true:
      r = fetch all,          root
      location = descend r,         array
      extract                              keys, location
    end

    private

# Because ForceContent is true:
    def content(hash, key) fetch (fetch hash, key), :content end

    def descend(hash, array)
      result =  hash
      array.each{|e| result = fetch result, e}
      result
    end

    def extract(keys,                hash)
      values =  keys.map{|k| content hash, k}.map(&:strip)
      ::Hash[   keys.zip values]
    end

# Use Array#first, since ForceArray is true:
    def fetch(hash, key) (hash.fetch key).first end

    def options_xml
      {
          AttrPrefix:     true, # True = on attributes, include prefixes (@).
          ForceArray:     true, # True = parse to arrays (even when only one item exists).
          ForceContent:   true, # True = parse text content consistently (whether or not attributes exist).
          KeepRoot:       true, # True = keep the root element (of the XML file).
          KeyAttr:        [],   # []   = Drop no attributes.
          KeyToSymbol:    true, # True = use symbols (instead of strings).
          NormalizeSpace: 0,    # 0    = Pass whitespace through (unaltered).
          }
    end

    def tree_full(       string)
# See http://xml-simple.rubyforge.org/
# http://search.cpan.org/~grantm/XML-Simple-2.20/lib/XML/Simple.pm

# The first argument can be a string containing XML
# (recognized by the presence of '<' and '>' characters),
# instead of a filepath:
      ::XmlSimple.xml_in string, options_xml
    end
  end
end
