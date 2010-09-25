module VagrantRake
  # A configuration class to configure defaults which are used for
  # the `vagrant-rake` plugin.
  class Config < Vagrant::Config::Base
    configures :rake
    attr_accessor :directory

    def validate(errors)
      errors.add(I18n.t("vagrant.plugins.rake.config_directory")) if directory && !directory.is_a?(String)
    end
  end
end
