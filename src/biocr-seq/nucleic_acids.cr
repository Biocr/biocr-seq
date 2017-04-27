require "./nucleotide.cr"

module Biocr::Seq
  class NucleicAcids(T) < Array(T)
    def self.new(s : String) : NucleicAcids(T)
      nucleotides = NucleicAcids(T).new
      s.each_char { |c| nucleotides << T.parse(c.to_s) }
      return nucleotides
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
