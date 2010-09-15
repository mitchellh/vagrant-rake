require "test_helper"

Protest.describe("`vagrant rake` command") do
  setup do
    clean_paths

    @klass = VagrantRake::Command
    @env = vagrant_env
  end

  should "require a rake command argument" do
    assert_raises(Thor::RequiredArgumentMissingError) {
      @klass.new([], {}, { :env => @env })
    }
  end

  should "not execute the command on non-created VMs" do
    vm = @env.vms.values.first

    assert !vm.created? # sanity
    vm.expects(:ssh).never
    @klass.new(["db:migrate"], {}, { :env => @env })
  end

  should "not execute the command on non-running VMs" do
    vm = @env.vms.values.first

    vm.stubs(:created?).returns(true)
    vm.stubs(:running?).returns(false)
    vm.expects(:ssh).never
    @klass.new(["db:migrate"], {}, { :env => @env })
  end

  should "execute the command on running VMs" do
    vm = @env.vms.values.first

    vm.stubs(:created?).returns(true)
    vm.stubs(:running?).returns(true)
    vm.ssh.expects(:execute).once
    @klass.new(["db:migrate"], {}, { :env => @env })
  end
end
