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

  def e_dfa
    visited_states = []
    visited_states.push @q0
    dfa_dfs @q0, visited_states
    print visited_states
    print @F
    return (visited_states & @F).empty?
  end

  def dfa_dfs q, visited_states
    @sigma.each do |c|
      if @delta.has_key? [q, c]
        unless visited_states.include? @delta[[q, c]]
          visited_states.push @delta[[q, c]]
          dfa_dfs @delta[[q, c]], visited_states
        end
      end
    end
  end

end
