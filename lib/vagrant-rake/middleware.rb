module VagrantRake
  # A Vagrant middleware which executes a rake task on a given
  # VM. This task will run "rake" on the VM that this action sequence
  # was run on. If an env variable "rake.command" is populated, then
  # this command will be executed by rake.
  class Middleware
    def initialize(app, env)
      @app = app
      @env = env
    end

    def call(env)
      if env["vm"].created? && env["vm"].running?
        command = "rake #{env["rake.command"]}".strip

        env["vm"].ssh.execute do |ssh|
          ssh.exec!("cd #{working_directory}")
          ssh.exec!(command) do |channel, type, data|
            env.ui.info data, :_translate => false, :_prefix => false if type != :exit_status
          end
        end
      end

      @app.call(env)
    end

    protected

    def working_directory
      @env["rake.cwd"] || @env["config"].vm.shared_folders["v-root"][:guestpath]
    end
  end
end
