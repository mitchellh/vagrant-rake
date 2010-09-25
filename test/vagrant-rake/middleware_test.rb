require "test_helper"

Protest.describe("rake middleware") do
  setup do
    @klass = VagrantRake::Middleware
    @app, @env = action_env(vagrant_env.vms.values.first.env)

    @instance = @klass.new(@app, @env)

    @env["vm"].stubs(:created?).returns(true)
    @env["vm"].vm.stubs(:running?).returns(true)
  end

  should "do nothing if the VM is not created" do
    @env["vm"].stubs(:created?).returns(false)
    @env["vm"].expects(:ssh).never
    @instance.call(@env)
  end

  should "do nothing if the VM is not running" do
    @env["vm"].vm.stubs(:running?).returns(false)
    @env["vm"].expects(:ssh).never
    @instance.call(@env)
  end

  should "run rake via SSH on the VM" do
    ssh = mock("ssh")
    @env["vm"].ssh.expects(:execute).yields(ssh)

    ssh.expects(:exec!).with("cd /vagrant; rake")

    silence_stream($stdout) { @instance.call(@env) }
  end

  should "run the specified rake command via SSH on the VM" do
    ssh = mock("ssh")
    @env["vm"].ssh.expects(:execute).yields(ssh)

    ssh.expects(:exec!).with("cd /vagrant; rake db:migrate")

    @env["rake.command"] = "db:migrate"
    silence_stream($stdout) { @instance.call(@env) }
  end

  context "cwd" do
    setup do
      @ssh = mock("ssh")
      @env["vm"].ssh.expects(:execute).yields(@ssh)
      @env["rake.cwd"] = nil
    end

    should "run the rake command in the specified cwd" do
      @ssh.expects(:exec!).with("cd /foo/bar; rake")

      @env["rake.cwd"] = "/foo/bar"
      silence_stream($stdout) { @instance.call(@env) }
    end

    should "run the rake command with the configured directory if middleware variable is not set" do
      @env.env.config.rake.directory = "/configured"

      @ssh.expects(:exec!).with("cd /configured; rake")
      silence_stream($stdout) { @instance.call(@env) }
    end

    should "run the rake command with the root shared directory if nothing configured" do
      @ssh.expects(:exec!).with("cd /vagrant; rake")
      silence_stream($stdout) { @instance.call(@env) }
    end
  end
end
