# coding: utf-8
require ::File.expand_path '../test_helper', __FILE__

require 'minitest/mock'
require 'quick_radio_playlist/run'

class ::QuickRadioPlaylist::RunTest < ::Minitest::Test
  include ::QuickRadioPlaylist
  include TestHelper

  def test_it_processes_files_correctly
#   (%w[sixth].product %w[simple]).
#   (%w[second].product %w[simple]).
#   (%w[first].product %w[simple]).
    (%w[first second sixth].product %w[simple complex]).
                    each do |ordinal,                complexity|
      next unless 'sixth' == ordinal if 'complex' == complexity
      clear_hot_files
      gather_files_ephemeral ordinal,                complexity
      gather_files_static
      ensure_files_empty     ordinal
      playlist_run
      assert_files_all       ordinal,                complexity
    end
  end

  private

  def add_ext(a, extension) a.map{|e| "#{e}.#{extension}"} end

  def assert_extension_hot(dirname, names, extension)
    add_ext(                        names, extension).
                           each do |basename|
      assert_file_same_hot dirname, basename
    end
    nil
  end

  def assert_file_same( name1,         name2)
    message = "Files '#{name1}' and '#{name2}' are not identical."
# Disallow conversion of line-ending characters:
    s1, s2  =          [name1,         name2].map{|e| ::IO.binread e}
    assert s1 == s2, (call_trace message, __FILE__)
    nil
  end

  def assert_file_same_hot(dirname, basename)
    assert_file_same filepath_hot(  basename),
         (::File.join      dirname, basename)
    nil
  end

  def assert_files_all(        ordinal, complexity)
    assert_files_html_multiple ordinal, complexity
    assert_files_txt           ordinal
    assert_files_static
    nil
  end

  def assert_files_html(   ordinal, complexity)
    dirname = ::File.join fixture,
                 'output', ordinal, complexity
    names = if 'common' == ordinal
      %w[now_playing]
    else
      %w[latest_five  recent_songs]
    end
    assert_extension_hot dirname, names, 'html'
    nil
  end

  def assert_files_html_multiple(ordinal, complexity)
    assert_files_html           'common', complexity
    assert_files_html            ordinal, complexity
    nil
  end

  def assert_files_static
    dirname = ::File.join fixture, *%w[output common]
    names = %w[current_hour  now_playing]
    assert_extension_hot dirname, names, 'txt'
    nil
  end

  def assert_files_txt(                      ordinal)
    dirname = ::File.join fixture, 'output', ordinal, 'common'
    names = %w[recent_songs]
    assert_extension_hot dirname, names, 'txt'
    nil
  end

  def ensure_files_empty(    ordinal)
    return unless 'first' == ordinal
    a = %w[current_hour  now_playing  recent_songs]
    add_ext(a, 'txt'    ).each do |basename|
      f = ::File.stat filepath_hot basename
      ::Kernel.abort unless f.file?
      ::Kernel.abort unless 0 == f.size
    end
    nil
  end

  def gather_current_hour(ordinal)
    s = ('first' ==       ordinal) ? '' : "2010 09 08 06\n"
    ::IO.binwrite filepath_hot('current_hour.txt'), s
    nil
  end

  def gather_current_song(ordinal)
    s = ('first' ==       ordinal) ? '' : recent_songs.last
    ::IO.binwrite filepath_hot('now_playing.txt'), s
    nil
  end

  def gather_files_ephemeral(ordinal, complexity)
    gather_files_mustache             complexity
    gather_files_txt         ordinal
    nil
  end

  def gather_files_mustache(complexity)
    a = %w[latest_five  now_playing  recent_songs]
    add_ext(a, 'mustache'     ).each do |basename|
      file_copy_hot ::File.join(
          fixture, 'input', complexity), basename
    end
    nil
  end

  def gather_files_static
    %w[now_playing.xml].each do |basename|
      file_copy_hot ::File.join(fixture,
             *%w[input common]), basename
    end
    nil
  end

  def gather_files_txt( ordinal)
    gather_current_hour ordinal
    gather_current_song ordinal
    gather_recent_songs ordinal
    nil
  end

  def gather_recent_songs(ordinal)
    beyond_songs_to_write = 5
    first_song_to_write =
        %w[         first         second  sixth ].zip(
          [ beyond_songs_to_write,  4,      0   ]).
                   assoc(ordinal).last
    s = recent_songs.slice(
              first_song_to_write...
            beyond_songs_to_write).join ''
    ::IO.binwrite filepath_hot('recent_songs.txt'), s
    nil
  end

  def in_test_directory
# Discard the parameter passed to the block:
    ::Dir.chdir('test/'){yield}
    nil
  end

  def mock_time_now() ::Time.stub(:now, (::Time.new 2010, 9, 8, 7, 6, 29).localtime){yield} end

  def playlist_run
    in_test_directory do
      mock_time_now{Run.run}
    end
    nil
  end

  def recent_songs
    @recent_songs ||= begin
      song_size_lines = 4
      filepath = ::File.join fixture, *%w[input  common  recent_songs.txt]
      ((::IO.readlines filepath).each_slice song_size_lines).to_a
    end
  end
end
