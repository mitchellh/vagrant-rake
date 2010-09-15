require "test_helper"

Protest.describe("`vagrant rake` command") do
  setup do
    clean_paths

    @klass = VagrantRake::Command
    @env = vagrant_env
    @vm = @env.vms.values.first
  end

  should "execute the command on every VM" do
    @vm.env.actions.expects(:run).with(:rake, "rake.command" => "db:migrate").once
    @env.cli("rake", "db:migrate")
  end

  should "execute fine with no command given" do
    @vm.env.actions.expects(:run).with(:rake, "rake.command" => "").once
    @env.cli("rake")
  end
end
