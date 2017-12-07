require 'test/unit'
require_relative '../src/dfa.rb'

class DFA_TEST < Test::Unit::TestCase

  def setup

    @even_length = Struct::DFA.new(
      [:a, :b],
      [0, 1],
      { [:a, 0] => :b, [:a, 1] => :b, [:b, 0] => :a, [:b, 1] => :a },
      :a,
      [:b]
    )

  end

  def test_fail
    assert(@even_length.accepts(""), "Incorrectly rejects even-length \"\"")
  end

end
