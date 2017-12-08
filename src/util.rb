# Util.rb
# Misc. helper functions
# Matthew DiBello

def powerset s
  a = []
  0.upto s.size do |n|
    a += s.combination(n).to_a
  end
  return a
end
