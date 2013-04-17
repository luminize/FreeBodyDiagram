#require "./vector.rb"
#require "./point.rb"

class Free_body
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
		@arrEquantion = [@eqn_Fx, @eqn_Fy, @eqn_Fz, eqn_Mx, eqn_My, eqn_Mz]

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
#      - an equations collection
#      - check restraints variables to see if there are enough restraints in 3D or 2D free body
#      - check loads collection to see if there are loads in which direction (2D or 3D)
# 	   - check rotation around x (moments) can only have y and z factors, same goes for moment around y and z

# 	   loadsc + restraints -> equations
# 	   destill from max 6 equations -> unknown variables
# 	   check if number of unknown variables >= number of equations

	def check_validity(arr_constraints, arr_equations)
		#todo: count all constraint"parts" and see if the amount of equaions equals the amount of unknown variables
	end 

	def destill_equations
		#traverse all constraints and destill x,y,z,Mx,My,Mz constraints
		equationpart = []
		constraintvector = []
		variables = []
		#traverse the array
		@constraintscollection.each do |constraint|
			constraintvector = constraint[1].constraint? 	# this will get the constraint vector [0,1,0,0,0,0] for iterating 
															# so we can break up the components in the different equations
			#

			[0].name?
		end

		
	end
end