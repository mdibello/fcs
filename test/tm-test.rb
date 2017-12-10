require 'test/unit'
require_relative '../src/tm.rb'

class TM_TEST < Test::Unit::TestCase

  def setup

    @repeat_string = TM.new(
      [:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :qaccept, :qreject],
      ['0', '1', '#'],
      ['0', '1', '#', 'x', '_'],
      { [:q1, '1'] => [:q3, 'x', :R], [:q3, '0'] => [:q3, '0', :R], [:q3, '1'] => [:q3, '1', :R],
        [:q3, '#'] => [:q5, '#', :R], [:q5, 'x'] => [:q5, 'x', :R], [:q5, '1'] => [:q6, 'x', :L],
        [:q6, '0'] => [:q6, '0', :L], [:q6, '1'] => [:q6, '1', :L], [:q6, 'x'] => [:q6, 'x', :L],
        [:q6, '#'] => [:q7, '#', :L], [:q7, '0'] => [:q7, '0', :L], [:q7, '1'] => [:q7, '1', :L],
        [:q7, 'x'] => [:q1, 'x', :R], [:q1, '0'] => [:q2, 'x', :R], [:q2, '0'] => [:q2, '0', :R],
        [:q2, '1'] => [:q2, '1', :R], [:q2, '#'] => [:q4, '#', :R], [:q4, 'x'] => [:q4, 'x', :R],
        [:q4, '0'] => [:q6, 'x', :L], [:q1, '#'] => [:q8, '#', :R], [:q8, 'x'] => [:q8, 'x', :R],
        [:q8, '_'] => [:qaccept, '_', :R] },
      :q1,
      :qaccept,
      :qreject
    )

  end

  def test_fail

    a = ['#', '1#1', '101#101', '1111100000#1111100000']
    r = ['1', '111', '0#1', '11#111', '0101#010', 'tms']
    a.each do |w|
      assert(@repeat_string.accepts(w), "Incorrectly rejects \"#{w}\"")
    end
    r.each do |w|
      assert(@repeat_string.rejects(w), "Incorrectly accepts \"#{w}\"")
    end

  end

end
