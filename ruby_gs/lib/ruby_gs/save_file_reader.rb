require "bindata" 
require_relative "structs"

module RubyGS

  class SaveFileReader


    ##
    # Reads a .sav file and builds a SaveFile object from its data.
    def self.read(file)
      raise "filename cannot be nil" if not file
      SaveFile.new SaveFileGS.read(File.open(file,"r")), file, true # TODO: Detect whether save belongs to Gold/Silver or Crystal
    end

    ##
	# DEPRECATED: Calculates the checksum values for both regions within a save file.
    def self.calc_checksums(file)
      warn "[DEPRECATION] SaveFileReader::calc_checksums is deprecated. Please use SaveFileReader::correct_checksums! instead."
      file.pos = 0
      content = file.read.split("").map(&:ord)
      c1 = content[0x2009..0x2D68].reduce(&:+)
      c2 = content[0x0C6B..0x17EC].reduce(&:+) + content[0x3D96..0x3F3F].reduce(&:+) + content[0x7E39..0x7E6C].reduce(&:+)
      file.close
      [c1.to_s(16),c2.to_s(16)]
    end

	##
	# Calculates the checksum values within a save file and writes them to the save file.
    def self.correct_checksums!(file)
      file.pos = 0
      content = file.read.split("").map(&:ord)
      c1 = content[0x2009..0x2D68].inject(&:+)
      c2 = content[0x0C6B..0x17EC].inject(&:+) + content[0x3D96..0x3F3F].inject(&:+) + content[0x7E39..0x7E6C].inject(&:+)
      content[0x2D6A] = (c1 & 0xFF00) >> 8
      content[0x2D69] = c1 & 0xFF
      content[0x7E6E] = (c2 & 0xFF00) >> 8
      content[0x7E6D] = c2 & 0xFF
      file.pos = 0
      file.write content.map(&:chr).join("")
      file.flush
      file
    end

  end

  ##
  # Represents a Gold/Silver/Crystal save file.
  #
  # @gs is set to true if the save file is from Gold/Silver and false otherwise.
  #
  # @filename is a string of the filename that the save file was originally read from.
  #
  # @save is the structure containing the save file's data and is delegated to SaveFile.
  class SaveFile

	attr_accessor :save
    attr_reader  :gs, :filename
    
    def initialize save, filename, gs
      @save, @gs, @filename = save, gs, filename
    end

    def verify_checksums
      case gs
      when true
        return verify_gs_checksums
      when false
        return verify_c_checksums
      end 
    end

	##
	# Writes the save structure to file.
	#
	# If loc is not provided, it will write directly to the original file.
    def write(loc = @filename)
      @save.write(File.open(loc, "wb"))
      verify_checksums
    end

	##
	# A convenience method for setting the species of a PartyPokemon in its structure and in the Team species_list.
    def set_team_species slot, species
      return if !(0..5).include? slot
      @save.team.pokemon[slot].species.assign species
      @save.team.species_list[slot].assign species
    end

    ##
	# A convenience method for turning a PartyPokemon into an Egg and setting the steps required to hatch it.
    def set_team_egg slot, egg_cycles
      raise "slot index must be between 0 and 5, inclusive" if !(0..5).include? slot
      @save.team.species_list[slot] = 0xFD
      @save.team.pokemon[slot].happiness = egg_cycles
    end

	##
	# A convenience method for turning an Egg into a Pokemon.
    def hatch_team_egg slot
      raise "slot index must be between 0 and 5, inclusive" if !(0..5).include? slot
      @save.team.species_list[slot].assign  @save.team.pokemon[slot].species
      @save.team.pokemon[slot].happiness = 20
    end

    def method_missing(sym, *args, &block)
      @save.send(sym, *args, &block)
    end
    
    private
      
      def verify_gs_checksums
        SaveFileReader.correct_checksums! File.open(@filename, "rb+")
      end

      def verify_c_checksums
		#TODO
      end

  end

end
