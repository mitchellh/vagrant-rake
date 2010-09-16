require "test_helper"

Protest.describe("rake middleware") do
  setup do
    @klass = VagrantRake::Middleware
    @app, @env = action_env(vagrant_env.vms.values.first.env)

    @instance = @klass.new(@app, @env)

    @env["vm"].stubs(:created?).returns(true)
    @env["vm"].stubs(:running?).returns(true)
  end

  should "do nothing if the VM is not created" do
    @env["vm"].stubs(:created?).returns(false)
    @env["vm"].expects(:ssh).never
    @instance.call(@env)
  end

  should "do nothing if the VM is not running" do
    @env["vm"].stubs(:running?).returns(false)
    @env["vm"].expects(:ssh).never
    @instance.call(@env)
  end

  should "run rake via SSH on the VM" do
    ssh = mock("ssh")
    @env["vm"].ssh.expects(:execute).yields(ssh)
    ssh.expects(:exec!).with("rake").once
    @instance.call(@env)
  end

  should "run the specified rake command via SSH on the VM" do
    ssh = mock("ssh")
    @env["vm"].ssh.expects(:execute).yields(ssh)
    ssh.expects(:exec!).with("rake db:migrate").once

    @env["rake.command"] = "db:migrate"
    @instance.call(@env)
  end
end
