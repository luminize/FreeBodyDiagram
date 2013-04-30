
require "./freebodydiagram.rb"
require "./vector.rb"
require "./point.rb"
require "./equation.rb"
require "./constraint.rb"


#set this option to true if you wish to see feedback from the calculations
$global_debug = true

#clear console
system "clear"

#STDOUT.flush
print "\033[0m"
print "\033[34mtekst\r\n"
#print "\033[1mtekst\r\n"
#print "\033[0m"

# each (free) body (diagram) must have an array of points
# resulting forces and moments are calctuated w.r.t. the interface
# each point in this array is defined with respect to the interface
# other resulting interfaces from other bodies are represented as 
# points with corresponfing (force/moment) vector

#todo: make an array with lines (consisting of points) in space.
#todo: make an array with planes (consisting of lines) in space.
#todo: make an array with bodies (consisting of planes) in space.

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
Points = Pointcollection.new('FBS-01-points')
PA = Point.new('P1', [1,2,3])
PB = Point.new('P2', [4,5,6])
PC = Point.new('P3', [7,8,9])
Points.add(PA)
#todo: add point as relative to origin of free body system, or add with thanslation from absolute
#      for now just see the behavior of 1 body system to check the code
#todo: add multiple points together
Points.add(PB)
Points.add(PC)

#add points for using constraints
Points.add(PC1 = Point.new('PC1', [0,-5,-5]))
Points.add(PC2 = Point.new('PC2', [0,5,-5]))
Points.add(PC3 = Point.new('PC3', [0,-5,5]))
Points.add(PC4 = Point.new('PC4', [0,5,5]))
Points.add(PC5 = Point.new('PC5', [0,0,5]))

Points.show!

Loads = Vectorcollection.new('FBS-01-loads')
Loads.add(Fa, PA)
Loads.add(Fb, PB)
Loads.add(Ma, PA)
Loads.show!

#done: make constraints collection
Constraints = Constraintcollection.new('FBS-01-constraints')
Constraints.add(C1 = Constraint.new('C1', [0,0,0,0,0,0]), PC1) #wrong, needs to be [1,0,0,0,0,0]
Constraints.add(C2 = Constraint.new('C2', [0,1,0,0,0,0]), PC2)
Constraints.add(C3 = Constraint.new('C3', [1,1,0,0,0,0]), PC3)
Constraints.add(C4 = Constraint.new('C4', [1,0,0,0,0,0]), PC4)
Constraints.add(C5 = Constraint.new('C5', [0,0,1,0,0,0]), PC5)

#now make free body part "Module1"
FBDModule1 = Free_body.new('Module1', Points, Loads, Constraints)

Points.add(PD = Point.new('P4', [4,8,6]))

FBDModule1.points?.show!

eq1 = Equation.new('eq1')
eq2 = Equation.new('eq2')

eq1.arr_terms_l.each { |part| puts "factor = #{part[0]} x #{part[1]}"} #output each part of the equation in console

eq1.add_term_l([4,'Fa_x'])
eq1.add_term_l([-3, 'Fby'])

eq2.add_term_l([-6,'Fa_x'])
eq2.add_term_l([-8, 'Fbz'])

#eq1.getEQ_leftside.each { |part| puts "factor = #{part[0]} x #{part[1]}"}

Points.find('P2')
Points.find('P5')

#FBDModule1.destill_equations

#correct constrainttype
C1.setvector([1,0,0,0,0,0])
FBDModule1.destill_equations

#method to check if variable exists in the equation
#puts eq1.var_exists?("Fa_x")
#puts eq1.var_exists?("Fa_y")

#development of solver
Equation_solver = Variable_eliminator.new()

puts Equation_solver.solve(eq1, eq2, 'Fa_x') #should yield an equation
puts "#{eq1.arr_terms_l} #{eq1.flt_constant_l}"
puts "#{eq2.arr_terms_l} #{eq2.flt_constant_l}"
puts "#{Equation_solver.solve(eq1, eq2, 'Fa_x').arr_terms_l} #{Equation_solver.solve(eq1, eq2, 'Fa_x').flt_constant_l}" #should yield an equation

#make small equation matrix of 2 for testing
eq3, eq4 = Equation.new('eq3'), Equation.new('eq4')
eq3.add_term_l([4,'a'])
eq3.add_term_l([2,'b'])
eq4.add_term_l([6,'a'])
eq4.add_term_l([-1,'b'])
eq3.flt_constant_l = 7
eq4.flt_constant_l = -2

puts "test for equation matrix of 2 with array of 2 variables should return resulting single equation"
puts Gauss_Jordan_matrix_solver.new([eq3, eq4], ['a', 'b']).solve

eq3.add_term_l([0,'c'])
puts Gauss_Jordan_matrix_solver.new([eq3, eq4], ['a', 'b']).solve

#below 3 test work
#puts Equation_solver.solve(eq1, eq2, 'Fa_y') #message not able to solve (Fa_y not in both)
#puts Equation_solver.solve(eq1, eq2, 'Fby') #message not able to solve (Fa_y not in both)
#puts Equation_solver.solve(eq1, eq2, 'Fbz') #message not able to solve (Fa_y not in both)

#todo: rename GaussJordanMatrix2EQsolver to equation_var_eliminator or something
#      make matrix of >2 be solved with equation_var_eliminator
#      add to equation_var_eliminator the output (bool?) to give the results if only 1 variables remains
#      the one remaining variable should be named and given it's value.
#      after this the loop can be reversed to fill all other variables


