# Salt::Host

Salt::Host is a set of classes to aid in using Salt as a configurator in Vagrant.  Though salt is a built-in configurator, using it is very messy, involving repeated code, blocks of assignments and configuration that is so very not DRY.  These classes are an attempt, albeit poor and in process, to clean up the use of salt in vagrant.  Since Vagrant is packaged as a stand-alone distribution, with an embedded ruby executable, the normal ruby way of distributing / installing / using gems won't work.  The Vagrant way of extending is to create a plugin, but that seems like overkill at this point.  

## Installation

1. From the top level directory of your vagrant setup (the directory with the Vagrantfile), check out this code
`git clone git@github.com:petermeulbroek/salt-vagrant.git`
1. IF you want to run tests, you'll have to have a working ruby environment with bundler and rspec.  If not, skip the next steps
  1. Install dependent Gems
  `bundle install --path vendor`
   Note that this puts all needed gems in a vendor subdirectory, to avoid clashes
  2.  Run tests
  `rake spec`
1.  The classs are usuable as is, but vagrant needs to be made aware of them.  You'll need to edit your Vagrantfile.  Insert the following near/at the top of the Vagrantfile
```
require 'yaml'

$LOAD_PATH.push File.expand_path('salt-vagrant/lib')
require  'salt/saltfactory'

hconfig = YAML.load_file("saltconfig.yml")

# hosts is a hash of Salt host classes
hosts = SaltFactory.new(hconfig).create
```
  This adds 


```ruby
gem 'salt-host'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salt-host

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/petermeulbroek/salt-host.
