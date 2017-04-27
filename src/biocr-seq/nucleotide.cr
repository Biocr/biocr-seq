module Biocr::Seq::Nucleotide
  enum DNA : UInt8
    GAP = 0b0000
    A   = 0b0001
    C   = 0b0010
    G   = 0b0100
    T   = 0b1000
    M   = 0b0011
    R   = 0b0101
    W   = 0b1001
    S   = 0b0110
    Y   = 0b1010
    K   = 0b1100
    V   = 0b0111
    H   = 0b1011
    D   = 0b1101
    B   = 0b1110
    N   = 0b1111

    def self.new(s : String)
      nucleotides = NucleicAcids(DNA).new
      s.each_char { |c| nucleotides << DNA.parse(c.to_s) }
      return nucleotides
    end
  end

  enum RNA : UInt8
    GAP = DNA::GAP
    A   = DNA::A
    C   = DNA::C
    G   = DNA::G
    U   = DNA::T
    M   = DNA::M
    R   = DNA::R
    W   = DNA::W
    S   = DNA::S
    Y   = DNA::Y
    K   = DNA::K
    V   = DNA::V
    H   = DNA::H
    D   = DNA::D
    B   = DNA::B
    N   = DNA::N

    def self.new(s : String)
      nucleotides = NucleicAcids(RNA).new
      s.each_char { |c| nucleotides << RNA.parse(c.to_s) }
      return nucleotides
    end
  end
end
