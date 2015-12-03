class PPData < BinData::Record
  endian :big
  bit :pp_ups, :nbits => 2
  bit :current, :nbits => 6
end
