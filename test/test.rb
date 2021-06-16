require 'minitest/autorun'
require 'minitest/power_assert'

require 'run-command'

class Test < MiniTest::Test

  def test_simple
    assert_output {
      run_command('echo', %w{a b}, verbose: true)
    }
  end

  def test_env
    assert_output {
      run_command('echo', %w{a b}, verbose: true, env: { 'FOO' => 'bar' })
    }
  end

  def test_env_argv0
    assert_output {
      run_command('echo', %w{a b}, verbose: true, env: { 'FOO' => 'bar' }, argv0: 'DATE')
    }
  end

  def test_pretend
    assert_output {
      run_command('echo', %w{a b}, verbose: true, pretend: true)
    }
  end

  def test_varied_args
    assert_output {
      run_command('echo', ['a', 'b', [1, :foo]], verbose: true)
    }
  end

end