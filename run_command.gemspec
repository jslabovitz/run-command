require_relative 'lib/run_command/version'

Gem::Specification.new do |s|
  s.name          = 'run_command'
  s.version       = RunCommand::VERSION
  s.summary       = 'A friendlier system().'
  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    RunCommand provides a friendlier system().
  }
  s.license       = 'MIT'
  s.homepage      = 'http://github.com/jslabovitz/run_command'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'rubygems-tasks', '~> 0.2'
end