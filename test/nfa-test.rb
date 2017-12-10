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

    @two_or_three = NFA.new(
      [:q, :r, :s, :t, :u, :v],
      ['0'],
      { [:q, :e] => [:r, :t], [:r, '0'] => :s, [:s, '0'] => :r, [:t, '0'] => :u, [:u, '0'] => :v, [:v, '0'] => :t },
      :q,
      [:r, :t]
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

    a = ['00', '000', '000000']
    r = ['0', '00000', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@two_or_three.accepts(w), "Incorrectly rejects two_or_three \"#{w}\"")
    end
    r.each do |w|
      assert(@two_or_three.rejects(w), "Incorrectly accepts two_or_three \"#{w}\"")
    end

  end

end
