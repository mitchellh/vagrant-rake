# -*- encoding: utf-8 -*-
require File.expand_path("../lib/vagrant-rake/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "vagrant-rake"
  s.version     = VagrantRake::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mitchell Hashimoto"]
  s.email       = ["mitchell.hashimoto@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/vagrant-rake"
  s.summary     = "A Vagrant plugin to execute `rake` commands from the host in the VM"
  s.description = "A Vagrant plugin to execute `rake` commands from the host in the VM"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "vagrant-rake"

  s.add_dependency "vagrant", "~> 0.8.0"
  s.add_development_dependency "protest", "~> 0.4.0"
  s.add_development_dependency "mocha", "~> 0.9.8"
  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
