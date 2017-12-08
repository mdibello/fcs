# DFA.rb
# Interpreter for DFAs
# Matthew DiBello

class DFA

  def initialize states, sigma, delta, q0, final
    @Q = states
    @sigma = sigma
    @delta = delta
    @q0 = q0
    @F = final
  end

  def accepts w

    current_state = @q0

    w.split('').each do |c|
      return false if !@sigma.include? c
      current_state = @delta[[current_state, c]]
    end

    return true if @F.include? current_state
    return false

  end

  def rejects w
    return !(accepts w)
  end

end
