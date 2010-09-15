require "test_helper"

Protest.describe("`vagrant rake` command") do
  setup do
    clean_paths

    @klass = VagrantRake::Command
    @env = vagrant_env
    @vm = @env.vms.values.first
  end

  should "require a rake command argument" do
    # TODO: Wish there was a way to check STDERR. I'm sure there is.
    # For now, expectations work fine, but don't test it as well.
    @vm.expects(:ssh).never
    silence_stream(STDERR) { @env.cli("rake") }
  end

  should "not execute the command on non-created VMs" do
    assert !@vm.created? # sanity
    @vm.expects(:ssh).never

    @env.cli("rake", "db:migrate")
  end

  should "not execute the command on non-running VMs" do
    @vm.stubs(:created?).returns(true)
    @vm.stubs(:running?).returns(false)
    @vm.expects(:ssh).never

    @env.cli("rake", "db:migrate")
  end

  should "execute the command on running VMs" do
    @vm.stubs(:created?).returns(true)
    @vm.stubs(:running?).returns(true)
    @vm.ssh.expects(:execute).once

    silence_stream(STDOUT) { @env.cli("rake", "db:migrate") }
  end
end
