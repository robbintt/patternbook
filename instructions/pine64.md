## Pine64 Pinebook

This refers to the pine64 ubuntu mate version that shipped installed in the firmware of the first release of the pinebook.

### Issues

- Installing these before installing ansible in a virtualenv allowed ansible to work:
    - `$ sudo apt install libffi-dev`
    - `$ sudo apt-get install libssl-dev`
- I manually created an adminuser equivalent to the one in the dotfiles role. This should probably be automated.
- nodejs section of playbook, I manually installed: `$ sudo apt install apt-transport-https`
- there is no `google-chrome-stable` candidate for amd64
