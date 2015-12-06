require "bindata" 
require_relative "structs"

module RubyGS

  class SaveFileReader

    def self.read(file)
      raise "filename cannot be nil" if not file
      SaveFile.new SaveFileGS.read(File.open(file,"r")), file, true
    end

    def self.calc_checksums(file)
      file.pos = 0
      content = file.read.split("").map(&:ord)
      c1 = content[0x2009..0x2D68].reduce(&:+)
      c2 = content[0x0C6B..0x17EC].reduce(&:+) + content[0x3D96..0x3F3F].reduce(&:+) + content[0x7E39..0x7E6C].reduce(&:+)
      file.close
      [c1.to_s(16),c2.to_s(16)]
    end

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

  class SaveFile

    attr_accessor :save, :gs, :filename
    
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

    def write(loc = @filename)
      @save.write(File.open(loc, "wb"))
      verify_checksums
    end

    def set_team_species slot, species
      return if !(0..5).include? slot
      @save.team.pokemon[slot].species.assign species
      @save.team.species_list[slot].assign species
    end

    def set_team_egg slot, egg_cycles
      raise "slot index must be between 0 and 5, inclusive" if !(0..5).include? slot
      @save.team.species_list[slot].assign 0xFD
	  @save.team.pokemon[slot].happiness = egg_cycles
    end

    def hatch_team_egg slot
      raise "slot index must be between 0 and 5, inclusive" if !(0..5).include? slot
      @save.team.species_list[slot].assign @save.team.pokemon[slot].species
    end

    def method_missing(sym, *args, &block)
      @save.send(sym, *args, &block)
    end
    
    private
      
      def verify_gs_checksums
        SaveFileReader.correct_checksums! File.open(@filename, "rb+")
      end

      def verify_c_checksums

      end

  end

end
