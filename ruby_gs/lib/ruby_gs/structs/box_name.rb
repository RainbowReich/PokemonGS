require_relative "../text_gs"

module RubyGS

  ##
  # A String representing the name of a PC Box.
  #
  # It can only contain 8 visible characters, the 9th being a terminator.
  # 
  class BoxName < BinData::Primitive
    string :val, :length => 9, :pad_byte => 'P'

    def get
      TextGS.decode self.val[0..7]
    end

    def set value
      self.val = TextGS.encode value
    end

  end

end
