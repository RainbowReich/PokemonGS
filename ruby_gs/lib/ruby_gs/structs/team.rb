require_relative "name_text"
require_relative "party_pokemon"

module RubyGS

  ##
  # Represents your party of Pokemon.
  #
  # Note that the species, nickname, and original trainer name of each Pokemon is stored separately
  # from their respective structures, instead being stored directly within the Team structure.
  #
  class Team < BinData::Record
    endian :big
    uint8 :unused
    uint8 :amount
    array :species_list, :type => :uint8, :initial_length => 7
    array :pokemon, :type => :party_pokemon, :initial_length => 6
    array :ot_name, :type => :name_text, :initial_length => 6
    array :name, :type => :name_text, :initial_length => 6
  end

end
