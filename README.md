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

* Ruby 2.2.2
* Rails 4.2.3
* PostgreSQL 9.x

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

In `/etc/hosts` on your development machine add the line similar to:

`192.168.1.20 spaghettiprogramming-server`

Ensure to change the values if needed.

Add your public key to root's authorized keys on the production support server.

```bash
cd config/provision
librarian-chef install
knife solo prepare root@spaghettiprogramming-server
```

*After cookbook updates*

```bash
cd config/provision
knife solo cook root@spaghettiprogramming-server
```

This will run the role called `spaghettiprogramming` to provision the server.

### Deploy the Application ###

```bash
cap production deploy
```

## Backups

The application database and files uploaded via paperclip are backed up in `/var/backups/spaghettiprogramming`.
