require "test_helper"

Protest.describe("`vagrant rake` command") do
  setup do
    @klass = VagrantRake::Command
  end

  should "require a rake command argument"
  should "not execute the command on non-created VMs"
  should "not execute the command on non-running VMs"
  should "execute the command on running VMs"
end
