#this class describes the point class

class Point
	def initialize(name, xyz_position = nil)
		#todo: check for name = string, if not then make some sort of error.
		@name = name
		@xyz = []
		#puts "new point = #{name}" if $global_debug
		#puts "position = #{xyz_position}" if $global_debug
		self.set(xyz_position) if (xyz_position != nil)
	end

	def set(position)
		@xyz = position
		#todo: check for array of 3
		puts "set point #{@name} to #{@xyz}" if $global_debug
	end

	def name?
		@name
	end

	def position?
		@xyz
	end
end

class Pointcollection

	def initialize(name)
		@name = name
		@collection = []
		puts "new point array = #{name}" if $global_debug
	end

	def add(point)
		#todo: check if input is of type "Point"
		@collection << point
	end

	#todo: think about the need for deleting points from collection. at this time 
	#      deleting means just not adding points

	def show!
		puts "showing points in collection #{@name}\r\n"
		@collection.each do |point|
			#iterate row and display point.name? and point.position?	
			puts "point #{point.name?} with position #{point.position?}"
		end
	end

	def get
		@collection
	end

	def name?
		@name
	end

	def find(strPointname)
		#find the position of a point if it is in the array
		boolPointfound = false
		pointposition = []
		@collection.each do |item| 
			if item.name? == strPointname
				boolPointfound = true 
				pointposition = item.position?
			end
		end

		if boolPointfound
			puts "found #{strPointname} at position #{pointposition}" 
		else
			puts "could not find a \"#{strPointname}\" in pointcollection #{@name} "
		end
	end
end