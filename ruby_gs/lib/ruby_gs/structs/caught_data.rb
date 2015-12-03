class CaughtData < BinData::Record # Only used in Crystal.
  endian :big
  bit :time, :nbits => 2
  bit :level, :nbits => 6
  bit :ot_gender, :nbits => 1
  bit :location, :nbits => 7
end
