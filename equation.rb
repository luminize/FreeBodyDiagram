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
	#an equation consists of : expressions, both left and right of the "=" sign
	#                          terms (coefficient, operator, variable) (4 * a)
	#                          constants (-56)
	#                          statement (=)
	#
	attr_accessor :name
	attr_reader :arr_terms_l, :arr_terms_r, :bool_cleanupdone, :flt_constant_l, :flt_constant_r                
	def initialize (strName)
		@arr_terms_l = []			#array as => [ [4, 'a'], [8, 'b']
		@arr_terms_r = []
		@flt_constant_l = 0
		@flt_constant_r = 0	
		@name = strName								
		@cntVariable = 0
		@arrVariable = []
		@bool_cleanupdone = false
	end

	def set_cons_l(floatingnumber)
		@flt_constant_l = floatingnumber.to_f
	end

	def set_cons_r(floatingnumber)
		@flt_constant_r = floatingnumber.to_f
	end

	def getVariables
		@arrVariable
	end

	def reset
		#reset equation first before re-running destillation of equations
		@arr_terms_l = []
		@arr_terms_r = []
		@flt_constant_l = 0.to_f	
		@flt_constant_r = 0.to_f								
		@arrVariable = []
	end

	def add_term_l(arrInput_l)
		add_term(@arr_terms_l, arrInput_l)
	end

	def add_term_r(arrInput_r)
		add_term(@arr_terms_r, arrInput_r)
	end

	def add_term(left_or_right_terms, arrInput)
		@bool_cleanupdone = false
		#todo: check for arr_coefficient = aray of 2, with first [0] a unit and second [1] a string (type Coefficient)
		#todo: check that the coefficient to be added is not already added (no adding 5a, and then -9a)
		#      if so, then on the left side, add
		#check if there already is a variable with the same name
		#do nothing if so
		if not @arrVariable.include?(arrInput[1])
			@arrVariable << arrInput[1] 
			#set coeficient in @arr_terms_l[i]
			left_or_right_terms << [arrInput[0].to_f, arrInput[1]]
		else
			puts "variable #{arrInput[1]} already exists. Nothing will be done. Check your code"
		end
	#end method add_term	
	end

	def get_coefficient(strVariable)
		result = nil
		self.cleanup_to_left
		first_coefficient_found = false
		#iterate thru terms and return at first (and should be only) instance
		@arr_terms_l.each { |term| result = term[0].to_f if term[1] == strVariable}
		return result
	end

	def how_many_vars?
		return @arrVariable.count
	end

	def show_summary
		puts "name              : #{@name}"
		puts "#{@arrVariable.count} variable(s)     : #{@arrVariable}"
		puts "expression left   : #{@arr_terms_l} + #{@flt_constant_l}"
		puts "expression right  : #{@arr_terms_r} + #{@flt_constant_r}"
		self.display_equation_as_string
	end

	def var_exists?(variable)
		self.cleanup_to_left
		@arrVariable.include?(variable)
	end

	def display_equation_as_string
		strHelper_1 = "#{@name}           ---> "
		strHelper_2 = ""

		#iterate all coefficients on left side
		@arr_terms_l.each { |coeff| strHelper_1 << "(#{coeff[0]} x #{coeff[1]}) + "}
		
		#add constant left side value and '=' sign
		strHelper_1 << "#{@flt_constant_l} = "
		
		#iterate and clean up right side because showing "0 + 0" is stupid
		if @arr_terms_r == [] then
			strHelper_2 << "0"
			strHelper_2 << " + #{@flt_constant_r}"
			strHelper_2 = "0" if strHelper_2 == "0 + 0"
		else
			@arr_terms_r.each { |coeff| strHelper_1 << "(#{coeff[0]} x #{coeff[1]}) + "}
			strHelper_2 << "#{@flt_constant_r}"
		end
		puts "#{strHelper_1 << strHelper_2}"
	end

	def cleanup_to_left
		arr_to_be_removed_indexes = []
		result = nil

		#clean up terms and constants in equation to get all to the left expression
		#since adding variables checks if the variable already exists we won't check if variables are double
		@arr_terms_r.each do |term|
			@arr_terms_l << [-1*term[0], term[1]] 
		end
		@flt_constant_l -= @flt_constant_r 
		
		#remove all terms which have a zero as coefficient in it
		@arr_terms_l.each_with_index do |term, index| 
			if term[0] == 0.0
				arr_to_be_removed_indexes.insert(0, index) 		#fill array backwards with to be removed term indices
				@arrVariable.delete(term[1])					#remove variable from known variables
			end
		end
		arr_to_be_removed_indexes.each_with_index { |v, i| @arr_terms_l.delete_at(v) if i != nil }
		
		#set right expression as []
		@arr_terms_r = []
		@flt_constant_r = 0.0
		@bool_cleanupdone = true
	end

	def has_terms?
		#all terms moved to the left expression
		self.cleanup_to_left
		if @arr_terms_l.count == 0
			return false
		else
			return true
		end
	end

	def has_only_one_left_term?
		#after expression cleanup all terms exept one are zero
		#meaning the value can be calculated
		int_non_zero_coeff = 0
		self.cleanup_to_left
		@arr_terms_l.each { |term| int_non_zero_coeff += 1 if term[0] != 0}
		if int_non_zero_coeff == 1
			return true
		else
			return false
		end
	end
end

class Variable_eliminator
#todo: find out private classes etc.
#	private_class_method :add_missing_terms

	#this matrix will get 2 equations and eliminate 1 variable with the Gauss Jordan eliminating method.
	#input : equation1, equation2, variable.
	#prereq: "equation1" and "equation2" will have to have "variable" in their equation coefficients
	def initialize()
		@arrGJmatrix = []
		@arr_allVariables = []
		#eqnHelper is a helper equation needed for the result of both equations
		@eqnHelper = Equation.new("result")
	end

	def solve(equation1, equation2, variable)

		#todo: check if equation1 and equation2 are of type Equation

		@arr_allVariables = []
		arr_multiplier = []
		c1, c2 = 0.0, 0.0
		flt_1, flt_2 = 0.0, 0.0
		eqnSolution = Equation.new("solution")
#		eqn_EQ1 = Equation.new('EQ1')
#		eqn_EQ2 = Equation.new('EQ2')
		
		#check both equation 1 and equation 2 to see if the variable exisit in the equation
		#only proceed if both equations have the variable
		#if not, then give message that it could not be solved

		if equation1.var_exists?(variable) and equation2.var_exists?(variable)
			
			#getting all the variables for EQ1 and EQ2 and adding to @arr_allVariables = [] if new unique variable
			equation1.getVariables.each { |varName| @arr_allVariables << varName if not @arr_allVariables.include?(varName)}
			equation2.getVariables.each { |varName| @arr_allVariables << varName if not @arr_allVariables.include?(varName)}
		#	p arr_allVariables

			#todo: add cleanup logic to method in Equation Class
			#cleanup must be don to ensure all terms are only in left expression
			#right expression should be 'zero'
			equation1.cleanup_to_left
			equation2.cleanup_to_left

			#get coefficient1 and coefficient 2 of variable in EQ1 and EQ2

			#todo:
			#      I should make a deep clone method in Equation class.
			#      the quick workaround (but not fastest) is the marshalling method
			eqn_EQ1 = Marshal.load( Marshal.dump(equation1) )
			eqn_EQ2 = Marshal.load( Marshal.dump(equation2) )
			#change names of copies for debugging sake
			eqn_EQ1.name, eqn_EQ2.name = "deep_copy_#{equation1.name}", "deep_copy_#{equation1.name}"
		
			#add missing terms to both equations
			#if a missing term is added, the coefficient will be 0
			self.add_missing_terms(eqn_EQ1)
			self.add_missing_terms(eqn_EQ2)

			#iterate all available variables
			#fill c1 and c2 so we know the multiplication factors
			c1 = eqn_EQ1.get_coefficient(variable)
			c2 = eqn_EQ2.get_coefficient(variable)

			#multiply in EQ2 with coefficient1 all coefficients of all variables
			#multiply in EQ1 with coefficient2 all coefficients of all variables
			#subtract all variables in EQ1 from all variables in EQ2
			@arr_allVariables.each do |var_in_term|
				coeff_result =   (c2 * eqn_EQ1.get_coefficient(var_in_term).to_f) \
							   - (c1 * eqn_EQ2.get_coefficient(var_in_term).to_f)
				eqnSolution.add_term_l([coeff_result, "#{var_in_term}"])
			end
			#now we have to do this for the constant(s) on the left side
			eqnSolution.set_cons_l (   (c2 * eqn_EQ1.flt_constant_l) \
									 - (c1 * eqn_EQ2.flt_constant_l) \
									)
			#now we only should return the equation
			return eqnSolution

		else
			puts "#{variable} does not exist in #{equation1.name} or (both) #{equation2.name}"
			return
		end
	#end of method solve
	end

	def add_missing_terms(eqn_equation)
		#check that cleanup has been done and all variables are in left expression
		if eqn_equation.bool_cleanupdone == false
			puts "cleanup not done on #{eqn_equation.name}"
			return
		end
		#quick result if number of terms in the equation equal number of total variables
		return if eqn_equation.arr_terms_l.count == @arr_allVariables.count
		#iterate variables and if not existing in variables in equation then add it
		@arr_allVariables.each { |value| eqn_equation.add_term_l([0, value]) if not eqn_equation.getVariables.include?(value)}
	#end of method add_missing_terms
	end

end


class Gauss_Jordan_matrix_solver
	def initialize(equations_matrix_input, arr_of_variables_input)
		#todo: check for types of objects
		
		#make a deep clone of the array of matrices and variables
		@arr_equation_matrix = Marshal.load( Marshal.dump(equations_matrix_input) )
		@arr_variables = Marshal.load( Marshal.dump(arr_of_variables_input) )
		@arr_indices = []
		@arr_results = []
		@eqn_result_eq = Equation.new("result equation of 2 EQ in GJ matrix solver")
	#	puts "entering initialize in Gauss_Jordan_matrix_solver"

		#check if there are equations which have all zero's in equation

	end

	def solve
		arr_variable_zero = []
		arr_term_non_zero_variables = []
		arr_variable_name = []
		arr_helper = []
		arr_variable_coeff = []
		#if there are only 2 equations and 2 variables left then only Variable_eliminator has to be
		#     called 1 time. Result from that must be used to solve the equation in the matrix above.
		# 	  the returned value is an array of [result_n, variable_n]. This is the turning point for
		# 	  solving the other equations upwards
		# 	  arr_equation_matrix[0] can now be solved with the info from the arr_results matrix.
		#     the resulting variable matrix [result_n-1, variable_n-1] will be added as first index.
		puts "number of equations in equation matrix = #{@arr_equation_matrix.count}"
		case @arr_equation_matrix.count
			when 0
				puts "GJMS error 0 equations in equation matrix"
				return
			when 1
				puts "GJMS error only 1 equation in equation matrix"
				return
			when 2
				puts "GJMS entering \'case 2\' in Gauss_Jordan_matrix_solver"
				#code for running eliminator and returning result.
				#this result needs to be used in current matrix to solve arr_equation_matirx[0]
				#and add the resulting [solution, variable] to the arr_results matrix to be used
				#for solving the equation matrix above.

#todo: check for same variable in both equations to be there
#todo: check that both are not zero equations
#todo: check that at least 1 of both has 2 non-zero terms with different variables

				@eqn_result_eq = Variable_eliminator.new.solve(@arr_equation_matrix[0], @arr_equation_matrix[1], @arr_variables[0])
				@eqn_result_eq.name = "result of #{@arr_equation_matrix[0].name} and #{@arr_equation_matrix[1].name}"
				p @eqn_result_eq
				
				#check that there is only 1 variable that is not 'zero'
				puts "GJMS left terms #{@eqn_result_eq.arr_terms_l}"
				
				#deep copy
				arr_helper = Marshal.load( Marshal.dump(@eqn_result_eq.arr_terms_l) )
				
		#		puts "GJMS arr_helper = #{arr_helper}"

				@eqn_result_e



				arr_helper.each_with_index do |term, index|
					if term[0] == 0
						arr_variable_zero << term 
					else
						arr_term_non_zero_variables << term
						arr_variable_name << term[1]
						arr_variable_coeff << term[0]
					end
				end

		# for debugging
		#		puts "GJMS arr_variable_zero = #{arr_variable_zero}"
		#		puts "GJMS arr_term_non_zero_variables = #{arr_term_non_zero_variables}"
		#		puts "GJMS #{arr_variable_zero.count} zero variables in left side terms are #{arr_variable_zero}"
		#		puts "GJMS @eqn_result_eq.flt_constant_l = #{@eqn_result_eq.flt_constant_l}"
				
				#check that @arr_variables[1] is the last remaining variable, consistent with variable that is not 'zero'
				if (arr_term_non_zero_variables.count == 1) 
				   		puts "GJMS 1 variable remaining with coefficient other than zero, and variable equals expected variable"
				   		#the only remaining variable thus is (-1 * flt_constant_l) / arr_variable_coeff
				   		puts "arr_term_non_zero_variables[0] = #{arr_term_non_zero_variables[0]}"
				   		@arr_results << [((-1 * @eqn_result_eq.flt_constant_l.to_f) / arr_variable_coeff[0].to_f), arr_variable_name[0]]
				   		puts "@arr_results[0] = #{@arr_results[0]}"
					else
				   		puts "GJMS error with remaining (zero) variables. returning without succes. check your code"
				end

				return @eqn_result_eq
			else #equations that are bigger than 2
				
				#TODO: do iteration of matrix > 2
				#TODO: invoking a new solver for the resulting matrix.
				#TODO: appending resulting values (array) to @arr_results
				#TODO: see for solving the known variables above (line 335 approx)


				#RANTING BELOW


		#now we need to decide how best to start. Let's take the first variable from the variables array 
		#     and check in which indices of arr_equation_matrix it exists
		#thus we fill an array with the indices of the equations which needs to be solved
		#after eliminating the first equation value of index [0] of arr_indices into the remaining equations 
		#     of arr_equation_matrix we copy the resulting equations and remaining (index of arr_matrices
		#     who are not in the values of arr_indices) equations in a new matrix




		end


	end
end



class Term
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