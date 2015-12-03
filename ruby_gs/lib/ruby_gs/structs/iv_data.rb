module RubyGS

  class IVData < BinData::Record
    endian :big
    bit4 :attack
    bit4 :defense
    bit4 :speed
    bit4 :special
  end
  
end
