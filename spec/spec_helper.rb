require 'bundler/setup'
require 'crypto_crafts'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


def run_command(cmd, v: false, run_mode: :inline)
  puts "==> #{cmd}"
  case run_mode
  when :inline
    output = `#{cmd}`
    puts output if v
    output
  when :system
    success = system cmd
    expect(success).to be_truthy
    success
  when :daemon
    pid = spawn cmd
    sleep (ENV['BOOTSTRAP'] || 10).to_i
    pid
  else
    raise "dont know how to run #{run_mode}"
  end
end
