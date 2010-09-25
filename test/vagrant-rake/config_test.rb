require "test_helper"

Protest.describe("Configuration class") do
  setup do
    @klass = VagrantRake::Config
    @instance = @klass.new
    @errors = Vagrant::Config::ErrorRecorder.new
  end

  should "be valid by default" do
    @instance.validate(@errors)
    assert @errors.errors.empty?
  end

  should "be invalid if directory is not a string" do
    @instance.directory = 24
    @instance.validate(@errors)

    assert !@errors.errors.empty?
  end
end
