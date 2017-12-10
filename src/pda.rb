# PDA.rb
# Interpreter for PDAs
# Matthew DiBello

class PDA

  def initialize states, sigma, gamma, delta, q0, final
    @Q = states
    @sigma = sigma
    @gamma = gamma
    @delta = delta
    @q0 = q0
    @F = final
  end

  def accepts w

    current_state = @q0
    stack = []

    w.split('').each do |c|

      input = :e

      until input == c

        return false if !@sigma.include?(c)

        if @delta.has_key? [current_state, :e, :e]
          input = :e
          stack.push :e
        elsif @delta.has_key? [current_state, c, :e]
          input = c
          stack.push :e
        elsif @delta.has_key? [current_state, :e, stack.last]
          input = :e
        elsif @delta.has_key? [current_state, c, stack.last]
          input = c
        else
          return false
        end
  
        x = @delta[[current_state, input, stack.pop]]
        current_state = x[0]
        stack.push x[1] unless x[1] == :e

      end

    end

    while (!stack.empty?) && (@delta.has_key? [current_state, :e, stack.last])
      x = @delta[[current_state, :e, stack.pop]]
      current_state = x[0]
      stack.push x[1] unless x[1] == :e
    end

    return true if @F.include? current_state
    return false

  end

  def rejects w
    return !(accepts w)
  end

end
