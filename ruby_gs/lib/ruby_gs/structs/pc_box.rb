require_relative "name_text"
require_relative "pc_pokemon"

module RubyGS

  class PCBox < BinData::Record
    endian :big
	uint8 :unused
    uint8 :amount
    array :species_list, :type => :uint8, :initial_length => 21
    array :pokemon, :type => :pc_pokemon, :initial_length => 20
    array :ot_name, :type => :name_text, :initial_length => 20
    array :name, :type => :name_text, :initial_length => 20
	uint8 :unused2
  end

end
