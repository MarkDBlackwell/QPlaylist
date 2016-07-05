# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'minitest/mock'
require 'quick_radio_playlist/data_access'

class ::QuickRadioPlaylist::DataAccessTest < ::Minitest::Test
  include ::QuickRadioPlaylist

  def test_readlines_chomp_removes_all_varieties_of_line_terminators
    filepath = ''
# "linefeed\ carriage\ return\n\r" fails:
    %W[
        nothing
        linefeed
        carriage\ return
        carriage\ return\ linefeed
        ].zip \
    %W[
        nothing
        linefeed\n
        carriage\ return\r
        carriage\ return\ linefeed\r\n
        ].each    do |expected,    stub_returns|
      DataAccess.stub :read_whole, stub_returns do
        actual = DataAccess.send :readlines_chomp, filepath
        assert_equal [expected], actual
      end
    end
  end
end


