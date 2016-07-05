# coding: utf-8
require 'os'
require 'quick_radio_playlist/bootstrap_configuration_airstream'
require 'quick_radio_playlist/bootstrap_configuration_user'
require 'quick_radio_playlist/error'

=begin

Bootstrapping means running an executable in the gem, which, in order:

1. Verifies it's running on Windows. Then, it:

2. Checks for a QuickRadioPlaylist configuration file specific to the 
Windows user.

Unless this already exists, it:

3. Copies it from the folder of samples. Then, it:

4. Checks therein, for a specification of the radio station's website 
domain name, along with its FTP username and password.

If all these already are specified, then it:

5. Checks therein, for a specification (in a list) of the radio 
station's airstreams.

If this list already is specified, then under a fixed filesystem 
location, it:

6. Ensures the existence of a folder for each radio airstream, and under 
it, a complete folder subtree. Then, under each, it:

7. Checks for a configuration file specific to the airstream.

Unless this file already exists, it:

8. Copies it from the folder of samples. Then, it:

9. Checks, within each airstream's configuration file, for a 
specification of the locations of the required mustache files.

If all these locations already are specified, then it:

10. Checks for their existence.

If all these already exist, then it:

11. Checks for the existence of a recent_songs.txt file, and stops 
(while printing an appropriate message) if it doesn't exist. (This is to 
prevent a loss of data, if one already exists, somewhere.)

Then, it:

12. Checks for the existence of its own Windows service.

If it doesn't exist, then it:

13. Creates its Windows service. Then, it:

14. Starts its Windows service.

=end

module ::QuickRadioPlaylist
  module Bootstrap
    extend self

    def run
      verify_windows
      \
                          BootstrapConfigurationUser.     file_ensure
      airstreams.each{|e| BootstrapConfigurationAirstream.file_ensure e}
      nil
    end

    private

    def airstreams() [] end

    def verify_windows() raise PlatformNotSupportedError unless ::OS.windows?; nil end
  end
end

