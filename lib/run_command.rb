require 'shellwords'

module RunCommand

  class Error < Exception; end

  def self.run_command(command, *args)
    options = args.last.kind_of?(Hash) ? args.pop : {}
    env = options.delete(:env) || {}
    verbose = options.delete(:verbose) || false
    pretend = options.delete(:pretend) || false
    argv0 = options.delete(:argv0)
    rebuilt_command = [
      # env.empty? ? nil : env.map { |kv| kv.join('=') },
      command,
      *args,
    ].flatten.compact.shelljoin
    warn "$ #{rebuilt_command}" if verbose
    unless pretend
      system(
        env,
        argv0 ? [command, argv0] : command,
        *args.flatten.compact.map(&:to_s),
        options) or raise Error, "Can't run command (status = #{$?}): #{rebuilt_command}"
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