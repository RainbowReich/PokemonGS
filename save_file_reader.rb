require "bindata" 

class TextGS

  def self.encode text
    text.chars.map { |c| text_table[c] ? text_table[c].chr : c }.join
  end

  def self.decode text
    text.chars.map { |c| text_table.key(c.ord) ? text_table.key(c.ord) : "" }.join
  end

  private
  
  def self.char_pair real, game
    { real: real, game: game }
  end 

  def self.text_table
    {
     "A" => 0x80, "B" => 0x81, "C" => 0x82,
     "D" => 0x83, "E" => 0x84, "F" => 0x85,
     "G" => 0x86, "H" => 0x87, "I" => 0x88, 
     "J" => 0x89, "K" => 0x8A, "L" => 0x8B,
     "M" => 0x8C, "N" => 0x8D, "O" => 0x8E,
     "P" => 0x8F, "Q" => 0x90, "R" => 0x91, 
     "S" => 0x92, "T" => 0x93, "U" => 0x94,  
     "V" => 0x95, "W" => 0x96, "X" => 0x97,
     "Y" => 0x98, "Z" => 0x99,  

     "a" => 0xA0, "b" => 0xA1, "c" => 0xA2,
     "d" => 0xA3, "e" => 0xA4, "f" => 0xA5,
     "g" => 0xA6, "h" => 0xA7, "i" => 0xA8, 
     "j" => 0xA9, "k" => 0xAA, "l" => 0xAB,
     "m" => 0xAC, "n" => 0xAD, "o" => 0xAE,
     "p" => 0xAF, "q" => 0xB0, "r" => 0xB1, 
     "s" => 0xB2, "t" => 0xB3, "u" => 0xB4,  
     "v" => 0xB5, "w" => 0xB6, "x" => 0xB7,
     "y" => 0xB8, "z" => 0xB9, 
     
     " " => 0xBA,

     "0" => 0xF6,"1" => 0xF7,"2" => 0xF8,
     "3" => 0xF9,
     "4" => 0xFA,
     "5" => 0xFB,
     "6" => 0xFC,
     "7" => 0xFD,
     "8" => 0xFE,
     "9" => 0xFF

    }
  end

end

class NameText < BinData::Primitive
  string :val, :length => 11, :pad_byte => 'P'

  def get
    TextGS.decode self.val
  end

  def set v
    self.val = TextGS.encode v
  end

end

class CaughtData < BinData::Record #Only used in Crystal; 
  endian :big
  bit :time, :nbits => 2
  bit :level, :nbits => 6
  bit :ot_gender, :nbits => 1
  bit :location, :nbits => 7
end

class PPData < BinData::Record
  endian :big
  bit :pp_ups, :nbits => 2
  bit :current, :nbits => 6
end

class IVData < BinData::Record
  endian :big
  bit4 :attack
  bit4 :defense
  bit4 :speed
  bit4 :special
end

class PartyPokemon < BinData::Record
  endian :big
  uint8 :species
  uint8 :held_item
  uint8 :move_1
  uint8 :move_2
  uint8 :move_3
  uint8 :move_4
  uint16 :ot_id
  bit :exp, :nbits => 24
  uint16 :hp_ev
  uint16 :attack_ev
  uint16 :defense_ev
  uint16 :speed_ev
  uint16 :special_ev
  iv_data :iv
  pp_data :pp_1
  pp_data :pp_2
  pp_data :pp_3
  pp_data :pp_4
  uint8 :happiness
  uint8 :pokerus
  caught_data :caught
  uint8 :level
  uint8 :status
  uint8 :unused
  uint16 :current_hp
  uint16 :max_hp
  uint16 :attack
  uint16 :defense
  uint16 :speed
  uint16 :special_attack
  uint16 :special_defense
end

class Team < BinData::Record
  endian :big
  uint8 :unused
  uint8 :amount
  array :species_list, :type => :uint8, :initial_length => 7
  array :pokemon, :type => :party_pokemon, :initial_length => 6
  array :ot_names, :type => :uint8, :initial_length => 66
  array :name, :type => :name_text, :initial_length => 6
end

class ItemEntry < BinData::Record
  endian :big
  uint8 :kind
  uint8 :amount
end

class SaveFileGS < BinData::Record
  endian :big
  array :unused, :type => :uint8, :initial_length => 0x2000
  array :options, :type => :uint8, :initial_length => 8
  array :unused2, :type => :uint8, :initial_length => 1
  uint16 :trainer_id
  name_text :trainer_name
  name_text :mom_name
  name_text :rival_name
  name_text :red_name
  name_text :blue_name
  #uint8 :daylight_savings
  array :unused3, :type => :uint8, :initial_length => 0x35 - 0x24
  array :time_played, :type => :uint8, :initial_length => 4
  array :unused4, :type => :uint8, :initial_length => 0x14
  uint8 :trainer_palette
  array :unused5, :type => :uint8, :initial_length => 0x36F
  bit :money, :nbits => 24
  array :unused6, :type => :uint8, :initial_length => 0x8
  array :tm_pocket, :type => :uint8, :initial_length => 57
  uint8 :item_count
  array :item_pocket, :type => :item_entry, :initial_length => 20
  uint8 :key_count
  array :key_pocket, :type => :uint8, :initial_length => 26
  array :ball_pocket, :type => :uint8, :initial_length => 26
  array :pc_items, :type => :uint8, :initial_length => 102
  array :unused7, :type => :uint8, :initial_length => 0x240
  uint8 :current_box
  array :unused8, :type => :uint8, :initial_length => 0x2
  array :box_names, :type => :uint8, :initial_length => 126
  array :unused9, :type => :uint8, :initial_length => 0xE5
  team :team
  #array :team, :type => :uint8, :initial_length => 428
  array :unused10, :type => :uint8, :initial_length => 0x16
  array :dex_owned, :type => :uint8, :initial_length => 32
  array :dex_seen, :type => :uint8, :initial_length => 32
  array :footer, :type => :uint8, :initial_length =>  0x559F
end

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

  def write
    @save.write(File.open(@filename, "wb"))
    verify_checksums
  end

  def set_team_species slot, species
    return if !(0..5).include? slot
    @save.team.pokemon[slot].species.assign species
    @save.team.species_list[slot].assign species
  end

  def set_team_egg slot
    return if !(0..5).include? slot
    @save.team.species_list[slot].assign 0xFD
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
