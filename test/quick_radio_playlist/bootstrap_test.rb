# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'minitest/mock'
require 'minitest/stub_const'
require 'quick_radio_playlist/bootstrap'
require 'quick_radio_playlist/error'

class ::QuickRadioPlaylist::BootstrapTest < ::Minitest::Test
  include ::QuickRadioPlaylist
  include TestHelper

  def test_it_can_be_run() Bootstrap.run end

  def test_it_verifies_it_is_running_on_Windows
    assert_raises PlatformNotSupportedError do
      ::OS.stub :windows?, false do
        Bootstrap.run
      end
    end
  end
end
