module VagrantRake
  class Command < Vagrant::Command::Base
    desc "Run a rake task inside the VM environment"
    register "rake RAKE_COMMAND"
    argument :rake_command, :type => :array, :required => true, :desc => "The command to run on the VM via Rake"

    def execute
      command = rake_command.join(" ")
    end
  end
end
