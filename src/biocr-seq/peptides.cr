require "./amino_acid.cr"

module Biocr::Seq
  # A `Peptides(T)` is a collection of objects of type T (`AminoAcid`).
  #
  # A `Peptides` can be created using the usual `new` method (others are provided).
  #
  # For more information about **AminoAcids**, read the `AminoAcid` documentation
  #
  # ```
  # Peptides.new         # => []
  # Peptides.new("ACGT") # => [ AminoAcid::A, AminoAcid::C, AminoAcid::G, AminoAcid::T]
  # ```
  class Peptides < Array(AminoAcid)
    # Create a new `Peptides` by their names
    #
    # ```
    # Peptides.new("ACG") # => [ AminoAcid::A, AminoAcid::C, AminoAcid::G ]
    # ```
    def self.new(s : String) : Peptides
      amino_acids = Peptides.new
      s.each_char { |c| amino_acids << AminoAcid.parse(c.to_s) }
      return amino_acids
    end

    # Create a new `Peptides` by their codes
    #
    # ```
    # Peptides.new([1, 2, 4]) # => [ AminoAcid::R, AminoAcid::N, AminoAcid::C ]
    # ```
    def self.new(s : Array(Int)) : Peptides
      amino_acids = Peptides.new
      s.each { |c| amino_acids << AminoAcid.from_value(c) }
      return amino_acids
    end

    # Returns an `Array(UInt8)` with values of the `AminoAcid`
    #
    # ```
    # peptides = Peptides.new("RNCH") # => [ AminoAcid::R, AminoAcid::N, AminoAcid::C, AminoAcid::H ]
    # peptides.values                 # => [ 1, 2 ,4, 8 ]
    # ```
    def values : Array(UInt8)
      self.map &.value
    end

    # Returns a `String` representation of this `Peptides`
    #
    # ```
    # peptides = Peptides.new("ACG") # => [ AminoAcid::A, AminoAcid::C, AminoAcid::G ]
    # peptides.to_s                  # => "ACG"
    # ```
    def to_s : String
      self.join("")
    end

    def to_s(io : IO)
      executed = exec_recursive(:to_s) do
        io << "[ "
        join(", ", io) { |i| io << "#{i.class.to_s.split("::")[2]}::#{i.inspect}" }
        io << " ]"
      end
      io << "[...]" unless executed
    end
  end
end
