require 'test/unit'
require_relative '../src/pda.rb'

class PDA_TEST < Test::Unit::TestCase

  def setup

    @zero_n_one_n = PDA.new(
      [:q1, :q2, :q3, :q4],
      ['0', '1'],
      ['0', '$'],
      { [:q1, :e, :e] => [:q2, '$'], [:q2, '0', :e] => [:q2, '0'], [:q2, '1', '0'] => [:q3, :e],
        [:q3, '1', '0'] => [:q3, :e], [:q3, :e, '$'] => [:q4, :e] },
      :q1,
      [:q1, :q4]
    )

  end

  def test_fail

    a = ['', '01', '0011', '00000000001111111111']
    r = ['1', '111', '00001', '000001111', '00000111111', '1110001110001', 'kk', 'uu11']
    a.each do |w|
      assert(@zero_n_one_n.accepts(w), "Incorrectly rejects \"#{w}\"")
    end
    r.each do |w|
      assert(@zero_n_one_n.rejects(w), "Incorrectly accepts \"#{w}\"")
    end

  end

end
