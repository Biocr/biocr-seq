require "./nucleotide.cr"

module Biocr::Seq
  class NucleicAcids(T) < Array(T)
    def self.new(s : String) : NucleicAcids(T)
      nucleotides = NucleicAcids(T).new
      s.each_char { |c| nucleotides << T.parse(c.to_s) }
      return nucleotides
    end

    def self.new(s : Array(Int)) : NucleicAcids(T)
      nucleotides = NucleicAcids(T).new
      s.each { |c| nucleotides << T.from_value(c) }
      return nucleotides
    end

    def complement : NucleicAcids(T)
      compl = self.values.map do |b|
        (b & DNA::A.value) << 3 | (b & DNA::T.value) >> 3 | (b & DNA::C.value) << 1 | (b & DNA::G.value) >> 1
      end
      klass = self[1]
      return NucleicAcids(typeof(klass)).new(compl)
    end

    def values : Array(UInt8)
      self.map &.value
    end

    def to_s : String
      self.join("")
    end

    def to_s(io : IO)
      executed = exec_recursive(:to_s) do
        io << "[ "
        join(", ", io) { |i| io << "#{i.class}::#{i.inspect}" }
        io << " ]"
      end
      io << "[...]" unless executed
    end
  end
end
