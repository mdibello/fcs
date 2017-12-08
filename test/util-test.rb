require 'test/unit'
require_relative '../src/util.rb'

class UTIL_TEST < Test::Unit::TestCase
  def test_fail
    assert(powerset([]) == [[]])
    assert(powerset([0]) == [[], [0]])
    assert(powerset([0, 1]) == [[], [0], [1], [0, 1]])
    assert(powerset([0, 1, 2]) == [[], [0], [1], [2], [0, 1], [0, 2], [1, 2], [0, 1, 2]])
  end
end
