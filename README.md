# QPlaylist

Welcome to QPlaylist!

A 64-bit Windows Ruby gem that provides customizable, live lists of
multiple streams of recent songs and includes them on website(s), for
any radio station which uses WideOrbit automation software.

Prerequisites:
1. WideOrbit Automation (which version?);
1. Windows operating system (NT family);
1. Windows 7 (maybe);
1. Rubyinstaller.org's "rubyinstaller-2.2.4-x64.exe", which is Ruby
version 2.2.4p230 (2015-12-16 revision 53155) [x64-mingw32] (exactly);
1. Rubyinstaller.org's Ruby Installer Development Kit, version
"DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe" (exactly);
1. Rubygems, version 2.6.4 (exactly);
1. Gem bundler, version 1.12.5 (exactly);

## Installation

I. Install Ruby

Install it into:
C:\progra\ruby-2.2.4-p230-x64

Uncheck:
1. Install Tcl/Tk support
1. Add Ruby executables to your PATH
1. Associate .rb and .rbw files with this Ruby installation

Add to PATH:
C:\progra\ruby-2.2.4-p230-x64\bin

Verify the following command reports the required version (of Ruby):
"2.2.4p230 (2015-12-16 revision 53155) [x64-mingw32]":

> ruby --version

II. Update Rubygems certificate

Navigate to http://guides.rubygems.org/ssl-certificate-update/

and see its section: "Installing using update packages".

However, instead download:
https://rubygems.org/downloads/rubygems-update-2.6.4.gem

Put it somewhere, e.g. C:\Install\tiny

> cd \Install\tiny
> gem install --local rubygems-update-2.6.4.gem
> update_rubygems --no-ri --no-rdoc

Verify the following command reports the required version (of Rubygems): "2.6.4":

> gem --version

III. Install Bundler

Install the required version of the Bundler gem:

> gem install bundler -v "1.12.5"

IV. Install Ruby Development Kit

Extract to:
C:\progra\ruby-DevKit-mingw64-64-4.7.2-20130224-1432

Set up the Development Kit (see also the instructions here):

https://github.com/oneclick/rubyinstaller/wiki/Development-Kit

> cd \progra\ruby-DevKit-mingw64-64-4.7.2-20130224-1432
> ruby dk.rb init

Ensure config.yml, below the "---" line, including the hyphen and space, contains exactly:

- C:/progra/ruby-2.2.4-p230-x64

> ruby dk.rb install


V. Obtain QPlaylist

    $ git clone {some URL}
    $ cd QPlaylist

And then execute:

    $ bundle

Further installation instructions:

The entire directory should be installed on a user's computer
(not on the WideOrbit server computer).

On the WideOrbit server, the user must create
another directory: 'NowPlaying'.

Inside this, they must place an HTML template file.
(Please see example file, 'template-sample.html'.)

Also, in it they may place a file of FTP commands
(if they cannot FTP to the webserver from their own, user computer).

BTW, WideOrbit is a large software system
used in radio station automation.

This program, along with its input and output files,
and a Windows batch file, all reside in the same directory.

The program converts the desired information
(about whatever song is now playing)
from a certain XML file format,
produced by WideOrbit,
into an HTML format, suitable for an
[iframe](https://en.wikipedia.org/w/index.php?title=HTML_element&oldid=714622443#Frames)
embedded in your radio station's webpage.

The program reads an HTML template file,
substitutes the XML file's information into it,
and thereby produces its output HTML file.

Required gems:
mustache
xml-simple

Which Ruby versions supported?

Known to work on Ruby
ruby 2.0.0p353 (2013-11-22) [x64-mingw32]

Go to https://www.ruby-lang.org . Click the top tab, 'Downloads'.

Search down for 'Windows' and 'RubyInstaller'.
Go there and then click the Download button.

On the resulting page, click (to download) the latest (highest-numbered)
Ruby 2.0.0 version, with 'x64' only if you're running on a 64-bit machine.

Once Ruby is installed (successfully), do this for each of the required gems, mentioned above:

gem install {gem name}

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow
you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/markdblackwell/quick_radio_playlist.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [GPL-3
License](https://opensource.org/licenses/GPL-3.0).
