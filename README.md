# README

### Requirements

* Ruby 2.3.0

* Rails 5.0

* Postgres database

### Installation:

* Install Ruby 2.3.0 interpreter (for example with rbenv)

* Install bundler gem
    > gem install bundler

* Install required Ruby libraries
    > bundle install

* Set database configuration in database.yml

* Create database
    > rake db:create && rake db:migrate

* Install required JS libraries
    > rake bower:install
