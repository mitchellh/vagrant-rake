require 'vagrant'
require 'vagrant-rake/command'
require 'vagrant-rake/middleware'

rake = Vagrant::Action::Builder.new do
  use VagrantRake::Middleware
end

Vagrant::Action.register(:rake, rake)
