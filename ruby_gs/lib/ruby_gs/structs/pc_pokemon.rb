require_relative "iv_data"
require_relative "pp_data"
require_relative "caught_data"

module RubyGS

  ##
  # Represents the data describing a Pokemon stored within a PC Box.
  # 
  # This is a stripped down version of the PartyPokemon structure as it lacks data on current combat stats.
  # 
  class PCPokemon < BinData::Record
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
	caught_data :caught # Crystal only; Filled with 0s otherwise.
	uint8 :level
  end

end
