require 'shellwords'

class RunCommand

  class Error < Exception; end

  def self.run_command(command, *args)
    new.run_command(command, *args)
  end

  def run_command(command, *args)
    command = command.to_s
    options = args.last.kind_of?(Hash) ? args.pop : {}
    args = args.flatten.compact.map(&:to_s)
    env = options.delete(:env) || {}
    verbose = options.delete(:verbose) || false
    pretend = options.delete(:pretend) || false
    argv0 = options.delete(:argv0)
    if verbose
      warn "$ %s%s" % [
        env.empty? ? nil : env.map { |kv| kv.join('=') }.join(' ') + ' ',
        [command, *args].shelljoin,
      ]
    end
    unless pretend
      system(
        env,
        argv0 ? [command, argv0] : command,
        *args,
        options) or raise Error, "Can't run command #{command.inspect}: status = #{$?}"
    end
  end

end

if $0 == __FILE__

  RunCommand.run_command('echo', %w{a b}, verbose: true)
  RunCommand.run_command('echo', %w{a b}, verbose: true, env: { 'FOO' => 'bar' })
  RunCommand.run_command('echo', %w{a b}, verbose: true, env: { 'FOO' => 'bar' }, argv0: 'DATE')
  RunCommand.run_command('echo', %w{a b}, verbose: true, pretend: true)
  RunCommand.run_command('echo', ['a', 'b', [1, :foo]], verbose: true)

end