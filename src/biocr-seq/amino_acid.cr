module Biocr::Seq
  enum AminoAcid : UInt8
    A    = 0x00
    R    = 0x01
    N    = 0x02
    D    = 0x03
    C    = 0x04
    Q    = 0x05
    E    = 0x06
    G    = 0x07
    H    = 0x08
    I    = 0x09
    L    = 0x0a
    K    = 0x0b
    M    = 0x0c
    F    = 0x0d
    P    = 0x0e
    S    = 0x0f
    T    = 0x10
    W    = 0x11
    Y    = 0x12
    V    = 0x13
    O    = 0x14 # non-standadard
    U    = 0x15 # non-standard
    B    = 0x16 # ambiguous
    J    = 0x17 # ambiguous
    Z    = 0x18 # ambiguous
    X    = 0x19 # ambiguous
    GAP  = 0x1b
    TERM = 0x1a
  end
end
