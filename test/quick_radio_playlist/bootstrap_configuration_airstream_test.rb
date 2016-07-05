# coding: utf-8
require ::File.expand_path '../bootstrap_configuration_test_helper', __FILE__

require 'quick_radio_playlist/bootstrap_configuration_airstream'

class ::QuickRadioPlaylist::BootstrapConfigurationAirstreamTest < ::Minitest::Test
  include ::QuickRadioPlaylist
  include BootstrapConfigurationTestHelper

  def test_file_copy_copies_that_file
           file_copy_copies_that_file
  end

  def test_it_calculates_file_filepaths
           it_calculates_file_filepaths
  end

  def test_it_calls_file_copy_when_lacks_that_file
           it_calls_file_copy_when_lacks_that_file
  end

  def test_it_calls_file_ensure
           it_calls_file_ensure
  end

  def test_it_calls_file_exist?
           it_calls_file_exist?
  end

  def test_it_checks_existence_of_file
           it_checks_existence_of_file
  end

  def test_it_doesn_t_call_file_copy_when_it_has_that_file
           it_doesn_t_call_file_copy_when_it_has_that_file
  end

  def test_it_leaves_untouched_file_when_it_has_that_file
           it_leaves_untouched_file_when_it_has_that_file
  end

  private

  def basename() [ ([program_name, @entry].join underscore), 'ini'].join dot end

  def dirname() ::File.join 'C:', program_name end

  def entries() %w[ anything  something_else ] end

  def parent_dirname_method() :airstream_parent_dirname end

  def setup
    @klass = BootstrapConfigurationAirstream
    super
  end
end
