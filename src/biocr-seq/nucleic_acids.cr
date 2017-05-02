require "./nucleotide.cr"

module Biocr::Seq
  # A `NucleicAcids(T)` is a collection of objects of type T (`DNA` or `RNA`).
  #
  # A `NucleicAcids` can be created using the usual `new` method (others are provided).
  #
  # For more information about **Nucleotides**, read the `Nucleotide` documentation
  #
  # ```
  # NucleicAcids(DNA).new         # => []
  # NucleicAcids(DNA).new("ACGT") # => [ DNA::A, DNA::C, DNA::G, DNA::T]
  # ```
  class NucleicAcids(T) < Array(T)
    # Create a new `NucleicAcids(T)` by their names
    #
    # ```
    # NucleicAcids(DNA).new("ACG") # => [ DNA::A, DNA::C, DNA::G ]
    # ```
    def self.new(s : String) : NucleicAcids(T)
      nucleotides = NucleicAcids(T).new
      s.each_char { |c| nucleotides << T.parse(c.to_s) }
      return nucleotides
    end

    # Create a new `NucleicAcids(T)` by their codes
    #
    # ```
    # NucleicAcids(DNA).new([1, 2, 4]) # => [ DNA::A, DNA::C, DNA::G ]
    # ```
    def self.new(s : Array(Int)) : NucleicAcids(T)
      nucleotides = NucleicAcids(T).new
      s.each { |c| nucleotides << T.from_value(c) }
      return nucleotides
    end

    # Returns a `NucleicAcids(T)` with the complementary `Nucleotide`
    #
    # ```
    # dna = NucleicAcids(DNA).new("ACG") # => [ DNA::A, DNA::C, DNA::G ]
    # dna.complement                     # => [ DNA::T, DNA::G, DNA::C ]
    # ```
    def complement : NucleicAcids(T)
      compl = self.values.map do |b|
        (b & DNA::A.value) << 3 | (b & DNA::T.value) >> 3 | (b & DNA::C.value) << 1 | (b & DNA::G.value) >> 1
      end
      klass = self[1]
      return NucleicAcids(typeof(klass)).new(compl)
    end

    # Returns an `Array(UInt8)` with values of the `Nucleotide`
    #
    # ```
    # dna = NucleicAcids(DNA).new("ACG") # => [ DNA::A, DNA::C, DNA::G ]
    # dna.values                         # => [ 1, 2 ,4 ]
    # ```
    def values : Array(UInt8)
      self.map &.value
    end

    # Returns a `String` representation of this `NucleicAcids(T)`
    #
    # ```
    # dna = NucleicAcids(DNA).new("ACG") # => [ DNA::A, DNA::C, DNA::G ]
    # dna.to_s                           # => "ACG"
    # ```
    def to_s : String
      self.join("")
    end

    def to_s(io : IO)
      executed = exec_recursive(:to_s) do
        io << "[ "
        join(", ", io) { |i| io << "#{i.class.to_s.split("::")[3]}::#{i.inspect}" }
        io << " ]"
      end
      io << "[...]" unless executed
    end
  end
end
