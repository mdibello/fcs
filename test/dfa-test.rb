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

    @even_length2 = DFA.new(
      [:x, :y],
      ['0', '1'],
      { [:x, '0'] => :y, [:x, '1'] => :y, [:y, '0'] => :x, [:y, '1'] => :x },
      :x,
      [:x]
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

  def test_dfa

    a = ['', '01', '1011', '1111111111111100']
    r = ['1', '111', '00001', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@even_length.accepts(w), "Incorrectly rejects even-length \"#{w}\"")
    end
    r.each do |w|
      assert(@even_length.rejects(w), "Incorrectly accepts even-length \"#{w}\"")
    end

    a = ['', '01', '1011', '1111111111111100']
    r = ['1', '111', '00001', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@even_length2.accepts(w), "Incorrectly rejects even-length2 \"#{w}\"")
    end
    r.each do |w|
      assert(@even_length2.rejects(w), "Incorrectly accepts even-length2 \"#{w}\"")
    end

    a = ['0', '10', '000', '111111110']
    r = ['', '1', '11', '111', '100000001']
    a.each do |w|
      assert(@even_value.accepts(w), "Incorrectly rejects even-value \"#{w}\"")
    end
    r.each do |w|
      assert(@even_value.rejects(w), "Incorrectly accepts even-value \"#{w}\"")
    end

  end

  def test_e_dfa
    assert(!(@even_length.e_dfa), "Incorrectly states even_length as empty")
    assert(!(@even_value.e_dfa), "Incorrectly states even_value as empty")
    assert(@empty.e_dfa, "Incorrectly states empty as not empty")
  end

  def test_invert

    r = ['', '01', '1011', '1111111111111100']
    a = ['1', '111', '00001', '1110001110001']
    a.each do |w|
      assert(@even_length.invert.accepts(w), "Incorrectly rejects even-length \"#{w}\"")
    end
    r.each do |w|
      assert(@even_length.invert.rejects(w), "Incorrectly accepts even-length \"#{w}\"")
    end

    r = ['0', '10', '000', '111111110']
    a = ['1', '11', '111', '100000001']
    a.each do |w|
      assert(@even_value.invert.accepts(w), "Incorrectly rejects even-value \"#{w}\"")
    end
    r.each do |w|
      assert(@even_value.invert.rejects(w), "Incorrectly accepts even-value \"#{w}\"")
    end

  end

  def test_union
    a = ['0', '00', '000', '11', '1010', '1111111111111100']
    r = ['1', '111', '101', '00001', '1110001110001']
    a.each do |w|
      assert(union(@even_length, @even_value).accepts(w), "Incorrectly rejects \"#{w}\"")
    end
    r.each do |w|
      assert(union(@even_length, @even_value).rejects(w), "Incorrectly accepts \"#{w}\"")
    end
  end

  def test_intersect
    a = ['00', '1010', '1111111111111100']
    r = ['0', '1', '01', '111', '100', '00001', '1110001110001']
    a.each do |w|
      assert(intersect(@even_length, @even_value).accepts(w), "Incorrectly rejects \"#{w}\"")
    end
    r.each do |w|
      assert(intersect(@even_length, @even_value).rejects(w), "Incorrectly accepts \"#{w}\"")
    end
  end

  def test_eq_dfa
    assert(!eq_dfa(@even_length, @even_value), "Incorrectly states even_length and even_value as equivalent")
    assert(!eq_dfa(@even_length, @empty), "Incorrectly states even_length and empty as equivalent")
    assert(eq_dfa(@empty, @empty), "Incorrectly states empty and empty as not equivalent")
    assert(eq_dfa(@even_length, @even_length2), "Incorrectly states even_length and even_length2 as not equivalent")
  end

end
