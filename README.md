# CanCanRight - Database driven rules for CanCan

[![Build Status](https://travis-ci.org/sealink/cancanright.svg?branch=master)](https://travis-ci.org/sealink/cancanright)

In order to allow for flexible and fine-grained access control across a large application it may
be useful to mange your CanCan abilities in your application's database. With CanCanRight users
are assigned many Roles which have many Rights. Rights represent CanCan rules.

CanCanRight is built for Rails 3+


## Installation

Add this to your Gemfile:

    gem 'cancanright'

and run the `bundle install` command.


## Getting Started

CanCanRight extends upon CanCan's features. It expects a `current_user` method to exist in the
controller. For information on getting started with CanCan please visit the
[CanCanCan Wiki](https://github.com/CanCanCommunity/cancancan/wiki).


## Defining Abilities

User permissions are defined in an `Ability` class. CanCanRight includes a Rails generator for
creating this class.

    rails g cancanright:ability

This creates an Ability class with an example of how to create CanCan Rules from Rights.
Additionally all of the existing CanCan features for defining abilities are available. See
[Defining Abilities](https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities) for
details.


## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec`
to run the tests.


## Contributing

If you find a bug please add an [issue on GitHub](https://github.com/sealink/cancanright/issues)
or fork the project and send a pull request. This project is intended to be a safe, welcoming
space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.
