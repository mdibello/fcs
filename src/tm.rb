# TM.rb
# Interpreter for TMs
# Matthew DiBello

class TM

  def initialize states, sigma, gamma, delta, q0, qaccept, qreject
    @Q = states
    @sigma = sigma
    @gamma = gamma
    @delta = delta
    @q0 = q0
    @qaccept = qaccept
    @qreject = qreject
  end

  def accepts w

    tape = w.split('')
    current_state = @q0
    head = 0

    while current_state != :qaccept && current_state != :qreject

      if @delta.has_key? [current_state, tape[head]]

        x = @delta[[current_state, tape[head]]]
        current_state = x[0]
        tape[head] = x[1]
  
        if x[2] == :R
          head += 1
          if head > (tape.size - 1)
            tape.push '_'
          end
        elsif x[2] == :L
          head -= 1
          if head < 0
            tape.unshift '_'
            head = 0
          end
        end

      else

        current_state = :qreject
        print tape
        puts

      end
        
    end

    return true if current_state == @qaccept
    return false

  end

  def rejects w
    return !(accepts w)
  end

end
