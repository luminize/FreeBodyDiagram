#this class describes the vector class

class Point
	def initialize(name)
		self.name = name

		@XYZ = nil

		puts "new point = #{name}" if $global_debug
	end
	def set(position)
		@XYZ = position

		#todo: check for array of 3

		puts "set point #{@name} to #{@XYZ}" if $global_debug
	end
	def get
		@XYZ
	end
end

class Pointcollection
		def initialize(name)
		self.name = name
		@collection[]

		puts "new point array = #{name}" if $global_debug
	end
end