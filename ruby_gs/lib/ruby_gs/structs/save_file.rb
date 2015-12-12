require_relative "team"
require_relative "pc_box"
require_relative "name_text"
require_relative "box_name"
require_relative "item_entry"
require_relative "pokedex_data"

module RubyGS

  ##
  # Represents the structure and data of a Gold/Silver Pokemon cartridge SRAM 
  # 
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
    uint8 :current_box_index
    array :unused8, :type => :uint8, :initial_length => 0x3
    array :box_names, :type => :box_name, :initial_length => 14
    array :unused9, :type => :uint8, :initial_length => 0xE4
    team :team
    array :unused10, :type => :uint8, :initial_length => 0x15
    pokedex_data :dex_owned
    pokedex_data :dex_seen
	array :unused11, :type => :uint8, :initial_length => 0x2E0
	pc_box :current_box
	array :unused12, :type => :uint8, :initial_length => 0xE44
	array :pc_box, :type => :pc_box, :initial_length => 14
	rest :rest
  end

end
