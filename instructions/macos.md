
## macos first-time setup


### update macos

This installation guide begins with a mac which has already been signed out of `find my macbook` and all Apple services per [Apple's "How To Reinstall macOS" Guide](https://support.apple.com/en-us/HT204904)

1. Boot Mac in `Internet Recovery Mode`: `Command+Option+r`
1. `Disk Management & Encryption` - Use the Disk Utility
    1. wipe the disk
    1. create a single partition
        - Journaling, Encrypted
        - Do not use case sensitive (breaks Adobe apps, maybe others?)
    1. Disk Encryption: Use unique, strong password
    1. nb: if a partition is encrypted, you can't wipe the partition table
1. The Macbook Air 13" 2013(?) Internet Recovery installs `Mountain Lion`
    - When this was repeated in 2017, internet recovery installed the current OS, `Sierra`
    - However on the same day in 2017, a different laptop whose drive was repartitioned entirely installed `Mountain Lion`. It may depend on if the mac is registered to an `apple id`
    - The `Sierra`-recovery mac was definitely registered to my `apple id`
    - I should check if the `Mountain Lion` mac is registered to an `apple id`
1. Initial Setup: OS Upgrade & Accounts
    1. Do add your `apple account` and `iCloud account` to simplify integrations
    1. local account creation
        - if necessary: add this `username` to ansible role `dotfilesuser` variables
    1. Top Menu => Apple Symbol => Software Update
        - If the icon is not there, go to the `App Store` and choose `Updates`
    1. Update `macos` to the most recent version
        1. Disable sending diagnostics and crash reports
        1. Disable Siri
        1. Detect and install updates
        1. Turn on: `auto updates`
    1. restart the computer entirely
1. After Initial Setup
    1. Turn Location Services off!
        - `System Preferences`->`Security & Privacy`->`Privacy`
        - Uncheck `Enable Location Services`
    1. Add iCloud Account: `System preferences`->`iCloud`
        - May have been optionally added during setup
        - Check: `Contacts`
        - Uncheck: `iCloud Drive`, `photos`, `calendars`, `mail`, `reminders`, `safari`, `notes`, `keychain`, `back to my mac`, `find my mac` 
    1. App: `messages`: 
        1. Make sure you are signed into your `apple account` on the laptop
        1. Make sure you have **enabled** your `iCloud account` on the laptop
        1. You should be prompted to enable your phone #, enter the code on your phone


### Add Ansible Dependencies & Deploy `macos.yml` Playbook 
    
1. The user is already able to use `sudo`
1. `Xcode Dev Tools`: Open `terminal` and type `xcode-select --install`
    - Apparently not strictly required for homebrew anymore
1. Homebrew - used for `python->pip->ansible` toolchain & gen. pkg management
    - install via one-liner at: [http://brew.sh](http://brew.sh)
1. `brew install python git`
1. Set up ssh access to github and bitbucket
    - `ssh-keygen`; Add key to bitbucket and github
    - You may also update your key from elsewhere
1. Make: `~/virtualenvs/`
    - `pip2 install virtualenv`
    - `mkdir ~/virtualenvs`
    - `git clone git@github.com:robbintt/pip.virtualenvs`
    - `virtualenv ansible`
    - `. ansible/bin/activate`
    - `pip install ansible`
    - `ansible --version`
1. Make: `~/monolith/`
    - `mkdir ~/monolith/
    - `git clone git@bitbucket.org:robbintt/patternbook.git`
1. With the `ansible virtualenv` activated, run the `macos.yml` playbook


### Manual Configuration

This stuff needs done manually.

1. Open `safari` and go to `File->Preferences...`
    - tab: `General`
        - Safari opens with: `a new private window`
        - new windows open with: `Empty Page`
        - new tabs open with: `Empty Page`
        - homepage: `about:blank`
        - remove history items: `after one day`
        - remove download list items: `Manually`
        - uncheck: `open 'safe' files after downloading`
    - tab: `Autofill`
        - uncheck: **everything**
    - tab: `Search` uncheck:
        - `include search engine suggestions`, 
        - `include Safari suggestions`, 
        - `enable quick website search`, `preload top hit in background`, 
        - `show favorites`
    - tab: `Security`
        - uncheck: `Allow WebGL`, `Allow Plug-ins`
    - tab: `Privacy`
        - check: `Ask websites not to track me`
        - uncheck: `Allow websites to check if Apple Pay is set up`
        - Website use of location services: `deny without prompting`
            - automatically off if you turned location services off
    - tab: `Notifications`
        - uncheck: `Allow websites to ask for permissions to send push notifications`
    - tab: `Advanced`
        - check: `Show full website addresses`, `Show Develop menu in menu bar`
    - Quit safari, the next time you (accidentally) open it will be in a `private session`

1. `System Preferences->Date & Time->Clock`
    1. Check: "use a 24 hour clock"
    1. Check: "show the date of the week"
    1. Check: "show the date"

1. `System Preferences->General`
    1. `Default Web Browser`: Google Chrome

1. `System Preferences->Notifications`
    1. Do this after setting up `chrome` and `messages`
    1. Select each item in the menu and choose `none` for alert style. Optionally turn off all check boxes.

1. Add a better local hostname `apple menu->System Preferences->Sharing`
    1. Change the "Computer Name"
    1. Manually set the hostname
        - `sudo scutil --set HostName 'your-hostname'`
    1. `Shut Down` the computer, then power it on again
1. Install `fonts` from dotfiles
    - `cd ~/.dotfiles/fonts/`
    - `open .`
    - in finder, doubleclick each font and choose `install font`
1. Manage iterm2
    1. Make `iterm2` the default terminal
        - Open `iTerm2`, choose file->"Make iTerm2 the default terminal"
    1. Use a modern bash shell
        - Set BASH shell location (for homebrew bash) in `Profiles->General->Command`: `/usr/local/bin/bash`
        - Test your version: `echo $BASH_VERSION`
    1. Update `iterm2` default profile
        - Set font: `Droid Sans Mono 16`
        - Import colors: `~/.dotfiles/.config/solarized_highcontrast_dark.itermcolors`
        - Once imported, select `solarized highcontrast dark` from the dropdown
        - `Command+Shift+.` - view hidden files in open/close/finder
        - `Command+Shift+G` - type a path in open/close/finder
        - `Preferences->Profiles->Window` - set `transparency` slider slightly above zero. 
1. Add a wallpaper: `System Preferences->Desktop & Screen Saver`
    1.  Add desktops until there are `4 desktops`
    1.  Add `~/.dotfiles/Wallpapers` as a source
    1.  For each desktop, add a wallpaper
1. Modify some System settings
    1. Responsive Keyboard: `System Preferences->Keyboard`
        - key repeat: fast
        - delay until repeat: short
    1. Turn dock hiding on: `Command+Option+D`
    1. right click: `System Preferences->Trackpad`
        - "Look up & data detectors" - off, this gesture is taken by the app 'middleclick'
        - Secondary click: click in bottom right corner
        - Tap to click: enable
        - Tracking speed, 6 of 10 (left to right)
    1. turn guest user off: `System Preferences->Users and Groups`
        - Turn guest user off
        - This may be the default
    1. `Click battery->show percentage` (in the top bar)
    1. `System Preferences->Energy Saver`
        - Turn off `power nap` on both tabs: `battery` and `power adapter`
        - Turn off `wake for wifi network access`
    1. `System Preferences->Spotlight` - avoid search queries being sent to microsoft
        - uncheck: `Spotlight Suggestions`
        - uncheck: `Allow Spotlight Suggestions in Look up`
    1. `System Preferences->Displays` 
        - uncheck: `Automatically adjust brightness`
    1. `System Preferences->Sound` 
        - uncheck: `Show volume in menu bar`
        - may be default now
1. Open `Karabiner-Elements`
    - remap: `capslock` `->` `left_control`
    - remap:
    - remap:
1. Manually manage the dock
    1. Items to add to the dock
        - Chrome
        - iterm2
        - Digital Color Meter
    1. Other options
        - Finder must be removed with a system setting
        - If more system settings are worth changing, consider this
1. Perform `first-time configurations` 
    - spectacle 
        - follow the `accessibility` dialog for first-time setup
        - enable 'Launch Spectacle at login'
        - press the > arrow on the bottom right
            - choose `Run: as a background application`
            - Select: "do not show this message again"
    - flux 
        - set location
        - choose `classic flux` colors
        - enable 'start f.lux at login'
    - keepassx
        - transfer the `database` and `key` files
        - open keepassx and test
    - slack
        - login to teams
        - what teams am I even on?

    - tunnelblick
        - enable 'launch at login'
        - Connect: "When Tunnelblick launches"
        - add `ovpn` file; connect with `user/password`
    - google chrome
        - Add account to google
        - Add sync password
        - Turn off download offline google documents...
        - Ensure sync features are right
        - Extensions: Freshstart, uBlock Origin, cVim
    - macdown
        - `macdown->preferences->editor`: uncheck `Auto-increment numbering in ordered lists`
        


1. Unspecified `first-time configurations`
    - etc... this should just refer me to the install roles to simplify things...
    - firefox
    - inkscape
    - gimp
    - vlc    
    - steam
    - sublime-text
    - docker
1. Manually installed: 
    - Citrix GoToMeeting: `Citrix Online Launcher.dmg`
    - Autodesk Meshmixer
    - [macos FTDI drivers](http://www.ftdichip.com/Drivers/VCP.htm)
    - Adobe Products?
    - Google Web Designer
    - Image Editor
    - Flycut
1. Set up SparkleShare projects as needed


#### Future

1. Automatically manage dock. Remove everything, add the basics I end up with after a few weeks: [manage dock as a file](http://hints.macworld.com/article.php?story=20090523192819542)
1. Incorporate this generic, idempotent process for installing from dmg:
    - [Generic .dmg Installer](https://github.com/sandstorm/macosx-with-ansible/blob/master/tasks/dmg-install.yml)
    - Only problem: if the package does not auto update, document it here and manually manage it.


##### Idea: Manage a controlled version of `dmg` files

This isn't really necessary because most everything is currently installed with `brew cask`

1. Consider storing local copies of `dmg` files
    - installed via ansible if possible
    - [Possible Route](https://github.com/MWGriffin/ansible-playbooks/blob/master/install/dmg.yaml)
    - [Another Playbook with great pattern for installing apps](https://github.com/mpereira/macbook-playbook/blob/master/roles/google-chrome/tasks/main.yml)


##### Manage the Dock

1. [Manage orientation and settings](https://github.com/ultimateboy/ansible.osx/blob/master/roles/ultimateboy.osxdefaults/tasks/dock.yml)
1. [Even more dock settings](http://www.makeuseof.com/tag/customise-mac-os-x-dock-hidden-terminal-commands/)
1. How do i manage apps in the dock?


#### Testing playbooks with virtualbox and macos images

1. This [repo](https://github.com/geerlingguy/mac-dev-playbook) gives [instructions](https://github.com/geerlingguy/macos-virtualbox-vm) and recommendations for how to test a playbook for osx desktop. It also has some ideas and patterns that are worth looking at.
1. Need to used bridged internet to give the mac virtualized wifi through virtualbox
1. Need to mount the virtual drive and format it
1. After install be sure to unmount the install iso image
1. Used `brew cask install virtualbox-extension-pack` to try to get wifi
    - Didn't work, github issue out for getting networking up


#### Macos References

1. Using Ansible with: cask, tap
    - [Cask](https://caskroom.github.io/)
    - [Ansible Cask](http://docs.ansible.com/ansible/homebrew_cask_module.html)
    - [Tap](http://docs.ansible.com/ansible/homebrew_tap_module.html) 


