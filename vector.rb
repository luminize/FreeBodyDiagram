#this class describes the vector class

class Vector
	def initialize(name,type = nil)
#		return puts "no usable type, F(orce) of M(oment) info needed" if ((type !="F") | (type != "M"))
		@name = name
		@type = type
		
		@norm = nil 		#this is the magnitude^2 = @scalar^2
		@dXdYdZ = []		#these are the "raw" forces acting in a point
		@ijk = []			#this is the (unit) direction vector
		@scalar = nil 		#the magnitude of a force or moment

		@isF_vector = nil
		@isM_vector = nil
		@isF_vector = true if type == 'F'
		@isM_vector = true if type == 'M'
		puts "name = #{name}, type = #{type}" if $global_debug
	end
	def set(scalar,ijk)
		@scalar = scalar
		@ijk=ijk
		#for setting information in the vector instance
		#meaning:
		#  scalar
		#  unit vector
		puts "set #{@name} vector to scalar #{@scalar} x #{@ijk}" if $global_debug
	end
	def to_vector(dXdYdZ)#,@type)
		#this one will be used for calculating the normal
		#vector with scalar from the given information (raw lengths in X, Y and Z direction).
		#lengths dX, dY and dZ will be used for calculating the norm
		#so we will have the unit vector (dX/norm, dY/norm and dZ/norm)
		#and the scalar of quangity 'norm' which is the scalar.
		
		#usefull if only components are known. Resulting in combining 
		#forces on the same point to 1 resultant and 1 direction

		#todo: check for nil-information

		#todo: check length of array
		
		#set info in "raw" vector information
		@dXdYdZ = dXdYdZ
		puts "in -->   : #{dXdYdZ}" if $global_debug

		#calculate norm of vector
		norm = 0
		dXdYdZ.each do |item|
		 norm = norm + (item*item)
		end
		@norm = norm
		puts "@dXdYdZ  : #{@dXdYdZ}" if $global_debug
		puts "norm     : #{norm}" if $global_debug
		
		#calculate resulting scalar
		@scalar = Math.sqrt(norm)
		puts "scalar   : #{@scalar}" if $global_debug
		
		#calculate the unit vector by deviding with the norm(=scalar)
		@ijk = []
		dXdYdZ.each do |item| 
			@ijk << item / @scalar
		end
		puts "n-vector : #{@ijk}" if $global_debug
	end
	def is_F_vector?
		if @isF_vector == true then
			return true
		else
			return false
		end
	end
	def is_M_vector?
		if @isM_vector == true then
			return true
		else
			return false
		end
	end
	def unit_vector?
		@ijk
	end
	def scalar?
		@scalar
	end
	def name?
		@name
	end
end

class Vectorcollection
	#Vector collection are Vectors attached to specific points. For now I do not choose to make
	#another separate collection where the dependancy is named. Maybe future if that makes things simple
	#at this moment it makes it mandatory for defining vectors as not being able to calculate if they
	#are not in this collection. Iterating this collection will be the base of calculating a free body system
	
	def initialize(name)
		@name = name
		@collection = []
		puts "new vector array = #{name}" if $global_debug
	end

	def add(vector,point)
		#todo: check if input is of type "Vector" and point is of type "Point"
		@collection << [vector, point]
		#puts "added vector, now collection = #{@collection}"
	end

	#todo: think about the need for deleting vectors from collection. at this time 
	#      deleting means just not adding points

	def show!
		puts "showing vectors in collection #{@name}\r\n"
		@collection.each do |row|
			#iterate row and display row[n] vector.name? and row[n]point.position?
			vector = row[0]
			point = row[1]
			#puts vector.name?
			#puts point.name?

			puts "vector #{vector.name?} at position #{point.position?}"
		end
	end

	def get
		@collection
	end

	def name?
		@name
		
	end
end