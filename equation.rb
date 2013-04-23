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

# this is an example of 2 equations with 2 unknown variables and thus should be solvable.

# at this moment not checked for completeness of string. The parentheses define the unknown parts of the equation
# all parts are added because forces or position w.r.t. position of moment dictate direction

class Equation
	#an equation consists of coefficients (units*variable) (4a), constants (-56) and an answer (=0)
	#all my free body diagram equations have a max of 6 coefficients, 1 constant and 1 answer (to keep it simple for now)
	#more than 6 unknown variables is unsolvable with 6 equations
	#in the future it might be needed to
	#initializing gives a 2d array with all "zero" values.
	#the hash will be a translation between our standard (iterating with calculations) and the variables given
	def initialize (name)
		@eqn_leftside = []
		@eqn_rightside = []
		@flt_constant_l = 0	
		@flt_constant_r = 0	
		@strName = name								
		@cntVariable = 0
		@arrVariable = []
	end

	def getEQ_leftside
		@eqn_leftside	
	end

	def getEQ_constant_l
		@flt_constant_l
	end

	def getEQ_constant_r
		@flt_constant_r
	end

	def getEQ_rightside
		@eqn_rightside	
	end

	def setC(floatingnumber)
		@flt_constant = floatingnumber
	end

	def getVariables
		@arrVariable
	end

	def reset
		#reset equation first before re-running destillation of equations
		@eqn_leftside = []
		@eqn_rightside = []
		@flt_constant_l = 0	
		@flt_constant_r = 0								
		@cntVariable = 0
		@arrVariable = []
	end

	def addCoefficient_l(arrInput)

		#todo: check for arr_coefficient = aray of 2, with first [0] a unit and second [1] a string (type Coefficient)
		#todo: check that the coefficient to be added is not already added (no adding 5a, and then -9a)
		#      if so, then on the left side, add
		
		#check if there already is a variable with the same name
		@arrVariable << arrInput[1] if not @arrVariable.include?(arrInput[1])
		#puts "arrInput[1] = #{arrInput[1]}"
		
		#set coeficient in @eqn_leftside[i]
		@eqn_leftside << arrInput
		#up the counter
		@cntVariable += 1
	end

	def addCoefficient_r(arrInput)
		#todo: like addCoefficient_l
	end

	def how_many_vars?
		return @cntVariable + 1
	end

	def show_summary
		puts "name          : #{@strName}"
		puts "#{@cntVariable} variable(s) : #{@arrVariable}"
		puts "leftside      : #{@eqn_leftside}"
		puts "constant_l    : #{@flt_constant_l}"
		puts "rightside     : #{@eqn_rightside}"
		puts "constant_r    : #{@flt_constant_r}"
		self.display_equation_as_string
	end

	def display_equation_as_string
		strHelper_1 = "#{@strName} ---> "
		strHelper_2 = ""
		@eqn_leftside.each { |coeff| strHelper_1 << "(#{coeff[0]} x #{coeff[1]}) + "}
		strHelper_1 << "#{@flt_constant_l} = "
		if @eqn_rightside == [] then
			strHelper_2 << "0"
			strHelper_2 << " + #{@flt_constant_r}"
			strHelper_2 = "0" if strHelper_2 == "0 + 0"
		else
			@eqn_rightside.each { |coeff| strHelper << "(#{coeff[0]} x #{coeff[1]}) + "}
			strHelper << "#{@flt_constant_r}"
		end
		puts "#{strHelper_1 << strHelper_2}"
	end
end

class GaussJordanMatrix2EQsolver
	#this matrix will get 2 equations and eliminate 1 variable with the Gauss Jordan eliminating method.
	#input : equation1, equation2, variable.
	#prereq: "equation1" and "equation2" will have to have "variable" in their equation coefficients
	def initialize
		@arrGJmatrix = []
		#eqnHelper is a helper equation needed for the result of both equations
		@eqnHelper = Equation.new

	end

	def add(equation)
		#todo: check if equation is of the class Equation
		@arrGJmatrix << equation
	end

	def solve(equation1, equation2, variable)
	end

end


class Coefficient
	#a coefficient is a unit * quantity like in the SI, 4m (4 meters) these are the parts a equation consists of
	#here it is a unit * variable (4x) or (-6t)
	def initialize(str_coefficient)
		@coefficient = [0, "var"]
		#todo: get input str_coefficient and rewrite so to make "a" as "1 * a"
		#      the first part should be the unit, the second one the variable
		#      the coefficient is basically with a number @coefficient[0] and a string @coefficient[1]
	end

	def get
		@coefficient
	end
end