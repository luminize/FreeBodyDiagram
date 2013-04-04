require "./vector.rb"
require "./point.rb"

class Free_body
	def initialize(name, pointscollection, vectorcollection)
		self.name = name
		self.pointscollection = pointscollection
		self.vectorcollection = vectorcollection
		self.vector_F = Vector.new(name << ' F_vector', 'F')
		self.vector_F = Vector.new(name << ' M_vector', 'M')
		puts "new free body : #{name} with point array #{pointscollection.name} and vector array#{vectorcollection}" if $global_debug
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
end