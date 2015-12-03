module RubyGS

  class ItemEntry < BinData::Record
    endian :big
    uint8 :kind
    uint8 :amount
  end

end
