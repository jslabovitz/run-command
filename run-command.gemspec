Gem::Specification.new do |s|
  s.name          = 'run-command'
  s.version       = '0.5'
  s.summary       = 'A friendlier system().'
  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    A friendlier system().
  }
  s.license       = 'MIT'
  s.homepage      = 'http://github.com/jslabovitz/run-command'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_development_dependency 'bundler', '~> 2.3'
  s.add_development_dependency 'minitest', '~> 5.16'
  s.add_development_dependency 'minitest-power_assert', '~> 0.3'
  s.add_development_dependency 'rake', '~> 13.0'
end