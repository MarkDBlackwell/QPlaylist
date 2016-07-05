# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'minitest/mock'
require 'quick_radio_playlist/song_initialize'

class ::QuickRadioPlaylist::SongInitializeTest < ::Minitest::Test
  include ::QuickRadioPlaylist
  include TestHelper

  def test_set_from_drops_leading_zeros_from_day
    key = :date
    actual   = {key => '2011 12 08'  }
    expected = {key => '2011 12 08', year: '2011', month: '12', day: '8'}
    run_and_assert_set_from expected,
                key, actual
  end

  def test_set_from_drops_leading_zeros_from_hour
    key = :clock
    %w[   1:57
         01:57
        001:57
        ].each       do |time|
      actual   = {key => time}
      expected = {key => time, hour: '1', minute: '57'}
      run_and_assert_set_from expected,
                  key, actual
    end
  end

  def test_set_from_drops_leading_zeros_from_month
    key = :date
    actual   = {key => '2011 07 31'  }
    expected = {key => '2011 07 31', year: '2011', month: '7', day: '31'}
    run_and_assert_set_from expected,
                key, actual
  end

  def test_set_from_drops_leading_zeros_from_year
    key = :date
    actual   = {key => '0910 9 8'  }
    expected = {key => '0910 9 8', year: '910', month: '9', day: '8'}
    run_and_assert_set_from expected,
                key, actual
  end

  def test_set_from_shortens_too_long_clock_array
    key = :clock
    expected = {key => '23:59', hour: '23', minute: '59'}
    %w[ 23:59:59
        23:59:59:59
        23:59:59:59:59
        ].each     do |too_long|
      actual = {key => too_long}
      run_and_assert_set_from expected,
                key, actual
    end
  end

  def test_set_from_shortens_too_long_date_array
    length_proper = 3
    key = :date
    expected = {key => '2011 12 31', year: '2011', month: '12', day: '31'}
    %w[ 2011\ 12\ 31\ 23
        2011\ 12\ 31\ 23\ 59
        2011\ 12\ 31\ 23\ 59\ 59
        ].each do |too_long|
      split     =  too_long.split ' ', keep_trailing_null_fields
      shortened =          (split.take length_proper).join ' '
      actual = {key => shortened}
      run_and_assert_set_from expected,
                key, actual
    end
  end

  def test_set_from_shortens_too_long_time_array
    key = :time
    expected = {key => '12:34 PM', clock: '12:34', meridian: 'PM'}
    %w[ 12:34\ PM\ 1
        12:34\ PM\ 1\ 2
        12:34\ PM\ 1\ 2\ 3
        ].each     do |too_long|
      actual = {key => too_long}
      run_and_assert_set_from expected,
                key, actual
    end
  end

  def test_set_from_supplies_default_on_empty
    %i[ clock date time].each do |key|
      actual   =                 {key => ''}
      expected = expected_default key
      run_and_assert_set_from expected,
                                  key, actual
    end
  end

  def test_set_from_supplies_default_on_missing_day
    key = :date
    actual   = {key => '2011 12'  }
    expected = {key => '2011 12 0', year: '2011', month: '12', day: '0'}
    run_and_assert_set_from expected,
                key, actual
  end

  def test_set_from_supplies_default_on_missing_hour
    key = :clock
    actual   = {key =>  ':59'}
    expected = {key => '0:59', hour: '0', minute: '59'}
    run_and_assert_set_from expected,
                key, actual
  end

  def test_set_from_supplies_default_on_missing_key
    %i[ clock date time].each       do |key|
      actual   = ::Hash.new
      expected = expected_default       key
      run_and_assert_set_from expected, key, actual
    end
  end

  def test_set_from_supplies_default_on_missing_meridian
    key = :time
    actual   = {key => '23:59'   }
    expected = {key => '23:59 AM', clock: '23:59', meridian: 'AM'}
    run_and_assert_set_from expected,
               key, actual
  end

  def test_set_from_supplies_default_on_missing_minute
    key = :clock
    actual   = {key => '23:'  }
    expected = {key => '23:00', hour: '23', minute: '00'}
    run_and_assert_set_from expected,
                key, actual
  end

  private

  def expected_default(key)
    case               key
    when :clock then  {key => '0:00'   ,  hour: '0'   ,   minute: '00',         }
    when :date  then  {key => '0 0 0'  ,  year: '0'   ,    month: '0' , day: '0'}
    when :time  then  {key => '0:00 AM', clock: '0:00', meridian: 'AM',         }
    else raise
    end
  end

  def keep_trailing_null_fields() -1 end

  def run_and_assert_set_from(expected, key, actual)
    SongInitialize.set_from             key, actual
    assert_equal              expected,      actual, (call_trace '', __FILE__)
    nil
  end
end
