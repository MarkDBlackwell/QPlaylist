# coding: utf-8
require ::File.expand_path '../../test_helper', __FILE__

module ::QuickRadioPlaylist
end
module ::QuickRadioPlaylist::TestHelper
  include ::QuickRadioPlaylist

  private

  def call_trace(message,                    file)
     s = ::Kernel.caller.select{|e| e =~ /^#{file}/}.join "\n"
    "#{          message}\n#{s}\n"
  end

  def clear_hot_files() pattern = "#{filepath_hot ''}*"; ::File.delete(*(::Dir.glob pattern)); nil end

  def dot() '.' end

  def file_copy(     f_in, f_out)
# Disallow conversion of line-ending characters:
    s = ::IO.binread f_in
    ::IO.    binwrite      f_out, s
    nil
  end

  def file_copy_hot(      dirname, basename)
    file_copy ::File.join(dirname, basename),
               (filepath_hot       basename)
    nil
  end

  def filepath_hot(basename) ::File.join 'test', 'var', basename end

  def fixture() ::File.join(*%w[test fixture]) end

  def program_name() 'QuickRadioPlaylist' end

  def underscore() '_' end
end
