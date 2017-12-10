# REX.rb
# Interpreter for REXes (compiles to NFAs)
# Matthew DiBello

def random_symbol
  return "q#{rand(1000000000).to_s}".to_sym
end

class REX

  def initialize rex

    nfa = rex_to_nfa rex

    @NFA = NFA.new nfa.states, nfa.sigma, nfa.delta, nfa.q0, nfa.final

  end

  def rex_to_nfa rex

    start_state = random_symbol
    end_state = random_symbol

    if rex[0] == :c
      nfa = SimpleNFA.new([start_state], [], {}, start_state, [start_state])
      rex.shift
      rex.each do |ex|
        n = rex_to_nfa ex
        nfa.states += n.states
        nfa.sigma += n.sigma
        nfa.final.each do |f|
          nfa.delta[[f, :e]] = n.q0
        end
        nfa.delta.merge!(n.delta)
        nfa.final = n.final
      end
    elsif rex[0] == :u
      nfa = SimpleNFA.new([start_state, end_state], [], {}, start_state, [end_state])
      rex.shift
      rex.each do |ex|
        n = rex_to_nfa ex
        nfa.states += n.states
        nfa.sigma += n.sigma
        if nfa.delta[[start_state, :e]] == nil
          nfa.delta[[start_state, :e]] = []
        end
        nfa.delta[[start_state, :e]].push n.q0
        n.final.each do |q|
          nfa.delta[[q, :e]] = end_state
        end
        nfa.delta.merge!(n.delta)
      end
    elsif rex[0] == :+
      nfa = SimpleNFA.new([start_state, end_state], [], {}, start_state, [end_state])
      if rex[1].kind_of? Array
        nfa.sigma += rex[1]
        rex[1].each do |x|
          nfa.delta[[start_state, x]] = end_state
        end
      else # rex[1] is single character
        nfa.sigma.push rex[1] unless rex[1] == :e
        nfa.delta[[start_state, rex[1]]] = end_state
      end
      nfa.delta[[end_state, :e]] = start_state
    elsif rex[0] == :*
      nfa = SimpleNFA.new([start_state], [], {}, start_state, [start_state])
      if rex[1].kind_of? Array
        nfa.sigma += rex[1]
        rex[1].each do |x|
          nfa.delta[[start_state, x]] = start_state
        end
      else # rex[1] is a single character
        nfa.sigma.push rex[1] unless rex[1] == :e
        nfa.delta[[start_state, rex[1]]] = start_state
      end
    else
      nfa = SimpleNFA.new([start_state, end_state], [], {}, start_state, [end_state])
      if rex[0].kind_of? Array
        nfa.sigma += rex[0]
        rex[0].each do |x|
          nfa.delta[[start_state, x]] = end_state
        end
      else # rex[0] is a single character
        nfa.sigma.push rex[0] unless rex[0] == :e
        nfa.delta[[start_state, rex[0]]] = end_state
      end
    end

    nfa.sigma.uniq!
    return nfa

  end

  def accepts w
    @NFA.accepts w
  end

  def rejects w
    @NFA.rejects w
  end

end
