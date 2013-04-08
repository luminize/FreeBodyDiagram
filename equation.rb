#this class has to process a string and return the information in the equation.
#the equation is the equilibrium of forces/moments in x,y or z direction
#+x, +y and +z defined with right hand rule 
#moments around x, y and z are positive as defined with right hand rule


# input example sum of moments about point 0,0 (zero) equals 0 	=> EQ1 => (+4*RP1.x)+(-3*RP2.x)+(56)=0
# 				sum of forces in x-direction equals 0			=> EQ2 => (+1*RP1.x)+(+1*RP2.x)+(3)=0

# above example translates as: 
# 	EQ1:
# 		arm 4(m) times resulting force (N) in x direction in point P1
#  		+
# 		arm -3(m) (point at other side of 0,0)	times resulting force (N) in x direction in point P2
# 		+
# 		all other known resulting moment (CCW) of (56) (Nm)
# 		=
# 		zero (0)			
# 	EQ2:
# 		resulting force (N) in x direction in point P1
# 		+
# 		resulting force (N) in x direction in point P2
# 		+
# 		all other known resulting forces of (3) in right direction (N)
# 		=
# 		zero (0)
#
# EQ1 and EQ2 can be written as
# EQ1 : 4a - 3b + 56 = 0
# EQ2 :  a +  b +  3 = 0 

# this is an example of 2 equations with 2 unknown variables ans thus should be solvable.

# at this moment not checked for completeness of string. The parentheses define the unknown parts of the equation
# all parts are added because forces or position w.r.t. position of moment dictate direction

class Equation
	def initialize(equationstring)
		@equation = {}
	end
end