require 'shellwords'

module RunCommand

  def run_command(command, *args)
    command = command.to_s
    options = args.last.kind_of?(Hash) ? args.pop.dup : {}
    options[:exception] = true
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
      data = ''
      IO.popen(env, [argv0 ? [command, argv0] : command, *args], 'r', options) do |io|
        data += io.read
      end
      data
    end
  end

end