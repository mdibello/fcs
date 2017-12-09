require 'test/unit'
require_relative '../src/nfa.rb'

class NFA_TEST < Test::Unit::TestCase

  def setup

    @one_third_last = NFA.new(
      [:x, :y, :z, :a],
      ['0', '1'],
      { [:x, '0'] => :x, [:x, '1'] => [:x, :y], [:y, '0'] => :z, [:y, '1'] => :z, [:z, '0'] => :a, [:z, '1'] => :a },
      :x,
      [:a]
    )

    @odd_length = NFA.new(
      [:q, :r, :s],
      ['0', '1'],
      { [:q, '0'] => :s, [:q, '1'] => :r, [:r, '0'] => :q, [:r, :e] => :s, [:s, :e] => :r, [:s, '1'] => :q },
      :q,
      [:s]
    )

  end

  def test_fail

    a = ['111', '10111', '1111111111111110', '00000000000000100']
    r = ['', '1', '011', '00001', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@one_third_last.accepts(w), "Incorrectly rejects one_third_last \"#{w}\"")
    end
    r.each do |w|
      assert(@one_third_last.rejects(w), "Incorrectly accepts one_third_last \"#{w}\"")
    end

    a = ['0', '1', '101', '1111111111111']
    r = ['', '01', 'as', 'dsf', '11111111']
    a.each do |w|
      assert(@odd_length.accepts(w), "Incorrectly rejects odd_length \"#{w}\"")
    end
    r.each do |w|
      assert(@odd_length.rejects(w), "Incorrectly accepts odd_length \"#{w}\"")
    end

  end

end
