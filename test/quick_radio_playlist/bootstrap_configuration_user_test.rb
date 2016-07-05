# coding: utf-8
require ::File.expand_path '../bootstrap_configuration_test_helper', __FILE__

require 'quick_radio_playlist/bootstrap_configuration_user'

class ::QuickRadioPlaylist::BootstrapConfigurationUserTest < ::Minitest::Test
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

  def basename() "#{dot}#{program_name}" end

  def dirname() 'somewhere' end

  def entries() [''] end

  def parent_dirname_method() :app_data end

  def setup
    @klass = BootstrapConfigurationUser
    super
  end
end
