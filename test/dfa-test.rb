require 'test/unit'
require_relative '../src/dfa.rb'

class DFA_TEST < Test::Unit::TestCase

  def setup

    @even_length = DFA.new(
      [:a, :b],
      ['0', '1'],
      { [:a, '0'] => :b, [:a, '1'] => :b, [:b, '0'] => :a, [:b, '1'] => :a },
      :a,
      [:a]
    )

    @even_value = DFA.new(
      [:x, :y],
      ['0', '1'],
      { [:x, '1'] => :x, [:x, '0'] => :y, [:y, '0'] => :y, [:y, '1'] => :x },
      :x,
      [:y]
    )

    @empty = DFA.new(
      [:x, :y],
      ['0', '1'],
      { [:x, '1'] => :x, [:x, '0'] => :y, [:y, '0'] => :y, [:y, '1'] => :x },
      :x,
      []
    )

  end

  def test_fail

    a = ['', '01', '1011', '1111111111111100']
    r = ['1', '111', '00001', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@even_length.accepts(w), "Incorrectly rejects even-length \"#{w}\"")
    end
    r.each do |w|
      assert(@even_length.rejects(w), "Incorrectly accepts even-length \"#{w}\"")
    end

    a = ['0', '10', '000', '111111110']
    r = ['', '1', '11', '111', '100000001']
    a.each do |w|
      assert(@even_value.accepts(w), "Incorrectly rejects even-value \"#{w}\"")
    end
    r.each do |w|
      assert(@even_value.rejects(w), "Incorrectly accepts even-value \"#{w}\"")
    end

    assert(@even_length.e_dfa, "Incorrectly states even_length as empty")
    assert(@even_value.e_dfa, "Incorrectly states even_value as empty")
    assert(!(@empty.e_dfa), "Incorrectly states empty as not empty")

  end

end
