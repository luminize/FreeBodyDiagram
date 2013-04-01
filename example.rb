require "./vector.rb"

#set this option to true if you wish to see feedback from the calculations
$global_debug = true

#todo: make an array with points in space.
#todo: make an array with lines (consisting of points) in space.
#todo: make an array with planes (consisting of lines) in space.
#todo: make an array with bodies (consisting of planes) in space.

#todo: points from this array should be able to be used by vectors
#todo: all other lines,planes and bodies are for visualising purposes

#todo: define "interface" as the result of all calculations
#todo: make method for calculating dXdYdZ out of two points

#todo: think about defining 2 vector types, Force or Moment --> Force x lenght = Moment

#todo: think about possibility to do calculations based on taking position as a function
#      meaning that i want to have results from a to b in interval of c mm


#declare vectors
#todo: fill array with all vectors for easy manipulations
Fa = Vector.new('Fa','F')
Fb = Vector.new('Fb','F')
Ma = Vector.new('Ma','M')

#set vector information to get unit vector with scalar
Fa.to_vector([10,10,10])
Fa.to_vector([30,56,87])
Ma.to_vector([0,300,0])

#display info
p Fa, Fb, Ma

#is the check on type vector working? yes!
puts Fa.is_F_vector?
puts Fb.is_M_vector?
puts Ma.is_M_vector?

#todo: get easy info on vector and scalar
#puts Fa::scalar
#puts Fa::unit_vector