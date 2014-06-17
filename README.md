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

* Ruby 2.1.2
* Rails 4.1.1
* PostgreSQL 9.1.13

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

#### database.yml
    development:
      adapter: postgresql
      encoding: utf8
      database: development_database
      port: 5432
      pool: 5
      timeout: 5000

    test:
      adapter: postgresql
      encoding: utf8
      database: test_database
      port: 5432
      pool: 5
      timeout: 5000

    production:
      adapter: postgresql
      encoding: utf8
      database: production_database
      username: username
      password: password
      port: 5432
      pool: 5
      timeout: 5000

#### application_config.yml

    development:
      GA_ACCOUNT: google analytics property account number
      SECRET_TOKEN: development_secret_token_for_session
      PAPERCLIP_HASH_SECRET: development_secret_token_for_paperclip_obfuscation

    test:
      GA_ACCOUNT: google analytics property account number
      SECRET_TOKEN: test_secret_token_for_session
      PAPERCLIP_HASH_SECRET: test_secret_token_for_paperclip_obfuscation

    production:
      GA_ACCOUNT: google analytics property account number
      SECRET_TOKEN: production_secret_token_for_session
      PAPERCLIP_HASH_SECRET: production_secret_token_for_paperclip_obfuscation
