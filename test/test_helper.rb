require "test/unit/assertions"
require "protest"
require "mocha"
require "vagrant-rake"

class Protest::TestCase
  include Test::Unit::Assertions
  include Mocha::API
  include Vagrant::TestHelpers

  # Get Mocha integrated properly into the tests
  alias :original_run :run
  def run(report)
    original_run(report)
    mocha_verify
  ensure
    mocha_teardown
  end

  # Helper to silence streams, courtesy of Ruby Facets library.
  def silence_stream(*streams) #:yeild:
    on_hold = streams.collect{ |stream| stream.dup }
    streams.each do |stream|
      stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
      stream.sync = true
    end
    yield
  ensure
    streams.each_with_index do |stream, i|
      stream.reopen(on_hold[i])
    end
  end
end

Protest.report_with(:documentation)
