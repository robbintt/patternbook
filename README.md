
## Ansible Playbooks

These playbooks all have supporting shell scripts that supply their arguments.


### Enhance playbooks with ninite.com 

From Kelly Albrink: [ninite.com](https://ninite.com/)

### dotfiles role is slightly busted and needs some one-time steps

1. Must use deploy key with private repo to ensure it is available during deployment.
    - Remove old deploy key for private dotfiles from git host and ansible repo
    - Generate new deploy key for private repo
    - Add deploy key to private repo and dotfiles role
    - Test new dotfiles deploy role locally (patternbox) before deploying across all servers
1. One-time: delete old dotfiles directories from all hosts, then install new dotfiles with playbook.


### List of Vaulted Files

Ansible does not track these, so track them here.

1. `common/files/dotfiles_deploy_rsa`


### How to get hosts?

Each shell script could use a separate hosts file or you could just use one, depending on the complexity. 

Optional: you can specify the path to the hosts file in each shell script
Optional: Symlink your hosts from files that aren't in this repo; no need to commit specific hosts files.
Optional: add any hosts symlinks to gitignore.


#### Todo Components


##### Urgent

1. make sure no competing lines are in the sudoers role
1. Review [Best Practices](http://docs.ansible.com/ansible/playbooks_best_practices.html)
1. Move adminuser variable into a variables file in a vault file
1. Move ssh key path into variable file in a vault file
1. Move dotfiles paths into variables file in a vault file
1. Can the deploy key just be a variable instead of a file?


##### Future

- pip role should regenerate virtualenvs for that device, if necessary
- rebooter isn't working for some reason. The sleep command probably needs to be a shell...
    - See if you can move the `restart wait_for` to a `handler` so it doesn't always hang 15 seconds.
    - or add a `when` condition?
- set [tzdata](https://gist.github.com/jerm/fc7f33f6a6d6534f6fde)!! already did this on some hosts so make it idempotent.
- consider moving all `vars` to [external_vars file](http://docs.ansible.com/ansible/playbooks_variables.html#variable-file-separation)
- Move /etc/sudoers config file to source control?
- A wordpress and sage theme/plugin base install is a nice to have: `wp-base`
- use a vault secret in a file, e.g. `vault.secret` outside of source control
- Rebuild ~/virtualenv virtualenvs automatically?
- See about Ansible on Python 3
    - potentially remove the Python 2 raw installation on Ubuntu 16.04 LTS


##### Using Ansible Vault

- Encrypt a file: `ansible-vault encrypt foo.yml bar.yml baz.yml`
- Decrypt a file: `ansible-vault decrypt foo.yml bar.yml baz.yml`
- View Contents: `ansible-vault view foo.yml bar.yml baz.yml`
- Run Playbook w/ Vault: `ansible-playbook site.yml --ask-vault-pass`
- Speed up Vault: `pip install cryptography`
    - this goes in your ansible virtualenv, needs dependencies installed locally though 


#### References

- [YAML Syntax Details](http://docs.ansible.com/ansible/YAMLSyntax.html)

- [Ansible Homebrew](http://docs.ansible.com/ansible/homebrew_module.html) exists...

- Ansible Modules Used:
    - [Apt](http://docs.ansible.com/ansible/apt_module.html)
    - [User](http://docs.ansible.com/ansible/user_module.html)
    - [Command](http://docs.ansible.com/ansible/command_module.html#command)
    - [Shell](http://docs.ansible.com/ansible/shell_module.html)
    - [Raw](http://docs.ansible.com/ansible/raw_module.html)
    - [lineinfile](http://docs.ansible.com/ansible/lineinfile_module.html)
    - [apache2_module](http://docs.ansible.com/ansible/apache2_module_module.html)
    - [Vault](http://docs.ansible.com/ansible/playbooks_vault.html)
    - [Copy](http://docs.ansible.com/ansible/copy_module.html)
    - [Git](http://docs.ansible.com/ansible/git_module.html)
    - [Become](http://docs.ansible.com/ansible/become.html)
    - [mysql_user](http://docs.ansible.com/ansible/mysql_user_module.html)
    - [get_url](http://docs.ansible.com/ansible/get_url_module.html)
    - [unarchive](http://docs.ansible.com/ansible/unarchive_module.html)

- [YAML Syntax](http://docs.ansible.com/ansible/YAMLSyntax.html)
- [Patterns](http://docs.ansible.com/ansible/intro_patterns.html) - decide which hosts to manage
    - grep for this to see a good example in a task
- [Best Practices](http://docs.ansible.com/ansible/playbooks_best_practices.html)
