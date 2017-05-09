require "./spec_helper"

include Biocr::Seq

describe Biocr::Seq::AminoAcid do
  describe "Arithmetic" do
    (AminoAcid::A + 1).should eq AminoAcid::R
    (AminoAcid::R + 1).should eq AminoAcid::N
    (AminoAcid::R - 1).should eq AminoAcid::A
    (AminoAcid::A < AminoAcid::R).should eq true
    (AminoAcid::A < AminoAcid::A).should eq false
  end
end
