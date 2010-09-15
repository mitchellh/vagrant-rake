module VagrantRake
  class Command < Vagrant::Command::Base
    desc "Run a rake task inside the VM environment"
    register "rake RAKE_COMMAND"
    argument :rake_command, :type => :array, :required => true, :desc => "The command to run on the VM via Rake"

    def execute
      command = rake_command.join(" ")

      target_vms.each do |vm|
        next if !vm.created? || !vm.running?

        env.ui.info "Executing: #{command}", :_translate => false

        vm.ssh.execute do |ssh|
          ssh.exec!(command) do |channel, type, data|
            env.ui.info data, :_translate => false, :_prefix => false
          end
        end
      end
    end
  end
end
