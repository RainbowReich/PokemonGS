

module RubyGS

  ##
  # Represents a Pokemon who has been seen or caught.
  FOUND = 1
  ##
  # Represents a Pokemon who has not yet been seen or caught.
  NOT_FOUND = 0

  class PokedexArray < BinData::Array
    
	def [] i
	  return @element_list[real_index(i)].snapshot 
	end

	def []= i, v
      @element_list[real_index(i)].assign v
	end 

    private

		def real_index n
		  return n if n % 8 == 0
		  ((n / 8).floor+2)*8 - (n % 8)
		end

  end

  class PokedexData < BinData::Record
    endian :big
    pokedex_array :species, :type => :bit1, :initial_length => 251 
    array :unknown, :type => :bit1, :initial_length => 5
  end

end
