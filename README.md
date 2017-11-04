# spaghettiprogramming.com

Simple blog application that I wrote for learning, testing out new things, and fun.


## Features

The spaghettiprogramming.com blog has some useful features:

* Simple admin login through has_secure_password
* Attach images to blog posts which are auto resized for you using the excellent paperclip gem.
* Attach any other type of files to a blog post, also courtesy of paperclip.
* You can specify a permalink / slug for nice looking urls or it will auto generate one based on title of blog post.
* Can have non public blog posts for articles you are working on, or just don't want people to see.
* Can use markdown in blog posts which will get rendered and formatted nicely.

## Dependencies and Versions

* Ruby 2.4.2
* Rails 4.2.10
* PostgreSQL 9.x
* Chef 13.5.3

## Test Suite

This application contains a test suite written with rspec.  To run the test suite simple run:

     rspec spec

## Setup and Configuration

### Clone the repository

    git clone git@github.com:MatthewRamirez/spaghettiprogramming.com.git

### Create configuration files
Certain config files are not in this git repository and you must make your own:

* config/database.yml
* config/application_config.yml
* config/secrets.yml

These files are managed through chef.  See `config/provision`

## Deployment instructions

### Provision a Server ###

*One-time setup*

Must use this specific version of `knife-solo` to make it work with `net-ssh` versions >= 4.x.

```bash
gem install knife-solo --pre
```

In `/etc/hosts` on your development machine add the line similar to:

`192.168.1.20 spaghettiprogramming-server`

Ensure to change the values if needed.

Add your public key to root's authorized keys on the server.

Update the remote server:

```bash
apt-get update; DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew"
```

Run locally in development environment:
```bash
cd config/provision
librarian-chef install
knife solo prepare --bootstrap-version=13.5.3 root@spaghettiprogramming-server
```

*After cookbook updates*

```bash
cd config/provision
knife solo cook root@spaghettiprogramming-server
```

This will run the role called `spaghettiprogramming` to provision the server.

Run remotely on production environment:

```bash
createdb spaghettiprogramming_production
```

Then in the `spaghettiprogramming_production` database:
```
create role spaghettiprogramming with unencrypted password 'thepassword' login;
alter database spaghettiprogramming_production owner to spaghettiprogramming
```

You can find the password by checking the production `database.yml` or by running `knife solo data bag show web_server database` in development environment.

### SSH
In the `/etc/ssh/sshd_config` of the deplyment destination comment out or remove the following:

`AcceptEnv LANG LC_*`

This prevents ssh clients from potentially sending incompatible locale environment variables.  Some VPS providers have set this while others have not.

### Bundler

Installer the bundler gem as the deploy user on the destination server.

```bash
sudo su - deploy
chruby 2.4.2
gem install bundle
```

### Deploy the Application ###

```bash
cap production deploy
```

A default bundle config file may get created in `/home/deploy/.bundle/config` on the production server with the content:

``
    BUNDLE_BIN: bin
    BUNDLE_SHEBANG: chruby-exec
    BUNDLE_DISABLE_SHARED_GEMS: '1'
    BUNDLE_PATH: vendor

``

This causes the following exception when deploying via `bundle exec cap production deploy`:

``
00:05 bundler:install
      01 /usr/local/bin/chruby-exec 2.4.2 -- bundle install --path /u/apps/intranet/shared/bundle --without development test --deployment
      01 /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/yaml_serializer.rb:67:in `block in load': undefined method `[]=' for nil:NilClass (NoMethodError)
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/yaml_serializer.rb:55:in `each'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/yaml_serializer.rb:55:in `load'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/settings.rb:408:in `block in load_config'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/shared_helpers.rb:118:in `filesystem_access'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/settings.rb:404:in `load_config'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/settings.rb:80:in `initialize'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler.rb:257:in `new'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler.rb:257:in `settings'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/env.rb:20:in `report'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/friendly_errors.rb:96:in `request_issue_report_for'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/friendly_errors.rb:46:in `log_error'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/friendly_errors.rb:126:in `rescue in with_friendly_errors'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/lib/bundler/friendly_errors.rb:122:in `with_friendly_errors'
      01  from /opt/rubies/ruby-2.4.2/lib/ruby/gems/2.4.0/gems/bundler-1.16.0/exe/bundle:22:in `<top (required)>'
      01  from /opt/rubies/ruby-2.4.2/bin/bundle:23:in `load'
      01  from /opt/rubies/ruby-2.4.2/bin/bundle:23:in `<main>'
``

To remedy this, remove the file `/home/deploy/.bundle/config`.

## Backups

The application database and files uploaded via paperclip are backed up in `/var/backups/application`.
