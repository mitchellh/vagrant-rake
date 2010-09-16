require "test_helper"

Protest.describe("`vagrant rake` command") do
  setup do
    clean_paths

    @klass = VagrantRake::Command
    @env = vagrant_env
    @vm = @env.vms.values.first
  end

  should "execute the command on every VM" do
    @vm.env.actions.expects(:run).with() do |action, options|
      assert_equal :rake, action
      assert_equal "db:migrate", options["rake.command"]
      true
    end

    @env.cli("rake", "db:migrate")
  end

  should "execute fine with no command given" do
    @vm.env.actions.expects(:run).with() do |action, options|
      assert_equal :rake, action
      assert_equal "", options["rake.command"]
      true
    end

    @env.cli("rake")
  end

  should "execute within the nil cwd by default" do
    @vm.env.actions.expects(:run).with() do |action, options|
      assert_equal :rake, action
      assert_equal nil, options["rake.cwd"]
      true
    end

    @env.cli("rake")
  end

  should "execute within the given cwd" do
    @vm.env.actions.expects(:run).with() do |action, options|
      assert_equal :rake, action
      assert_equal "/foo/bar", options["rake.cwd"]
      true
    end

    @env.cli("rake", "--cwd", "/foo/bar")
  end
end
