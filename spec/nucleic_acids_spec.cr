require "./spec_helper"

include Biocr::Seq::Nucleotide

describe Biocr::Seq::NucleicAcids do
  describe "#values" do
    it "return all values " do
      dna = DNA.new("ACGT")
      dna.values.should eq [1, 2, 4, 8]
      dna.values.should be_a Array(UInt8)
    end
  end

  describe "#to_s" do
    it "convert to String" do
      dna = DNA.new("ACGT")
      dna.to_s.should eq "ACGT"
    end
    it "convert to string and show the class" do
      dna = DNA.new("A")
      dna.inspect.should eq "[ Biocr::Seq::Nucleotide::DNA::A ]"
    end
  end
end
