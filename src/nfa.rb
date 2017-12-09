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
        end
        if new_delta[[q, c]] == []
          new_delta.delete [q, c]
        else
          new_delta[[q, c]].flatten!
          new_delta[[q, c]].sort!
        end
      end
    end

    @DFA = DFA.new(
      (powerset states),
      sigma,
      new_delta,
      [q0],
      (powerset states).select { |q| q & final != [] }.map { |x| x.sort }
    )

  end

  def accepts w
    return @DFA.accepts w
  end

  def rejects w
    return @DFA.rejects w
  end

end
