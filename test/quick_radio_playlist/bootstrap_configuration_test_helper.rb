# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'minitest/mock'
require 'minitest/stub_const'
require 'quick_radio_playlist/bootstrap'

module ::QuickRadioPlaylist::BootstrapConfigurationTestHelper
  include ::QuickRadioPlaylist
  include TestHelper

  private

  def entries_each() entries.each{|e| @entry = e; yield}; nil end

  def entries_empty?() (entries.join '').empty? end

  def expect_entry(mock)
    params = [:call, nil]
    params.push [@entry] unless entries_empty?
    mock.expect(*params)
    nil
  end

  def                     file_copy_copies_that_file
    entries_each do
      filepath = filepath_hot basename
      ::File.delete filepath if           ::File.exist?  filepath
      refute                              ::File.exist?  filepath
# The syntax checker requires both levels of parentheses:
      @klass.stub(parent_dirname_method, (::File.dirname filepath)) do
        send_file_symbol :file_copy
      end
      filepath_expected = "data/example/example_#{program_name}#{tag}.ini"
      expected =              ::IO.binread filepath_expected
      assert_equal expected, (::IO.binread               filepath)
# Remove copied file, for other tests?
##    clear_hot_files
    end
    nil
  end

  def         it_calculates_file_filepaths
    entries_each do
      expected = ::File.join               dirname, basename
      actual = unless entries_empty?
        send_file_symbol   :file_filepath
      else
        @klass.stub parent_dirname_method, dirname do
          send_file_symbol :file_filepath
        end
      end
      assert_equal expected, actual
    end
    nil
  end

  def              it_calls_file_copy_when_lacks_that_file
    entries_each do
      mock = ::Minitest::Mock.new
      expect_entry                       mock
      @klass.  stub        :file_copy,   mock  do
        @klass.stub        :file_exist?, false do
          send_file_symbol :file_ensure
        end
      end
      mock.verify
    end
    nil
  end

  def   it_calls_file_ensure
    mock = ::Minitest::Mock.new
    entries_each do
      expect_entry            mock
    end
    @klass.stub :file_ensure, mock do
      if                            entries_empty?
        Bootstrap.run
      else
        Bootstrap.stub :airstreams, entries do
          Bootstrap.run
        end
      end
    end
    mock.verify
    nil
  end

  def              it_calls_file_exist?
    entries_each do
      mock = ::Minitest::Mock.new
      expect_entry mock
      @klass.  stub        :file_exist?, mock do
        @klass.stub        :file_copy,   nil  do
          send_file_symbol :file_ensure
        end
      end
      mock.verify
    end
    nil
  end

  def       it_checks_existence_of_file
    filepath  = 'anywhere'
    mock_file = ::Minitest::Mock.new
    mock_file.expect :exist?, false,    [filepath]
    Object.  stub_const  :File,     mock_file     do
      @klass.stub        :file_filepath, filepath do
        send_file_symbol :file_exist?
      end
    end
    mock_file.verify
    nil
  end

  def     it_doesn_t_call_file_copy_when_it_has_that_file
    mock = Proc.new{flunk}
    @klass.  stub        :file_copy,   mock do
      @klass.stub        :file_exist?, true do
        send_file_symbol :file_ensure
      end
    end
    nil
  end

  def it_leaves_untouched_file_when_it_has_that_file
    entries_each do
      filepath = filepath_hot basename
    ::File.open( filepath, 'w'){|f| empty_it = 0; f.truncate empty_it}
      assert ::File.exist?                               filepath
# The syntax checker requires both levels of parentheses:
      @klass.stub(parent_dirname_method, (::File.dirname filepath)) do
        send_file_symbol :file_ensure
      end
      assert_equal '', (::IO.binread                     filepath)
# Remove that file, for other tests?
##    clear_hot_files
    end
    nil
  end

  def send_file_symbol(symbol)
    params   =        [symbol]
    @entry ||= ''
    params.push @entry unless entries_empty?
    @klass.send(*params)
  end

  def tag() entries_empty? ? '' : '_airstream' end
end
