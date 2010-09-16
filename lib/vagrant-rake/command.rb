module VagrantRake
  class Command < Vagrant::Command::Base
    desc "Run a rake task inside the VM environment"
    register "rake RAKE_COMMAND"
    argument :rake_command, :type => :array, :required => false, :desc => "The command to run on the VM via Rake"
    class_option :cwd, :type => :string, :default => nil

    # Executes the given rake command on the VMs that are represented
    # by this environment.
    def execute
      command = (rake_command || []).join(" ")
      target_vms.each { |vm| execute_on_vm(vm, command) }
    end

    protected

    # Executes a command on a specific VM.
    def execute_on_vm(vm, command)
      vm.env.actions.run(:rake,
                         "rake.command" => command,
                         "rake.cwd" => options[:cwd])
    end
  end
end
