require "./spec_helper"

describe Biocr::Seq::Peptides do
  describe "Create Peptides" do
    it "create from 1 AminoAcid String" do
      Peptides.new("A").should eq [AminoAcid::A]
      Peptides.new("a").should eq [AminoAcid::A]
      Peptides.new("C").should eq [AminoAcid::C]
      Peptides.new("c").should eq [AminoAcid::C]
      Peptides.new("G").should eq [AminoAcid::G]
      Peptides.new("g").should eq [AminoAcid::G]
    end

    it "create k Peptides from String" do
      Peptides.new("ACGT").should eq [AminoAcid::A, AminoAcid::C, AminoAcid::G, AminoAcid::T]
      Peptides.new("aCgT").should eq [AminoAcid::A, AminoAcid::C, AminoAcid::G, AminoAcid::T]

      Peptides.new("ACGT").should be_a Peptides
      Peptides.new("ACGU").should be_a Peptides
    end

    it "create k Peptides from Array(Int)" do
      Peptides.new([1, 2, 4, 8]).should eq [AminoAcid::R, AminoAcid::N, AminoAcid::C, AminoAcid::H]
    end
  end

  describe "#values" do
    it "return all values " do
      peptides = Peptides.new("RNCH")
      peptides.values.should eq [1, 2, 4, 8]
      peptides.values.should be_a Array(UInt8)
    end
  end

  describe "#to_s" do
    it "convert to String" do
      peptide = Peptides.new("ACGT")
      peptide.to_s.should eq "ACGT"
    end
    it "convert to string and show the class" do
      peptides = Peptides.new("A")
      peptides.inspect.should eq "[ AminoAcid::A ]"
    end
  end

  describe "#errors" do
    it "Raise error when try to create with a empty space" do
      expect_raises do
        Peptides.new("AC GT")
        Peptides.new("AC GU")
      end
    end
  end
end
