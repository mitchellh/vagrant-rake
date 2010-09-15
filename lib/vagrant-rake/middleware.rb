module VagrantRake
  # A Vagrant middleware which executes a rake task on a given
  # VM.
  class Middleware
    def initialize(app, env)
      @app = app
      @env = env
    end

    def call(env)
      if env["vm"].created? && env["vm"].running?
        command = "rake #{env["rake.command"]}".strip

        env["vm"].ssh.execute do |ssh|
          ssh.exec!(command) do |channel, type, data|
            env.ui.info data, :_translate => false, :_prefix => false if type != :exit_status
          end
        end
      end

      @app.call(env)
    end
  end
end
