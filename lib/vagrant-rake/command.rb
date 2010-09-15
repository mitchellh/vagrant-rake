module VagrantRake
  class Command < Vagrant::Command::Base
    desc "Run a rake task inside the VM environment"
    register "rake"

    def execute
      env.ui.info "HELLO!", :_translate => false
    end
  end
end
