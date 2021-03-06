#    Copyright 2013 - 2014 by Bas de Bruijn, bdebruijn@luminize.nl
#
#    This file is part of FreeBodyDiagram.
#
#    FreeBodyDiagram is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    FreeBodyDiagram is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with FreeBodyDiagram.  If not, see <http://www.gnu.org/licenses/>.
#

#require "./vector.rb"
#require "./point.rb"
#require "./equation.rb"

class Free_body
	attr_accessor :arrEquantion
	def initialize(name, pointscollection, loadscollection, constraintscollection)
		@name = name # => "FB_01_body1"
		#todo: check for types of collections of points, vectors and constraints
		@pointscollection = pointscollection
		@loadscollection = loadscollection
		@constraintscollection = constraintscollection

		@eqn_Fx = Equation.new("sum Fx")
		@eqn_Fy = Equation.new("sum Fy")
		@eqn_Fz = Equation.new("sum Fz")
		@eqn_Mx = Equation.new("sum Mx")
		@eqn_My = Equation.new("sum My")
		@eqn_Mz = Equation.new("sum Mz")

		#the array containing all yet known equations, equations for frictin can be added later
		@arrEquantion = [@eqn_Fx, @eqn_Fy, @eqn_Fz, @eqn_Mx, @eqn_My, @eqn_Mz]
		@cntVariables = 0
		@arrVariables = []

		@origin = Point.new("origin", [0,0,0])

		#todo: check if reference to points in vector array are consistent
		#      with the names in the points collection. This means that I 
		#      should not be able to attach a vector if the point is not
		#      in the points array
		@loadsvector_F = Vector.new("#{name}_F_vector", 'F')
		@loadsvector_M = Vector.new("#{name}_M_vector", 'M')

		#todo: define point other than @origin [0,0,0] where resulting loadsvectors _F and _M should work
		#      means that the arm for calculating moments of restraints has to be calculated

		puts "new free body : #{name} with point array #{pointscollection.name?} and loads array #{loadscollection.name?}" if $global_debug
#		puts @vector_F.name? if $global_debug
#		puts @vector_M.name? if $global_debug
	end

	def update
		#needed for updating calculations when changing name -> names of vectors_M and _F, calculations etc.
	end

	def calc_res_forces
		#resulting forces from points to "interface" should be calculated
		#meaning known F's added to the Free_body::loadsvector_F
		#meaning resulting M's added to the Free_body:loadsvecor_M
		#do this with self.calc_res_moments

		#if above works than we can add the possibility to define a point other than (0,0,0) to calculate

	end
	
	def calc_res_moments
		#resulting couples from points to "interface" should be calculated
		#meaning known M's added to the Free_body::vector_M

		#above mentionned "interface" is for now @origin[0,0,0]
	end

	def loadsvector_F?
		@loadsvector_F
	end

	def loadsvector_M?
		@loadsvector_M
	end

	def name?
		@name
	end

	def points?
		@pointscollection
	end

	def loads?
		@loadscollection
	end

	def constraints?
		@constraintscollection
	end

#todo: make way of figuring out how to transform a restraints collection to
#      - check restraints variables to see if there are enough restraints in 3D or 2D free body
#      - check loads collection to see if there are loads in which direction (2D or 3D)


	def check_validity(arr_constraints, arr_equations)
		#todo: count all constraint"parts" and see if the amount of equaions equals the amount of unknown variables
	end 

	def destill_equations
		#traverse all constraints and destill Fx,Fy,Fz,Mx,My,Mz constraints
		term = []
		constraintvector = []
		distance = nil
		#reset first all values of equation except name for array of equations
		@arrEquantion.each {|equation| equation.reset}
		@arrVariables = []
		@cntVariables = 0

		#traverse the array
		#puts @constraintscollection
		@constraintscollection.get.each do |content|#, item|
			constraintvector = content[0].vector? 	# this will get the constraint vector [0,1,0,0,0,0] for iterating 
															# so we can break up the components in the different equations
			#p item[1].name? 
			#p constraintvector
			puts "point #{content[1].name?} at #{content[1].position?} constrained : #{constraintvector}"
			constraintvector.each_index do |index|
				#we now run each index and see if the value is not zero
				#the index itself prescribes into which equations the factor has to go
				
				#puts "value: #{constraintvector[index]}, index: #{index}"
				
				#done: do not take factor in equation of moments if distance == 0
				
				if constraintvector[index] != 0 then
					case index
					when 0 #sum Fx and in My and Mz
						puts "add to sum Fx : #{content[1].name?}.Fx"
						term = [1, "#{content[1].name?}.Fx"]
						#add to sum Fx
						@eqn_Fx.add_term_l(term)

						distance = content[1].position?[index+2] - @origin.position?[index+2]
						if distance != 0 then
							puts "add to sum My : #{content[1].name?}.Fx distance #{distance}" 
							term = [distance, "#{content[1].name?}.Fx"]
							#add to sum My
							@eqn_My.add_term_l(term)
						end

						distance = content[1].position?[index+1] - @origin.position?[index+1]
						if distance != 0
							puts "add to sum Mz : #{content[1].name?}.Fx distance #{distance}" 
							term = [distance, "#{content[1].name?}.Fx"]
							#add to sum Mz
							@eqn_Mz.add_term_l(term)
						end
						#
					when 1 #sum Fy and in Mx and Mz
						puts "add to sum Fy : #{content[1].name?}.Fy"
						term = [1, "#{content[1].name?}.Fy"]
						#add to sum Fy
						@eqn_Fy.add_term_l(term)

						distance = content[1].position?[index+0] - @origin.position?[index+0]
						if distance != 0 then
							puts "add to sum Mx : #{content[1].name?}.Fy distance #{distance}"
							term = [distance, "#{content[1].name?}.Fy"]
							#add to sum Mx
							@eqn_Mx.add_term_l(term)
						end
						
						distance = content[1].position?[index-1] - @origin.position?[index-1]
						if distance != 0 then
							puts "add to sum Mz : #{content[1].name?}.Fy distance #{distance}"
							term = [distance, "#{content[1].name?}.Fy"]
							#add to sum Mz
							@eqn_Mz.add_term_l(term)
						end
						#
					when 2 #sum Fz and in Mx and My
						puts "add to sum Fz : #{content[1].name?}.Fz"
						term = [1, "#{content[1].name?}.Fz"]
						#add to sum Fz
						@eqn_Fz.add_term_l(term)

						distance = content[1].position?[index-1] - @origin.position?[index-1]
						if distance != 0 then
							puts "add to sum Mx : #{content[1].name?}.Fz distance #{distance}"
							term = [distance, "#{content[1].name?}.Fz"]
							#add to sum Mx
							@eqn_Mx.add_term_l(term)
						end

						distance = content[1].position?[index-2] - @origin.position?[index-1]
						if distance != 0 then
							puts "add to sum My : #{content[1].name?}.Fz distance #{distance}"
							term = [distance, "#{content[1].name?}.Fz"]
							#add to sum Mz
							@eqn_Mz.add_term_l(term)
						end
						#
					when 3 #sum Mx
						puts "add to sum Mx : #{content[1].name?}.Mx}"
						term = [1, "#{content[1].name?}.Mx"]
						@eqn_Mx.add_term_l(term)
						#
					when 4 #sum My
						puts "add to sum My : #{content[1].name?}.My}"
						term = [1, "#{content[1].name?}.My"]
						@eqn_My.add_term_l(term)
						#
					when 5 #sum Mz
						puts "add to sum Mz : #{content[1].name?}.Mz}"
						term = [1, "#{content[1].name?}.Mz"]
						@eqn_Mz.add_term_l(term)
						#
					else
						#something that is not supposed to happen
					end
				#end of if statement
				end 
			#end of iterating constraintvector
			end
		#end of iterating constraintscollection
		end

		#determine validity of equations and variables w.r.t. solvability

		#todo: find out why error is raised if i do self.determine_unique_FBD_variables
		#./FreeBodyDiagram/freebodydiagram.rb:217:in `destill_equations': uninitialized constant Free_body::Self (NameError)

		determine_unique_FBD_variables
		number_of_zero_equations = determine_non_solvable_equations
		puts "#{@name} has #{@arrVariables.count} variables : #{@arrVariables}"
		if (@arrEquantion.count - number_of_zero_equations) == @arrVariables.count
			puts "there are #{@arrEquantion.count - number_of_zero_equations} equations and theoretically should be solvable"
		else
			puts "there are #{@arrEquantion.count - number_of_zero_equations} equations and theoretically should NOT be solvable"
			#todo: raise error
		end
	#end of method "destill_equations"
	end

	def determine_unique_FBD_variables
		#iterate equation array
		#get all variables
		#check if the variable already exists
		#in not then add them to @arrVariables
		@arrEquantion.each do |value| 
			#getting the variables for each equation and adding to @arrVariables = [] if new unique variable
			value.getVariables.each { |name| @arrVariables << name if not @arrVariables.include?(name)}
		end
	end

	def determine_non_solvable_equations
		#iterate array and count the number of equations where all coefficients are zero
		int_zero_equations = 0
		@arrEquantion.each do |value|
			int_zero_equations += 1 if value.has_terms? == 0
		end
		return int_zero_equations
	end

end