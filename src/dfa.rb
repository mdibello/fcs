# DFA.rb
# Interpreter for DFAs
# Matthew DiBello

class DFA

  attr_accessor :states
  attr_accessor :sigma
  attr_accessor :delta
  attr_accessor :q0
  attr_accessor :final

  def initialize states, sigma, delta, q0, final
    self.states = states
    self.sigma = sigma
    self.delta = delta
    self.q0 = q0
    self.final = final
  end

  def accepts w

    current_state = self.q0

    w.split('').each do |c|
      return false if !self.sigma.include? c
      current_state = self.delta[[current_state, c]]
    end

    return true if self.final.include? current_state
    return false

  end

  def rejects w
    return !(accepts w)
  end

  def e_dfa
    visited_states = []
    visited_states.push self.q0
    dfa_dfs self.q0, visited_states
    return (visited_states & self.final).empty?
  end

  def dfa_dfs q, visited_states
    self.sigma.each do |c|
      if self.delta.has_key? [q, c]
        unless visited_states.include? self.delta[[q, c]]
          visited_states.push self.delta[[q, c]]
          dfa_dfs self.delta[[q, c]], visited_states
        end
      end
    end
  end

  def invert
    return DFA.new(self.states, self.sigma, self.delta, self.q0, self.states - self.final)
  end

end


def union d1, d2
  delta = {}
  (d1.states.product d2.states).each do |q|
    d1.sigma.each do |c|
      if (d1.delta.has_key? [q[0], c]) && (d2.delta.has_key? [q[1], c])
        delta[[q, c]] = [d1.delta[[q[0], c]], d2.delta[[q[1], c]]]
      end
    end
  end
  return DFA.new(
    (d1.states.product d2.states),
    d1.sigma,
    delta,
    [d1.q0, d2.q0],
    (d1.states.product d2.states).select { |q| (d1.final.include? q[0]) || (d2.final.include? q[1]) }
  )
end

def intersect d1, d2
  delta = {}
  (d1.states.product d2.states).each do |q|
    d1.sigma.each do |c|
      if (d1.delta.has_key? [q[0], c]) && (d2.delta.has_key? [q[1], c])
        delta[[q, c]] = [d1.delta[[q[0], c]], d2.delta[[q[1], c]]]
      end
    end
  end
  return DFA.new(
    (d1.states.product d2.states),
    d1.sigma,
    delta,
    [d1.q0, d2.q0],
    (d1.states.product d2.states).select { |q| (d1.final.include? q[0]) && (d2.final.include? q[1]) }
  )
end

def eq_dfa d1, d2
  return union(intersect(d1, d2.invert), intersect(d1.invert, d2)).e_dfa
end
