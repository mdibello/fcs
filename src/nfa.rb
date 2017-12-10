# NFA.rb
# Interpreter for NFAs
# Matthew DiBello

require_relative './util.rb'

def epsilon_function delta, new_delta, q, c, v
  if v.kind_of? Array
    v.each { |w| epsilon_function delta, new_delta, q, c, w }
  else
    if delta.has_key? [v, :e]
      x = delta[[v, :e]]
      if (x.kind_of?(Symbol) && !new_delta[[q, c]].include?(x)) ||
         (x.kind_of?(Array) && !(new_delta[[q, c]] & x).empty?)
        new_delta[[q, c]].push x
        epsilon_function delta, new_delta, q, c, x
      end
    end
  end
end    

class NFA

  attr_accessor :states
  attr_accessor :sigma
  attr_accessor :delta
  attr_accessor :q0
  attr_accessor :final

  def initialize states, sigma, delta, q0, final

    new_delta = {}
    (powerset states).each do |q|
      q.sort!
      sigma.each do |c|
        new_delta[[q, c]] = []
        q.each do |x|
          if delta.has_key? [x, c]
            v = delta[[x, c]]
            new_delta[[q, c]].push v
            epsilon_function delta, new_delta, q, c, v
          end
          if delta.has_key? [x, :e]
            v = delta[[x, :e]]
            if v.kind_of? Array
              v.each do |y|
                if delta.has_key? [y, c]
                  z = delta[[y, c]]
                  new_delta[[q, c]].push(z) if z != :e
                  epsilon_function delta, new_delta, q, c, z
                end
              end
            else
              if delta.has_key? [v, c]
                w = delta[[v, c]]
                new_delta[[q, c]].push(w) if w != :e
                epsilon_function delta, new_delta, q, c, v
              end
            end
          end
        end
        if new_delta[[q, c]] == []
          new_delta.delete [q, c]
        else
          new_delta[[q, c]].flatten!
          new_delta[[q, c]].uniq!
          new_delta[[q, c]].sort!
        end
      end
    end

    self.states = (powerset states)
    self.sigma = sigma
    self.delta = new_delta
    self.q0 = [q0]
    self.final = (powerset states).select { |q| q & final != [] }.map { |x| x.sort }

    @DFA = DFA.new(self.states, self.sigma, self.delta, self.q0, self.final)

  end

  def accepts w
    return @DFA.accepts w
  end

  def rejects w
    return @DFA.rejects w
  end

end

class SimpleNFA

  def initialize states, sigma, delta, q0, final
    self.states = states
    self.sigma = sigma
    self.delta = delta
    self.q0 = q0
    self.final = final
  end

  attr_accessor :states, :sigma, :delta, :q0, :final

end
