require "./spec_helper"

describe Biocr::Seq::NucleicAcids do
  describe "Create NucleicAcids" do
    it "create from 1 Nucleotide String" do
      NucleicAcids(DNA).new("A").should eq [DNA::A]
      NucleicAcids(DNA).new("A").should eq [DNA::A]
      NucleicAcids(DNA).new("a").should eq [DNA::A]
      NucleicAcids(DNA).new("C").should eq [DNA::C]
      NucleicAcids(DNA).new("c").should eq [DNA::C]
      NucleicAcids(DNA).new("G").should eq [DNA::G]
      NucleicAcids(DNA).new("g").should eq [DNA::G]

      NucleicAcids(RNA).new("A").should eq [RNA::A]
      NucleicAcids(RNA).new("a").should eq [RNA::A]
      NucleicAcids(RNA).new("C").should eq [RNA::C]
      NucleicAcids(RNA).new("c").should eq [RNA::C]
      NucleicAcids(RNA).new("G").should eq [RNA::G]
      NucleicAcids(RNA).new("g").should eq [RNA::G]
    end

    it "create k Nucleotide from String" do
      NucleicAcids(DNA).new("ACGT").should eq [DNA::A, DNA::C, DNA::G, DNA::T]
      NucleicAcids(DNA).new("aCgT").should eq [DNA::A, DNA::C, DNA::G, DNA::T]

      NucleicAcids(RNA).new("ACGU").should eq [RNA::A, RNA::C, RNA::G, RNA::U]
      NucleicAcids(RNA).new("aCgU").should eq [RNA::A, RNA::C, RNA::G, RNA::U]

      NucleicAcids(DNA).new("ACGT").should be_a Biocr::Seq::NucleicAcids(Biocr::Seq::Nucleotide::DNA)
      NucleicAcids(RNA).new("ACGU").should be_a Biocr::Seq::NucleicAcids(Biocr::Seq::Nucleotide::RNA)
    end
  end

  describe "#values" do
    it "return all values " do
      dna = NucleicAcids(DNA).new("ACGT")
      dna.values.should eq [1, 2, 4, 8]
      dna.values.should be_a Array(UInt8)
    end
  end

  describe "#to_s" do
    it "convert to String" do
      dna = NucleicAcids(DNA).new("ACGT")
      dna.to_s.should eq "ACGT"
    end
    it "convert to string and show the class" do
      dna = NucleicAcids(DNA).new("A")
      dna.inspect.should eq "[ Biocr::Seq::Nucleotide::DNA::A ]"
    end
  end

  describe "#errors" do
    it "Raise error when try to create with a empty space" do
      expect_raises do
        NucleicAcids(DNA).new("AC GT")
        NucleicAcids(RNA).new("AC GU")
      end
    end
  end
end
