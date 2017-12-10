require 'test/unit'
require_relative '../src/rex.rb'

class REX_TEST < Test::Unit::TestCase

  def setup
    @concat = REX.new([:c, 'r', 'e', 'x'])
    @union = REX.new([:u, 'r', 'e', 'x'])
    @kleene = REX.new([:*, 'r'])
    @oneup = REX.new([:+, 'r'])
  end

  def test_fail

    a = ['rex']
    r = ['', 're', 'rexx', 'ex']
    a.each do |w|
      assert(@concat.accepts(w), "Incorrectly rejected #{w}")
    end
    r.each do |w|
      assert(@concat.rejects(w), "Incorrectly accepted #{w}")
    end

    a = ['r', 'e', 'x']
    r = ['', 're', 'rexx', 'ex']
    a.each do |w|
      assert(@union.accepts(w), "Incorrectly rejected #{w}")
    end
    r.each do |w|
      assert(@union.rejects(w), "Incorrectly accepted #{w}")
    end

    a = ['', 'r', 'rr', 'rrrrrrrrrrrr']
    r = ['re', 'rexx', 'ex']
    a.each do |w|
      assert(@kleene.accepts(w), "Incorrectly rejected #{w}")
    end
    r.each do |w|
      assert(@kleene.rejects(w), "Incorrectly accepted #{w}")
    end

    a = ['r', 'rr', 'rrrrrrrrrrrr']
    r = ['', 're', 'rexx', 'ex']
    a.each do |w|
      assert(@oneup.accepts(w), "Incorrectly rejected #{w}")
    end
    r.each do |w|
      assert(@oneup.rejects(w), "Incorrectly accepted #{w}")
    end

  end

end
