# DFA.rb
# Interpreter for DFAs
# Matthew DiBello

Struct.new("DFA", :Q, :sigma, :delta, :q0, :F) do

  def run_dfa dfa w

    current_state = q0

    w.each do |c|
      current_state = delta[[current_state, c]]
    end

    return true if F.contains current_state
    return false

  end

end
