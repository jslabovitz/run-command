require 'shellwords'

module Kernel

  class RunCommandFailed < Exception; end

  def run_command(*args, **options)
    command = args.shift
    args = args.flatten.compact.map(&:to_s)
    env = options.delete(:env) || {}
    verbose = options.delete(:verbose) || false
    pretend = options.delete(:pretend) || false
    argv0 = options.delete(:argv0)
    input = options.delete(:input)
    interactive = options.delete(:interactive)
    if verbose
      warn "$ %s%s" % [
        env.empty? ? nil : env.map { |kv| kv.join('=') }.join(' ') + ' ',
        [command, *args].shelljoin,
      ]
    end
    unless pretend
      if interactive
        system(env, *command)
        output = nil
      else
        output = IO.popen(env, [argv0 ? [command, argv0] : command, *args], 'r+', options) do |io|
          io.write(input.to_s) if input
          io.close_write
          io.read
        end
      end
      raise RunCommandFailed, "Command #{command.to_s.inspect} failed: #{$?}" if $? != 0
      output
    end
  end

end