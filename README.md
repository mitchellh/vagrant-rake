# vagrant-rake

`vagrant-rake` is a plugin for [Vagrant](http://vagrantup.com) which allows
a developer to execute rake tasks on the host using the `vagrant rake` command
and have them be invoked on the guest. This alleviates the need to SSH into
the VM to simply run a rake task.

This gem is also a good example of how to create a proper Vagrant plugin.

**NOTE:** This plugin requires Vagrant 0.6 or later.

## Installing / Getting Started

To use this plugin, first install Vagrant 0.6 or later. Next, install this gem:

    gem install vagrant-rake

The `vagrant rake` command should now be available. To use it, simply
pass use it as if you were running rake locally. The various ways to
call the command is shown below:

    vagrant rake db:migrate
    vagrant rake build
    vagrant rake test --cwd /some/other/directory

The plugin will auotomatically run your rake task on the VM, forwarding
the output to you on the host.

You can also specify the default working directory for executed
rake tasks in your Vagrantfile:

    Vagrant::Config.run do |config|
      config.rake.directory = "/my/custom/directory"
    end

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
