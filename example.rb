
require "./freebodydiagram.rb"
require "./vector.rb"
require "./point.rb"


#set this option to true if you wish to see feedback from the calculations
$global_debug = true

# each (free) body (diagram) must have an array of points
# resulting forces and moments are calctuated w.r.t. the interface
# each point in this array is defined with respect to the interface
# other resulting interfaces from other bodies are represented as 
# points with corresponfing (force/moment) vector

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
Fb.to_vector([30,56,87])
Ma.to_vector([0,300,0])

#display info
#p Fa, Fb, Ma

#is the check on type vector working? yes!
#puts "is Fa a F vector? #{Fa.is_F_vector?}"
#puts "is Fb a M vector? #{Fb.is_M_vector?}"
#puts "is Ma a M vector? #{Ma.is_M_vector?}"

#done: get easy info on vector and scalar
puts "Fa scalar (magnitude of force) = #{Fa.scalar?}"
puts "Fa unit vector (i-j-k direction)= #{Fa.unit_vector?}"

#to find the Moment of a Force Vector with a distance there should
#be at least 1 interface. The interface is the "answer" as in
#an equation. All forces, mass, moments and other results from other
#interfaces will be calculated to this interface point.

#first check points collection and vectors collection
P_coll = Pointcollection.new('FBS-01-points')
PA = Point.new('P1', [1,2,3])
PB = Point.new('P2', [4,5,6])
PC = Point.new('P3', [7,8,9])
P_coll.add(PA)
#todo: add point as relative to origin of free body system, or add with thanslation from absolute
#      for now just see the behavior of 1 body system to check the code
#todo: add multiple points together
P_coll.add(PB)
P_coll.add(PC)
P_coll.show!

V_coll = Vectorcollection.new('FBS-01-vectors')
V_loads.add(Fa, PA)
V_loads.add(Fb, PB)
V_loads.add(Ma, PA)
V_loads.show!

#todo: make constraints collection

#now make free body part "Module1"
Module1 = Free_body.new('Module1', P_coll, V_loads)