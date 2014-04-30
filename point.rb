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