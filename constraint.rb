class Constraint
	def initialize (name, constrainttype)
		#@constraintvector tells us in which direction force and/or moment can be restricted
		#meaning x,y,z,Mx,My,Mz
		@constraintvector = [0,0,0,0,0,0]
		#todo: check for array of 6, consisting only of 0 and 1
		@constraintvector = constrainttype
		@name = name
	end

	def name?
		@name
	end

	def setvector(constrainttype)
		@constraintvector = constrainttype
	end

	def vector?
		@constraintvector
	end
end

class Constraintcollection
	#Vector collection are Vectors attached to specific points. For now I do not choose to make
	#another separate collection where the dependancy is named. Maybe future if that makes things simple
	#at this moment it makes it mandatory for defining vectors as not being able to calculate if they
	#are not in this collection. Iterating this collection will be the base of calculating a free body system
	
	def initialize(name)
		@name = name
		@collection = []
		puts "new constraint array = #{name}" if $global_debug
	end

	def add(constraint,point)
		#todo: check if input is of type "Constraint" and point is of type "Point"
		@collection << [constraint, point]
		#puts "added vector, now collection = #{@collection}"
	end

	#todo: think about the need for deleting constraints from collection. at this time 
	#      deleting means just not adding points

	def show!
		puts "showing constraints in collection #{@name}\r\n"
		@collection.each do |row|
			#iterate row and display row[n] constraint.name? and row[n]point.position?
			constraint = row[0]
			point = row[1]
			#puts vector.name?
			#puts point.name?

			puts "vector #{constraint.name?} at position #{point.position?}"
		end
	end

	def get
		@collection
	end

	def name?
		@name
	end
end