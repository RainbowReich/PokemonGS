require_relative "../text_gs"

class NameText < BinData::Primitive
  string :val, :length => 11, :pad_byte => 'P'

  def get
    TextGS.decode self.val
  end

  def set v
    self.val = TextGS.encode v
  end

end
