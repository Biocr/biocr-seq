module Biocr::Seq
  module Count

    def self.bases(sequence : String)
      counter = {} of Char => Int32
      sequence.each_char do |c|
        counter[c] ||= 0
        counter[c] += 1
      end
      counter
    end
    
    def self.only(nucleotide : Char, sequence : String)
      count = 0
      sequence.each_char do |c|
        count += 1 if c == nucleotide
      end
      count
    end

  end
end
