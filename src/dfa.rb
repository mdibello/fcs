# DFA.rb
# Interpreter for DFAs
# Matthew DiBello

Struct.new("DFA", :Q, :sigma, :delta, :q0, :F) do

  def accepts w

    current_state = q0

    w.each do |c|
      current_state = delta[[current_state, c]]
    end

    return true if F.contains current_state
    return false

  end

  def rejects w

    return !(accepts w)

  end

end
