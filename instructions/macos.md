
## macos first-time setup


### update macos

This installation guide begins with a mac which has already been signed out of `find my macbook` and all Apple services per [Apple's "How To Reinstall macOS" Guide](https://support.apple.com/en-us/HT204904)

1. Boot Mac in `Original OS Recovery Mode` which doesn't actually have a name: `Command+Option+shift+r`
    - recovers the OS your mac shipped with
1. `Disk Management & Encryption` - Use the Disk Utility
    1. wipe the disk
    1. create a single partition
        - Journaling, Encrypted
        - Do not use case sensitive (breaks Adobe apps, maybe others?)
    1. Disk Encryption: Use unique, strong password
    1. nb: if a partition is encrypted, you can't wipe the partition table
1. The Macbook Air 13" 2013(?) Internet Recovery installs `Mountain Lion`
    - This is because `cmd+opt+r` is internet recovery but recovers the current OS and `cmd+opt+shift+r` is the manufacturer original OS recovery
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
        - Update all software
    1. Set app store preferences: `System Preferences->App Store`
        - check 'automatically check for upates'
            - uncheck: all sub-checkboxes
            - definitely do not want apple installing stuff during the work day, they are getting very sloppy
    1. Update `macos` to the most recent version
        1. Disable sending diagnostics and crash reports
        1. Disable Siri
        1. Detect and install updates
        1. Turn on: `auto updates`
    1. restart the computer entirely
1. After Initial Setup
    1. Turn Location Services off!
        - `System Preferences`->`Security & Privacy`->`General`
            - Check: Require password `IMMEDIATELY` after sleep or screen saver begins
        - `System Preferences`->`Security & Privacy`->`Privacy`
            - Uncheck `Enable Location Services`
    1. Add iCloud Account: `System preferences`->`iCloud`
        - May have been optionally added during setup
        - Check: `Contacts`, `keychain`
        - Uncheck: `iCloud Drive`, `photos`, `calendars`, `mail`, `reminders`, `safari`, `notes`, `back to my mac`, `find my mac` 
    1. App: `messages`: 
        1. Make sure you are signed into your `apple account` on the laptop
        1. Make sure you have **enabled** your `iCloud account` on the laptop
        1. You should be prompted to enable your phone #, enter the code on your phone


### Add Ansible Dependencies & Deploy `macos.yml` Playbook 
    
1. The user is already able to use `sudo`
1. `Xcode Dev Tools`: Open `terminal` and type `xcode-select --install`
    - Apparently not strictly required for homebrew anymore
    - Possible necessary high sierra steps (homebrew did prompt to install xcode)
        1. Install xcode from app store (cli did not work)
        1. Inside xcode choose `XCode->Open Developer Tool->More Developer Tools
        1. login with apple and download 'Command Line Tools' for your macos AND xcode versions
            - There is a type for each macos+xcode pair of versions
            - e.g. "Command Line Tools (macOS 10.13) for Xcode 9.1"
        1. You may or may not need a restart in this process. I restarted but am not sure.
1. Homebrew - used for `python->pip->ansible` toolchain & gen. pkg management
    - install via one-liner at: [https://brew.sh](https://brew.sh)
1. `brew install python2 git`
1. Set up ssh access to github and bitbucket
    - `ssh-keygen`; Add key to bitbucket and github
    - You may also update your key from elsewhere
1. Make: `~/virtualenvs/`
    - `pip install virtualenv`
    - `mkdir ~/virtualenvs`
    - `git clone git@github.com:robbintt/pip.requirements`
    - `virtualenv ansible`
    - `. ansible/bin/activate`
    - `pip install ansible`
    - `ansible --version`
1. Make: `~/monolith/`
    - `mkdir ~/monolith/
    - `git clone git@github.com:robbintt/patternbook.git`
1. With the `ansible virtualenv` activated, run the `macos.yml` playbook


### Manual Configuration

This stuff needs done manually.

1. Open `safari` and go to `Safari->Preferences...`
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
        - `enable quick website search`, 
        - `preload top hit in background`, 
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
    1. uncheck: `Allow Handoff between this Mac and your iCloud devices`

1. `System Preferences->Notifications`
    1. Do this after setting up `chrome` and `messages`
    1. Select each item in the menu and choose `none` for alert style. Optionally turn off all check boxes.
    1. Be sure to do this for `iterm` and `messages` - both are super annoying

1. Add a better local hostname `apple menu->System Preferences->Sharing`
    1. Change the "Computer Name"
    1. Manually set the hostname
        - `sudo scutil --set HostName 'your-hostname'`
    1. `Shut Down` the computer, then power it on again
1. Install `fonts` from dotfiles
    - `cd ~/.dotfiles/fonts/`
    - `open .`
    - in finder, doubleclick each font and choose `install font`
1. Make home your finder default
    - Open `finder`->view
        - select `show path bar`
        - select `show status bar`
    - Open `finder -> finder preferences -> general`
        - check: `hard disks` - show disks on desktop
        - dropdown: `New finder windows show`:`<your home dir>`
        - uncheck: open folders in tabs instead of new windows
    - Open `finder -> finder preferences -> Sidebar`
        - check: `<your home directory>`, `Pictures`, `<all things in the devices category>`
        - uncheck: whatever you don't want to see...
    - Open `finder -> finder preferences -> advanced`
        - check: `show all filename extensions`, `keep folders on top when sorting by name`
        - when performing a search: search the current folder

1. Manage iterm2
    1. Make `iterm2` the default terminal
        - Open `iTerm2`, choose file->"Make iTerm2 the default terminal"
    1. Use a modern bash shell
        - Set BASH shell location (for homebrew bash) in `Profiles->General->Command`: `/usr/local/bin/bash`
        - Test your version: `echo $BASH_VERSION`
        - `preferences->appearance`: uncheck "show tab close buttons"
    1. Update `iterm2` default profile
        - Set font: `Droid Sans Mono 14`
        - Import colors: `~/.dotfiles/.config/solarized_highcontrast_dark.itermcolors`
        - Once imported, select `solarized highcontrast dark` from the dropdown
        - `Command+Shift+.` - view hidden files in open/close/finder
        - `Command+Shift+G` - type a path in open/close/finder
        - `Preferences->Profiles->Window` - set `transparency` slider slightly above zero. 
    1. `preferences->advanced1`
        - `Tabs: eliminate close button` set to `Yes`
1. Add a wallpaper: `System Preferences->Desktop & Screen Saver`
    1.  Add desktops until there are `4 desktops`
    1.  Add `~/.dotfiles/Wallpapers` as a source
    1.  For each desktop, add a wallpaper
    1.  Select the `Screensaver` tab and choose `Never`
1. Modify some System settings
    1. Keyboard: `System Preferences->Keyboard`
        1. `Modifier Keys...`
            - choose `control in the select box for the `Caps Lock` key
            - you will need to redo this for every keyboard you install
        1. Responsive Keyboard
            - key repeat: fast
            - delay until repeat: short
        1. Text input settings (apple quotes and period insert OFF)
            - uncheck `use smart quotes and dashes`
            - uncheck: `add period with double-space`
            - uncheck: `capitalize words automatically`
            - uncheck: `correct spelling automatically`
    1. Turn dock hiding on: `Command+Option+D`
    1. right click: `System Preferences->Trackpad`
        - "Look up & data detectors" - off, this gesture is taken by the app 'middleclick'
        - Secondary click: click in bottom right corner
        - Tap to click: enable
        - Tracking speed, 6 of 10 (left to right)
        - More Gestures: uncheck `swipe between pages`
    1. `System Preferences->Users and Groups`
        - Choose your user, select itunes and choose the - button to delete it
        - Turn middleclick on
        - If you have installed steam, you must disable it from starting up here
        - turn guest user off
        - This may be the default
    1. `Click battery->show percentage` (in the top bar)
    1. `System Preferences->Energy Saver`
            
        1. `Battery` tab:
            - Slider: `Turn display off after 5 minutes`
            - Turn on: `Put hard disks to sleep when possible`
            - Turn off: `Slightly dim the display on battery power`
            - Turn off: `Enable power nap`
        1. `Power Adapter` tab:
            - Slider: `Turn display off after 20 minutes`
            - Turn off: `Prevent computer from sleeping automatically when display is off`
            - Turn on: `Put hard disks to sleep when possible`
            - Turn off: `Wake for Wi-Fi network access`
            - Turn off: `Enable power nap`

    1. `System Preferences->Spotlight` - avoid search queries being sent to microsoft
        - uncheck: `Spotlight Suggestions`
        - uncheck: `Allow Spotlight Suggestions in Look up`
    1. `System Preferences->Displays` 
        - check: `scaled` resolution, choose the one above `Default`
        - uncheck: `Automatically adjust brightness`
    1. `System Preferences->Sound` 
        - uncheck: `Show volume in menu bar`
        - may be default now
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
        - `macdown->preferences->editor`: 
            - uncheck `Auto-increment numbering in ordered lists`
            - check `insert spaces instead of tabs`
            - check `scroll past end`

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
1. Start necessary services like `postgresql` and `mysql`; maybe `emacs service` in the future
    - Use `brew services list` to see available services.


##### XBox 360 Controller with keyboard and mouse emulation

This is used for whatever, primarily minecraft.

Games that support the XBox 360 controller can also hook into this.

1. Install the driver manually from [https://github.com/360Controller/360Controller#installation](https://github.com/360Controller/360Controller#installation)
2. Install ControllerMate
    - `brew cask install controllermate` 
    - optional: manual install from website (latest release?)
    - Add your license key from your email history
3. Add any configurations you need to controllermate
    - My configs should be in ~/.dotfiles/extra/
    - I modified a minecraft config from http://dig.ratbastards.org/post/29623068215/minecraft-on-the-mac-with-an-xbox-controller
    - note: the minecraft config requires the `system preferences->mouse` tracking speed be at the lowest (leftmost) setting.

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

1. Disable the dock (may need redone after update?)
    - `defaults write com.apple.dock tilesize -int 1`
    - `killall Dock`

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


