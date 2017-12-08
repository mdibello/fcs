# NFA.rb
# Interpreter for NFAs
# Matthew DiBello

require_relative './util.rb'

class NFA

  def initialize states, sigma, delta, q0, final
    @DFA = DFA.new(
      powerset states,
      sigma,
      # delta
      [q0],
      (powerset states).select { |q| q & final != [] }
    )
  end

  def accepts w
    return @DFA.accepts w
  end

  def rejects w
    return @DFA.rejects w
  end

end
