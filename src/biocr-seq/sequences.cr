require "biocr-parser"

module Biocr::Seq
  module Sequences
    alias Fasta = Biocr::Parser::Fasta

    def self.to_rna(sequence : String)
      sequence.gsub(/T/, 'U')
    end

    def self.complement(sequence : String)
      sequence.tr("ATCG", "TAGC").reverse
    end

    def self.gc_content(sequence : String)
      gc_count = Biocr::Seq::Count.only('G', sequence) + Biocr::Seq::Count.only('C', sequence)
      (100*gc_count.to_f/sequence.size).round(6)
    end

    def self.gc_content(fasta : Fasta)
      seq = fasta.sequences.each_with_object(Hash(String, Float64).new) do |fasta, memo|
        gc = self.gc_content(fasta.seq)
        memo[fasta.definition] = gc
      end
      seq.max_by { |e| e[1] }
    end

    def self.motiff(sequence : String, sub : String)
      sub_hash, sub_size = sub.hash, sub.size
      seq_size = sequence.size
      positions = Array(Int32).new

      sequence.each_char_with_index do |c, i|
        positions << i+1 if sequence[i, sub_size].hash == sub_hash
      end
      positions
    end

    def self.motiff(fasta : Fasta)
      common_substr = -> (seq : String, seqs : Array(String), size : Int32) {
        (1..(seq.size-size+1)).each_with_index do |_,i|
          part = seq[i...i+size]
          search = seqs.map &.includes?(part)
          next if search.includes?(false)
          return part
        end
        return ""
      }

      sequences = fasta.sequences.map &.seq
      seq = sequences.first
      left = 0
      right = seq.size + 1

      while left + 1 < right
        mid = (left + right) / 2

        unless common_substr.call(seq, sequences, mid) == ""
          left = mid
        else
          right = mid
        end
      end
      common_substr.call(seq, sequences, left)
    end

    def self.profile(sequences : Array(String))
      sequence_size = sequences.first.size

      matrix = {} of Char => Array(Int32)
      sequences.first.chars.uniq!.each do |n|
        matrix[n] = Array.new(sequence_size, 0)
      end

      sequences.each do |sequence|
       sequence.chars.each_with_index do |c, i|
         matrix[c][i] += 1
       end
      end
      matrix
    end

    def self.profile(fasta : Fasta)
      seq = fasta.sequences.each_with_object(Array(String).new) do |fasta, memo|
        memo << fasta.seq
      end
      profile(seq)
    end

    def self.consensus(profile : Hash(Char,Array(Int32)))
      consensus = Array(Char).new
      profile_size = profile.values.first.size
      profile_size.times do |i|
        consensus << profile.max_by { |k,v| v[i]}.first
      end
      consensus.join("")
    end
  end
end
