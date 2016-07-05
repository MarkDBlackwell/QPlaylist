# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'quick_radio_playlist/version'

class ::QuickRadioPlaylist::VersionTest < ::Minitest::Test
  include ::QuickRadioPlaylist

  def test_it_has_a_version_number
    refute_nil VERSION
  end
end
