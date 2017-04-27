require "./spec_helper"
include Biocr::Seq::Nucleotide

describe Biocr::Seq::Nucleotide do
  describe "Parse Nucleotide" do
    it "Parse 1 Nucleotide from String" do
      DNA.new("A").should eq [DNA::A]
      DNA.new("a").should eq [DNA::A]
      DNA.new("C").should eq [DNA::C]
      DNA.new("c").should eq [DNA::C]
      DNA.new("G").should eq [DNA::G]
      DNA.new("g").should eq [DNA::G]

      RNA.new("A").should eq [RNA::A]
      RNA.new("a").should eq [RNA::A]
      RNA.new("C").should eq [RNA::C]
      RNA.new("c").should eq [RNA::C]
      RNA.new("G").should eq [RNA::G]
      RNA.new("g").should eq [RNA::G]
    end

    it "Parse k Nucleotide from String" do
      DNA.new("ACGT").should eq [DNA::A, DNA::C, DNA::G, DNA::T]
      DNA.new("aCgT").should eq [DNA::A, DNA::C, DNA::G, DNA::T]

      RNA.new("ACGU").should eq [RNA::A, RNA::C, RNA::G, RNA::U]
      RNA.new("aCgU").should eq [RNA::A, RNA::C, RNA::G, RNA::U]

      DNA.new("ACGT").should be_a Biocr::Seq::NucleicAcids(Biocr::Seq::Nucleotide::DNA)
      RNA.new("ACGU").should be_a Biocr::Seq::NucleicAcids(Biocr::Seq::Nucleotide::RNA)
    end
  end

  describe "Errors" do
    it "Raise error when try to parse a empty space" do
      expect_raises do
        DNA.new("AC GT")
        RNA.new("AC GU")
      end
    end
  end
end
