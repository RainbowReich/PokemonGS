require_relative "name_text"
require_relative "party_pokemon"

class Team < BinData::Record
  endian :big
  uint8 :unused
  uint8 :amount
  array :species_list, :type => :uint8, :initial_length => 7
  array :pokemon, :type => :party_pokemon, :initial_length => 6
  array :ot_names, :type => :uint8, :initial_length => 66
  array :name, :type => :name_text, :initial_length => 6
end
