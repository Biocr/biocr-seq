require "./nucleotide.cr"

module Biocr::Seq
  class NucleicAcids(T) < Array(T)
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
