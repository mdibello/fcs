# NFA.rb
# Interpreter for NFAs
# Matthew DiBello

require_relative './util.rb'

class NFA

  def initialize states, sigma, delta, q0, final

    new_delta = {}
    (powerset states).each do |q|
      sigma.each do |c|
        new_delta[[q, c]] = []
        q.each do |x|
          new_delta[[q, c]].push delta[[x, c]] if delta.has_key? [x, c]
        end
        if new_delta[[q, c]] == []
          new_delta.delete [q, c]
        else
          new_delta[[q, c]].flatten!
        end
      end
    end
      
    @DFA = DFA.new(
      (powerset states),
      sigma,
      new_delta,
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
