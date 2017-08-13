### WordPress Deployment - incomplete

This has not been done and the information below is a draft.


#### Project Deployment Playbook: apps.yml

- WordPress Deployment Automation Process:
    - How will I differentiate between a clean install and a deployment?

    0. Is there any concept of first-time install in wp-cli? yes.
        - i will always want a base layer of plugins and theme on first time install
        - also need to consider node, bower, etc.
    1. add process for extracting latest.tar.gz wordpress files to directory variable
    2. fix permissions on latest.tar.gz
    3. add wp-config.php to template and abstract variables in jinja2
        - install wp-config on host
    4. delete wp-content directory, git install project wp-content directory
        - dependency: deploy project ssh key on remote machine
        - dependency: project must have a wp-content root. use submodules for themes and plugins
    5. create mysql database, user, pw
        - first time install: will generate db tables
        - deployment: deploy database from a remote host... i will need a datastore for this
            - install with wp-cli.phar import
    

#### WordPress deployment automation needs:

    - Install wp-cli.phar in bin and just use it from there... `$HOME/bin/wp-cli.phar`
        - Unless there is an ansible API for this
        - how much of wp-cli is idempotent?

    - Deploy: Existing Project
        - `https://wordpress.org/latest.tar.gz`
        - Initalize MySQL: username, password, database_name
            - Import database with wp_cli.phar
        - Project git repository
            - Originate in `/wp-contents/` to include plugins
        - Fresh `wp-config.php` with:
            - mysql username, password, database_name
            - salts
            - any project information
        - Add new apache2 config in `sites-available` and enable, restart apache2

    - Deploy: New Project
        - `https://wordpress.org/latest.tar.gz`
        - Initalize MySQL: username, password, database_name
        - Run first-time install
        - Initialize remote git repository in `wp-contents/`
            - Identify name of remote repository
            - Deploy sage, deploy all plugins
            - Perform initial commit and push
        - Fresh `wp-config.php` with:
            - mysql username, password, database_name
            - salts
            - any project information
        - Add new apache2 config in `sites-available` and enable, restart apache2
