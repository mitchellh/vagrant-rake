require 'vagrant'

if Vagrant::VERSION < "0.6.0"
  STDERR.puts "Vagrant 0.6 is required for this plugin to work."
  exit 1
end

require 'vagrant-rake/command'
