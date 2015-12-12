require_relative "../text_gs"

module RubyGS

  class BoxName < BinData::Primitive
    string :val, :length => 9, :pad_byte => 'P'

    def get
      TextGS.decode self.val[0..7]
    end

    def set v
      self.val = TextGS.encode v
    end

  end

end
