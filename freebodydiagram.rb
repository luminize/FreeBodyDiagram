#require "./vector.rb"
#require "./point.rb"

class Free_body
	def initialize(name, pointscollection, vectorcollection)
		@name = name
		#todo: check for types of collections of points and vectors
		@pointscollection = pointscollection
		@vectorcollection = vectorcollection

		#todo: check if reference to points in vector array are consistent
		#      with the names in the points collection. This means that I 
		#      should not be able to attach a vector if the point is not
		#      in the points array
		@vector_F = Vector.new("#{name}_F_vector", 'F')
		@vector_M = Vector.new("#{name}_M_vector", 'M')

		puts "new free body : #{name} with point array #{pointscollection.name?} and vector array #{vectorcollection.name?}" if $global_debug
#		puts @vector_F.name? if $global_debug
#		puts @vector_M.name? if $global_debug
	end

	def update
		#needed for updating calculations when changing name -> names of vecotrs_M and _F, calculations etc.
	end

	def calc_res_forces
		#resulting forces from points to "interface" should be calculated
		#meaning known F's added to the Free_body::vector_F
		#meaning resulting M's added to the Free_body:vecor_M
		#do this with self.calc_res_moments

	end
	
	def calc_res_moments
		#resulting couples from points to "interface" should be calculated
		#meaning known M's added to the Free_body::vector_M

	end

	def vector_F?
		@vector_F
	end

	def vector_M
		@vector_M
	end

	def name?
		@name
	end
end