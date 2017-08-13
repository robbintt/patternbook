## Ubuntu 16.04 Desktop

Some disorganized install notes.

### Install Steps - read through all steps before install

1. Install `xubuntu x64 16.04 latest security release (16.04.3 currently)`
    - select 'install third party software for graphics... etc.'
    - select 'download updates while installing xubuntu'
    - ensure you are formatting the partition.
        - DO NOT install on an unformatted partition unless you have a specific plan for that.

2. Upgrade: 
    - `apt-get update && apt-get upgrade`
    - `apt install python-pip vim git python-apt libssl-dev`
    - system: `sudo pip install pip virtualenv --upgrade`
    - restart the computer

3. make ansible virtualenv `~/virtualenvs/ansible`
    - activate and `pip install ansible`

4. `ssh-keygen` - add key to github and bitbucket

5. Clone and run playbook: `patternbox.sh` / `patternbox.yml`
    - ON FIRST RUN: turn on `--ask-sudo-pass` in `patternbox.sh`

6. Manual installations
    - Slack only offers a versioned deb currently `slack-desktop-2.3.4-amd64.deb`
        - install the versioned deb for simplicity, for now
