# vagrant-rake

`vagrant-rake` is a plugin for [Vagrant](http://vagrantup.com) which allows
a developer to execute rake tasks on the host using the `vagrant rake` command
and have them be invoked on the guest. This alleviates the need to SSH into
the VM to simply run a rake task.

This gem is also a good example of how to create a proper Vagrant plugin.

**NOTE:** This plugin requires Vagrant 0.6 or later. At the time of this writing
Vagrant 0.6 is still in development. This is the first plugin being written to
both test the system and showcase how a plugin works.

## Installing / Getting Started

To use this plugin, first install Vagrant 0.6 or later. At the time of
creating this README, Vagrant 0.6 is still not released, so you would have
to build from [the git repository](http://github.com/mitchellh/vagrant).
Next, install this gem:

    gem install vagrant-rake

The `vagrant rake` command should now be available. To use it, simply
pass use it as if you were running rake locally. The various ways to
call the command is shown below:

    vagrant rake db:migrate
    vagrant rake build
    vagrant rake test --cwd /some/other/directory

The plugin will auotomatically run your rake task on the VM, forwarding
the output to you on the host.

## Working with the Plugin Source

If you'd like to work with the plugin source (for learning purposes or
to make a contribution), then clone out this repository, then run the
test suite to verify everything is working:

    git clone git://github.com/mitchellh/vagrant-rake.git
    cd vagrant-rake

Then bundle the environment to get the required gems, and run rake to
verify that the test suite passes:

    bundle install
    rake
